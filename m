Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953FA46AB46
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356400AbhLFWSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348166AbhLFWSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:18:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319ADC061746;
        Mon,  6 Dec 2021 14:14:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E2FC7CE17E3;
        Mon,  6 Dec 2021 22:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9FBC341CB;
        Mon,  6 Dec 2021 22:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638828879;
        bh=otwRXNrGvQ/O1C7GeCAdY8OUaJ5b0dy76mjEaM9QNc8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YOFcL1HWIIVhKrXHAoZPBZcrPBcDf3J/doqqRfimg6IsLR3X5RSuJ1LbMnIOvykco
         uyPXxP7wilJIH+XMkm8c1/i9MdQDJZt4GMWlJp0cbkme2HHhWEQTbjJnYkJcHUm4j8
         sLxmZqa47wouW0Ct7OvkVfx+EzFhXxNvE+Po20Y1UfgGNz9ATv4iFfX1OmwH62W/Ud
         6ABAIHXYJIhLPuaXWDYJ70Grsgw4a4l+T8ZZcqwpX5UohyafwAFqeSoTm7KjG6dOi+
         BGL6u/95c4FoiaWqTgcNixRnGRQVEwSpJ0rYJG0cVrQeen9kqMwbOwHbql2xI8u0n3
         v/1WG4KH7xJqw==
Received: by mail-ot1-f53.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so15479067otv.9;
        Mon, 06 Dec 2021 14:14:39 -0800 (PST)
X-Gm-Message-State: AOAM530tJk/J8tQJ/cuIukVMU1B0zIE13vsZ9E1oX0BofHCPJgKgiCxI
        pQ+3wJ9+wnzFZqf0NevZSV63ZkOqpH2kNWGkKe8=
X-Google-Smtp-Source: ABdhPJxRgd7Mb/rbbu6kih35mOlU4v9R/Agdp/rdixteGL4ij0wePhwN99JcbqzTzEz5XG/ZAuDRPL4xU7x/J+CUiw4=
X-Received: by 2002:a05:6830:1514:: with SMTP id k20mr31134627otp.147.1638828878298;
 Mon, 06 Dec 2021 14:14:38 -0800 (PST)
MIME-Version: 1.0
References: <20211124200700.15888-1-chang.seok.bae@intel.com>
 <20211124200700.15888-12-chang.seok.bae@intel.com> <YaWfKB+k66MzNtIi@sol.localdomain>
 <011B53ED-6D9E-41EB-834B-8A64485DBED5@intel.com>
In-Reply-To: <011B53ED-6D9E-41EB-834B-8A64485DBED5@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 6 Dec 2021 23:14:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF1hoyW6fdidJ2Dt4R_qBv_QLNaowKf4LM5Oe3_zaJuTA@mail.gmail.com>
Message-ID: <CAMj1kXF1hoyW6fdidJ2Dt4R_qBv_QLNaowKf4LM5Oe3_zaJuTA@mail.gmail.com>
Subject: Re: [PATCH v3 11/15] crypto: x86/aes-kl - Support AES algorithm using
 Key Locker instructions
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Gairuboyina, Charishma1" <charishma1.gairuboyina@intel.com>,
        "Dwarakanath, Kumar N" <kumar.n.dwarakanath@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 at 07:57, Bae, Chang Seok <chang.seok.bae@intel.com> wrote:
>
> On Nov 29, 2021, at 19:48, Eric Biggers <ebiggers@kernel.org> wrote:
> > On Wed, Nov 24, 2021 at 12:06:56PM -0800, Chang S. Bae wrote:
...
> >> diff --git a/arch/x86/crypto/aeskl-intel_asm.S b/arch/x86/crypto/aeskl-intel_asm.S
> >> new file mode 100644
> >> index 000000000000..d56ec8dd6644
> >> --- /dev/null
> >> +++ b/arch/x86/crypto/aeskl-intel_asm.S
> >
> > This file gets very long after all the modes are added (> 1100 lines).  Is there
> > really no feasible way to share code between this and aesni-intel_asm.S, similar
> > to how the arm64 AES implementations work?  Surely most of the logic is the
> > same, and it's just the actual AES instructions that differ?
>
> No, these two instruction sets are separate. So I think no room to share the
> ASM code.
>

On arm64, we have

aes-ce.S, which uses AES instructions to implement the AES core transforms

aes-neon.S, which uses plain NEON instructions to implement the AES
core transforms

aes-modes.S, which can be combined with either of the above, and
implements the various chaining modes (ECB, CBC, CTR, XTS, and a
helper for CMAC, CBCMAC and XMAC)

If you have two different primitives for performing AES transforms
(the original round by round one, and the KL one that does 10 or 14
rounds at a time), you should still be able to reuse most of the code
that implements the non-trivial handling of the chaining modes.


> >> +config CRYPTO_AES_KL
> >> +    tristate "AES cipher algorithms (AES-KL)"
> >> +    depends on (LD_VERSION >= 23600) || (LLD_VERSION >= 120000)
> >> +    depends on DM_CRYPT
> >
> > 'depends on DM_CRYPT' doesn't really make sense here, since there is no actual
> > dependency on dm-crypt in the code.
>
> I think the intention here is to build a policy that the library is available
> only when there is a clear use case.
>
> But maybe putting such restriction is too much here.
>
> Thanks
> Chang
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/crypto/aes_generic.c
>
>
