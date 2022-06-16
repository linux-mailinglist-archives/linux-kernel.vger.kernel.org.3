Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE92354DEB3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 12:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376361AbiFPKKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 06:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376384AbiFPKKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:10:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCB35D64F;
        Thu, 16 Jun 2022 03:10:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3D5F614E7;
        Thu, 16 Jun 2022 10:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED15C34114;
        Thu, 16 Jun 2022 10:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655374205;
        bh=5Dv9JP3bXTE2uRf8zpfYaCIFCVrfFMzOlE7ggr6awAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IYDHKbGAj2H3C7abExcrGg3XeVyxWJFBwZbj+e7U25ljTeS1lgsku/UdBOrtJb0y4
         el7qE6m5ZwuK/cF75cI2QylFcHrU1bkD32jUColuY5DHgWdKitem53ILh90Fd6FQrZ
         u2XniIJ0R5Pa4N5Be3F3keALqflYTtaOh7lV9u+k=
Date:   Thu, 16 Jun 2022 12:10:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, vdonnefort@google.com,
        Guenter Roeck <linux@roeck-us.net>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <YqsBeme1Vnzj5k7+@kroah.com>
References: <20220616092737.1713667-1-sebastianene@google.com>
 <20220616092737.1713667-3-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616092737.1713667-3-sebastianene@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 09:27:39AM +0000, Sebastian Ene wrote:
> This driver creates per-cpu hrtimers which are required to do the
> periodic 'pet' operation. On a conventional watchdog-core driver, the
> userspace is responsible for delivering the 'pet' events by writing to
> the particular /dev/watchdogN node. In this case we require a strong
> thread affinity to be able to account for lost time on a per vCPU.
> 
> This part of the driver is the 'frontend' which is reponsible for
> delivering the periodic 'pet' events, configuring the virtual peripheral
> and listening for cpu hotplug events. The other part of the driver
> handles the peripheral emulation and this part accounts for lost time by
> looking at the /proc/{}/task/{}/stat entries and is located here:
> https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  drivers/misc/Kconfig               |  12 ++
>  drivers/misc/Makefile              |   1 +
>  drivers/misc/vcpu_stall_detector.c | 222 +++++++++++++++++++++++++++++
>  3 files changed, 235 insertions(+)
>  create mode 100644 drivers/misc/vcpu_stall_detector.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 41d2bb0ae23a..9b3cb5dfd5a7 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -483,6 +483,18 @@ config OPEN_DICE
>  
>  	  If unsure, say N.
>  
> +config VCPU_STALL_DETECTOR
> +	tristate "VCPU stall detector"
> +	select LOCKUP_DETECTOR
> +	help
> +	  Detect CPU locks on the virtual machine. This driver relies on the
> +	  hrtimers which are CPU-binded to do the 'pet' operation. When a vCPU
> +	  has to do a 'pet', it exits the guest through MMIO write and the
> +	  backend driver takes into account the lost ticks for this particular
> +	  CPU.

which virtual machine framework is this for?  kvm?  xen?  hyperv?
vmware?  something else?

Specifics please...

thanks,

greg k-h
