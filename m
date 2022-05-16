Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97613528AC2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343772AbiEPQnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiEPQnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:43:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2D23C49B;
        Mon, 16 May 2022 09:43:02 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bq30so26874496lfb.3;
        Mon, 16 May 2022 09:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6TEXOrGonqBHDI02WFnDT6MZU0GuS1E5oZr7DwmRQAE=;
        b=k7f6XYZbJ94FfyJk0wON7y+wwoOp7Vh5HPgELgN8BlLX48kImxK1qow61S2S1F3Dv5
         s6uSu+tUtaZKll84sSTdrqwZiWxm26zBvM0euEKopvaOYQI81bDM2lil76B5QElY4ocr
         d4+ysb85T9ZYB/iLJAt15pb1x/r2oklBQVSnIo07B7TAJrDriWsuVGkIHIRLFS3DM8eV
         e/kZuEZEdIsW+ZbWy1d7uaT0fGvEaL/HODMGlvsXpjGR32JP6go7pRw9i7ESSvSYoZLM
         sjxMyz0+sZCZ2gA12/nQclnBNddLVsXo14Lhz2ukcjUSgKquzLPCyOIv4fUV+B5c1Xxj
         8NoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6TEXOrGonqBHDI02WFnDT6MZU0GuS1E5oZr7DwmRQAE=;
        b=32WZOjNwk/plIM+dsB5kufcJlP5n0XCvJzMzF88CZ8HCDlc/wWml6ruV8ZrpC3DKLO
         mWEh3zzVUVosR886+EyNRDpefb4BpUg4Ug2K+csDBUHVzR2+3wH4Iy5GwHCY9aWAyrGy
         fKOWqgFeh2VU6Ddf8GEjJg1bzVMwdGEWfNbILiOkDyzdy510607L8a2AdcOQS73dk/Wo
         10Gvkt+zgJJAXuogVNZw/YUIDp5qnG+o2ZZuJRBeCuGbZQFBv2aGEPDivAmz1X+nD1Jv
         +6yDh9AUsyFr7QHa/czNTxcC9Evz7czk/ZvolarX0vok88CDgAfyO4hNnGUdbakDERCT
         P0fA==
X-Gm-Message-State: AOAM532Qga6tzLHZCqrdno/k+EqTEXR6Gj1yHdgCKBItCtqRVYl50x2g
        l+E0dReBrVbyWOmqUlNbBvY=
X-Google-Smtp-Source: ABdhPJz0JReZOUil7DxxnqlPA11+PNCL6YSbtUkJsX81BjvMmOSPXOvlo0gAEMW85b/+OVDIaAT53g==
X-Received: by 2002:ac2:504e:0:b0:471:fa2a:fad with SMTP id a14-20020ac2504e000000b00471fa2a0fadmr13722570lfm.148.1652719381168;
        Mon, 16 May 2022 09:43:01 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id bg14-20020a05651c0b8e00b0024f3d1daee0sm1563840ljb.104.2022.05.16.09.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 09:43:00 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 16 May 2022 18:42:58 +0200
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alison Chaiken <achaiken@aurora.tech>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] rcu/nocb: Add an option to ON/OFF an offloading from RT
 context
Message-ID: <YoJ/ElNTZpd7cY7L@pc638.lan>
References: <CAEXW_YSbWetMt2_-m4G9Nt5S8ybATihB+5FMJMMo3jKDG4pPjg@mail.gmail.com>
 <20220509181417.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnldSkaWu40cVimj@pc638.lan>
 <20220510100135.62a4f7df@gandalf.local.home>
 <Ynu8rM42aSyGN7li@pc638.lan>
 <20220511102957.56bd582b@gandalf.local.home>
 <YnvNbRcd3KRfQW3C@pc638.lan>
 <YnvN3PPds3BlZ5fi@pc638.lan>
 <Ynvvto4xcK1dn8iA@pc638.lan>
 <20220516122259.3bc2b3de@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516122259.3bc2b3de@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 11 May 2022 19:17:42 +0200
> Uladzislau Rezki <urezki@gmail.com> wrote:
> 
> > OK. It was added on the latest kernel:
> > 
> > root@pc638:/home/urezki# cat /sys/kernel/debug/tracing/trace_pipe
> >   vmalloc_test/0-1296    [062] b....    18.157470: 0xffffffffc044e5dc: -> in the local_bh_disable()
> > 
> > root@pc638:/home/urezki# cat /sys/kernel/debug/tracing/trace
> > # tracer: nop
> > #
> > # entries-in-buffer/entries-written: 0/0   #P:64
> > #
> > #                                _-----=> irqs-off/BH-disabled
> > #                               / _----=> need-resched
> > #                              | / _---=> hardirq/softirq
> > #                              || / _--=> preempt-depth
> > #                              ||| / _-=> migrate-disable
> > #                              |||| /     delay
> > #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > #              | |         |   |||||     |         |
> > root@pc638:/home/urezki# uname -a
> > Linux pc638 5.17.0-rc2-next-20220201 #63 SMP PREEMPT Tue May 10 20:39:08 CEST 2022 x86_64 GNU/Linux
> > root@pc638:/home/urezki#
> > 
> > so it shows *bh* disabled sections.
> 
> Ah yes. That was added with commit 289e7b0f7eb47 ("tracing: Account bottom
> half disabled sections."). Maybe I should mark that as stable?
> 
BTW, a commit message of the "289e7b0f7eb47" change exactly describes
my first thought why it behaves like that. So if it is possible it would
be great to have it in the 5.10 and 5.15 stable kernels.

Thanks!

--
Uladzislau Rezki
