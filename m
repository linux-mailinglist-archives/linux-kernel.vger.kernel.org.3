Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2223545595
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344064AbiFIU1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343803AbiFIU05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:26:57 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F2FF419A3;
        Thu,  9 Jun 2022 13:26:54 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nzOjz-0005nZ-00; Thu, 09 Jun 2022 22:26:51 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id C10CAC032C; Thu,  9 Jun 2022 22:25:18 +0200 (CEST)
Date:   Thu, 9 Jun 2022 22:25:18 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Yupeng Li <liyupeng@zbhlos.com>
Cc:     chenhuacai@kernel.org, jiaxun.yang@flygoat.com, jdelvare@suse.com,
        linux@roeck-us.net, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        caizp2008@163.com
Subject: Re: [PATCH 1/1] MIPS: Loongson-3: fix compile mips cpu_hwmon as
 module build error.
Message-ID: <20220609202518.GA4320@alpha.franken.de>
References: <20220608011229.2056016-1-liyupeng@zbhlos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220608011229.2056016-1-liyupeng@zbhlos.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 09:12:29AM +0800, Yupeng Li wrote:
>   set cpu_hwmon as a module build with loongson_sysconf, loongson_chiptemp
>   undefined error,fix cpu_hwmon compile options to be bool.Some kernel
>   compilation error information is as follows:
> 
>   Checking missing-syscalls for N32
>   CALL    scripts/checksyscalls.sh
>   Checking missing-syscalls for O32
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   CC [M]  drivers/platform/mips/cpu_hwmon.o
>   Building modules, stage 2.
>   MODPOST 200 modules
> ERROR: "loongson_sysconf" [drivers/platform/mips/cpu_hwmon.ko] undefined!
> ERROR: "loongson_chiptemp" [drivers/platform/mips/cpu_hwmon.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:92：__modpost] 错误 1
> make: *** [Makefile:1261：modules] 错误 2
> 
> Signed-off-by: Yupeng Li <liyupeng@zbhlos.com>
> ---
>  drivers/platform/mips/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/mips/Kconfig b/drivers/platform/mips/Kconfig
> index d421e1482395..6b51ad01f791 100644
> --- a/drivers/platform/mips/Kconfig
> +++ b/drivers/platform/mips/Kconfig
> @@ -17,7 +17,7 @@ menuconfig MIPS_PLATFORM_DEVICES
>  if MIPS_PLATFORM_DEVICES
>  
>  config CPU_HWMON
> -	tristate "Loongson-3 CPU HWMon Driver"
> +	bool "Loongson-3 CPU HWMon Driver"
>  	depends on MACH_LOONGSON64
>  	select HWMON
>  	default y
> -- 
> 2.34.1

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
