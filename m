Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D505401A6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245754AbiFGOmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245703AbiFGOmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:42:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F96117A9E;
        Tue,  7 Jun 2022 07:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=guGbsi6oQ5yXtvY36/60g5guK2nnm8Y0GIptFeWRFlQ=; b=qpWI3F+WZnevlqACCPvNu6xauF
        IB3a2y7ZiiMGbm7ySpCd26UyeoH4gVxQcuKSWjoJHDFKS/Kodfpk80w1QlhaCv8dlZoWCAr1bJJrC
        vzRppARJ1BxpVHzug25b+gxh9OnxWci76flCsRfUncNrPbdk1z1omtyUb6SqSVH5ZtKtsMfiWKomP
        BATr4sutE5oEYI+cQ+0bCXajldf/aO2davX8436aEzFSjtQDdHOIS54GhcMAnZ5DA+/zXc7tymO4+
        7vPZdzNhxm4xWkOjvplPguQxvvHKvRVTsNMMGMwkYqlanUpZ7hLUx0cQ0uAfHFaEYOvfZkDW/fMyE
        uWE1ARFQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyaO5-005kq1-IP; Tue, 07 Jun 2022 14:40:54 +0000
Message-ID: <96f4cf1f-bd1e-ae5b-172b-fea572a32500@infradead.org>
Date:   Tue, 7 Jun 2022 07:40:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 5/6] x86: Add Kconfig/Makefile to build hardware
 prefetch control driver
Content-Language: en-US
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, rafael@kernel.org, lenb@kernel.org,
        gregkh@linuxfoundation.org, mchehab+huawei@kernel.org,
        eugenis@google.com, tony.luck@intel.com, pcc@google.com,
        peterz@infradead.org, marcos@orca.pet, marcan@marcan.st,
        linus.walleij@linaro.org, nicolas.ferre@microchip.com,
        conor.dooley@microchip.com, arnd@arndb.de, ast@kernel.org,
        peter.chen@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org
References: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
 <20220607120530.2447112-6-tarumizu.kohei@fujitsu.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220607120530.2447112-6-tarumizu.kohei@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/22 05:05, Kohei Tarumizu wrote:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 4bed3abf444d..3ee173483f9f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1359,6 +1359,23 @@ config X86_CPUID
>  	  with major 203 and minors 0 to 31 for /dev/cpu/0/cpuid to
>  	  /dev/cpu/31/cpuid.
>  
> +config X86_HWPF_CONTROL
> +	tristate "x86 Hardware Prefetch Control support"
> +	depends on X86_64
> +	help
> +	  This provides a sysfs interface to control the Hardware Prefetch
> +	  behavior for X86.
> +
> +	  Some Intel processors have MSR 0x1a4 (MSR_MISC_FEATURE_CONTROL),
> +	  which can control the hardware prefech behavior. If the processor

	                                 prefetch

> +	  supports this, the module can be loaded with the name x86-pfctl.
> +
> +	  Depending on the characteristics of the application, this register
> +	  parameters improve or degrade performance.
> +
> +	  Please see Documentation/ABI/testing/sysfs-devices-system-cpu for
> +	  more information.
> +

-- 
~Randy
