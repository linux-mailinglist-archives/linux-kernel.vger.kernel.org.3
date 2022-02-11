Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFBB4B2D01
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352715AbiBKScM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:32:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242655AbiBKScK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:32:10 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E69D2C9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:32:08 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id m8so7522199ilg.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hR0BNaskgNQ2rEDEEGiZfn+Qbe1DLRpQ6GavJuM1OP8=;
        b=dFxKY8uynIlFayqwyn6IlICvauejaukqN8D68uw5nNkmD9+SNZu16EO8U6XC7wv412
         i/q5kwSRNGXCLqUkcAWumgWM3bNWLgjugW2dvS+OKzk1l05jnyBv1F82IWhj8IqnavdU
         bJ/Ak246KOcbC7J+dFGNY2rIBZIxfZOnVAkpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hR0BNaskgNQ2rEDEEGiZfn+Qbe1DLRpQ6GavJuM1OP8=;
        b=I5cY4hBDonkMRh2mJ04Xrpzt7Yp6Xy7Hrcur/rOGg8ZvktiJ5ANzjmKiEDyP8+vObh
         VsFcG5N1kBpOSRuagynAqCsEn2iv49QzRMWVh2MLHE2YZAL/tm1Y04MWDtEGM4inoMVU
         SYEeP1CsHq6AuC+XWyuMQ7RvZVd9vP4yiQVjrtHo4d8V4tEldO0IXuJv/je/lViT7YGJ
         EdKyY4f4Ic8NCr2/Dfoj2x9JczFn4yDNEvaugcfHDdGG0DUtBRF1VP75MDmLjovgPc45
         wM2z/etpwU7vkJ9GRmqTuYM/DjqL0citVCks1fTdFXEg7mkqMKN5vLoP1mxGgRVXA/ky
         lKpQ==
X-Gm-Message-State: AOAM533XODnFa27o9ML/OojhshR2b9NBvE7wPw9AFkCAhxA+INvTn3UP
        GOpgZ8AOhdlN0oRwuq5uR9/p+g==
X-Google-Smtp-Source: ABdhPJyckP23f2ZCgS5vZ2HOrMzLpFaw6fUVynBg7qm1D+pnwiRiF7ejIv1ZASLc7CZwzvDCjnbGfg==
X-Received: by 2002:a05:6e02:1c41:: with SMTP id d1mr1562233ilg.88.1644604327941;
        Fri, 11 Feb 2022 10:32:07 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id 193sm5542743iob.17.2022.02.11.10.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 10:32:07 -0800 (PST)
Subject: Re: [PATCH 6/8] ucounts: Handle inc_rlimit_ucounts wrapping in fork
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        containers@lists.linux-foundation.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
 <20220211021324.4116773-6-ebiederm@xmission.com>
 <20220211113454.socmlrne5heux7q7@example.org>
 <87sfspz409.fsf@email.froward.int.ebiederm.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <85eb952b-4bff-73fb-caaa-bf49d6b16248@linuxfoundation.org>
