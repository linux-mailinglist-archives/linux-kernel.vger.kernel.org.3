Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA775B04F9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiIGNP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiIGNPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:15:36 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AF087B1DF;
        Wed,  7 Sep 2022 06:15:15 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oVutd-0000YC-01; Wed, 07 Sep 2022 15:15:13 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id BEA7BC0EC6; Wed,  7 Sep 2022 15:08:48 +0200 (CEST)
Date:   Wed, 7 Sep 2022 15:08:48 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: OCTEON: irq: Fix octeon_irq_force_ciu_mapping()
Message-ID: <20220907130848.GB17817@alpha.franken.de>
References: <20220906095943.60296-1-alexander.sverdlin@nokia.com>
 <20220906095943.60296-3-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906095943.60296-3-alexander.sverdlin@nokia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 11:59:43AM +0200, Alexander A Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> For irq_domain_associate() to work the virq descriptor has to be
> pre-allocated in advance. Otherwise the following happens:
> 
> WARNING: CPU: 0 PID: 0 at .../kernel/irq/irqdomain.c:527 irq_domain_associate+0x298/0x2e8
> error: virq128 is not allocated
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.78-... #1
>         ...
> Call Trace:
> [<ffffffff801344c4>] show_stack+0x9c/0x130
> [<ffffffff80769550>] dump_stack+0x90/0xd0
> [<ffffffff801576d0>] __warn+0x118/0x130
> [<ffffffff80157734>] warn_slowpath_fmt+0x4c/0x70
> [<ffffffff801b83c0>] irq_domain_associate+0x298/0x2e8
> [<ffffffff80a43bb8>] octeon_irq_init_ciu+0x4c8/0x53c
> [<ffffffff80a76cbc>] of_irq_init+0x1e0/0x388
> [<ffffffff80a452cc>] init_IRQ+0x4c/0xf4
> [<ffffffff80a3cc00>] start_kernel+0x404/0x698
> 
> Use irq_alloc_desc_at() to avoid the above problem.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> ---
>  arch/mips/cavium-octeon/octeon-irq.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
