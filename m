Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F73D56FF98
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiGKK6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiGKK6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:58:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20C601020A1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:03:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88C871682;
        Mon, 11 Jul 2022 03:03:19 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D63B23F73D;
        Mon, 11 Jul 2022 03:03:14 -0700 (PDT)
Date:   Mon, 11 Jul 2022 11:02:04 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor.Dooley@microchip.com
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, catalin.marinas@arm.com, will@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux@armlinux.org.uk, arnd@arndb.de, Daire.McNamara@microchip.com,
        niklas.cassel@wdc.com, damien.lemoal@opensource.wdc.com,
        geert@linux-m68k.org, zong.li@sifive.com, kernel@esmil.dk,
        hahnjo@hahnjo.de, guoren@kernel.org, anup@brainfault.org,
        atishp@atishpatra.org, heiko@sntech.de, philipp.tomsich@vrull.eu,
        robh@kernel.org, maz@kernel.org, viresh.kumar@linaro.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Brice.Goglin@inria.fr
Subject: Re: [PATCH v2 1/2] arm64: topology: move store_cpu_topology() to
 shared code
Message-ID: <20220711100204.bj3r3g6xs577kuul@bogus>
References: <20220708203342.256459-1-mail@conchuod.ie>
 <20220708203342.256459-2-mail@conchuod.ie>
 <fb8534d9-baaa-2643-5119-602dfa5de758@microchip.com>
 <efa89122-b428-7691-49d3-f5867206f05a@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efa89122-b428-7691-49d3-f5867206f05a@microchip.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2022 at 12:58:57PM +0000, Conor.Dooley@microchip.com wrote:
> Looking at the arm32 implementation - it appears to be mostly the sort of MPIDR
> stuff that was removed from the arm64 implementation in 3102bc0e6ac7 ("arm64:
> topology: Stop using MPIDR for topology information"). Could arm32 benefit from
> the same shared implemenation too, or is usage of MPIDR only invalid for arm64?

I don't recall all the details but IIRC there are parts if arch_topology
that are ARM64/RISC-V only. ARM32 doesn't use it as it may break old
platforms. Some of the functions that still arm32 specific are retained
in arch/arm

> The other difference is a call to update_cpu_capacity() in the arm32
> implementation. Could that be moved to smp_store_cpu_info() which is the only
> callsite of store_cpu_topology()?
>

No please, leave arm32 as is. It was done for a reason like that and it
help to not break some of the old 32-by platforms.

> Either way, will respin a v3 that doesn't break the arm32 build when
> CONFIG_GENERIC_ARCH_TOPOLOGY is enabled :)
>

Thanks.

-- 
Regards,
Sudeep
