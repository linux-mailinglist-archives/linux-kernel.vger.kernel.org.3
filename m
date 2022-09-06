Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CE55AF86E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 01:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiIFXfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 19:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiIFXe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 19:34:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8C731EF2;
        Tue,  6 Sep 2022 16:34:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MMhYq38SZz4xD3;
        Wed,  7 Sep 2022 09:34:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1662507291;
        bh=4US3THlCO1EMb1gSb9ztork5wBimNJa/nZMcdS+Fg/M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VE9G55kF0YvBPTmfEKRNLaOLD928FpPFqAcNpL+f8KrrJ98Z6/s7Ls4ACxDbQLjiz
         E4hCICN6PrT1JV2Doci74i6u8iUELHz6WKa8weEmztx+WhmmFKzJcxoPtF0rjggIKm
         BxWXqa3X6MefPexoJt+3HkCQG+lj0E3/25I9+R69dkW0ybhEIbZYoAeJYlfHpx/47O
         +OsAyVQq2IrWk3kDEj8NBKVhMDl9QoQPtrUhII0czRT5IizvjFTt7liWxxkcoVacqF
         jNKoxW2w8uKB9ovSNUnPneATOBtcgGJn4FyjeS4nZe4Px07FEr1ktrhp2CX3Vu8dGP
         TTu5Vt4Ozw+Sg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Douglas Su <d0u9.su@outlook.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Daniel Xu <dxu@dxuuu.xyz>, Miguel Cano <macanroj@gmail.com>,
        David Gow <davidgow@google.com>,
        Tiago Lam <tiagolam@gmail.com>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>,
        linux-um@lists.infradead.org
Subject: Re: [PATCH v8 27/31] Kbuild: add Rust support
In-Reply-To: <CAK7LNARTX+2Z=pnGbbUepxskE+KZ1f5YsfQukJ88ijPBQt9_GA@mail.gmail.com>
References: <20220802015052.10452-1-ojeda@kernel.org>
 <20220802015052.10452-28-ojeda@kernel.org>
 <CAK7LNARTX+2Z=pnGbbUepxskE+KZ1f5YsfQukJ88ijPBQt9_GA@mail.gmail.com>
Date:   Wed, 07 Sep 2022 09:34:38 +1000
Message-ID: <8735d4t6up.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> writes:
> On Tue, Aug 2, 2022 at 10:53 AM Miguel Ojeda <ojeda@kernel.org> wrote:
>>
>> Having all the new files in place, we now enable Rust support
>> in the build system, including `Kconfig` entries related to Rust,
>> the Rust configuration printer, the target specification
>> generation script, the version detection script and a few
>> other bits.
...
>> +
>> +config RUSTC_VERSION_TEXT
>> +       string
>> +       depends on RUST
>> +       default $(shell,command -v $(RUSTC) >/dev/null 2>&1 && $(RUSTC) --version || echo n)
>> +
>> +config BINDGEN_VERSION_TEXT
>> +       string
>> +       depends on RUST
>> +       default $(shell,command -v $(BINDGEN) >/dev/null 2>&1 && $(BINDGEN) --version || echo n)
>> +
>
> Where are these config options used?
>
> I grep'ed but no hit.
>
> masahiro@zoe:~/ref/linux-next$ git grep RUSTC_VERSION_TEXT
> init/Kconfig:config RUSTC_VERSION_TEXT
> masahiro@zoe:~/ref/linux-next$ git grep BINDGEN_VERSION_TEXT
> init/Kconfig:config BINDGEN_VERSION_TEXT

That came up before in a review by Nick:

Miguel wrote:
> Nick wrote:
> > Are these two kconfigs used anywhere?
> 
> Not for the moment, but it could still be useful when getting
> `.config` reports (and we could add it to `LINUX_COMPILER` etc. in the
> future).

https://lore.kernel.org/all/CANiq72n2bU3LSGu-4v66nif_95EVq--z2X_F2V7JBPU8v=h8EA@mail.gmail.com/


cheers
