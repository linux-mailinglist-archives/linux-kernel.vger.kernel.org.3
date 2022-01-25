Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9105049BB82
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiAYSu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:50:27 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49352 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233655AbiAYSuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:50:05 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 21DFC1EC0441;
        Tue, 25 Jan 2022 19:49:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643136598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FWGEovRBlRsOHRRs3KcfU9GtAqXhXF86p7IhLQZAYMs=;
        b=KDrqcOLGqwq4yaIkVt75JKs+Z0rFT0PyASpCymwwSZkMftN7YqtFe1CJuZmBMhrvnfNvaZ
        psf22yWMp+gShTh8s+pL/JnCkQp2THC2dauqIR0sTSDW0Bo0NEeMqb0jn8nvSvg8TZckhy
        uBDo5a+gLkeGt5zHs33SQztucp3Gsa0=
Date:   Tue, 25 Jan 2022 19:49:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        x86@kernel.org, llvm@lists.linux.dev, linux-sparse@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH] objtool: prefer memory clobber & %= to volatile &
 __COUNTER__
Message-ID: <YfBGVfk5jnHgC4UE@zn.tnic>
References: <20220114010526.1776605-1-ndesaulniers@google.com>
 <YeQei0xNzMq7bFdg@zn.tnic>
 <20220118192256.jzk5dnceeusq7x7u@treble>
 <20220118230120.pivvson7qekfiqic@treble>
 <CAKwvOdmLzwz=02ypt0_1324_5-7i3Az7HizFaDMqZv__-D99uA@mail.gmail.com>
 <CAKwvOdm+pnKb2PU7H5W1ks8eFd3DPEtN5kzjhnz5TLLwpBLOsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdm+pnKb2PU7H5W1ks8eFd3DPEtN5kzjhnz5TLLwpBLOsA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 03:38:38PM -0800, Nick Desaulniers wrote:
> $ wget https://download.01.org/0day-ci/archive/20220119/202201190702.XNSXrMTK-lkp@intel.com/config
> -O .config
> $ make -j72 -s olddefconfig drivers/net/wireless/mac80211_hwsim.o
> drivers/net/wireless/mac80211_hwsim.o: warning: objtool:
> mac80211_hwsim_tx()+0x9aa: unreachable instruction
> $ gcc --version
> gcc (Debian 11.2.0-12) 11.2.0

Yap, I got mine with:

gcc (Debian 10.2.1-6) 10.2.1 20210110

but since you hit it with gcc11, I don't see why I won't hit it with
gcc10.

> :(

You said it.
 
> Let me see if I can come up with a reduced test case that I will
> report upstream to https://gcc.gnu.org/bugzilla/.

Sounds good.

Please send the bug # once you have that so that I can add myself to Cc.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
