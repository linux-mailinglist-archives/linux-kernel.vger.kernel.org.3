Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA31586048
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 19:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiGaRyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 13:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiGaRyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 13:54:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A613AFD01;
        Sun, 31 Jul 2022 10:54:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4025460FC9;
        Sun, 31 Jul 2022 17:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCE0C433D6;
        Sun, 31 Jul 2022 17:54:01 +0000 (UTC)
Date:   Sun, 31 Jul 2022 13:53:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Tao Zhou <tao.zhou@linux.dev>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V9 01/16] rv: Add Runtime Verification (RV) interface
Message-ID: <20220731135355.713859c5@rorschach.local.home>
In-Reply-To: <5431c5e4-a8b0-738c-5143-3976cb904b9a@kernel.org>
References: <cover.1659052063.git.bristot@kernel.org>
        <a4bfe038f50cb047bfb343ad0e12b0e646ab308b.1659052063.git.bristot@kernel.org>
        <YuU7TGxm5pzmBFTx@geo.homenetwork>
        <0197dd47-ea15-4d8b-5fc7-e466d8a501a7@kernel.org>
        <YuaadlzgSJLtzOUw@geo.homenetwork>
        <20220731124730.311c8207@rorschach.local.home>
        <20220731130144.26576a6a@rorschach.local.home>
        <5431c5e4-a8b0-738c-5143-3976cb904b9a@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jul 2022 19:49:23 +0200
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> On 7/31/22 19:01, Steven Rostedt wrote:
> > static int da_monitor_init_##name(void)                                                         \
> > {                                                                                               \
> >         int slot;                                                                               \
> >                                                                                                 \
> >         slot = rv_get_task_monitor_slot();  <- if this returns positive, things break           \
> >         if (slot < 0 || slot >= RV_PER_TASK_MONITOR_INIT)                                       \
> > 
> > And we probably need slot to be negative if it is greater or equal to RV_PER_TASK_MONITOR_INIT.
> > 
> >                 return slot;                                                                    \
> >                                   
> 
> ok, there will be a problem when RV_PER_TASK_MONITOR_INIT changes to > 1. This will need to be patched to
> return negative. So far we have only one because there is only one per task monitor.
> 

Exactly. And reviewers like Tao and myself are going to continue to
flag it as a bug as we don't assume that RV_PER_TASK_MONITOR_INIT will
stay 1 ;-)

-- Steve

