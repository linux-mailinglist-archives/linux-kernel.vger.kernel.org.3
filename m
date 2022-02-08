Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715AF4AE4AB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387196AbiBHWa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386911AbiBHVUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:20:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317B5C0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:20:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F014B81D94
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 21:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB4FC004E1;
        Tue,  8 Feb 2022 21:19:56 +0000 (UTC)
Date:   Tue, 8 Feb 2022 16:19:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Byungchul Park <byungchul.park@lge.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 03/12] timer: Protect lockdep functions with #ifdef
Message-ID: <20220208161954.4adde540@gandalf.local.home>
In-Reply-To: <CAM9d7cgdauVW+HdpQS_FNG4e3SRR1JP74N1Z-SX+hXZ-yDM5DQ@mail.gmail.com>
References: <20220208184208.79303-1-namhyung@kernel.org>
        <20220208184208.79303-4-namhyung@kernel.org>
        <20220208143641.7850bbc6@gandalf.local.home>
        <CAM9d7cgdauVW+HdpQS_FNG4e3SRR1JP74N1Z-SX+hXZ-yDM5DQ@mail.gmail.com>
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

On Tue, 8 Feb 2022 12:29:32 -0800
Namhyung Kim <namhyung@kernel.org> wrote:

> Hi Steve,
> 
> On Tue, Feb 8, 2022 at 11:36 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Tue,  8 Feb 2022 10:41:59 -0800
> > Namhyung Kim <namhyung@kernel.org> wrote:
> >  
> > > With upcoming lock tracepoints config, it'd define some of lockdep
> > > functions without enabling CONFIG_LOCKDEP actually.  The existing code
> > > assumes those functions will be removed by the preprocessor but it's
> > > not the case anymore.  Let's protect the code with #ifdef's explicitly.  
> >
> > I wonder if it would be cleaner to have another macro name for these
> > locations to keep out the ugly #ifdef in the code.
> >
> > lockdep_init_map_raw() ?  
> 
> Yeah, I like that..  Then I also need to add the _raw variants
> for acquire, release and so on.  Is that ok?
>

Yeah, most definitely.

Thanks,

-- Steve
