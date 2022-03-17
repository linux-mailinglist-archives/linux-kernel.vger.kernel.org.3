Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34E74DCA93
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbiCQP4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiCQP4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:56:13 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14312013DC;
        Thu, 17 Mar 2022 08:54:56 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w8so4779574pll.10;
        Thu, 17 Mar 2022 08:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mMOjieI0qzIYfRMDlfr5HCocAdYTGwybirX7HeVkJU4=;
        b=JI1FfV3dtK4SWgK8jB1/DulUo5IGShqwyM+DnQc7ctLk1RRIqBYwEJkXjlWXfw+GaH
         1NPxSFy4whY9/lMlGDGORM6mL/wIENFVmcb1cadAFVhpnxZs/iXEkWAzhABiCi5TrGqs
         hK6QUwVpZpKycjOwbXtlziVa/7XqQrVnEwANFp178Gzzc9TBNrMQVJdSWK5/FYVLKqEn
         AuwkTKQh6tHJKRVXCsqUD2YL94pERiYQZ6QzfwALFFl9kiLzRiGqqIZfwKcvbJrpEcZN
         uE3bKv8V8RGs/MPrKECYJt9Z7jQTzdltZl//5aweUbOWPKCiSRCZEkGoOb4ev98F9Mau
         sxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mMOjieI0qzIYfRMDlfr5HCocAdYTGwybirX7HeVkJU4=;
        b=NNgGOELtzEJ2sW3qGH4x6nEEC6t6o02E1AIcoYSj0OuIDsZYS73LPzEt4kYSVIYUCb
         vD4/BNIO4yZ+u/RvSjx8dwSZQxF04yQ39u9VFsd3XxP0zXIODK/uL/U9svMhLVIaYw4S
         LLiUu4ZkUQjO5PDWVDzexbebRci9d2cpearkw37IVBm9ITfqjNn887J50enn1sA5sxmF
         dpz1jVuNRw4cv+3IBxYgnnrIdto/nXgXvTmrtsT8YmwttuEeXjuT+wQ9xl7rwdryLBOg
         LCrlecu3lTZePSkuqk+AnVsXJm+R6qbfNkCsSg6OcjqczvXp0G+h7/1Kytnqu4DaNXLw
         hpfg==
X-Gm-Message-State: AOAM533TKODcWeMSZkQfAhocx+OTgUbBteIdyMpTnLEJSzEsONPra+Om
        Dq/WHU5wGhVKOFStZpqkk+s=
X-Google-Smtp-Source: ABdhPJxTUsWJRzKPehFk9oW8+4UiaTh7irzqPW+toW8+lAAD8aF/O5DgiVyHD14uXvxupvng4JXIjg==
X-Received: by 2002:a17:902:7610:b0:151:6152:549c with SMTP id k16-20020a170902761000b001516152549cmr5466701pll.91.1647532496165;
        Thu, 17 Mar 2022 08:54:56 -0700 (PDT)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004f1111c66afsm7904707pfl.148.2022.03.17.08.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 08:54:55 -0700 (PDT)
Date:   Thu, 17 Mar 2022 15:54:51 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     rcu <rcu@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RCU: undefined reference to irq_work_queue
Message-ID: <YjNZy2luiN0E1JNN@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <YjMcZexG/kJepYDi@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <CAABZP2wZgZGAg5iVry21suEZ3e2PXhAhfwLvRCPvMRU5+zGG+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABZP2wZgZGAg5iVry21suEZ3e2PXhAhfwLvRCPvMRU5+zGG+g@mail.gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 11:22:28PM +0800, Zhouyi Zhou wrote:
> Hi,
> 
> On Thu, Mar 17, 2022 at 8:48 PM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> >
> > Hello RCU folks,
> >
> > I like to use minimal configuration for kernel development.
> > when building with tinyconfig + CONFIG_PREEMPT=y on arm64:
> I invoke cross compiler to reproduce the bug on my X86 machine
> $make  ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
> CC=aarch64-linux-gnu-gcc-10 tinyconfig
> let CONFIG_PREEMPT=y  in .config
> $make  ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
> CC=aarch64-linux-gnu-gcc-10 -j 16
> LD      vmlinux
> aarch64-linux-gnu-ld: kernel/rcu/update.o: in function `call_rcu_tasks':
> update.c:(.text+0xb30): undefined reference to `irq_work_queue'
> update.c:(.text+0xb30): relocation truncated to fit: R_AARCH64_CALL26
> against undefined symbol `irq_work_queue'

Right. that was exactly what I faced :)

> >
> > ld: kernel/rcu/update.o: in function `call_rcu_tasks':
> > update.c:(.text+0xb2c): undefined reference to `irq_work_queue'
> > update.c:(.text+0xb2c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `irq_work_queue'
> > make: *** [Makefile:1155: vmlinux] Error 1
> >
> > It seems RCU calls irq_work_queue() without checking if CONFIG_IRQ_WORK is enabled.
> >
> > --
> > Thank you, You are awesome!
> > Hyeonggon :-)

> Meanwhile, there is no error for doing the same to build X86 kernel.
> I think the reason is:
> arch/x86/Kconfig select PERF_EVENT
> and PERF_EVENT select IRQ_WORK

Right. selecting anything that selects IRQ_WORK solves the problem.
Simply enabling printk also solves this.

> Hope my little research could provide some clues to solve the problem ;-)

Thank you for kind reply!

BTW, can we just fix this? (e.g. by conditionally compiling the problematic
code or always selecting IRQ_WORK)

> You are welcome
> Cheers
> Zhouyi

-- 
Thank you, You are awesome!
Hyeonggon :-)
