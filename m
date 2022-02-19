Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E834A4BC906
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 16:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242416AbiBSPJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 10:09:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiBSPI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 10:08:58 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F7347AFB
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 07:08:39 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id f19so20830271qvb.6
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 07:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k/I+1clxvE02ds3q/vpOq8sh7Fxc4ogvnxrh8xQHKuQ=;
        b=TleVrJNvlg/phE6uPMhvbmuSYGDJ5V9cN6e+Jw6Qtb8F4Job48cLov/trdCAtu5M5D
         Lt8HaV4STqMw9oOxFHVveTysmnzpfrFjATpfi6SltgTK3TD6Db7USlvYJrUsPOKe9tCt
         mKzShr9SSx4HbeU7z5b/PU02bOC427SAxsXBSK9pk+mm7MVm0VeVD34t3Jg2bXdQN7G2
         5XRSUBZ2ICErh5q0J4FwlvYe7CyvC61OQXYw054YMXU9KI8sMGYpsgrADv+R9Ij07DT3
         Fuo5uxDMYfcxilCrH2+9/NJeGG4FWYqbfg+NPP2HOvN2fvjWZgiaHVNchF/PEo25JZAe
         wp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=k/I+1clxvE02ds3q/vpOq8sh7Fxc4ogvnxrh8xQHKuQ=;
        b=OsOrmgZqRGqJBx6gQwOeNSo5zcP7Th5Sd8oEZeDnj32zk/SDYO+tljtkQNhroswdti
         BOKcahBvsoTirY53PE0V/egpxntc5D0rS9lht79qlqgfZ2djpsWKHTFoo9/IBq7EftYE
         mqVVg2FA9U+G8RDXQKraLBBCKcTxgoxPeHH9K4fHJAW3Sow95AXOBzasOWw/7vr063aw
         5Yg/57710YQNIC6M21EeB23UMMMhIFNN5/n1VlwKM8l+S8EZqUId4P8oIWAOz5hNqQGp
         kl0mIwNOjsOLK0ZdxIaoTeymf+WBQ2EsPC4npay8JWBy2g/s4+jL5r79hMKM1MHTbQog
         NzJA==
X-Gm-Message-State: AOAM533jgqW+lOBx3C8MnZlMFd5H8jn2HvpJHHpRvuX7r0PLycFW820G
        fXMVoSn59VDVJvZCV/pk7xTJ1F300f08lA==
X-Google-Smtp-Source: ABdhPJyameQf7qV6cY5aAnDrPxy0Mb/C7d3bYB8Zb9PsM/egWUJPaMo36d8imI5Rx3LXwRBv4FBtyw==
X-Received: by 2002:ad4:5ca5:0:b0:421:6335:89 with SMTP id q5-20020ad45ca5000000b0042163350089mr9331773qvh.89.1645283318438;
        Sat, 19 Feb 2022 07:08:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q12sm27643417qtx.51.2022.02.19.07.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 07:08:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 19 Feb 2022 07:08:36 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     miquel.raynal@bootlin.com, krzysztof.kozlowski@canonical.com,
        vigneshr@ti.com, nm@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: omap2: Prevent invalid configuration and
 build error
Message-ID: <20220219150836.GA1035394@roeck-us.net>
References: <20220118123525.8020-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118123525.8020-1-rogerq@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 02:35:25PM +0200, Roger Quadros wrote:
> We need to select MEMORY as well otherwise OMAP_GPMC will not be built.
> For simplicity let's select MEMORY and OMAP_GPMC unconditionally as
> this driver depends on OMAP_GPMC driver and uses symbols from there.
> 
> Fixes: dbcb124acebd ("mtd: rawnand: omap2: Select GPMC device driver for ARCH_K3")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

This patch ignores OMAP_GPMC dependencies and results in:

WARNING: unmet direct dependencies detected for OMAP_GPMC
  Depends on [n]: MEMORY [=y] && OF_ADDRESS [=n]
  Selected by [m]:
  - MTD_NAND_OMAP2 [=m] && MTD [=m] && MTD_RAW_NAND [=m] && (ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST [=y]) && HAS_IOMEM [=y]

when configuring sparc64:allmodconfig, and in the following
build failure when trying to build that image.

Building sparc64:allmodconfig ... failed
--------------
Error log:
<stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
sparc64-linux-ld: drivers/memory/omap-gpmc.o: in function `gpmc_probe_generic_child':
omap-gpmc.c:(.text.unlikely+0x14c4): undefined reference to `of_platform_device_create'

Guenter

> ---
>  drivers/mtd/nand/raw/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 20408b7db540..d986ab4e4c35 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -42,7 +42,8 @@ config MTD_NAND_OMAP2
>  	tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
>  	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>  	depends on HAS_IOMEM
> -	select OMAP_GPMC if ARCH_K3
> +	select MEMORY
> +	select OMAP_GPMC
>  	help
>  	  Support for NAND flash on Texas Instruments OMAP2, OMAP3, OMAP4
>  	  and Keystone platforms.
> -- 
> 2.17.1
> 
