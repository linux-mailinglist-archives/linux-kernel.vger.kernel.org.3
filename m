Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5B354649B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346979AbiFJKw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239945AbiFJKwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:52:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E9A52FEF7D;
        Fri, 10 Jun 2022 03:48:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 724FA12FC;
        Fri, 10 Jun 2022 03:48:46 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C9613F766;
        Fri, 10 Jun 2022 03:48:44 -0700 (PDT)
Date:   Fri, 10 Jun 2022 11:48:40 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Yoan Picchi <yoan.picchi@arm.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 2/2] Removes the x86 dependency on the QAT drivers
Message-ID: <20220610114840.10db23ea@donnerap.cambridge.arm.com>
In-Reply-To: <20220609213652.GA115440-robh@kernel.org>
References: <20220607165840.66931-1-yoan.picchi@arm.com>
 <20220607165840.66931-3-yoan.picchi@arm.com>
 <20220609213652.GA115440-robh@kernel.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 15:36:52 -0600
Rob Herring <robh@kernel.org> wrote:

Hi,

> On Tue, Jun 07, 2022 at 04:58:40PM +0000, Yoan Picchi wrote:
> > This dependency looks outdated. After the previous patch, we have been able
> > to use this driver to encrypt some data and to create working VF on arm64.
> > We have not tested it yet on any big endian machine, hence the new dependency  
> 
> For the subject, use prefixes matching the subsystem (like you did on 
> patch 1).
> 
> The only testing obligation you have is compiling for BE.

So I just compiled for arm64 BE, powerpc BE & LE, and riscv again:
$ file qat_c62xvf.ko
qat_c62xvf.ko: ELF 64-bit MSB relocatable, ARM aarch64, version 1 (SYSV),
BuildID[sha1]=630cc0ee5586c7aeb6e0ab5567ce2f2f7cc46adf, with debug_info,
not stripped
qat_c62xvf.ko: ELF 64-bit MSB relocatable, 64-bit PowerPC or cisco 7500,
version 1 (SYSV), BuildID[sha1]=4090ba181cf95f27108bf3ecde0776f12ef2b636,
not stripped
qat_c62xvf.ko: ELF 64-bit LSB relocatable, 64-bit PowerPC or cisco 7500,
version 1 (SYSV), BuildID[sha1]=2cb0fd09d5bc36c8918fcd061c9f3dac1546cf0d,
not stripped
qat_c62xvf.ko: ELF 64-bit LSB relocatable, UCB RISC-V, version 1 (SYSV),
BuildID[sha1]=bfaa53df7e9aad79d3ab4c05e75ca9169227f6b8, not stripped

All built without errors or warnings, for every of the enabled drivers.

> If kconfig was
> supposed to capture what endianness drivers have been tested or not
> tested with, then lots of drivers are missing the dependency. Kconfig
> depends/select entries should generally be either to prevent compile
> failures (you checked PPC, RiscV, etc.?) or to hide drivers *really*
> specific to a platform. IMO, we should only have !CPU_BIG_ENDIAN if it 
> is known not to work and not easily fixed.

Fair enough, I leave that decision to Giovanni. I have plans to test this
with BE, but getting a BE setup on a server is not trivial, both for
userland and actual booting, so this will take some time. We just didn't
want to block this on some BE concerns.

> Also, with the dependency, no one can test the driver without modifying 
> the kernel and if it does work as-is, then one has to upstream a change 
> and then wait for it to show up in distro kernels. You could mitigate 
> the first part with COMPILE_TEST.

Yeah, that's a good point, we were already bitten by this, the initial
testing was done on a stable distro kernel (v5.4), and it worked fine
already there.

Cheers,
Andre
