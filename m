Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAD355EDA1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbiF1TJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbiF1TJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:09:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796CF18B1E;
        Tue, 28 Jun 2022 12:09:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23DBEB81F65;
        Tue, 28 Jun 2022 19:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3367C3411D;
        Tue, 28 Jun 2022 19:09:30 +0000 (UTC)
Date:   Tue, 28 Jun 2022 15:09:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V4 15/20] Documentation/rv: Add deterministic automata
 monitor synthesis documentation
Message-ID: <20220628150929.35911ab2@gandalf.local.home>
In-Reply-To: <65c0f41a30850002cac84f143616f932d147251d.1655368610.git.bristot@kernel.org>
References: <cover.1655368610.git.bristot@kernel.org>
        <65c0f41a30850002cac84f143616f932d147251d.1655368610.git.bristot@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 10:44:57 +0200
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> +DA monitor synthesis in a nutshell
> +------------------------------------------------------
> +
> +The synthesis of automata-based models into the Linux *RV monitor* abstraction
> +is automated by a tool named "dot2k", and the "rv/da_monitor.h" provided
> +by the RV interface.
> +
> +Given a file "wip.dot", representing a per-cpu monitor, with this content::

Specify what "wip" is here too.

-- Steve

> +
> +  digraph state_automaton {
> +	center = true;
> +	size = "7,11";
> +	rankdir = LR;
> +	{node [shape = circle] "non_preemptive"};
> +	{node [shape = plaintext, style=invis, label=""] "__init_preemptive"};
> +	{node [shape = doublecircle] "preemptive"};
> +	{node [shape = circle] "preemptive"};
> +	"__init_preemptive" -> "preemptive";
> +	"non_preemptive" [label = "non_preemptive"];
> +	"non_preemptive" -> "non_preemptive" [ label = "sched_waking" ];
> +	"non_preemptive" -> "preemptive" [ label = "preempt_enable" ];
> +	"preemptive" [label = "preemptive"];
> +	"preemptive" -> "non_preemptive" [ label = "preempt_disable" ];
> +	{ rank = min ;
> +		"__init_preemptive";
> +		"preemptive";
> +	}
> +  }
> +
