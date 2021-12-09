Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D8346E781
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbhLILZj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Dec 2021 06:25:39 -0500
Received: from aposti.net ([89.234.176.197]:55020 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231765AbhLILZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:25:38 -0500
Date:   Thu, 09 Dec 2021 11:21:53 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: config CPU_SUPPORTS_HUGEPAGES refers to the non-existing symbol
 ARCH_PHYS_ADDR_T_64BIT
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Daniel Silsby <dansilsby@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        BROADCOM NVRAM DRIVER <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <H8IU3R.H5QVNRA077PT@crapouillou.net>
In-Reply-To: <CAKXUXMyip-Ojt-uOsjU-LnajM+cV4EcAf6ABNoAus+t2fAizDg@mail.gmail.com>
References: <CAKXUXMyip-Ojt-uOsjU-LnajM+cV4EcAf6ABNoAus+t2fAizDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

Le mer., déc. 8 2021 at 12:43:00 +0100, Lukas Bulwahn 
<lukas.bulwahn@gmail.com> a écrit :
> Dear Daniel, dear Paul, dear Thomas,
> 
> In commit d4a451d5fc84 ("arch: remove the ARCH_PHYS_ADDR_T_64BIT
> config symbol") from April 2018, the config ARCH_PHYS_ADDR_T_64BIT was
> removed and all instances of that config were refactored
> appropriately. Since then, it is recommended to use the config
> PHYS_ADDR_T_64BIT instead.
> 
> Then in June 2019, commit 171543e75272 ("MIPS: Disallow
> CPU_SUPPORTS_HUGEPAGES for XPA,EVA") introduces the expression
> "!(32BIT && (ARCH_PHYS_ADDR_T_64BIT || EVA))" for config
> CPU_SUPPORTS_HUGEPAGES, which refers to the non-existing symbol
> ARCH_PHYS_ADDR_T_64BIT.
> 
> In this expression, the symbol ARCH_PHYS_ADDR_T_64BIT always evaluates
> to false. So, the expression is effectively "!(32BIT && EVA)" right
> now.
> 
> Now, it is a bit unclear what is intended here, especially since it
> was not noticed to be wrong for the last two years:
> 
> - The commit is buggy, but nobody noticed it so far. It was intended
> to refer to PHYS_ADDR_T_64BIT. We need to provide a fix that changes
> the semantics by referring to the intended Kconfig symbol.

It should be PHYS_ADDR_T_64BIT, yes.

> - The commit is just a bit unclean and that is why nobody noticed. The
> reference to ARCH_PHYS_ADDR_T_64BIT can be dropped. We can provide a
> clean-up patch that preserves the current semantics.

AFAIK hugepages still don't work as-is on 32-bit as we are running out 
of available bits in PTEs. I do have hugepages enabled on a kernel 
build, but I have to manually disable ARCH_HAS_PTE_SPECIAL and 
CPU_HAS_RIXI to free up space. This is annoying but not something that 
can be fixed easily.

-Paul

> Once the situation for that commit and its intention is clear, I am
> happy to provide the suitable patch.
> 
> Best regards,
> 
> Lukas


