Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78366549AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbiFMSCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244547AbiFMSBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:01:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD373D48;
        Mon, 13 Jun 2022 06:44:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59C486136C;
        Mon, 13 Jun 2022 13:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEE4C3411C;
        Mon, 13 Jun 2022 13:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655127894;
        bh=SJRMus/BrkP3vZSiuqVxHOTCxoFSg6FdAcDr36Ttmc8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gjj58l5gwcWlK20bbp9cq5UzCb3FzYuo8gSP9m7FOz61y3+/6jw16j5bSlSgphnc8
         99piEzRHWd+EsGvu5Z4OUB8hMOoaHzV57i9V2INBtqwhbgq/hrGAUjmgEmTkjBxFaz
         aPwTJfEH11ewftcdF95vLKLZcmyTre9V0/exP9NBK1g/9sHMrr0vCEYCPCOvRh1xYE
         0w87H4s56a0B0dRbAqmWml9Bx8OOSD32CNxh/rrfFleZWIovdw8CHHRH3oIlnP8itb
         bD3fhf22w5DNGo0bwN5bM9Lj2zurq5C2+v91DSn1n0PtzCgG0/sAl8P27JG+88h929
         UeseoLqyYnRVA==
Received: by mail-ua1-f45.google.com with SMTP id o8so2152924uap.6;
        Mon, 13 Jun 2022 06:44:54 -0700 (PDT)
X-Gm-Message-State: AOAM531auZ6shlyMXTJQeowraO5R+GjKMnAD1YN3m0U3n4Cn39x04VL8
        8hsjMfvMseRkefb5cmgrqDsZRF2F3IhtpfLU/w==
X-Google-Smtp-Source: ABdhPJwJdSYFPrU1lg9RQoPXl/q9bfbItYSHKMVnQIK267UpiLdgLX0oIGrik27v8fBGf1yD7rtr9VX6VNPHvUarm0M=
X-Received: by 2002:ab0:2705:0:b0:379:7378:3c75 with SMTP id
 s5-20020ab02705000000b0037973783c75mr1881607uao.77.1655127893697; Mon, 13 Jun
 2022 06:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220607165840.66931-1-yoan.picchi@arm.com> <20220607165840.66931-3-yoan.picchi@arm.com>
 <20220609213652.GA115440-robh@kernel.org> <20220610114840.10db23ea@donnerap.cambridge.arm.com>
 <YqcUXrFGO+QVMKBd@silpixa00400314>
In-Reply-To: <YqcUXrFGO+QVMKBd@silpixa00400314>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 13 Jun 2022 07:44:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ_mjR8tbUu0n4AxXSVGtDOMTnRZTBRyvOAwe28tGXamA@mail.gmail.com>
Message-ID: <CAL_JsqJ_mjR8tbUu0n4AxXSVGtDOMTnRZTBRyvOAwe28tGXamA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Removes the x86 dependency on the QAT drivers
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Yoan Picchi <yoan.picchi@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>, qat-linux@intel.com,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 4:41 AM Giovanni Cabiddu
<giovanni.cabiddu@intel.com> wrote:
>
> On Fri, Jun 10, 2022 at 11:48:40AM +0100, Andre Przywara wrote:
> > On Thu, 9 Jun 2022 15:36:52 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >
> > Hi,
> >
> > > On Tue, Jun 07, 2022 at 04:58:40PM +0000, Yoan Picchi wrote:
> > > > This dependency looks outdated. After the previous patch, we have been able
> > > > to use this driver to encrypt some data and to create working VF on arm64.
> > > > We have not tested it yet on any big endian machine, hence the new dependency
> > >
> > > For the subject, use prefixes matching the subsystem (like you did on
> > > patch 1).
> Just to add on this, patches to the qat driver should have the following
> headline:
>     crypto: qat -
> not
>     crypto: qat:
>
> > >
> > > The only testing obligation you have is compiling for BE.
> >
> > So I just compiled for arm64 BE, powerpc BE & LE, and riscv again:
> > $ file qat_c62xvf.ko
> > qat_c62xvf.ko: ELF 64-bit MSB relocatable, ARM aarch64, version 1 (SYSV),
> > BuildID[sha1]=630cc0ee5586c7aeb6e0ab5567ce2f2f7cc46adf, with debug_info,
> > not stripped
> > qat_c62xvf.ko: ELF 64-bit MSB relocatable, 64-bit PowerPC or cisco 7500,
> > version 1 (SYSV), BuildID[sha1]=4090ba181cf95f27108bf3ecde0776f12ef2b636,
> > not stripped
> > qat_c62xvf.ko: ELF 64-bit LSB relocatable, 64-bit PowerPC or cisco 7500,
> > version 1 (SYSV), BuildID[sha1]=2cb0fd09d5bc36c8918fcd061c9f3dac1546cf0d,
> > not stripped
> > qat_c62xvf.ko: ELF 64-bit LSB relocatable, UCB RISC-V, version 1 (SYSV),
> > BuildID[sha1]=bfaa53df7e9aad79d3ab4c05e75ca9169227f6b8, not stripped
> >
> > All built without errors or warnings, for every of the enabled drivers.
> >
> > > If kconfig was
> > > supposed to capture what endianness drivers have been tested or not
> > > tested with, then lots of drivers are missing the dependency. Kconfig
> > > depends/select entries should generally be either to prevent compile
> > > failures (you checked PPC, RiscV, etc.?) or to hide drivers *really*
> > > specific to a platform. IMO, we should only have !CPU_BIG_ENDIAN if it
> > > is known not to work and not easily fixed.
> >
> > Fair enough, I leave that decision to Giovanni. I have plans to test this
> > with BE, but getting a BE setup on a server is not trivial, both for
> > userland and actual booting, so this will take some time. We just didn't
> > want to block this on some BE concerns.
> Just inspecting the code I can see we are not handling BE in the logic
> that builds FW descriptors.
> My preference would be to keep !CPU_BIG_ENDIAN until the driver is fixed
> and tested.

Okay, then at least add '|| COMPILE_TEST' so that allyesconfig builds build it.

Rob
