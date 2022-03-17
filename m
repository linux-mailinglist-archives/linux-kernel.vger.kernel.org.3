Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790014DC9D3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbiCQP0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiCQP0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:26:04 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC9BA76E5;
        Thu, 17 Mar 2022 08:24:47 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id o23so2900082pgk.13;
        Thu, 17 Mar 2022 08:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=usEw/9zILn/ReAk3HjpqynG8ak/iYodsJ69LtgTZqzY=;
        b=CbjChgFyksrB2uJub5ZxzqMVWwQgaeSRgsnbu9ypUCdKeCW8vzhLyiNUy45vxpiL55
         GYD4xv0OZNaU6ttC9IhC7eYHpchFyqThu5HLRiHmRjBkCttofL4BYopBHW8XYYYhA1Kl
         froexnIv3slF5j742aZLJN/ipsficHgy5PhWtaWGjnD+KJSmO4go/n1pAV1C5dKoVMqm
         tP5nBf7v1d2uympeqYYTbbFCY0IafJw+3vGz+8Ymh3CmQ5WMeuyKrW6FY+HIRQaCgtNL
         lmVgs/ARm2Dqo13VLrtnJZJWp3dPszL6vRuRVp6OjwMa5QxBlCPDkoclTqJXAsQ2VrOa
         15kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=usEw/9zILn/ReAk3HjpqynG8ak/iYodsJ69LtgTZqzY=;
        b=7Ej1W7OAj2fxrE+/8pG0YG2y1d91Q8V3UjTZGDs5NVm1Fu6iWmoMiobPw00BOcSNU5
         iQeWn7WYtrlFyPLu2c5DG9s4dcd+vaM7GapCwWANQw70E0hvDvl7ZFY7f1wV/P9kYaZ9
         vHOVXt1XypH3LRjMHdYIrPLUGNU+2ZPepEkuwJemZW0cpvkeyrE4WjuzvnavzVxvPmrS
         IP5SjQYp6C40nqMUzJSc1d4N0YQGWaD3ZIq3NLVj8lvrEm5jQu3buqERC7QeAeGwLXfU
         kyIZoBD/E0EGBipcf2XnCstBoujjy9wXXm7nelUcKfemyJES22gSgJdkLpfix4+x0yWf
         9KNw==
X-Gm-Message-State: AOAM531AZ34O8mJ4cW8Byox/kiD1zqmxWddrMWZa/Oc8vQVFK0hKNrHb
        gBVbNnJfD7moyMtbxLVTVJs=
X-Google-Smtp-Source: ABdhPJxj31GhQEKZTb405oDb5XG4l3RqAIHXD3qnUrjITDOJpIz7TjqWw751LdIXpm60i3bx4xaseA==
X-Received: by 2002:a05:6a00:c93:b0:4f7:c76:921f with SMTP id a19-20020a056a000c9300b004f70c76921fmr5009892pfv.73.1647530687172;
        Thu, 17 Mar 2022 08:24:47 -0700 (PDT)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id j14-20020a056a00174e00b004f66ce6367bsm8322798pfc.147.2022.03.17.08.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 08:24:46 -0700 (PDT)
Date:   Thu, 17 Mar 2022 15:24:42 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: Re: RCU: undefined reference to irq_work_queue
Message-ID: <YjNSuprCqjAgGgqB@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <YjMcZexG/kJepYDi@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <20220317140000.GO4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220317140000.GO4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 07:00:00AM -0700, Paul E. McKenney wrote:
> On Thu, Mar 17, 2022 at 11:32:53AM +0000, Hyeonggon Yoo wrote:
> > Hello RCU folks,
> > 
> > I like to use minimal configuration for kernel development.
> > when building with tinyconfig + CONFIG_PREEMPT=y on arm64:
> > 
> > ld: kernel/rcu/update.o: in function `call_rcu_tasks':
> > update.c:(.text+0xb2c): undefined reference to `irq_work_queue'
> > update.c:(.text+0xb2c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `irq_work_queue'
> > make: *** [Makefile:1155: vmlinux] Error 1
> > 
> > It seems RCU calls irq_work_queue() without checking if CONFIG_IRQ_WORK is enabled.
> 
> Indeed it does!
> 
> And kernel/rcu/Kconfig shows why:
> 
> config TASKS_TRACE_RCU
> 	def_bool 0
> 	select IRQ_WORK
> 	help
> 	  This option enables a task-based RCU implementation that uses
> 	  explicit rcu_read_lock_trace() read-side markers, and allows
> 	  these readers to appear in the idle loop as well as on the CPU
> 	  hotplug code paths.  It can force IPIs on online CPUs, including
> 	  idle ones, so use with caution.
> 
> So the solution is to further minimize your configuration so as to
> deselect TASKS_TRACE_RCU.

They are already not selected.

> This means making sure that both BPF and
> the various RCU torture tests are all deselected.

I wanted to say call_rcu_tasks() can be referenced even when IRQ_WORK is not
selected, making it fail to build.

> > ld: kernel/rcu/update.o: in function `call_rcu_tasks':
> > update.c:(.text+0xb2c): undefined reference to `irq_work_queue'
> > update.c:(.text+0xb2c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `irq_work_queue'
> > make: *** [Makefile:1155: vmlinux] Error 1

Isn't it better to fix this build failure?

It fails to build when both TASKS_TRACE_RCU and IRQ_WORK are not selected
and PREEMPT is selected.

  │ Symbol: TASKS_TRACE_RCU [=n]                                            │
  │ Type  : bool                                                            │
  │ Defined at kernel/rcu/Kconfig:96                                        │
  │ Selects: IRQ_WORK [=n]                                                  │
  │ Selected by [n]:                                                        │
  │   - BPF_SYSCALL [=n]                                                    │
  │   - RCU_SCALE_TEST [=n] && DEBUG_KERNEL [=y]                            │
  │   - RCU_TORTURE_TEST [=n] && DEBUG_KERNEL [=y]                          │
  │   - RCU_REF_SCALE_TEST [=n] && DEBUG_KERNEL [=y]

Thanks!

> 
> Or turn on IRQ_WORK, for example, if you need to use BPF.
> 
> 							Thanx, Paul

-- 
Thank you, You are awesome!
Hyeonggon :-)
