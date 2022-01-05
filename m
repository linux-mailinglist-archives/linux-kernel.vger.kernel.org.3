Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6C24855BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241389AbiAEPVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241379AbiAEPVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:21:19 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229E8C06118A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 07:21:19 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6DA781EC00F4;
        Wed,  5 Jan 2022 16:21:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1641396073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=60sZy1n1opr5VqrLvNtyneuBS/LpQn1g43b/HUiP4ik=;
        b=USZxIMKja30KjTyaWqEOEv7mqiBxm1iOJxOoC5NuSPpefa8Bc0U7t810V5qq4Sw2sReq8O
        XYxBN8u2AMrgzksYNxLJXRvgQ69GLWnVUEI76mNyfSmjDrWs3UW0uEteOtvxZT5h2Pk/5c
        KW0b1XPRjLmEH10UnvReNfik1diI7VA=
Date:   Wed, 5 Jan 2022 16:21:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     Marco Elver <elver@google.com>, Carel Si <beibei.si@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [LKP] Re: [x86/mm/64] f154f29085:
 BUG:kernel_reboot-without-warning_in_boot_stage - clang KCOV?
Message-ID: <YdW3a3dUfi5pBaiH@zn.tnic>
References: <YbsPwyLnejLQMbTb@zn.tnic>
 <20211216115838.GA23522@linux.intel.com>
 <e48b72d4-558a-ed7c-43cd-0cb70091be11@intel.com>
 <YbyIJYzqtHPKRMFt@zn.tnic>
 <20211221143153.GA4676@linux.intel.com>
 <CANpmjNO4hs1B9eDY9edGGOXY45a8smdtYfYfbDRnGWSYch4wGg@mail.gmail.com>
 <YcHxKzB3WPurKlZ9@zn.tnic>
 <a5cb8140-5834-7649-e629-f2775cf5b9a9@intel.com>
 <YdWCstlEW6k45+hH@zn.tnic>
 <fa2f7d50-5226-726d-a9ad-2c42cb5c4054@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa2f7d50-5226-726d-a9ad-2c42cb5c4054@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 08:47:28PM +0800, Yin Fengwei wrote:
> it's better that clang restore its behavior to clang-12.

Probably, but I'm not gonna hold my breath - folks are likely very
busy...

> Or people need to use __no_profile annotation if want to add function
> before GCOV/KASAN is initialized.

... yap, and because fixing it this way is easy, I've already queued the
__no_profile solution:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/mm&id=b64dfcde1ca9cb82e38e573753f0c0db8fb841c2

Thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
