Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969E6562EDA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbiGAIvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbiGAIus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:50:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A935776954
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:49:53 -0700 (PDT)
Received: from zn.tnic (p200300ea970ff648329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:f648:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A7CBD1EC054C;
        Fri,  1 Jul 2022 10:49:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1656665387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=G3xHhcqScCGIvIpU6/xMf4HdunIdawCMidwzOpG6vNw=;
        b=P5x6rHymoj0XYM8nVmAzYnZnA328dXxBBlACz0n2YWJIn6qYHcN6DM4qoYP6d9Wwk1MscR
        vx8E/AT96muZKLNbqWh01dVZhPhse1T+9h+8Z9/93j4nZjQmjEXUD3Weg1UMmeWIJlc6kt
        5tDFORgmr08Lu+6X61kJY2Ynm7ZhPPU=
Date:   Fri, 1 Jul 2022 10:49:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH] RAS/CEC: Reduce default threshold to offline a page to
 "2"
Message-ID: <Yr61Jy6aGhxeulxN@zn.tnic>
References: <20220607212015.175591-1-tony.luck@intel.com>
 <YrnBWjkX82OhXAtL@zn.tnic>
 <7da92773f7084c57814f7ef4d033bc53@intel.com>
 <Yrsleko0MnGtwaaR@zn.tnic>
 <8f580a2544d846c69c9941e151fa7cc3@intel.com>
 <Yr1MntoeRKAmkxAf@zn.tnic>
 <Yr3XLMwYnRMa3Opw@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yr3XLMwYnRMa3Opw@agluck-desk3.sc.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 10:02:36AM -0700, Luck, Tony wrote:
> Yes. The cost to offline a page is low (4KB reduction in system capacity
> on a system with 10's or 100's of GB memory).

*If* that page is going to go bad at all.

> The risk to the system if the page does develop an uncorected error is
> high (process is killed, or system crashes).

That's not what the papers say.

> The question is whether the default threshold should be "do I feel
> lucky?" and those corrected errors are nothing to worry about. Or
> "do I want to take the safe path?" and premptively offline pages
> at the first sign of trouble.

Well, we can't decide that for every possible situation so if Intel's
recommendation is to do that on Intel systems, then users can set that.

/sys/kernel/debug/ras/cec/action_threshold is perhaps not the perfect
interface for that but we can make something more user-friendly.

> Is there a study about "wobbly" DIMMs?

Most of the papers I looked at say that the majority of errors are CE
and that there's a likelihood that those errors can turn UE but none is
quantifying that likelihood. One paper says that a huge number of the
errors are transient. If you offline such a page just because two alpha
particles flew through it, you're offlining a perfectly good page.

DRAM vendor is also important as different DRAM vendors show different
error stats. And so on and so on.

So you can't simply go and decide for all and say, the answer is 2.

> We now have some real data. Instead of a "finger in the air guess"
> that was made (on a different generation of DIMM technology ... the
> AMD paper you reference below says DDR4 is 5.5x worse than DDR3).

In the next sentence it says that the hardware handles those errors just
fine!

> Second most common on DDR4 DIMMs is "row failure". Which current ECC
> systems don't handle well.

This is not what we're talking about here - we're talking about
offlining pages after 2 CEs.

As to the row offlining - yes, no question there, we need to address
that.

> While that's low from one perspective (0.6% servers affected) it's high
> enough to be interesting to the CSP - because they lose revenue and
> reputation when they have to tell their customers: "sorry the VM you
> rented from us just crashed". Note that one physical system crashing
> may take down dozens of VMs.

So that whitepaper doesn't specify what they call "fault". Because
in one of the papers in the Reference section, they explain the
terminology:

"A fault is the underlying cause of an error, such as a stuck-at bit or
high-energy particle strike. Faults can be active (causing errors), or
dormant (not causing errors).

An error is an incorrect portion of state resulting from an active
fault, such as an incorrect value in memory. Errors may be detected and
possibly corrected by higher level mechanisms such as parity or error
correcting codes (ECC). They may also go uncorrected, or in the worst
case, completely undetected (i.e., silent)."

So even if we put on the most pessimistic glasses and say that 0.6%
of the faults result in system crashes, then CSP can go and set the
threshold to something lower for their use case after following
recommendations by DRAM and CPU vendor and so on.

> While anyone can tune the RAS_CEC threshold. The default value should
> be something reasonable. I'm sticking with "2" being much more
> reasonable default than 1023.

You can make that configurable or Intel-only or whatever - but not
unconditional for everyone.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
