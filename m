Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6884D660E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350252AbiCKQZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350227AbiCKQZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:25:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2AE107A84;
        Fri, 11 Mar 2022 08:24:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14B11B82B00;
        Fri, 11 Mar 2022 16:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D8AC36AEA;
        Fri, 11 Mar 2022 16:24:27 +0000 (UTC)
Date:   Fri, 11 Mar 2022 11:24:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     beaub@linux.microsoft.com, Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org
Subject: Re: [next] arm64: allmodconfig: kernel BUG at
 include/linux/page-flags.h:509
Message-ID: <20220311112426.7e3cf434@gandalf.local.home>
In-Reply-To: <CADYN=9+xY5Vku3Ws5E9S60SM5dCFfeGeRBkmDFbcxX0ZMoFing@mail.gmail.com>
References: <CADYN=9+xY5Vku3Ws5E9S60SM5dCFfeGeRBkmDFbcxX0ZMoFing@mail.gmail.com>
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

On Fri, 11 Mar 2022 10:43:32 +0100
Anders Roxell <anders.roxell@linaro.org> wrote:

> Hi,
> 
> I'm building and running an arm64 allmodconfig kernel on next.
> Reacently I've seen this error below, for full log see [1].
> 
> [   56.000810][    T1] ------------[ cut here ]------------
> [   56.003178][    T1] kernel BUG at include/linux/page-flags.h:509!
> [   56.006291][    T1] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [   56.008921][    T1] Modules linked in:
> [   56.010600][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G
>         T 5.17.0-rc6-next-20220304 #1
> ff4358f1e97b9d4d3a7966961f455fb8cb5c735d
> [   56.015962][    T1] Hardware name: linux,dummy-virt (DT)
> [   56.018189][    T1] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT
> -SSBS BTYPE=--)
> [   56.021355][    T1] pc : set_page_reservations+0xf8/0x3b8
> [   56.023655][    T1] lr : set_page_reservations+0xec/0x3b8
> [   56.025976][    T1] sp : ffff80000eb37c20
> [   56.027699][    T1] x29: ffff80000eb37c20 x28: ffff0000079d8050
> x27: 0000000000000001
> [   56.031030][    T1] x26: ffff80000a2c6140 x25: ffff80000e240380
> x24: ffff80000b780f70
> [   56.034381][    T1] x23: fffffc0000000000 x22: 000000000028b100
> x21: fffffc000028b100
> [   56.037728][    T1] x20: ffff80000e23ffe0 x19: ffff80000e23ffe0
> x18: 0000000000000000
> [   56.041039][    T1] x17: 0000000000000000 x16: 0000000000000000
> x15: 0000000000000000
> [   56.044323][    T1] x14: 0000000000000000 x13: fffffffffffe34f0
> x12: fffffffffffe3498
> [   56.047644][    T1] x11: 0000000000000000 x10: 0000000000000000 x9
> : 0000000000000000
> [   56.050941][    T1] x8 : 0000000000000000 x7 : 0000000000000000 x6
> : 0000000000000000
> [   56.054258][    T1] x5 : 0000000000000000 x4 : 0000000000000000 x3
> : 0000000000000000
> [   56.057729][    T1] x2 : 0000000000000000 x1 : 0000000000000000 x0
> : 0000000000000001
> [   56.061075][    T1] Call trace:
> [   56.062436][    T1]  set_page_reservations+0xf8/0x3b8
> [   56.064709][    T1]  trace_events_user_init+0x1bc/0x3f8


Hmm,

static void set_page_reservations(bool set)
{
	int page;

	for (page = 0; page < MAX_PAGES; ++page) {
		void *addr = register_page_data + (PAGE_SIZE * page);

		if (set)
			SetPageReserved(virt_to_page(addr));
		else
			ClearPageReserved(virt_to_page(addr));
	}
}

static int __init trace_events_user_init(void)
{
	int ret;

	/* Zero all bits beside 0 (which is reserved for failures) */
	bitmap_zero(page_bitmap, MAX_EVENTS);
	set_bit(0, page_bitmap);

	register_page_data = kzalloc(MAX_EVENTS, GFP_KERNEL);

	if (!register_page_data)
		return -ENOMEM;

	set_page_reservations(true);

Beau,

Why are you reserving the page? Can't you just allocate a page and use that?

	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, 0);
	register_page_data = page_address(page);

What was the purpose of setting it reserved?

-- Steve

> [   56.067110][    T1]  do_one_initcall+0x2ac/0x6c0
> [   56.069267][    T1]  do_initcalls+0x17c/0x244
> [   56.071269][    T1]  kernel_init_freeable+0x2a0/0x344
> [   56.073587][    T1]  kernel_init+0x34/0x180
> [   56.075614][    T1]  ret_from_fork+0x10/0x20
> [   56.077655][    T1] Code: 97937293 f9401a80 91000400 f9001a80
> (d4210000) [   56.080828][    T1] ---[ end trace 0000000000000000 ]---
> [   56.083250][    T1] Kernel panic - not syncing: Oops - BUG: Fatal
> exception [   56.086279][    T1] ---[ end Kernel panic - not syncing:
> Oops - BUG: Fatal exception ]---
> 
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> 
> Any idea what happens?
> 
> 
> Cheers,
> Anders
> [1] http://ix.io/3Rkj

