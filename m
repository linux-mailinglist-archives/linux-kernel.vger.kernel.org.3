Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AFE56902D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiGFRBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiGFRBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:01:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A18964D1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 10:01:29 -0700 (PDT)
Received: from zn.tnic (p200300ea970ff625329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:f625:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 372DB1EC0453;
        Wed,  6 Jul 2022 19:01:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1657126883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YuG9Q+oxYEiway3JJ+jBLFvim0S1LMN5Amv/Z4wmYOg=;
        b=EOVKH88UnwbLUGmgyTFs6FasfHgJZWGtuo5qd9U2XujbRMoomm+jklABu0L5mmqRDWIYKS
        6sX8bZuCKS/Svvc1Ue3/+A9RQTeqkeFyDI7QVgA9nZl1k5a6QdUys/lsRGfvh+BIBPHXHN
        AyMRh/70e+IFGqqPfhAFHm5sislbIFo=
Date:   Wed, 6 Jul 2022 19:01:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
Message-ID: <YsW/3/fEuNYAuFwZ@zn.tnic>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
 <YsRTAGI2PhfZ5V7M@zn.tnic>
 <016d281b-7e40-f1bd-66ee-c19c3cc56efe@suse.com>
 <YsRjX/U1XN8rq+8u@zn.tnic>
 <b7fa785b-cea3-3e05-c101-d6c7bd101ef3@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7fa785b-cea3-3e05-c101-d6c7bd101ef3@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 08:17:41AM +0200, Jan Beulich wrote:
> Sure, but that alone won't help.

Well, the MTRR code looks at X86_FEATURE_MTRR. If Xen doesn't expose the
MTRRs, then that bit should be clear in the CPUID the guest sees.

So in that case, you could test X86_FEATURE_XENPV at the end of
mtrr_bp_init() and not disable PAT if running as a PV guest. Would that
work?

> There's a beneficial side effect of running through pat_disable():
> That way pat_init() will bail right away. Without that I'd need to
> further special case things there (as under Xen/PV PAT must not be
> written, only read)

We have wrmsr_safe for that.

> Any decent hypervisor will allow overriding CPUID, so in principle
> I'd expect any to permit disabling MTRR to leave a guest to use
> the (more modern and less cumbersome) PAT alone.

So I'm being told that it would be generally beneficial for all kinds of
virtualization solutions to be able to support PAT only, without MTRRs
so it would be interesting to see how ugly it would become to decouple
PAT from MTRRs in Linux...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
