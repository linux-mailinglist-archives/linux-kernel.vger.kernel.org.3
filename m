Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFFE4FFA74
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbiDMPlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236604AbiDMPlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:41:25 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB1165790
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:39:04 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q12so2118729pgj.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=DxJfVoXKPdOlTQvVmyarNtB29EwfKGHS1Fifh7zsq2E=;
        b=uY45qSzf04cWaI3k4F1GEU/sSfvG/Kau1iqafXf4dkiTn0NbFnPocQtZ7UsKh0VUp2
         RXrD5gFylflMgU2H1iAm4kqNyLOeo4WpjI/0vXKCKbaHb4jBCMN1hOyJNjQqCVNXkVpn
         T6Dkw1RIZ7yizbAlbYMlGI1cdXiSpn/ULHuQdz/yJisJgC6AD7DXhe/bSCevSmdQyKeI
         LrN4SXQPYBrlRbDdCHpznTUQfUIXaRbr64sICgyOJe58vuhMjWk+WVAAFqOMSjK1n8XO
         4Lg+djptKsTjhFvckq1kNZ/qYb1ksSm3R5FTcxTCoGIwuydOVsSD0+mg/ckEG+Cvc0ps
         ucLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=DxJfVoXKPdOlTQvVmyarNtB29EwfKGHS1Fifh7zsq2E=;
        b=QkAwHH4BhMoOBpyCiFpt1bRLiM8LbIvrvvtCSyhDR/zexvsnOJ7MmrlHhPJWkRVSZX
         22s/7cuwHDDL64b+vLLtKEsu61sWUjHe9psykQMOHYMStvzQbueWc681rHWG/Dx8m1gm
         5DDtgzfWYcYCc7AvHDanBmJ3IN3Kxq1nszUkLXbGSUVPe+rGtx/lMNci+R8IEksX7n4z
         +FxgccLHnq8tRZtdN1XHXwInuxcwNSsMNgztnWQa952euA1cb/xaLyYD9z0md/RonuM4
         7TSvHrXE5m9bMn540rSIPtmWgT1KcT6YruDEcGnmZ6oNg3I/OAY8j5uJzM9Ei1qD+NAF
         RgBQ==
X-Gm-Message-State: AOAM531gm2YlnZLotU214G6NSP7TLbfPgWuNhvKsT/LQqExyaSjaxJDS
        7uHlAkn+p2tnLEBkQi/P3y88rA==
X-Google-Smtp-Source: ABdhPJzABUepV+pOKNOa/qGo8Cb9AzI31mFMtubu55738u0SxFfV1zDgoqxXQR7pdwT8dhcV6G5A9w==
X-Received: by 2002:a63:f718:0:b0:398:f14d:4915 with SMTP id x24-20020a63f718000000b00398f14d4915mr34511070pgh.9.1649864343691;
        Wed, 13 Apr 2022 08:39:03 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id h10-20020a056a001a4a00b004f7c76f29c3sm43523472pfv.24.2022.04.13.08.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 08:39:03 -0700 (PDT)
Message-ID: <43bcc403-c06b-d6b7-d042-56dd6ce714ae@linaro.org>
Date:   Wed, 13 Apr 2022 08:39:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     Tejun Heo <tj@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org,
        syzbot+e42ae441c3b10acf9e9d@syzkaller.appspotmail.com
References: <20220413095606.1182-1-hdanton@sina.com>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: [PATCH] cgroup: don't queue css_release_work if one already
 pending
In-Reply-To: <20220413095606.1182-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf,
On 4/13/22 02:56, Hillf Danton wrote:
> On Tue, 12 Apr 2022 12:24:59 -0700 Tadeusz Struk wrote:
>> Syzbot found a corrupted list bug scenario that can be triggered from
>> cgroup css_create(). The reproduces writes to cgroup.subtree_control
>> file, which invokes cgroup_apply_control_enable(), css_create(), and
>> css_populate_dir(), which then randomly fails with a fault injected -ENOMEM.
>> In such scenario the css_create() error path rcu enqueues css_free_rwork_fn
>> work for an css->refcnt initialized with css_release() destructor,
>> and there is a chance that the css_release() function will be invoked
> 
> Could you tip-point the percpu_ref_kill needed to trigger the css_release()?

