Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3CD4E3CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiCVKxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiCVKxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:53:31 -0400
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF26814AD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:52:02 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KN7bP2J8JzMpxpl;
        Tue, 22 Mar 2022 11:52:01 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KN7bN0m1lzljnTl;
        Tue, 22 Mar 2022 11:52:00 +0100 (CET)
Message-ID: <6c14d652-edb2-da32-4025-de1a234c828f@digikod.net>
Date:   Tue, 22 Mar 2022 11:53:07 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v1 1/1] certs: Explain the rational to call panic()
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20220321174548.510516-1-mic@digikod.net>
 <20220321174548.510516-2-mic@digikod.net>
 <CAHC9VhR+Ss5VAUHLutTvyS8g+agZy7d0YGcu_9dV1LBx_8ifNQ@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <CAHC9VhR+Ss5VAUHLutTvyS8g+agZy7d0YGcu_9dV1LBx_8ifNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/03/2022 19:23, Paul Moore wrote:
> On Mon, Mar 21, 2022 at 1:45 PM Mickaël Salaün <mic@digikod.net> wrote:
>>
>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>
>> The blacklist_init() function calls panic() for memory allocation
>> errors.  This change documents the reason why we don't return -ENODEV.
>>
>> Suggested-by: Paul Moore <paul@paul-moore.com> [1]
>> Requested-by: Jarkko Sakkinen <jarkko@kernel.org> [1]
>> Link: https://lore.kernel.org/r/YjeW2r6Wv55Du0bJ@iki.fi [1]
>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>> Link: https://lore.kernel.org/r/20220321174548.510516-2-mic@digikod.net
>> ---
>>   certs/blacklist.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
> 
> I would suggest changing the second sentence as shown below, but
> otherwise it looks good to me.
> 
> Reviewed-by: Paul Moore <paul@paul-moore.com>
> 
>> diff --git a/certs/blacklist.c b/certs/blacklist.c
>> index 486ce0dd8e9c..ac26bcf9b9a5 100644
>> --- a/certs/blacklist.c
>> +++ b/certs/blacklist.c
>> @@ -307,6 +307,14 @@ static int restrict_link_for_blacklist(struct key *dest_keyring,
>>
>>   /*
>>    * Initialise the blacklist
>> + *
>> + * The blacklist_init() function is registered as an initcall via
>> + * device_initcall().  As a result the functionality doesn't load and the
> 
> "As a result if the blacklist_init() function fails for any reason the
> kernel continues to execute."

Thanks, I'll fix that.

> 
>> + * kernel continues on executing.  While cleanly returning -ENODEV could be
>> + * acceptable for some non-critical kernel parts, if the blacklist keyring
>> + * fails to load it defeats the certificate/key based deny list for signed
>> + * modules.  If a critical piece of security functionality that users expect to
>> + * be present fails to initialize, panic()ing is likely the right thing to do.
>>    */
>>   static int __init blacklist_init(void)
>>   {
> 
> --
> paul-moore.com
