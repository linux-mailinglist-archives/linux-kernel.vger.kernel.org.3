Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E455A4A9E97
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377349AbiBDSEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377342AbiBDSEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:04:16 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA036C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 10:04:15 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5771A1EC063A;
        Fri,  4 Feb 2022 19:04:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643997850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+GKcNDqU0eHa0DTgwWwDAB+4H8UR5uqiTrhITy3VuXg=;
        b=XHeg0wJ/rz9RkfDxQ58rqUoCSg3CQ8A8FlBRQY5dJFQFfTIxtrrHYEEaCFAprzVetWoE1t
        n5XBijVnIWcmc1iMZ5yHyWRHfSNB0/zrbJR+g5n8z6DpOGKWRK3Oyo3zO3q3Sca10DkaYL
        Ucb0kceTlGZAy28K4C381feCxf1UBEI=
Date:   Fri, 4 Feb 2022 19:04:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] cpumask: Add a x86-specific cpumask_clear_cpu()
 helper
Message-ID: <Yf1qmXRVbd5g/Vni@zn.tnic>
References: <20220204083015.17317-1-bp@alien8.de>
 <20220204083015.17317-2-bp@alien8.de>
 <547b5ccef6a54df49e556f596aafaa39@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <547b5ccef6a54df49e556f596aafaa39@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 04:46:24PM +0000, Luck, Tony wrote:
> > Also, always inline two more cpumask generic helpers.
> >
> > allyesconfig:
> >
> >    text    data     bss     dec     hex filename
> > 190553143       159425889       32076404        382055436       16c5b40c vmlinux.before
> > 190551812       159424945       32076404        382053161       16c5ab29 vmlinux.after
> 
> That looks odd. You added "always" to some inline functions, which I'd
> have thought might cause *more* inlining, and thus an increase in text
> size. But it actually went *down* by 1331 bytes.

Or maybe the compiler did some optimizations after the inlining. Here
are the numbers on an allmodconfig - 1073 bytes less with this patch.

   text    data     bss     dec     hex filename
27409158        31062465        26710144        85181767        513c547 vmlinux.before
27408085        31062821        26710144        85181050        513c27a vmlinux.after

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
