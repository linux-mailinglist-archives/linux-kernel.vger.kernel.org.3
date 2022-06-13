Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B40549BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343614AbiFMSjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345661AbiFMSi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:38:56 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4964F36305;
        Mon, 13 Jun 2022 08:33:21 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id DD35F1E80D53;
        Mon, 13 Jun 2022 23:32:06 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ph1dDZH7zWRn; Mon, 13 Jun 2022 23:32:04 +0800 (CST)
Received: from [172.30.21.244] (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id CB06C1E80D05;
        Mon, 13 Jun 2022 23:32:03 +0800 (CST)
From:   liqiong <liqiong@nfschina.com>
Subject: Re: [PATCH] smackfs: check for allocation failure of kmalloc()
To:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuzhe@nfschina.com,
        renyu@nfschina.com
References: <20220613062202.29194-1-liqiong@nfschina.com>
 <88718d10-4435-f5a8-9123-afc73257e0ca@schaufler-ca.com>
Message-ID: <f2e6beb0-bce9-0e73-aefc-8f6c6b5509f4@nfschina.com>
Date:   Mon, 13 Jun 2022 23:33:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <88718d10-4435-f5a8-9123-afc73257e0ca@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022年06月13日 22:53, Casey Schaufler 写道:
> On 6/12/2022 11:22 PM, Li Qiong wrote:
>> As the possible failure of the kmalloc(), it should be better
>> to check it and print a warning message.
>
> The allocation is done with __GFP_NOFAIL, which assures
> it will not fail.

Thanks,  my mistake.
Drop this patch.



>
>>
>> Signed-off-by: Li Qiong <liqiong@nfschina.com>
>> ---
>>   security/smack/smackfs.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
>> index 4b58526450d4..0d11ba3cb4cd 100644
>> --- a/security/smack/smackfs.c
>> +++ b/security/smack/smackfs.c
>> @@ -695,6 +695,11 @@ static void smk_cipso_doi(void)
>>                  __func__, __LINE__, rc);
>>         doip = kmalloc(sizeof(struct cipso_v4_doi), GFP_KERNEL | __GFP_NOFAIL);
>> +    if (unlikely(!doip)) {
>> +        printk(KERN_WARNING "%s:%d failed to allocate a memory for doip\n",
>> +               __func__, __LINE__);
>> +        return;
>> +    }
>>       doip->map.std = NULL;
>>       doip->doi = smk_cipso_doi_value;
>>       doip->type = CIPSO_V4_MAP_PASS;
