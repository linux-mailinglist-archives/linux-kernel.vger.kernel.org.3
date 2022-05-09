Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3841851F540
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiEIHZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236483AbiEIHVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:21:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240C012609
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IQlZz/h5atycWEAD+yUb3i16NDy1Qyycxp+32Nqj2f8=; b=Bt171fII0kKQtSprI3kJJ7QBvb
        8xWEHRUWSLTEL63TEdThGtconyY4PBBcq9bY6BXapEanBFko11TDGtvmn3rgWiUxM4exBhwGUDy5w
        VRDeFnZAaMOPpMWGE3EWM1/00ZypElWHZwcm4dhKc+yMBXJYEXVuNkEw8mx0L95qA5CMk5D6TLNbN
        eD3DBQ7mDSVe7f2MtG7DMOXfh1S/Xthy8Gt93C4sND48EpGku9AhXpW6hamyEYjrYuoMU+Kzf+GNU
        cbYOE+b4lwTVYRzj1yR/h2SZq6MCf4LNBj3y1XTX+HunJj6aa9MvtZL3qWLVrlX1aF8rOBD+zaKPK
        1qrCmLsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnxdV-003Dti-Nt; Mon, 09 May 2022 07:16:53 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B82BF980E93; Mon,  9 May 2022 09:16:52 +0200 (CEST)
Date:   Mon, 9 May 2022 09:16:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        rui.zhang@intel.com, len.brown@intel.com, tim.c.chen@intel.com
Subject: Re: [PATCH] x86/tsc: Add option to force HW timer based recalibration
Message-ID: <20220509071652.GE76023@worktop.programming.kicks-ass.net>
References: <20220508144733.91343-1-feng.tang@intel.com>
 <20220509045839.GA40730@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509045839.GA40730@shbuild999.sh.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 12:58:39PM +0800, Feng Tang wrote:
> Sorry, just spotted some typos, here is the updated version
> 
> 
> From ee8e3d772c623d27d79c43da5a76fb6252175aba Mon Sep 17 00:00:00 2001
> From: Feng Tang <feng.tang@intel.com>
> Date: Sun, 8 May 2022 20:22:12 +0800
> Subject: [PATCH] x86/tsc: Add option to force HW timer based recalibration
> 
> Currently when HW provides the tsc freq info through MSR or CPUID(0x15),
> the info will be taken as the 'best guess', and kernel will set the
> X86_FEATURE_TSC_KNOWN_FREQ flag and skip the HW timer based recalibration,
> which works pretty well.
> 
> And there is still very few corner case that the freq info is not
> accurate enough with small deviation from the actual value, like on
> a product with early buggy version of firmware or on some
> pre-production hardware.
> 
> Add an option 'recalibrate' for 'tsc' kernel parameter to force the
> tsc freq recalibration with HPET/PM_TIMER, and warn if the deviation
> from previous value is more than about 500 PPM.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>

Why isn't 'tsc_early_khz=' not working for you? Afaict that will
override calibrate_tsc() when provided and as such can be used on these
early platforms for provide the right value until such time that the
firmware is fixed.
