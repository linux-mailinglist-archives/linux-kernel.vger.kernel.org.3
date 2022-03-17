Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A3E4DC81F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbiCQOB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbiCQOBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:01:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B8E1E31BA;
        Thu, 17 Mar 2022 07:00:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E44E3B81E9E;
        Thu, 17 Mar 2022 14:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF4FC340ED;
        Thu, 17 Mar 2022 14:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647525600;
        bh=FsXnLpvuwrnZJL+9hSDFu0U3Tmtv14ERqUsxk7V5DjQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oY75XE6PhHFsePv/9o7mdFpveQpH2BeQ9lmEsb2rwhFLl/8IzIiNeHWjYPXRY0zpz
         gWNtfka58zm05oQbUQGycnFBKqBaiEb8NM4Fv98gJMsCZUWNZPDm5quSTMR8SJI/e/
         VxTAPFMDzqX7luucRDawg30/KCAMfJzCBhakUVCvzoKts5Nnu+kvVNmRL7wxTlE5tl
         vAEcvEcXCRX5OCIP+KvjOxYX4WbSUxzsd3AgexF65DoOTPRhWvzZ9QG7TMYJfEWHRk
         kdBCnGe41QS7HVPBFDiqGsja3m2Ids2gR4sqr09qfZNFCddt3no5ScZU/50d8BWWwK
         lZX2pTb1VJVfQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 54F9B5C0341; Thu, 17 Mar 2022 07:00:00 -0700 (PDT)
Date:   Thu, 17 Mar 2022 07:00:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: Re: RCU: undefined reference to irq_work_queue
Message-ID: <20220317140000.GO4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YjMcZexG/kJepYDi@ip-172-31-19-208.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjMcZexG/kJepYDi@ip-172-31-19-208.ap-northeast-1.compute.internal>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 11:32:53AM +0000, Hyeonggon Yoo wrote:
> Hello RCU folks,
> 
> I like to use minimal configuration for kernel development.
> when building with tinyconfig + CONFIG_PREEMPT=y on arm64:
> 
> ld: kernel/rcu/update.o: in function `call_rcu_tasks':
> update.c:(.text+0xb2c): undefined reference to `irq_work_queue'
> update.c:(.text+0xb2c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `irq_work_queue'
> make: *** [Makefile:1155: vmlinux] Error 1
> 
> It seems RCU calls irq_work_queue() without checking if CONFIG_IRQ_WORK is enabled.

Indeed it does!

And kernel/rcu/Kconfig shows why:

config TASKS_TRACE_RCU
	def_bool 0
	select IRQ_WORK
	help
	  This option enables a task-based RCU implementation that uses
	  explicit rcu_read_lock_trace() read-side markers, and allows
	  these readers to appear in the idle loop as well as on the CPU
	  hotplug code paths.  It can force IPIs on online CPUs, including
	  idle ones, so use with caution.

So the solution is to further minimize your configuration so as to
deselect TASKS_TRACE_RCU.  This means making sure that both BPF and
the various RCU torture tests are all deselected.

Or turn on IRQ_WORK, for example, if you need to use BPF.

							Thanx, Paul
