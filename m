Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3354DC12F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiCQIaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiCQIan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:30:43 -0400
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc08])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0875BDAFD6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 01:29:22 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KK0g45ZWXzMpnl0;
        Thu, 17 Mar 2022 09:29:20 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KK0g342cGzlhSMZ;
        Thu, 17 Mar 2022 09:29:19 +0100 (CET)
Message-ID: <57a2e3ef-5baa-16ef-7865-245134a26e25@digikod.net>
Date:   Thu, 17 Mar 2022 09:30:02 +0100
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Paul Moore <paul@paul-moore.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220311174741.250424-1-mic@digikod.net>
 <20220311174741.250424-3-mic@digikod.net> <YjLk5p1ej3JwFdaJ@iki.fi>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v1 2/2] certs: Remove panic() calls from
 system_trusted_keyring_init()
In-Reply-To: <YjLk5p1ej3JwFdaJ@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/03/2022 08:36, Jarkko Sakkinen wrote:
> On Fri, Mar 11, 2022 at 06:47:41PM +0100, Mickaël Salaün wrote:
>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>
>> Replace panic() calls from device_initcall(system_trusted_keyring_init)
>> with proper error handling using -ENODEV.
>>
>> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org> [1]
>> Link: https://lore.kernel.org/r/Yik0C2t7G272YZ73@iki.fi [1]
>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>> Link: https://lore.kernel.org/r/20220311174741.250424-3-mic@digikod.net
>> ---
>>   certs/system_keyring.c | 26 ++++++++++++++++++++------
>>   1 file changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
>> index 05b66ce9d1c9..428046a7aa7f 100644
>> --- a/certs/system_keyring.c
>> +++ b/certs/system_keyring.c
>> @@ -148,8 +148,10 @@ static __init int system_trusted_keyring_init(void)
>>   			      KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH),
>>   			      KEY_ALLOC_NOT_IN_QUOTA,
>>   			      NULL, NULL);
>> -	if (IS_ERR(builtin_trusted_keys))
>> -		panic("Can't allocate builtin trusted keyring\n");
>> +	if (IS_ERR(builtin_trusted_keys)) {
>> +		pr_err("Can't allocate builtin trusted keyring\n");
>> +		return -ENODEV;
>> +	}
>>   
>>   #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
>>   	secondary_trusted_keys =
>> @@ -161,14 +163,26 @@ static __init int system_trusted_keyring_init(void)
>>   			      KEY_ALLOC_NOT_IN_QUOTA,
>>   			      get_builtin_and_secondary_restriction(),
>>   			      NULL);
>> -	if (IS_ERR(secondary_trusted_keys))
>> -		panic("Can't allocate secondary trusted keyring\n");
>> +	if (IS_ERR(secondary_trusted_keys)) {
>> +		pr_err("Can't allocate secondary trusted keyring\n");
>> +		goto err_secondary;
>> +	}
>>   
>> -	if (key_link(secondary_trusted_keys, builtin_trusted_keys) < 0)
>> -		panic("Can't link trusted keyrings\n");
>> +	if (key_link(secondary_trusted_keys, builtin_trusted_keys) < 0) {
>> +		pr_err("Can't link trusted keyrings\n");
>> +		goto err_link;
>> +	}
>>   #endif
>>   
>>   	return 0;
>> +
>> +err_link:
>> +	key_put(secondary_trusted_keys);
>> +
>> +err_secondary:
>> +	key_put(builtin_trusted_keys);
>> +
>> +	return -ENODEV;
>>   }
>>   
>>   /*
>> -- 
>> 2.35.1
>>
> 
> Changes make sense to me but you should implement all this to the original
> patch set.

You agreed to add this patch on top of the others a few days ago: 
https://lore.kernel.org/r/f8b1ea77afe8d6698b4a2122254ff8be310412b1.camel@kernel.org

What do you think about Paul's concerns?
