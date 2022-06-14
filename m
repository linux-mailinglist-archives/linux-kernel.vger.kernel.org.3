Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C6C54B25A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245606AbiFNNe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244577AbiFNNe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:34:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA211C121;
        Tue, 14 Jun 2022 06:34:55 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LMq8l6mqqzRjR5;
        Tue, 14 Jun 2022 21:31:35 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 21:34:53 +0800
Subject: Re: [PATCH -next] selinux: Fix memleak in security_read_state_kernel
To:     Ondrej Mosnacek <omosnace@redhat.com>
CC:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        <michalorzel.eng@gmail.com>, Austin Kim <austin.kim@lge.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20220613135953.135998-1-xiujianfeng@huawei.com>
 <CAFqZXNvHB0cftgbK+mScbZbcO71OLpXrBMxWAx1z1eB27mm8Cw@mail.gmail.com>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <f7151722-6450-7efd-1e3d-e31245dc3da2@huawei.com>
Date:   Tue, 14 Jun 2022 21:34:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNvHB0cftgbK+mScbZbcO71OLpXrBMxWAx1z1eB27mm8Cw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/6/14 20:57, Ondrej Mosnacek 写道:
> On Mon, Jun 13, 2022 at 4:02 PM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>> In this function, it directly returns the result of __security_read_policy
>> without freeing the allocated memory in *data, cause memory leak issue,
>> so free the memory if __security_read_policy failed.
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>   security/selinux/ss/services.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
>> index 69b2734311a6..fe5fcf571c56 100644
>> --- a/security/selinux/ss/services.c
>> +++ b/security/selinux/ss/services.c
>> @@ -4048,6 +4048,7 @@ int security_read_policy(struct selinux_state *state,
>>   int security_read_state_kernel(struct selinux_state *state,
>>                                 void **data, size_t *len)
>>   {
>> +       int err;
>>          struct selinux_policy *policy;
>>
>>          policy = rcu_dereference_protected(
>> @@ -4060,5 +4061,11 @@ int security_read_state_kernel(struct selinux_state *state,
>>          if (!*data)
>>                  return -ENOMEM;
>>
>> -       return __security_read_policy(policy, *data, len);
>> +       err = __security_read_policy(policy, *data, len);
>> +       if (err) {
>> +               vfree(*data);
>> +               *data = NULL;
>> +               *len = 0;
>> +       }
>> +       return err;
>>   }
>> --
>> 2.17.1
>>
> security_read_policy() defined a few lines above has the same pattern
> (just with vmalloc_user() in place of vmalloc()). Would you like to
> send another patch to fix that function as well?
No problem, patch already sent.
>
