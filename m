Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EF057120B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 07:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiGLF6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 01:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGLF6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 01:58:13 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE8593C11;
        Mon, 11 Jul 2022 22:58:12 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 19so8690099ljz.4;
        Mon, 11 Jul 2022 22:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=98QKZRRjktULyJB2oCAwRiwYRLiFSUT43FJ/8QHRm0w=;
        b=bhAW/UXIPy2w3FRdyp4jeJuD5oIGA+F8MgG9CjKYC0G5axKlRNfujDhGg5HS692ZvB
         bH3i9WxKSOpfyinMUz6RwdFVaoYOzd85/+SiOspohofTvK3yJbDjsx3M0lfp+JooL5NA
         0xo1sd8iw+QU8SrzP0pQW2BFCayCVu8QWST3tM0+wZwVECKbmzN+JRVJPUiiLTC6x3pf
         nuedpfCfFslzY79ebXVpgsulhA4qzifP+D3yv59bjMcMzzAKYebbWPlZGLMhiSNx2oc7
         HDMN9jKGcm+bVsgCBXSSL63SCIgDtaNWjcUzc2+IJZNK4wj7iHnkkXvTTzcvjYulG4x7
         1ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=98QKZRRjktULyJB2oCAwRiwYRLiFSUT43FJ/8QHRm0w=;
        b=eDX3NKiqyl0OvMCT3P4hiwabvxzCv9EaWyJxJFzCWy/N1DRTLwZ4ku6UiWLs684a22
         XEw2rS2qg7+JXjwXJ2mnRqnOJB2se/K/GMDFs6dwjtKKEx7bGS9CHtHWaiNILozaJD1K
         eq4DVr5h21/5Gmd7WM+T4q3DWG7VrET/wswbvqKQt8rEvZHkFFPNIf6SCC0pxKb7z2Ar
         PfP5PQzyuHd0rf+yGQ4n4TSXPZMwBNl9IMeVfgY9vl+D0UTun0yxyh1wC5JBJd8hvhf4
         KqORgURycU2hgh4jVcVFbRd4puwmVvV54OGqmnTvWqSwnQerXQV1229GXs7uAYQZ66+K
         vuow==
X-Gm-Message-State: AJIora+UWzRE5ynafw2mB7hLZAoOXDXuk11lzPj6BKMPcUQaGrHg8Yji
        B0+p1jSDzLAMzVXqFcAF7QwQytYUlTLzLuQHm6Q=
X-Google-Smtp-Source: AGRyM1vf7m6B3lMY7xYvcR71EEYqtwR8FdBdq3JSoDrsig44qrY2Efv9HRAb5GD4SmyPXtFlLCiU+b/BwZZXpa6IprM=
X-Received: by 2002:a2e:9004:0:b0:25a:6dee:4ae2 with SMTP id
 h4-20020a2e9004000000b0025a6dee4ae2mr12510646ljg.33.1657605490792; Mon, 11
 Jul 2022 22:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220705123705.764-1-xuewen.yan@unisoc.com> <20220711174629.uehfmqegcwn2lqzu@wubuntu>
 <YsyO9GM9mCydaybo@slm.duckdns.org> <20220711171130.6390600b@gandalf.local.home>
In-Reply-To: <20220711171130.6390600b@gandalf.local.home>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Tue, 12 Jul 2022 13:57:59 +0800
Message-ID: <CAB8ipk_mB0uo8YUj6Ct5t9BWjXba1PznJ7QL7UVg+mSO401=bg@mail.gmail.com>
Subject: Re: [PATCH] sched/schedutil: Fix deadlock between cpuset and cpu
 hotplug when using schedutil
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tejun Heo <tj@kernel.org>, Qais Yousef <qais.yousef@arm.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, xuewyan@foxmail.com, linux-pm@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Lukasz Luba <Lukasz.Luba@arm.com>
Content-Type: multipart/mixed; boundary="00000000000075055005e3955a08"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000075055005e3955a08
Content-Type: text/plain; charset="UTF-8"

[RESEND]

On Tue, Jul 12, 2022 at 5:34 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 11 Jul 2022 10:58:28 -1000
> Tejun Heo <tj@kernel.org> wrote:
>
> > I don't think lockdep would be able to track CPU1 -> CPU2 dependency here
> > unfortunately.
> >
> > > AFAIU:
> > >
> > >
> > > CPU0                                     CPU1                                   CPU2
> > >
> > > // attach task to a different
> > > // cpuset cgroup via sysfs
> > > __acquire(cgroup_threadgroup_rwsem)
> > >
> > >                                          // pring up CPU2 online
> > >                                          __acquire(cpu_hotplug_lock)
> > >                                          // wait for CPU2 to come online
>
> Should there be some annotation here that tells lockdep that CPU1 is now
> blocked on CPU2?
>
> Then this case would be caught by lockdep.
>
> -- Steve
>
>
> > >                                                                                 // bringup cpu online
> > >                                                                                 // call cpufreq_online() which tries to create sugov kthread
> > > __acquire(cpu_hotplug_lock)                                                     copy_process()
> > >                                                                                    cgroup_can_fork()
> > >                                                                                       cgroup_css_set_fork()
> > >                                                                                       __acquire(cgroup_threadgroup_rwsem)
> > > // blocks forever                        // blocks forever                            // blocks forever
> > >

Indeed, It's caused by threads instead of cpus.

Our soc contains two cpufreq policy.0-5 belongs to policy0, 6-7
belongs to policy1.

when cpu6/7 online

Thread-A                                                      Thread-B

