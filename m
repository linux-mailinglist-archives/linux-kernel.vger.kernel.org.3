Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAFE4A30F3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 18:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352874AbiA2RD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 12:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiA2RDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 12:03:54 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAF0C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 09:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=vq4Avmy7ppv5DneVq71c6GVpA7SJmG9GPgd/NUf1nv4=; b=DU4Hzal/kaaGKDb+MKnAgrEERN
        B/LOfBx+Fdtj7EfYyPPGQCk0MU0DLdhgB9OZSeext1Vuvr5vF3TuuIUgDP/t3VQR8DLSobUXqmPc3
        xndJ1JWuNYkNdPZc4v7dcuI9VICG57bZRRmvRTGNhyq8CjMTmGbqAMikaZVn9f+26tDvqyXYDm09Y
        GApPOQEjZTNwzOG4RwnAeofDYn0Iw0I3arYKFLI6pE1VWayJs+tvDfARSIToFciXDmLlWk5IQkgkm
        A4ZL/O2EfXRsWIFNeX+AK12iChqJQXRq9KsC3R44tiP+vf9OA8L9HX9/q7zud/tqH8jA+ThHRqO4B
        xvMtSDeg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nDr8M-004uD7-3Y; Sat, 29 Jan 2022 17:03:30 +0000
Message-ID: <964539a8-334d-37d4-99e7-d2dd76887fa1@infradead.org>
Date:   Sat, 29 Jan 2022 09:03:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/8] arm64: Add Kconfig/Makefile to build hardware
 prefetch control driver
Content-Language: en-US
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
 <20220125071414.811344-5-tarumizu.kohei@fujitsu.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220125071414.811344-5-tarumizu.kohei@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 1/24/22 23:14, Kohei Tarumizu wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6978140edfa4..c2256dbb0243 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig

>  	def_bool y
>  	depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_SYSREG
>  
> +config ARM64_HWPF_CONTROL
> +	tristate "ARM64 Hardware Prefetch Control support"
> +	depends on HWPF_CONTROL
> +	default m

Don't enable random drivers unless they are required for booting etc.
So can you justify having this driver enabled by default?

I see that the X86 driver is not enabled by default.

> +	help
> +	  This adds Hardware Prefetch Control driver support for ARM64.

thanks.
-- 
~Randy
