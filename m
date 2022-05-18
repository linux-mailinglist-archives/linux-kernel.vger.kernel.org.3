Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B609552B2EE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiERHKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiERHJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:09:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96306E7312
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:09:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3127CB81E9A
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A7CC385A5;
        Wed, 18 May 2022 07:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652857794;
        bh=2JqqIZvpbqswCTRP/bzbvdehB+RQl291QgBbPVeUz5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pp6SO/TKxrZNHvldAOjrKknX9j4MOMm00eEc1bfMfTaRIqoiHbCk/9Ay0O4pYErpz
         4WdOW/iMxXaSM20je3wnFPC3Rgm/JmcjW14O0UwKCfuPKAz+kyEFtfveeT5pwRSsYI
         CO9ObRCJkU7czDbnU3B4Uu/unhdj0DhMD4BhO25o=
Date:   Wed, 18 May 2022 09:09:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, rafael@kernel.org,
        mchehab+huawei@kernel.org, eugenis@google.com, tony.luck@intel.com,
        pcc@google.com, peterz@infradead.org, marcos@orca.pet,
        conor.dooley@microchip.com, nicolas.ferre@microchip.com,
        marcan@marcan.st, linus.walleij@linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 5/8] arm64: Create cache sysfs directory without ACPI
 PPTT for hardware prefetch control
Message-ID: <YoSbwJIDoXz5Aipv@kroah.com>
References: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
 <20220518063032.2377351-6-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518063032.2377351-6-tarumizu.kohei@fujitsu.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 03:30:29PM +0900, Kohei Tarumizu wrote:
> Create a cache sysfs directory without ACPI PPTT if the
> CONFIG_HWPF_CONTROL is true.
> 
> Hardware prefetch control driver need cache sysfs directory and cache
> level/type information. In ARM processor, these information can be
> obtained from the register even without PPTT.
> 
> This patch set the cpu_map_populated to true if the machine doesn't
> have PPTT. It use only the level/type information obtained from
> CLIDR_EL1, and don't use CCSIDR information.
> 
> Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
> ---
>  arch/arm64/kernel/cacheinfo.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
> index 587543c6c51c..039ec32d0b3d 100644
> --- a/arch/arm64/kernel/cacheinfo.c
> +++ b/arch/arm64/kernel/cacheinfo.c
> @@ -43,6 +43,21 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
>  	this_leaf->type = type;
>  }
>  
> +#if defined(CONFIG_HWPF_CONTROL)

Please do not put #if in .c files.

> +static bool acpi_has_pptt(void)
> +{
> +	struct acpi_table_header *table;
> +	acpi_status status;
> +
> +	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> +	if (ACPI_FAILURE(status))
> +		return false;
> +
> +	acpi_put_table(table);
> +	return true;
> +}
> +#endif
> +
>  int init_cache_level(unsigned int cpu)
>  {
>  	unsigned int ctype, level, leaves, fw_level;
> @@ -95,5 +110,19 @@ int populate_cache_leaves(unsigned int cpu)
>  			ci_leaf_init(this_leaf++, type, level);
>  		}
>  	}
> +
> +#if defined(CONFIG_HWPF_CONTROL)
> +	/*
> +	 * Hardware prefetch functions need cache sysfs directory and cache
> +	 * level/type information. In ARM processor, these information can be
> +	 * obtained from registers even without PPTT. Therefore, we set the
> +	 * cpu_map_populated to true to create cache sysfs directory, if the
> +	 * machine doesn't have PPTT.
> +	 **/
> +	if (!acpi_disabled)
> +		if (!acpi_has_pptt())
> +			this_cpu_ci->cpu_map_populated = true;
> +#endif

Same here, no #if is needed if you do it properly in your .h file.

thanks,

greg k-h
