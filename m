Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C77756714F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiGEOjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiGEOjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:39:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FAE656E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09329619D9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 14:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917FEC341C7;
        Tue,  5 Jul 2022 14:39:02 +0000 (UTC)
Date:   Tue, 5 Jul 2022 10:39:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sascha Hauer <sha@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ingo Molnar <mingo@redhat.com>, kernel@pengutronix.de
Subject: Re: Performance impact of CONFIG_FUNCTION_TRACER
Message-ID: <20220705103901.41a70cf0@rorschach.local.home>
In-Reply-To: <20220705105416.GE5208@pengutronix.de>
References: <20220705105416.GE5208@pengutronix.de>
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

On Tue, 5 Jul 2022 12:54:16 +0200
Sascha Hauer <sha@pengutronix.de> wrote:

> Hi,
> 
> I ran some lmbench subtests on a ARMv7 machine (NXP i.MX6q) with and
> without CONFIG_FUNCTION_TRACER enabled (with CONFIG_DYNAMIC_FTRACE
> enabled and no tracing active), see below. The Kconfig help text of this
> option reads as:
> 
> > If it's runtime disabled (the bootup default), then the overhead of
> > the instructions is very small and not measurable even in
> > micro-benchmarks.  

Well, this is true for x86 ;-)

> 
> In my tests the overhead is small, but it surely exists and is
> measurable at least on ARMv7 machines. Is this expected? Should the help
> text be rephrased a little less optimistic?

You mean "(but may vary by architecture)"

As I believe due to using a link register for function calls, ARM
requires adding two 4 byte nops to every function where as x86 only
adds a single 5 byte nop.

Although nops are very fast (they should not be processed in the CPU's
pipe line, but I don't know if that's true for every arch). It also
affects instruction cache misses, as adding 8 bytes around the code
will cause more cache misses than when they do not exist.

Also, there's some configurations that use the old mcount that does add
some more code to handle the mcount case.

So if this is just to have us change the kconfig, I'm happy to do that.

-- Steve
