Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B904F487A3B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348209AbiAGQU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:20:58 -0500
Received: from foss.arm.com ([217.140.110.172]:42100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348184AbiAGQU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:20:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E170913D5;
        Fri,  7 Jan 2022 08:20:56 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.7.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86D793F66F;
        Fri,  7 Jan 2022 08:20:55 -0800 (PST)
Date:   Fri, 7 Jan 2022 16:20:52 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: booting.rst: Clarify on requiring non-secure
 EL2
Message-ID: <YdhoZPfjuI9vxSe3@FVFF77S0Q05N>
References: <20220107160056.322141-1-andre.przywara@arm.com>
 <20220107160056.322141-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107160056.322141-2-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 04:00:55PM +0000, Andre Przywara wrote:
> The ARMv8.4 architecture revision introduced the EL2 exception level
> to the secure world. Clarify the existing wording to make sure that
> Linux relies on being executed in the non-secure state.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  Documentation/arm64/booting.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
> index 52d060caf8bb..07cb34ed4200 100644
> --- a/Documentation/arm64/booting.rst
> +++ b/Documentation/arm64/booting.rst
> @@ -10,9 +10,9 @@ This document is based on the ARM booting document by Russell King and
>  is relevant to all public releases of the AArch64 Linux kernel.
>  
>  The AArch64 exception model is made up of a number of exception levels
> -(EL0 - EL3), with EL0 and EL1 having a secure and a non-secure
> -counterpart.  EL2 is the hypervisor level and exists only in non-secure
> -mode. EL3 is the highest priority level and exists only in secure mode.
> +(EL0 - EL3), with EL0, EL1 and EL2 having a secure and a non-secure
> +counterpart.  EL2 is the hypervisor level, EL3 is the highest priority
> +level and exists only in secure mode. Both are architecturally optional.
>  
>  For the purposes of this document, we will use the term `boot loader`
>  simply to define all software that executes on the CPU(s) before control
> @@ -167,8 +167,8 @@ Before jumping into the kernel, the following conditions must be met:
>  
>    All forms of interrupts must be masked in PSTATE.DAIF (Debug, SError,
>    IRQ and FIQ).
> -  The CPU must be in either EL2 (RECOMMENDED in order to have access to
> -  the virtualisation extensions) or non-secure EL1.
> +  The CPU must be in non-secure state, either in EL2 (RECOMMENDED in order
> +  to have access  to the virtualisation extensions), or in EL1.
                   ^^

Nit: double space

It might be clearer to explicitly say "non-secure EL2" and "non-secure EL1"
here, but either way this looks good to me, so with the whitespace fixed:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
