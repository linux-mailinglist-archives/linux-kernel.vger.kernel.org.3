Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79D25401AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245703AbiFGOon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbiFGOok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:44:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784761F61D;
        Tue,  7 Jun 2022 07:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=48Hfd+jD/f1EB59e4qpnjbo55s+xlwG7cHyRK3ej9qA=; b=Rjriw2g47BENZtGXOct//0jyIE
        mQ9pzJXKDvC5+VMirUs+P2jUtYztRyyNNoOYaRkyv2RUiiPVNl31ilUVoZOHgkCGlmDXTRAtoMrBV
        Ir5WRdu71po8s6XnkMhDbUIDM+xYZXoIKBA6I7gkbmFeyoQ2H0qtA3Rwpl/F8Tc5W9WwrZbtq6VH4
        e3IBwN7d+zg+YjvMXNwZuvgmuJzzlSldNgvne4jNER8UkZ6P3oLyTaGoKUeHNGBgHW4+C78C7rEKC
        NV3WinqUnZLKXFHXV3rlUQxbhvKPwR1K7Blyzd2c4RoG6atUoNshkZq3otmEvzZ8/nNoWSwZPqSvA
        3B9+4wfA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyaO6-005kq3-Ju; Tue, 07 Jun 2022 14:40:56 +0000
Message-ID: <7b76ac34-1c50-c0da-9bf3-d05bdd9959cb@infradead.org>
Date:   Tue, 7 Jun 2022 07:40:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 2/6] soc: fujitsu: Add Kconfig/Makefile to build
 hardware prefetch control driver
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
 <20220607120530.2447112-3-tarumizu.kohei@fujitsu.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220607120530.2447112-3-tarumizu.kohei@fujitsu.com>
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
> diff --git a/drivers/soc/fujitsu/Kconfig b/drivers/soc/fujitsu/Kconfig
> new file mode 100644
> index 000000000000..6c5990b75cc5
> --- /dev/null
> +++ b/drivers/soc/fujitsu/Kconfig
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +menu "Fujitsu SoC drivers"
> +
> +config ALLOW_INCOMPLETE_CACHE_SYSFS
> +	bool
> +
> +config A64FX_HWPF_CONTROL
> +	tristate "A64FX Hardware Prefetch Control driver"
> +	depends on ARM64
> +	select ALLOW_INCOMPLETE_CACHE_SYSFS
> +	help
> +	  This provides a sysfs interface to control the Hardware Prefetch
> +	  behavior for A64FX.
> +
> +	  A64FX has IMP_PF_STREAM_DETECT_CTRL_EL0, which can control the
> +	  hardware prefech behavior. If the processor supports this, the

	           prefetch

> +	  module can be loaded with the name a64fx-pfctl.
> +
> +	  Depending on the characteristics of the application, this register
> +	  parameters improve or degrade performance.
> +
> +	  Please see Documentation/ABI/testing/sysfs-devices-system-cpu for
> +	  more information.

-- 
~Randy
