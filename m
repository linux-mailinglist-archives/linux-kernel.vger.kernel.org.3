Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716EE552CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348155AbiFUI2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348003AbiFUI1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:27:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6D3112B;
        Tue, 21 Jun 2022 01:27:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FA68614E8;
        Tue, 21 Jun 2022 08:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0EDC3411D;
        Tue, 21 Jun 2022 08:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655800071;
        bh=vq74hwgGIXNtd0Oi63FHItQ2lILjSqcBsh/3jD/OHLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YinFmWa0LnPWSl/yFozEUqdXRXcFe43cprSV792cAQ3aIEKKQvS1TXTpJF2xUT1cQ
         5t/aEXebIamIl6rgiO7Vx6lF/0IzixGEKjwfuxgt6D+Agirczg6MS+DYZlK+4bDuNw
         g1lrL3YBbouTPimhhJolQbMTXmuYNdntgnGpWV0M=
Date:   Tue, 21 Jun 2022 10:27:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, vdonnefort@google.com,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v7 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <YrGBBFW2d/scKDeN@kroah.com>
References: <20220621080308.3952915-1-sebastianene@google.com>
 <20220621080308.3952915-3-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621080308.3952915-3-sebastianene@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 08:03:09AM +0000, Sebastian Ene wrote:
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
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  drivers/misc/Kconfig               |  12 ++
>  drivers/misc/Makefile              |   1 +
>  drivers/misc/vcpu_stall_detector.c | 222 +++++++++++++++++++++++++++++
>  3 files changed, 235 insertions(+)
>  create mode 100644 drivers/misc/vcpu_stall_detector.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 41d2bb0ae23a..e15c85d74c4b 100644
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
> +	  Detect CPU locks on a kvm virtual machine. This driver relies on
> +	  the hrtimers which are CPU-binded to do the 'pet' operation. When a
> +	  vCPU has to do a 'pet', it exits the guest through MMIO write and
> +	  the backend driver takes into account the lost ticks for this
> +	  particular CPU.
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called vcpu_stall_detector.

Should this depend on KVM_GUEST?

thanks,

greg k-h