Date:   Fri, 11 Feb 2022 11:32:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87sfspz409.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 10:50 AM, Eric W. Biederman wrote:
> Alexey Gladkov <legion@kernel.org> writes:
> 
>> On Thu, Feb 10, 2022 at 08:13:22PM -0600, Eric W. Biederman wrote:
>>> Move inc_rlimit_ucounts from copy_creds into copy_process immediately
>>> after copy_creds where it can be called exactly once.  Test for and
>>> handle it when inc_rlimit_ucounts returns LONG_MAX indicating the
>>> count has wrapped.
>>>
>>> This is good hygenine and fixes a theoretical bug.  In practice
>>> PID_MAX_LIMIT is at most 2^22 so there is not a chance the number of
>>> processes would ever wrap even on an architecture with a 32bit long.
>>>
>>> Fixes: 21d1c5e386bc ("Reimplement RLIMIT_NPROC on top of ucounts")
>>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>> ---
>>>   kernel/cred.c | 2 --
>>>   kernel/fork.c | 2 ++
>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/cred.c b/kernel/cred.c
>>> index 229cff081167..96d5fd6ff26f 100644
>>> --- a/kernel/cred.c
>>> +++ b/kernel/cred.c
>>> @@ -358,7 +358,6 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
>>>   		kdebug("share_creds(%p{%d,%d})",
>>>   		       p->cred, atomic_read(&p->cred->usage),
>>>   		       read_cred_subscribers(p->cred));
>>> -		inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
>>>   		return 0;
>>>   	}
>>>   
>>> @@ -395,7 +394,6 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
>>>   #endif
>>>   
>>>   	p->cred = p->real_cred = get_cred(new);
>>> -	inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
>>>   	alter_cred_subscribers(new, 2);
>>>   	validate_creds(new);
>>>   	return 0;
>>> diff --git a/kernel/fork.c b/kernel/fork.c
>>> index 6f62d37f3650..69333078259c 100644
>>> --- a/kernel/fork.c
>>> +++ b/kernel/fork.c
>>> @@ -2026,6 +2026,8 @@ static __latent_entropy struct task_struct *copy_process(
>>>   		goto bad_fork_free;
>>>   
>>>   	retval = -EAGAIN;
>>> +	if (inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1) == LONG_MAX)
>>> +		goto bad_fork_cleanup_count;
>>>   	if (is_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
>>>   		if ((task_ucounts(p) != &init_ucounts) &&
>>>   		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
>>
>> It might make sense to do something like:
>>
>> 	if (inc_rlimit_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1, rlimit(RLIMIT_NPROC)) == LONG_MAX) {
>> 		if ((task_ucounts(p) != &init_ucounts) &&
>> 		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
>>
>> and the new function:
>>
>> long inc_rlimit_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, long v, unsigned long rlimit)
>> {
>> 	struct ucounts *iter;
>> 	long ret = 0;
>> 	long max = rlimit;
>> 	if (rlimit > LONG_MAX)
>> 		max = LONG_MAX;
>> 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
>> 		long new = atomic_long_add_return(v, &iter->ucount[type]);
>> 		if (new < 0 || new > max)
>> 			ret = LONG_MAX;
>> 		else if (iter == ucounts)
>> 			ret = new;
>> 		max = READ_ONCE(iter->ns->ucount_max[type]);
>> 	}
>> 	return ret;
>> }
>>
>> This will avoid double checking the same userns tree.
>>
>> Or even modify inc_rlimit_ucounts. This function is used elsewhere like
>> this:
>>
>>
>> msgqueue = inc_rlimit_ucounts(info->ucounts, UCOUNT_RLIMIT_MSGQUEUE, mq_bytes);
>> if (msgqueue == LONG_MAX || msgqueue > rlimit(RLIMIT_MSGQUEUE)) {
>>
>>
>> memlock = inc_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
>> if (!allowed && (memlock == LONG_MAX || memlock > lock_limit) && !capable(CAP_IPC_LOCK)) {
>>
>>
>> In all cases, we have max value for comparison.
> 
> Good point.   The downside is that it means we can't use the same code
> in exec.  The upside is that the code is more idiomatic.
> 

Checking on this a bit more on other callers of inc_rlimit_ucounts(),
we might have another issue:

1. mqueue_get_inode() does:
      spin_lock(&mq_lock);
      msgqueue = inc_rlimit_ucounts(info->ucounts, UCOUNT_RLIMIT_MSGQUEUE, mq_bytes);
                         if (msgqueue == LONG_MAX || msgqueue > rlimit(RLIMIT_MSGQUEUE)) {
                                 dec_rlimit_ucounts(info->ucounts, UCOUNT_RLIMIT_MSGQUEUE, mq_bytes);
                                 spin_unlock(&mq_lock);


2. user_shm_lock() &shmlock_user_lock
     spin_lock(&shmlock_user_lock);
         memlock = inc_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);

         if (!allowed && (memlock == LONG_MAX || memlock > lock_limit) && !capable(CAP_IPC_LOCK)) {
                 dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);

3. user_namespace_sysctl_init() Doesn't check for max value.

4. copy_creds() doesn't check for max value in its 3 calls to inc_rlimit_ucounts()

You can see that each of these instances some callers dec_rlimit_ucounts().
They hold different locks. So do we have a window where LONG_MAX could
overflow and go unnoticed?

thanks,
-- Shuah

