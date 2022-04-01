Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF63F4EEA69
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344561AbiDAJak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344559AbiDAJah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:30:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC4A91CCACE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:28:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B747A13D5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:28:46 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 78D763F66F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:28:46 -0700 (PDT)
Date:   Fri, 1 Apr 2022 10:28:29 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ARM: vexpress/spc: Avoid negative array index when !SMP
Message-ID: <YkbFvYRkcXgo3mpK@e110455-lin.cambridge.arm.com>
References: <20220331190443.851661-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220331190443.851661-1-keescook@chromium.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 12:04:43PM -0700, Kees Cook wrote:
> When building multi_v7_defconfig+CONFIG_SMP=n, -Warray-bounds exposes
> a couple negative array index accesses:
> 
> arch/arm/mach-vexpress/spc.c: In function 've_spc_clk_init':
> arch/arm/mach-vexpress/spc.c:583:21: warning: array subscript -1 is below array bounds of 'bool[2]' {aka '_Bool[2]'} [-Warray-bounds]
>   583 |   if (init_opp_table[cluster])
>       |       ~~~~~~~~~~~~~~^~~~~~~~~
> arch/arm/mach-vexpress/spc.c:556:7: note: while referencing 'init_opp_table'
>   556 |  bool init_opp_table[MAX_CLUSTERS] = { false };
>       |       ^~~~~~~~~~~~~~
> arch/arm/mach-vexpress/spc.c:592:18: warning: array subscript -1 is below array bounds of 'bool[2]' {aka '_Bool[2]'} [-Warray-bounds]
>   592 |    init_opp_table[cluster] = true;
>       |    ~~~~~~~~~~~~~~^~~~~~~~~
> arch/arm/mach-vexpress/spc.c:556:7: note: while referencing 'init_opp_table'
>   556 |  bool init_opp_table[MAX_CLUSTERS] = { false };
>       |       ^~~~~~~~~~~~~~
> 
> Skip this logic when built !SMP.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Sudeep, can you please take this through your tree for sending it to arm-soc?

Best regards,
Liviu

> ---
>  arch/arm/mach-vexpress/spc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
> index 1da11bdb1dfb..1c6500c4e6a1 100644
> --- a/arch/arm/mach-vexpress/spc.c
> +++ b/arch/arm/mach-vexpress/spc.c
> @@ -580,7 +580,7 @@ static int __init ve_spc_clk_init(void)
>  		}
> 
>  		cluster = topology_physical_package_id(cpu_dev->id);
> -		if (init_opp_table[cluster])
> +		if (cluster < 0 || init_opp_table[cluster])
>  			continue;
> 
>  		if (ve_init_opp_table(cpu_dev))
> --
> 2.32.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
