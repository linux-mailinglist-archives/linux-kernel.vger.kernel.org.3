Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99294C5C99
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 16:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiB0PfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 10:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiB0PfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 10:35:10 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A374706A
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 07:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2jzM5G+jDFWNsvZXeWW9MAnYJtKTGI7nZmKfJNemupw=; b=XVqHlmRpyTgJXW0pExxOAMHaBv
        nY9p22KH+nuicxSSG3LKf7nl7gogVZFJqRDI98OSkGlLavH/5bZIx89S1a/2xJwXmW9Zh5y0AQc1l
        Pw/vbn6id/vSHHoiM01GBxlqS+exysWmERi6kl+M2U8d23sP4uRRoKpxkGsa8/SqIM5V5lXI6unX1
        2P0qfTcRN+3LYBXv2K+4IaeO71fAe5+8GrclIGKiXbJpIB90BWT6HAwtM1CCJ2iYtXDvqmIUIGBPD
        l/JZrZqJLBonLaNBLDHQnKCAtwd2Sag2q1KQJG9nNB6byN2CrBhdujMyqD93mGzMoeKDLuJZLiXcP
        99TP52ZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOLYN-00DaBz-Ud; Sun, 27 Feb 2022 15:33:44 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 40A8B986209; Sun, 27 Feb 2022 16:33:42 +0100 (CET)
Date:   Sun, 27 Feb 2022 16:33:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ed Tsai <ed.tsai@mediatek.com>
Subject: Re: [PATCH v3 0/2] sched/tracing: sched_switch prev_state reported
 as TASK_RUNNING when it's not
Message-ID: <20220227153342.GD11184@worktop.programming.kicks-ass.net>
References: <20220120162520.570782-1-valentin.schneider@arm.com>
 <20220121121558.618b98e7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121121558.618b98e7@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 12:15:58PM -0500, Steven Rostedt wrote:
> 
> This all looks fine to me:
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Peter, want to take this through your tree?

Queued up now. Thanks!
