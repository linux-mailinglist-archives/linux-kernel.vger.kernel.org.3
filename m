Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB124B376F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiBLSfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:35:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiBLSfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:35:39 -0500
X-Greylist: delayed 241 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Feb 2022 10:35:35 PST
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3302C6007C;
        Sat, 12 Feb 2022 10:35:35 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1nIx76-001UOn-Ci; Sat, 12 Feb 2022 19:27:16 +0100
Received: from dynamic-077-011-010-081.77.11.pool.telefonica.de ([77.11.10.81] helo=[192.168.1.7])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1nIx75-000dOg-TM; Sat, 12 Feb 2022 19:27:16 +0100
Message-ID: <0396e38b-f681-a035-b6ea-21127fdf5615@physik.fu-berlin.de>
Date:   Sat, 12 Feb 2022 19:27:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
To:     ojeda@kernel.org
Cc:     alex.gaynor@gmail.com, antonio.terceiro@linaro.org,
        aou@eecs.berkeley.edu, ark.email@gmail.com,
        benh@kernel.crashing.org, bobo1239@web.de, boqun.feng@gmail.com,
        bp@alien8.de, catalin.marinas@arm.com, d0u9.su@outlook.com,
        dave.hansen@linux.intel.com, dsosnowski@dsosnowski.pl,
        dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org,
        hpa@zytor.com, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux@armlinux.org.uk,
        linuxppc-dev@lists.ozlabs.org, macanroj@gmail.com,
        masahiroy@kernel.org, me@kloenk.de, michal.lkml@markovi.net,
        mingo@redhat.com, mpe@ellerman.id.au, ndesaulniers@google.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, paulus@samba.org,
        rust-for-linux@vger.kernel.org, tglx@linutronix.de,
        thesven73@gmail.com, torvalds@linux-foundation.org,
        wedsonaf@google.com, will@kernel.org, x86@kernel.org
References: <20220212130410.6901-17-ojeda@kernel.org>
Subject: Re: [PATCH v4 16/20] Kbuild: add Rust support
Content-Language: en-US
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <20220212130410.6901-17-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 77.11.10.81
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sat, Feb 12, 2022 at 02:03:42PM +0100, Miguel Ojeda wrote:
> +config RUST
> +	bool "Rust support"
> +	depends on RUST_IS_AVAILABLE
> +	depends on ARM64 || CPU_32v6 || CPU_32v6K || (PPC64 && CPU_LITTLE_ENDIAN) || X86_64 || RISCV

Is there any particular reason why this list excludes MIPS*, i386, big-endian
PowerPC and SPARC targets which are already supported by the Rust programming
language?

Are the arch/$ARCH/rust/target.json files everything that's needed for supporting
the other targets?

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

