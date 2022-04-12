Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C7C4FEB22
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiDLXcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiDLXb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:31:58 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70CBD90FC8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:17:53 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8D1B592009C; Wed, 13 Apr 2022 00:17:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7EA6492009B;
        Tue, 12 Apr 2022 23:17:50 +0100 (BST)
Date:   Tue, 12 Apr 2022 23:17:50 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Daniel Vacek <neelx@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/apic: Clarify i82489DX bit overlap in APIC_LVT0
In-Reply-To: <87ee22f3ci.ffs@tglx>
Message-ID: <alpine.DEB.2.21.2204122235140.9383@angie.orcam.me.uk>
References: <20220202140244.1681140-1-neelx@redhat.com> <874k361liu.ffs@tglx> <CACjP9X_A7aLmvypyOz1UrXM571gx_X5q7=w-1j+G+MSbCteiEw@mail.gmail.com> <87ee22f3ci.ffs@tglx>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2022, Thomas Gleixner wrote:

> Daniel stumbled over the undocumented bit overlap of the i82498DX external
> APIC and the TSC deadline timer configuration bit in modern APICs.

 For the record, it's documented in the i82498DX datasheet[1] and user 
manual[2]:

'Bits [19:18] Timer Base: This field selects the time base input to be 
used by the timer.

  00: (Base 0): Uses "CLKIN" as input.

  01: (Base 1): Uses "TMBASE".

  10: (Base 2): Uses the output of the divider (Base 2).'

(the wording is virtually the same in both sources).  Base 2 setting is 
compatible with later APIC implementations. 

 Since you're removing the macros and the documents referred aren't easily 
available it may be worth to mention the settings somewhere, such as the 
comment you're adding.

 Intel indeed did not document the two-bit field in any later literature, 
and the i82498DX part cannot be used with any other APIC device due to a 
protocol (and also wiring) difference in the inter-APIC communication bus.

 There's also bit 2 of the Divide Configuration Register.  That bit is 
hardwired to 0 in later APIC versions, however in the i82498DX it selects 
the time base input to be used by the divider, 0 for CLK (CLKIN) or 1 for 
TMBASE.  Conversely bit 3 is hardwired to 0 in the i82498DX.

References:

[1] "82489DX Advanced Programmable Interrupt Controller", Intel 
    Corporation, Order Number: 290446-002, October 1993, Section 6.12 
    "Timer Registers", p.27

[2] M. Jayakumar, "AP-388 82489DX User's Manual", Multiprocessor 
    Technology Group, Intel Corporation, Order Number: 292116-002, 
    November 1995, Section "Register Programming Details", p.22

 FWIW,

  Maciej
