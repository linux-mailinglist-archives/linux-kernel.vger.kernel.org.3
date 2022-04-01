Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E944EF7EF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbiDAQaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344678AbiDAQaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:30:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C32182AF9;
        Fri,  1 Apr 2022 09:03:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 766F761AF8;
        Fri,  1 Apr 2022 16:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83596C2BBE4;
        Fri,  1 Apr 2022 16:03:07 +0000 (UTC)
Date:   Fri, 1 Apr 2022 12:03:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        linux-ia64@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3 v2] Docs: admin/kernel-parameters: edit a few boot
 options
Message-ID: <20220401120305.00076d14@gandalf.local.home>
In-Reply-To: <20220401030927.12023-2-rdunlap@infradead.org>
References: <20220401030927.12023-1-rdunlap@infradead.org>
        <20220401030927.12023-2-rdunlap@infradead.org>
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

On Thu, 31 Mar 2022 20:09:25 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> @@ -5908,6 +5910,8 @@
>  	trace_buf_size=nn[KMG]
>  			[FTRACE] will set tracing buffer size on each cpu.
>  
> +	trace_clock=	[FTRACE] See Documentation/trace/ftrace.rst

	trace_clock=	[FTRACE] Set the clock used for tracing events
			at boot up.
			local - Use the per CPU time stamp counter
				(converted into nanoseconds). Fast, but
				depending on the architecture, may not be
				in sync between CPUs.
			global - Event time stamps are synchronize across
				CPUs. May be slower than the local clock,
				but better for some race conditions.
			counter - Simple counting of events (1, 2, ..)
				note, some counts may be skipped due to the
				infrastructure grabbing the clock more than
				once per event.
			uptime - Use jiffies as the time stamp.
			perf - Use the same clock that perf uses.
			mono - Use ktime_get_mono_fast_ns() for time stamps.
			mono_raw - Use ktime_get_raw_fast_ns() for time
				stamps.
			boot - Use ktime_get_boot_fast_ns() for time stamps.
			Architectures may add more clocks. See
			Documentation/trace/ftrace.rst for more details.

-- Steve


> +
>  	trace_event=[event-list]
>  			[FTRACE] Set and start specified trace events in order
>  			to facilitate early boot debugging. The event-list is a
