Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7ECE4CB56A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiCCDVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiCCDU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:20:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB26869CD7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:20:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F0FE61700
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9CEC004E1;
        Thu,  3 Mar 2022 03:20:12 +0000 (UTC)
Date:   Wed, 2 Mar 2022 22:20:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 0/2] tracing: Add a way to have custom events in the
 tracefs directory
Message-ID: <20220302222011.46102726@rorschach.local.home>
In-Reply-To: <20220303103101.913c64b92bc7a65e90e22eb1@kernel.org>
References: <20220302032414.503960863@goodmis.org>
        <20220303103101.913c64b92bc7a65e90e22eb1@kernel.org>
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

On Thu, 3 Mar 2022 10:31:01 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Tue, 01 Mar 2022 22:24:14 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > We would like to have in production a way to record sched wakeups and
> > sched switch, and be able to save the information in a small file
> > with as much available as possible. Currently the wake up and sched switch
> > events are 36 and 64 bytes each (plus a 4 byte ring buffer event header).
> > 
> > By having a custom module tap into the sched switch and waking trace points
> > we can bring those events down to 16 and 14 bytes respectively.  
> 
> OK, so we can use eprobe to shrink down the 'visible' log for the event,
> but it still consumes the event buffer because eprobe will fetch the event
> data from the event log. So to reduce the actual consumption of the
> trace buffer, we have to define a new event format and callback.
>

Well, the buffer content itself is shrunk, and we were using eprobes to begin
with for this purpose. The issue is that eprobes still needs to record the
event into a temporary buffer (or the ring buffer then discard it) to
copy the data into the eprobe. This makes using eprobes slower than the
event it is taken from, as the event it is attached to must run first.

Since we have the ability to create a custom module, to do this
directly, and this is much smaller and even a bit faster than the
tracepoints we are attached to.

-- Steve
