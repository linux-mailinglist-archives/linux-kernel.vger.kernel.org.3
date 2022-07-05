Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E595673FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiGEQOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiGEQOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:14:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F6D1D0CD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 09:14:32 -0700 (PDT)
Received: from zn.tnic (p200300ea970ff682329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:f682:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE60F1EC056D;
        Tue,  5 Jul 2022 18:14:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1657037667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=N6tbxGmzXBxnpgTLBtsPda9RXrIjxRareOpLL9aV2cQ=;
        b=b1oDXangh6joLJ4eJiLlt65DHN5Z2xgOJEAqh8yBWaHfnBh5StIk5WDx8/vFl/Zg2uQHxr
        YDtaDYF84OYviCczo367n5Dg1lxaOv5KmseVlSKx/BLKSxtghSdfuiavw5fMJVFBq/i68g
        kPi/0377ZM6hMiN9YmdzYpu324hEM8A=
Date:   Tue, 5 Jul 2022 18:14:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
Message-ID: <YsRjX/U1XN8rq+8u@zn.tnic>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
 <YsRTAGI2PhfZ5V7M@zn.tnic>
 <016d281b-7e40-f1bd-66ee-c19c3cc56efe@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <016d281b-7e40-f1bd-66ee-c19c3cc56efe@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 05:56:36PM +0200, Jan Beulich wrote:
> Re-using pat_disabled like you do in your suggestion below won't
> work, because mtrr_bp_init() calls pat_disable() when MTRRs
> appear to be disabled (from the kernel's view). The goal is to
> honor "nopat" without honoring any other calls to pat_disable().

Actually, the current goal is to adjust Xen dom0 because:

1. it uses the PAT code

2. but then it does something special and hides the MTRRs

which is not something real hardware does.

So this one-off thing should be prominent, visible and not get in the
way.

As to mtrr_bp_init(), can you use X86_FEATURE_XENPV there to detect this
special case when the kernel is running as dom0 and set stuff there
accordingly so that it doesn't disable PAT?

Then you don't have to touch pat_disabled() either but intergrate the
Xen variant properly...

> I can probably fiddle with pat_enabled() instead of with
> init_cache_modes(), but when making the change I had the feeling
> this might be less liked (as looking more hacky, at least to me).

Why would that be more hacky?

I'd much rather check upfront what the kernel is running on and act
accordingly instead of hooking into random functions and then years
later wonder why was it done in the first place.

> But besides the "where" the other question is: Do you really want
> me to limit this to Xen/PV, rather than - as I have it now -
> extending it to any hypervisor, which may behave in similar ways?

Well, do you know of some other HV which hides MTRRs from the guest?

I haven't heard of any...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
