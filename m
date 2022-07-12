Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85795711E5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 07:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiGLFmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 01:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiGLFmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 01:42:51 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C3D313B7;
        Mon, 11 Jul 2022 22:42:50 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w2so8663381ljj.7;
        Mon, 11 Jul 2022 22:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zM+7Ia0D1LFOseCqEI+gePQBl/sXqgJrHhwF1LURLE=;
        b=k6TvCtfYb0GAcCDtxZakimrltkcWBauzi5MAwiEvJQ6LLQFkLOUwa76avTftgSW5+N
         L3U2Nup6Yq6lHfBk/2X9zDN3SxdCLkIkhT+rVQ6+v91ePnhPQMmyQmkxwYlxxCdx0pcS
         z9LVgipZle4P4seLSZPWRg+SsVR5TyImdoxa4r7Gooy6mBXVqQZOZytwL9RujSDW+nhh
         IDiSEBo7go5F3xaIq24n2KvypVnjjbvA1N2u1DYroCPlOAGz3tIO+dMdcNk7/prc5bxy
         NOBxZOcx8ln2yst1zHoE01ozuy5DwIxH2WaJatTYvaqDpPm3uiSqgzHyt8ysG5Z8MWgr
         h+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zM+7Ia0D1LFOseCqEI+gePQBl/sXqgJrHhwF1LURLE=;
        b=sICnFqNxGOCssLKCc2O/bJucw4ZIxPVMxQmV4iu5AuyC0HlyM9LE6aE7cjN2f9hhog
         ot9dFpU8nBvGX6Ba87FJxmnInAFWyoHH/31svxGeV+jP5Nz3qREmCXA8tQIC7Sw5Pol5
         +zvVb05rX4CZ0zzczg+hfUzHJNnmM+Wak/L6iRP/LxB34oDHOrGYM9mi4emcCSFlVgWX
         tQ7X9XPjeRHQZVomoZyOweMPmPsRQwhS6GgTGHil6g6BxHKTfi6wpxzCwomhsIjl8zD/
         n+yWTgbUwdkzMg2hRWBOCWKfTTKzTYploak5MQc92R266LWLlbVlgh4QEwhPRd+AvSea
         FUhw==
X-Gm-Message-State: AJIora84ybh4WO+HoXvXivQspsfgRwKfDhd/3/x6zEpABmBP7JPpMbL8
        euC4yz8yop4cA84SYUnU4UQ+ajHAEuOl30Ua1i0=
X-Google-Smtp-Source: AGRyM1smKoP6j10YSShEe0VSHveXNwgOlrbfQpQgOtak3lrvYAl8B+R7Gp4kP7bJY5bcoiSbHCy7TCuEfvCcq9AiKuA=
X-Received: by 2002:a2e:9004:0:b0:25a:6dee:4ae2 with SMTP id
 h4-20020a2e9004000000b0025a6dee4ae2mr12484732ljg.33.1657604568554; Mon, 11
 Jul 2022 22:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220705123705.764-1-xuewen.yan@unisoc.com> <20220711174629.uehfmqegcwn2lqzu@wubuntu>
 <YsyO9GM9mCydaybo@slm.duckdns.org> <20220711171130.6390600b@gandalf.local.home>
In-Reply-To: <20220711171130.6390600b@gandalf.local.home>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Tue, 12 Jul 2022 13:42:37 +0800
Message-ID: <CAB8ipk87YFtnTDz6MQv6ooruM_iROa+3vMeOWctpN8bba3xfkQ@mail.gmail.com>
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
        Lukasz Luba <Lukasz.Luba@arm.com>,
        "pengcheng.lai@unisoc.com" <pengcheng.lai@unisoc.com>
Content-Type: multipart/mixed; boundary="0000000000007d080b05e39523cd"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007d080b05e39523cd
Content-Type: text/plain; charset="UTF-8"

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
                          cpuhp/6
  kthreadd

cgroup_file_write                                          device_online
cgroup1_tasks_write                                              ...
__cgroup1_procs_write                                      _cpu_up
write(&cgroup_threadgroup_rwsem); <<     cpus_write_lock();<<
cgroup_attach_task                                               ......
cgroup_migrate_execute                             cpuhp_kick_ap
--------->  cpuhp_thread_fun
cpuset_attach                                               //waiting
for cpuhp             cpuhp_invoke_callback
cpus_read_lock()
                             cpuhp_cpufreq_online

                                         cpufreq_online
 //blocked
                                    sugov_init

                                        __kthread_create_on_node
      kthreadd

                                       //blocked, waiting for kthreadd
         copy_process


                          cgroup_can_fork


                          cgroup_css_set_fork


                          __acquires(&cgroup_threadgroup_rwsem)

So it's logic is:
Thread-A ----->Thread-B------>cpuhp----->kthreadd-----
     ^
              |
     |<---------------------------------------------------------------<-

When cpu offline, the sugov thread would stop, so it would waiting
cgroup_threadgroup_rwsem when kthread_stop();
It's logic is:
Thread-A ----->Thread-B------>cpuhp-------->sugov-----
     ^
              |
     |<---------------------------------------------------------------<-


As Qais said:
> if there's anything else that creates a kthread when a cpu goes online/offline
> then we'll hit the same problem again.

Indeed, only the cpuhp thread create/destroy kthread would cause the case.


I have put the test script in the mail, and I have tested it without
monkey test, the deadlock still occurs..


Thanks!
xuewen.yan

--0000000000007d080b05e39523cd
Content-Type: text/x-sh; charset="US-ASCII"; name="test_hotplug.sh"
Content-Disposition: attachment; filename="test_hotplug.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_l5hqxkdb0>
X-Attachment-Id: f_l5hqxkdb0

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
--0000000000007d080b05e39523cd--
