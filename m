Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2255F54C4BC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347964AbiFOJek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242322AbiFOJei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:34:38 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0D0220E1;
        Wed, 15 Jun 2022 02:34:37 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LNKrK43bBzDqt9;
        Wed, 15 Jun 2022 17:34:09 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 17:34:35 +0800
Subject: Re: [PATCH -next] selinux: Fix potential memory leak in
 selinux_add_opt
To:     Paul Moore <paul@paul-moore.com>
CC:     <stephen.smalley.work@gmail.com>, <eparis@parisplace.org>,
        <omosnace@redhat.com>, <selinux@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220611090550.135674-1-xiujianfeng@huawei.com>
 <CAHC9VhSwYdrHw8jNYxWApPYMjnmX-ZDN1=CzmRBeS1HoL-KOOA@mail.gmail.com>
 <c54658e5-f0bd-b3f6-3cf8-d7d0e8b1c4df@huawei.com>
 <CAHC9VhTkfBm8zCDw=m+jaDZW15LB+bRJ5+ymxsSJKW=V645S2g@mail.gmail.com>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <d7947bfd-b8f4-9ca5-ad1d-ce9489f6ab4e@huawei.com>
Date:   Wed, 15 Jun 2022 17:34:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTkfBm8zCDw=m+jaDZW15LB+bRJ5+ymxsSJKW=V645S2g@mail.gmail.com>
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


在 2022/6/15 9:17, Paul Moore 写道:
> On Mon, Jun 13, 2022 at 9:18 PM xiujianfeng <xiujianfeng@huawei.com> wrote:
>> 在 2022/6/14 4:22, Paul Moore 写道:
>>> On Sat, Jun 11, 2022 at 5:07 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>>>> In the entry of selinux_add_opt, *mnt_opts may be assigned to new
>>>> allocated memory, and also may be freed and reset at the end of the
>>>> function. however, if security_context_str_to_sid failed, it returns
>>>> directly and skips the procedure for free and reset, even if it may be
>>>> handled at the caller of this function, It is better to handle it
>>>> inside.
>>>>
>>>> Fixes: 70f4169ab421 ("selinux: parse contexts for mount options early")
>>>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>>>> ---
>>>>    security/selinux/hooks.c | 12 +++++++-----
>>>>    1 file changed, 7 insertions(+), 5 deletions(-)
>>> Have you actually observed a memory leak from the selinux_mnt_opts
>>> allocation in selinux_add_opt()?
>>>
>>> The selinux_add_opt() function has two callers:
>>> selinux_sb_eat_lsm_opts() and selinux_fs_context_parse_param().  The
>>> former cleans up the selinux_mnt_opts allocation it its error handler
>>> while the latter will end up calling
>>> security_free_mnt_opts()/selinux_free_mnt_opts() to free the
>>> fs_context:security when the fs_context is destroyed.
>>>
>>> This patch shouldn't be necessary.
>> I may not have made it clear, I said potential means may have a third
>> caller in the future.
> Let's not worry about it.  If you wanted to add a comment header to
> the function (see selinux_skb_peerlbl_sid() for an example) to make it
> clear that callers are responsible for cleaning up @mnt_opts on error
> I think that would be okay ... although even that is going to be a
> problem in the new mount API case where selinux_add_opt() is going to
> be called multiple times.
>
>> I think the error handler as following is not necessary:
>>
>> err:
>>           if (is_alloc_opts) {
>>                   kfree(opts);
>>                   *mnt_opts = NULL;
>>           }
>>
>> otherwise, some error paths goto err label while others don't, It's
>> confusing.
> That's a fair point.  Looking at the patch which added it, we should
> probably also return EINVAL when @s is NULL instead of ENOMEM.  In
> fact, in all the cases where we currently jump to @err, I think we are
> guaranteed that @is_alloc_opts is false as it requires a previously
> populated @opts.
>
> If you want to submit another patch, I would suggest doing the
> following in the patch:
>
> 1. Change the @s NULL check to return -EINVAL when @s is NULL.
> 2. Allocate @opts/@mnt_opts if NULL, but don't call kfree() on the
> object in case of error.  The new mount API will cleanup when it is
> done and selinux_sb_eat_lsm_opts() will cleanup on error.
>
> If you don't have time to put together a patch for this, let me know and I will.

no problem, I will do it, thanks for your suggestion.

>
