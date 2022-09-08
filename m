Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5DF5B1450
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiIHGCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiIHGC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:02:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501CACAC4E;
        Wed,  7 Sep 2022 23:02:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5B07B81F9E;
        Thu,  8 Sep 2022 06:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F130CC433D6;
        Thu,  8 Sep 2022 06:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662616939;
        bh=x0GKCvCjflBtX1AF1k1VB/0WylD+G87f6QGZUG42Y2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ku2XVBcA2SI7p1XDOyy886e45Ao6j8Vf6BL3m9vb5/jRoJBMWZyJZE0CEwY0kSqps
         Hh0n8nfIk1uCuE3LC6HwdVZoxOQUN8qzGVRMtx423YhdIHty++t7SYfQvW2ipo2RRS
         4Bls6YxoiZ+f/VG3IoE3hxD4KWaAksAsE/Pa/9yE=
Date:   Thu, 8 Sep 2022 08:02:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
Cc:     appanad@amd.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, git@amd.com
Subject: Re: [PATCH v3 4/4] drivers: misc: Add Support for TMR Inject IP
Message-ID: <YxmFgblww9VfySnv@kroah.com>
References: <20220908042444.2866731-1-appana.durga.kedareswara.rao@amd.com>
 <20220908042444.2866731-5-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908042444.2866731-5-appana.durga.kedareswara.rao@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 09:54:44AM +0530, Appana Durga Kedareswara rao wrote:
> The Triple Modular Redundancy(TMR) provides functional fault injection by
> changing selected MicroBlaze instructions, which provides the possibility
> to verify that the TMR subsystem error detection and fault recovery logic
> is working properly, provided sysfs entries which allow the user to inject
> a fault.
> 
> Usage:
> echo 1 > /sys/kernel/debug/xtmr_inject/inject_fault/inject_fault
> 
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
> ---
> Changes for v3:
> --> Updated the driver to use fault-injection api as suggested by Greg.
> --> Updated the Kconfig to compile the driver as a module.
> Changes for v2:
> --> Fixed Month in the sysfs description.
> --> Fixed line over 80 char in driver.
> --> Replaced kstrtol with kstrtoul as suggested by Michal.
> --> Added error check for xlnx,magic value.
> 
>  MAINTAINERS                      |   6 +
>  drivers/misc/Kconfig             |  10 ++
>  drivers/misc/Makefile            |   1 +
>  drivers/misc/xilinx_tmr_inject.c | 181 +++++++++++++++++++++++++++++++
>  4 files changed, 198 insertions(+)
>  create mode 100644 drivers/misc/xilinx_tmr_inject.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5fc5ec13985e..1207effa8e15 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13284,6 +13284,12 @@ F:	Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
>  F:	Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
>  F:	drivers/misc/xilinx_tmr_manager.c
>  
> +MICROBLAZE TMR INJECT
> +M:	Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
> +F:	drivers/misc/xilinx_tmr_inject.c
> +
>  MICROCHIP AT91 DMA DRIVERS
>  M:	Ludovic Desroches <ludovic.desroches@microchip.com>
>  M:	Tudor Ambarus <tudor.ambarus@microchip.com>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 1508cc29b05a..7b1930a7f18a 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -506,6 +506,16 @@ config TMR_MANAGER
>  
>  	  Say N here unless you know what you are doing.
>  
> +config TMR_INJECT
> +	tristate "Select TMR Inject"
> +	depends on TMR_MANAGER && FAULT_INJECTION

But if CONFIG_FAULT_INJECTION_DEBUG_FS is not enabled, does this driver
actually do anything?  Why not just depend on that option?

thanks,

greg k-h