What I think happens is that the write triggers:
cgroup_subtree_control_write()->cgroup_apply_control()->cgroup_apply_control_enable()->css_create()

which, allocates and initializes the css, then fails in cgroup_idr_alloc(), 
bails out and calls queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);

then cgroup_subtree_control_write bails out to out_unlock, which then goes:

cgroup_kn_unlock()->cgroup_put()->css_put()->percpu_ref_put(&css->refcnt)->percpu_ref_put_many(ref)
which then calls ref->data->release(ref); and tries to enqueue the same causing 
list corruption in insert_work.


>> for a cgroup_subsys_state, for which a destroy_work has already been
>> queued via css_create() error path. This causes a list_add corruption
>> as can be seen in the syzkaller report [1].
>> This can be avoided by adding a check to css_release() that checks
>> if it has already been enqueued.
>>
>> [1] https://syzkaller.appspot.com/bug?id=e26e54d6eac9d9fb50b221ec3e4627b327465dbd
> 
> Given my failure of finding the lore URL to what was
> Reported-by: syzbot+e42ae441c3b10acf9e9d@syzkaller.appspotmail.com
> such a link is welcome to see the list corruption.
> 

syzkaller doesn't send reports to any kernel mailing lists that are rachived in 
lore. The relevant links can be found in the dashboard, link [1] in the patch.

https://syzkaller.appspot.com/bug?id=e26e54d6eac9d9fb50b221ec3e4627b327465dbd

See the links in:
Crash: BUG: corrupted list in insert_work (log)

crash: https://syzkaller.appspot.com/text?tag=CrashReport&x=11bd5e9b700000
log: https://syzkaller.appspot.com/text?tag=CrashLog&x=16bd5e9b700000

>>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Zefan Li <lizefan.x@bytedance.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: Andrii Nakryiko <andrii@kernel.org>
>> Cc: Martin KaFai Lau <kafai@fb.com>
>> Cc: Song Liu <songliubraving@fb.com>
>> Cc: Yonghong Song <yhs@fb.com>
>> Cc: John Fastabend <john.fastabend@gmail.com>
>> Cc: KP Singh <kpsingh@kernel.org>
>> Cc: <cgroups@vger.kernel.org>
>> Cc: <netdev@vger.kernel.org>
>> Cc: <bpf@vger.kernel.org>
>> Cc: <stable@vger.kernel.org>
>> Cc: <linux-kernel@vger.kernel.org>
>>
>> Reported-by: syzbot+e42ae441c3b10acf9e9d@syzkaller.appspotmail.com
>> Fixes: 8f36aaec9c92 ("cgroup: Use rcu_work instead of explicit rcu and work item")
>> Signed-off-by: Tadeusz Struk <tadeusz.struk@linaro.org>
>> ---
>>   kernel/cgroup/cgroup.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index adb820e98f24..9ae2de29f8c9 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -5210,8 +5210,11 @@ static void css_release(struct percpu_ref *ref)
>>   	struct cgroup_subsys_state *css =
>>   		container_of(ref, struct cgroup_subsys_state, refcnt);
>>   
>> -	INIT_WORK(&css->destroy_work, css_release_work_fn);
>> -	queue_work(cgroup_destroy_wq, &css->destroy_work);
>> +	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT,
>> +			      work_data_bits(&css->destroy_work))) {
>> +		INIT_WORK(&css->destroy_work, css_release_work_fn);
>> +		queue_work(cgroup_destroy_wq, &css->destroy_work);
>> +	}
>>   }
>>   
>>   static void init_and_link_css(struct cgroup_subsys_state *css,
>> -- 
>> 2.35.1
>>

-- 
Thanks,
Tadeusz
