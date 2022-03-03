Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C3B4CB453
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiCCBbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiCCBbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:31:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511471A3610
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:31:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06C0FB8219C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 01:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1756CC004E1;
        Thu,  3 Mar 2022 01:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646271065;
        bh=yVgRgw5m5lLT1E7Nmm6XCellHV2rWD6CVIFlpue1JpM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rs8Ae2JjbWRyO1xU/GDANYjS3hg2W/bmxwfXy0Pk8pB2irZSEICLEzyVn8uN3cnsW
         wr7uIachgDUYFutNV+BCwx5MCnPS5hFzik4Qih2oDAu5G7aaj7hE9FC5yfmII0zN6y
         iSCBEDECORe13Iu2mWTHVGfZeq6ebMiGH5vQBk6Jk6KKaFLcjjZia4pMjqGFAclDWb
         qS4IxLPjjtPx7eJ7ximK9KeTCdyGFGAHglgXb/wHQcD4AxE+izEVAml3DRChnRa0ym
         j9TkMto1AiwKS/Hz3eC7ybkmj78QzEpK73M79XCW3Z4zxn/l/VMCO5mAAeg+DcQqq9
         mNgzrh2h9Qq2g==
Date:   Thu, 3 Mar 2022 10:31:01 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 0/2] tracing: Add a way to have custom events in the
 tracefs directory
Message-Id: <20220303103101.913c64b92bc7a65e90e22eb1@kernel.org>
In-Reply-To: <20220302032414.503960863@goodmis.org>
References: <20220302032414.503960863@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Mar 2022 22:24:14 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> We would like to have in production a way to record sched wakeups and
> sched switch, and be able to save the information in a small file
> with as much available as possible. Currently the wake up and sched switch
> events are 36 and 64 bytes each (plus a 4 byte ring buffer event header).
> 
> By having a custom module tap into the sched switch and waking trace points
> we can bring those events down to 16 and 14 bytes respectively.

OK, so we can use eprobe to shrink down the 'visible' log for the event,
but it still consumes the event buffer because eprobe will fetch the event
data from the event log. So to reduce the actual consumption of the
trace buffer, we have to define a new event format and callback.

Thank you,

> 
> Steven Rostedt (Google) (2):
>       tracing: Allow custom events to be added to the tracefs directory
>       tracing: Add sample code for custom trace events
> 
> ----
>  kernel/trace/trace_events.c               |   2 +
>  samples/Kconfig                           |   8 +-
>  samples/Makefile                          |   1 +
>  samples/trace_events/Makefile             |   2 +
>  samples/trace_events/trace_custom_sched.c | 280 ++++++++++++++++++++++++++++++
>  5 files changed, 292 insertions(+), 1 deletion(-)
>  create mode 100644 samples/trace_events/trace_custom_sched.c


-- 
Masami Hiramatsu <mhiramat@kernel.org>
