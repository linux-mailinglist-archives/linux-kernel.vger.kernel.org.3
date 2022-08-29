Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B304A5A4112
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 04:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiH2C2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 22:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiH2C2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 22:28:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2DB220E0;
        Sun, 28 Aug 2022 19:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=PO7cJBFihQeNVhVlYLRbma6dh9Gy9x7adrAO453Twb0=; b=bPqnn3CW6xQRwD6JjWz14jxZdr
        kMnVFfoaBwrW5AF+BfDMLpXQ8IoJFwlUWCG4PLfLWems1Q8OBX2jMIwkJ5oySLAyCCg7xAQ0XyLjS
        GtGoY8383o6BcX5fdnthyKbBTbS8EFfDJizIm1K1k3ff1b0zv/LPoRRIpokLuAxUc2+0HxAldahWe
        3rO/GTVfaPC7E2SH4H1MWTxz/bURqJb5HAnIaVnNjv0Pkm7CzALezZUrgOCzrxSBVKxbkxSvVcw2C
        tJkRxMy1G34P75tY1qugd4DKO3Xhk32Sr+oOGlxB4SL1aWAwrsMbcRwbbnF01wa1ZgftQVaIKkIMF
        7po+Jr2Q==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSUUx-003jOd-DL; Mon, 29 Aug 2022 02:27:38 +0000
Message-ID: <d6ddb57b-4a6c-1549-1352-800a7bb4d529@infradead.org>
Date:   Sun, 28 Aug 2022 19:27:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] cpuidle: qcom_scm: fix Kconfig dependencies again
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        He Ying <heying24@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20210421135723.3601743-1-arnd@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20210421135723.3601743-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

Can we get Arnd's patch merged, please?

It's been awhile...

On 4/21/21 06:57, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The previous compile time fix was incomplete and still results in
> warnings like:
> 
> WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
>   Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
>   Selected by [y]:
>   - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]
> 
> WARNING: unmet direct dependencies detected for QCOM_SCM
>   Depends on [n]: (ARM [=y] || ARM64) && HAVE_ARM_SMCCC [=n]
>   Selected by [y]:
>   - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]
> 
> Use a dependency on ARCH_SUSPEND_POSSIBLE as a prerequisite for
> selecting ARM_CPU_SUSPEND, and a dependency on HAVE_ARM_SMCCC
> for QCOM_SCM.
> 
> Fixes: 498ba2a8a275 ("cpuidle: Fix ARM_QCOM_SPM_CPUIDLE configuration")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/cpuidle/Kconfig.arm | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 334f83e56120..fc596494251c 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -107,7 +107,8 @@ config ARM_TEGRA_CPUIDLE
>  
>  config ARM_QCOM_SPM_CPUIDLE
>  	bool "CPU Idle Driver for Qualcomm Subsystem Power Manager (SPM)"
> -	depends on (ARCH_QCOM || COMPILE_TEST) && !ARM64 && MMU
> +	depends on ARCH_QCOM || (ARCH_SUSPEND_POSSIBLE && COMPILE_TEST)
> +	depends on ARM && HAVE_ARM_SMCCC
>  	select ARM_CPU_SUSPEND
>  	select CPU_IDLE_MULTIPLE_DRIVERS
>  	select DT_IDLE_STATES

Thanks.
-- 
~Randy
