Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D669B5668B3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiGEKzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiGEKyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:54:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5146C15FD9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:54:19 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1o8gCA-00042x-6S; Tue, 05 Jul 2022 12:54:18 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1o8gC8-0005Te-EP; Tue, 05 Jul 2022 12:54:16 +0200
Date:   Tue, 5 Jul 2022 12:54:16 +0200
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, kernel@pengutronix.de
Subject: Performance impact of CONFIG_FUNCTION_TRACER
Message-ID: <20220705105416.GE5208@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Sascha Hauer <sha@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I ran some lmbench subtests on a ARMv7 machine (NXP i.MX6q) with and
without CONFIG_FUNCTION_TRACER enabled (with CONFIG_DYNAMIC_FTRACE
enabled and no tracing active), see below. The Kconfig help text of this
option reads as:

> If it's runtime disabled (the bootup default), then the overhead of
> the instructions is very small and not measurable even in
> micro-benchmarks.

In my tests the overhead is small, but it surely exists and is
measurable at least on ARMv7 machines. Is this expected? Should the help
text be rephrased a little less optimistic?

lat_fs
======

CONFIG_FUNCTION_TRACER=y
------------------------

  _ file size
 /        _ repetitions
 |       /         _ created files per second
 |       |        /        _ deleted files per second
 |       |        |       /
0k      205     38325   70264
1k      123     21949   41495
4k      119     21632   42365
10k     84      14408   29439

CONFIG_FUNCTION_TRACER=n
------------------------

0k      198     39317   76241
1k      125     22397   42420
4k      125     22038   44144
10k     84      14965   30032

./scripts/do_ctx
================

Measures context switch time (in us?)

CONFIG_FUNCTION_TRACER=y
------------------------
"size=0k ovr=4.60
2 16.57
4 15.75
8 16.99
16 16.93
24 18.79
32 20.11
64 22.20
96 21.59

CONFIG_FUNCTION_TRACER=n
------------------------
"size=0k ovr=4.88
2 15.26
4 17.29
8 18.25
16 18.40
24 22.19
32 20.85
64 23.32
96 23.11
 
lat_pipe
========

I think it measures the time between sending and receiving data
through a pipe.

CONFIG_FUNCTION_TRACER=y
------------------------
Pipe latency: 44.7039 microseconds

CONFIG_FUNCTION_TRACER=n
------------------------
Pipe latency: 41.9876 microseconds

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