cgroup_file_write                                          device_online
cgroup1_tasks_write                                              ...
__cgroup1_procs_write                                      _cpu_up
write(&cgroup_threadgroup_rwsem); <<     cpus_write_lock();<<
cgroup_attach_task                                               ......
cgroup_migrate_execute                             cpuhp_kick_ap
cpuset_attach                                              //wakeup cpuhp
cpus_read_lock()                                        //waitingfor cpuhp


cpuhp/6                                                        kthreadd

cpuhp_thread_fun
cpuhp_invoke_callback
cpuhp_cpufreq_online
cpufreq_online
 sugov_init
 __kthread_create_on_node                 copy_process
 //blocked, waiting for kthreadd             cgroup_can_fork
                                                        cgroup_css_set_fork
                           __acquires(&cgroup_threadgroup_rwsem)
                                                        //blocked

So it's logic is:
Thread-A --->Thread-B---->cpuhp--->kthreadd---->Thread-A

When cpu offline, the sugov thread would stop, so it would waiting
cgroup_threadgroup_rwsem when kthread_stop();
It's logic is:
Thread-A --->Thread-B---->cpuhp--->sugov---->Thread-A

As Qais said:
> if there's anything else that creates a kthread when a cpu goes online/offline
> then we'll hit the same problem again.

Indeed, only the cpuhp thread create/destroy kthread would cause the case.

I have put the test script in the mail, and I have tested it without
monkey test, the deadlock still occurs..


Thanks!
xuewen.yan

--00000000000075055005e3955a08
Content-Type: text/x-sh; charset="US-ASCII"; name="test_hotplug.sh"
Content-Disposition: attachment; filename="test_hotplug.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_l5hrh50n0>
X-Attachment-Id: f_l5hrh50n0

IyEvc3lzdGVtL2Jpbi9zaAoKaW50ZXJ2YWw9MC41CQkJCQkJCQkJCQkJCQkJCQpwYXRoPSIvc3lz
L2RldmljZXMvc3lzdGVtL2NwdS9jcHUiCm5fY3B1PWBscyAvc3lzL2RldmljZXMvc3lzdGVtL2Nw
dSB8IGdyZXAgIl5jcHVbMC05XSIgfCB3YyAtbGAKbl9wb2xpY3k9YGxzIC9zeXMvZGV2aWNlcy9z
eXN0ZW0vY3B1L2NwdWZyZXEgfCBncmVwICJecG9saWN5WzAtOV0iIHwgd2MgLWxgCgpmdW5jdGlv
biByYW5kb21faG90cGx1ZygpewoJbGV0IG5fY3B1LT0xCglsb2NhbCByZXQ9MAoJd2hpbGUgWyAx
IF0KCWRvCgkJbGV0IHJldD0kUkFORE9NJSRuX2NwdQoJCWxldCByZXQrPTEKCQlsb2NhbCBvbmxp
bmU9YGNhdCAkcGF0aCRyZXQiL29ubGluZSJgCgkJWyAiJG9ubGluZSIgPSAiMCIgXSAmJiBjbT0x
IHx8IGNtPTAKCQlvbmxpbmVfY3B1cwoJCWdldF9jcHVzPSQ/CgkJaWYgWyAiJGNtIiA9ICIxIiBd
O3RoZW4KCQkJZWNobyAkY20gPiAkcGF0aCRyZXQiL29ubGluZSIKCQkJZWNobyAib25saW5lX2Nw
dV9jb3VudD0kZ2V0X2NwdXMgbl9wb2xpY3k9JG5fcG9saWN5ICRwYXRoJHJldC9vbmxpbmUgJGNt
ICRvbmxpbmUgYGNhdCAkcGF0aCRyZXQvb25saW5lYCBgY2F0IC9zeXMvZGV2aWNlcy9zeXN0ZW0v
Y3B1L29ubGluZWAiCgkJCXNsZWVwICRpbnRlcnZhbAoJCWVsc2UKCQkJaWYgWyAiJGdldF9jcHVz
IiAtZ3QgIjIiIF07dGhlbgoJCQkJZWNobyAkY20gPiAkcGF0aCRyZXQiL29ubGluZSIKCQkJCWVj
aG8gIm9ubGluZV9jcHVfY291bnQ9JGdldF9jcHVzIG5fcG9saWN5PSRuX3BvbGljeSAkcGF0aCRy
ZXQvb25saW5lICRjbSAkb25saW5lIGBjYXQgJHBhdGgkcmV0L29ubGluZWAgYGNhdCAvc3lzL2Rl
dmljZXMvc3lzdGVtL2NwdS9vbmxpbmVgIgoJCQkJc2xlZXAgJGludGVydmFsCgkJCWVsc2UKCQkJ
CWVjaG8gIm9ubGluZV9jcHVfY291bnQ9WyAkZ2V0X2NwdXMgLWx0IDIgXSwgbl9wb2xpY3k9JG5f
cG9saWN5ICwgbmV4dCBsb29wLCAkcGF0aCRyZXQvb25saW5lICRjbSAkb25saW5lIGBjYXQgJHBh
dGgkcmV0L29ubGluZWAgYGNhdCAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9vbmxpbmVgIgoJCQlm
aQoJCWZpCgoJZG9uZQp9CgpmdW5jdGlvbiBvbmxpbmVfY3B1cygpewoJbG9jYWwgY3B1X2NvdW50
PTEKCWZvciBpIGluIGBzZXEgMSAkbl9jcHVgCglkbwoJCVsgImBjYXQgJHBhdGgke2l9L29ubGlu
ZWAiIC1lcSAiMSIgXSAmJiBsZXQgY3B1X2NvdW50PWNwdV9jb3VudCsxIAoJZG9uZQoJcmV0dXJu
ICRjcHVfY291bnQKfQoKCnJhbmRvbV9ob3RwbHVnCgoK
--00000000000075055005e3955a08--
