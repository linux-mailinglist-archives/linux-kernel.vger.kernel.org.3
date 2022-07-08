Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A37356BB1D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbiGHNrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238268AbiGHNrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:47:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEA131347;
        Fri,  8 Jul 2022 06:47:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83AFF627B0;
        Fri,  8 Jul 2022 13:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603A0C341C0;
        Fri,  8 Jul 2022 13:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657288045;
        bh=ti34gkI5DpDj2IoOp134IrjFCpPYMKEKic1GnzTmR8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WCHFwrgiD/Q53H1kFimo9V1/QQETg/b032nMhy6BWJAbm17bp0cthezUXD1lJkToJ
         rERjtfYqYWHaex7S1AGRrBO9f2eiMaMAT5uMj+nbngvI+yGvke+DB2k4kzUhBmBz14
         Mgkr+X7ruMPEzCQjuH1UxdwGOorfOpN0+uypdjhs=
Date:   Fri, 8 Jul 2022 15:47:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, vdonnefort@google.com,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v11 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <Ysg1axKEaLgG+uQa@kroah.com>
References: <20220708112344.1965947-1-sebastianene@google.com>
 <20220708112344.1965947-3-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708112344.1965947-3-sebastianene@google.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 11:23:45AM +0000, Sebastian Ene wrote:
> This driver creates per-cpu hrtimers which are required to do the
> periodic 'pet' operation. On a conventional watchdog-core driver, the
> userspace is responsible for delivering the 'pet' events by writing to
> the particular /dev/watchdogN node. In this case we require a strong
> thread affinity to be able to account for lost time on a per vCPU.
> 
> This part of the driver is the 'frontend' which is reponsible for
> delivering the periodic 'pet' events, configuring the virtual peripheral
> and listening for cpu hotplug events. The other part of the driver is
> an emulated MMIO device which is part of the KVM virtual machine
> monitor and this part accounts for lost time by looking at the
> /proc/{}/task/{}/stat entries.
> 
> Reviewed-by: Will Deacon <will@kernel.org>
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  drivers/misc/Kconfig               |  14 ++
>  drivers/misc/Makefile              |   1 +
>  drivers/misc/vcpu_stall_detector.c | 223 +++++++++++++++++++++++++++++
>  3 files changed, 238 insertions(+)
>  create mode 100644 drivers/misc/vcpu_stall_detector.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 41d2bb0ae23a..d5b7610459f7 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -483,6 +483,20 @@ config OPEN_DICE
>  
>  	  If unsure, say N.
>  
> +config VCPU_STALL_DETECTOR
> +	tristate "Guest vCPU stall detector"
> +	select LOCKUP_DETECTOR

This should be a "depends on", not a select, right?  This got enabled on
my build when I didn't want it to, and trying to track down why it was
enabled would be a pain for people.

thanks,

greg k-h
