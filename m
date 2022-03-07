Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2595A4D0398
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241257AbiCGQBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbiCGQBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:01:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4A985666
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB2D460AF8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 16:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1973C340EF;
        Mon,  7 Mar 2022 16:00:15 +0000 (UTC)
Date:   Mon, 7 Mar 2022 16:00:12 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     will@kernel.org, Linu Cherian <lcherian@marvell.com>,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuc.decode@gmail.com
Subject: Re: [PATCH V3] irqchip/gic-v3: Workaround Marvell erratum 38545 when
 reading IAR
Message-ID: <YiYsDCo1wUTWkbHf@arm.com>
References: <20220307143014.22758-1-lcherian@marvell.com>
 <877d9525eq.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d9525eq.wl-maz@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 02:39:25PM +0000, Marc Zyngier wrote:
> On Mon, 07 Mar 2022 14:30:14 +0000,
> Linu Cherian <lcherian@marvell.com> wrote:
> > 
> > When a IAR register read races with a GIC interrupt RELEASE event,
> > GIC-CPU interface could wrongly return a valid INTID to the CPU
> > for an interrupt that is already released(non activated) instead of 0x3ff.
> > 
> > As a side effect, an interrupt handler could run twice, once with
> > interrupt priority and then with idle priority.
> > 
> > As a workaround, gic_read_iar is updated so that it will return a
> > valid interrupt ID only if there is a change in the active priority list
> > after the IAR read on all the affected Silicons.
> > 
> > Since there are silicon variants where both 23154 and 38545 are applicable,
> > workaround for erratum 23154 has been extended to address both of them.
> > 
> > Signed-off-by: Linu Cherian <lcherian@marvell.com>
> > ---
> > Changes since V2:
> > - Changed masked part number to individual part numbers
> > - Added additional comment to clarify on priority groups
> > 
> > 
> > Changes since V1:
> > - IIDR based quirk management done for 23154 has been reverted
> > - Extended existing 23154 errata to address 38545 as well,
> >   so that existing static keys are reused. 
> > - Added MIDR based support macros to cover all the affected parts
> > - Changed the unlikely construct to likely construct in the workaround
> >   function.
> > 
> > 
> > 
> > 
> >  Documentation/arm64/silicon-errata.rst |  2 +-
> >  arch/arm64/Kconfig                     |  8 ++++++--
> >  arch/arm64/include/asm/arch_gicv3.h    | 23 +++++++++++++++++++++--
> >  arch/arm64/include/asm/cputype.h       | 13 +++++++++++++
> >  arch/arm64/kernel/cpu_errata.c         | 20 +++++++++++++++++---
> >  5 files changed, 58 insertions(+), 8 deletions(-)
> 
> Looks good to me this time.
> 
> Catalin, Will: happy to take this into the irqchip tree for 5.18 with
> your Ack, or you can take it into the arm64 tree with my
> 
> Reviewed-by: Marc Zyngier <maz@kernel.org>

Fine by me to take it into irqchip but do a quick check for conflicts
with other arm64 changes in for-next/core.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
