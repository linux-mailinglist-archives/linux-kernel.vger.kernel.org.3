Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743464673E8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379582AbhLCJ2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379567AbhLCJ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:28:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FF4C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 01:25:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFE01629A4
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 09:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9115DC53FD2;
        Fri,  3 Dec 2021 09:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638523524;
        bh=3AUOk2ZKqKhp8BtiY8AjFGaXIUAdD2D1gvG87zbIadw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VfXW3A+ArzE1LYCd+V9np3vB+r74BAunrm0OT2Be6KvHUl5TRVL4slL6Lj1F3efM+
         ivNk++0+dTuZrT3rbXCzW83e1cm7TpqmBECkHpC+AC7woPwyeEv/3eahML4jNnvBXg
         zdLPRYj1WPyXZxAIGPPstSQ/5hkl+rE0xsa4S1Do=
Date:   Fri, 3 Dec 2021 10:25:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ronak Jain <ronak.jain@xilinx.com>
Cc:     michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        rajan.vaja@xilinx.com, corbet@lwn.net,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        lakshmi.sai.krishna.potthuri@xilinx.com
Subject: Re: [PATCH v3 2/3] firmware: zynqmp: Add sysfs entry for runtime
 features
Message-ID: <YanigXDtuo7MpVg8@kroah.com>
References: <20211203091814.15582-1-ronak.jain@xilinx.com>
 <20211203091814.15582-3-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203091814.15582-3-ronak.jain@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 01:18:13AM -0800, Ronak Jain wrote:
> Create sysfs entry for runtime feature configuration. The support
>  is added for an over temperature and external watchdog feature.
> 
> The below listed files are used for runtime features configuration:
> /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> 
> In order to configure an over temperature or external watchdog
>  features, first the user need to select the valid config id and then
>  the user can configure the value for selected feature config id.
> 
> Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>

Ah, here's the documentation.

You should say so in the Subject line, and the changelog text is not
correct, this is a documentation update.


> ---
> Changes in v3:
> - None
> 
> Changes in v2:
> - Update commit message
> ---
>  .../ABI/stable/sysfs-driver-firmware-zynqmp   | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> index f5724bb5b462..2fde354715a5 100644
> --- a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> +++ b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> @@ -113,3 +113,87 @@ Description:
>  		    # echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/health_status
>  
>  Users:		Xilinx
> +
> +What:		/sys/devices/platform/firmware\:zynqmp-firmware/feature_config_*
> +Date:		Aug 2021
> +KernelVersion:	5.14

5.14?

Are these sysfs files already in the kernel tree?

And can you break this up into one entry per sysfs file?

One for the feature_config_id file and one for feature_config_value?

thanks,

greg k-h
