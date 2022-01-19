Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57C64939ED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 12:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354342AbiASLvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 06:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241852AbiASLvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 06:51:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDB8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 03:51:21 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1nA9Uh-000380-KK; Wed, 19 Jan 2022 12:51:15 +0100
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1nA9Uf-0006vc-Qw; Wed, 19 Jan 2022 12:51:13 +0100
Date:   Wed, 19 Jan 2022 12:51:13 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, git@xilinx.com, michals@xilinx.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org, heikki.krogerus@linux.intel.com,
        Manish Narani <manish.narani@xilinx.com>
Subject: Re: [PATCH v12 2/5] arm64: zynqmp: DT: Add Xilinx AMS node
Message-ID: <20220119115113.GA26036@pengutronix.de>
References: <20211203212358.31444-1-anand.ashok.dumbre@xilinx.com>
 <20211203212358.31444-3-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211203212358.31444-3-anand.ashok.dumbre@xilinx.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:47:25 up 39 days, 20:32, 81 users,  load average: 1.32, 1.28,
 1.00
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Dec 2021 21:23:55 +0000, Anand Ashok Dumbre wrote:
> The Xilinx AMS includes an ADC as well as on-chip sensors that can be
> used to sample external and monitor on-die operating conditions, such as
> temperature and supply voltage levels.
> 
> Co-developed-by: Manish Narani <manish.narani@xilinx.com>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 74e66443e4ce..ab96708fe65e 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -878,6 +878,30 @@
>  			timeout-sec = <10>;
>  		};
>  
> +		xilinx_ams: ams@ffa50000 {
> +			compatible = "xlnx,zynqmp-ams";
> +			status = "disabled";
> +			interrupt-parent = <&gic>;
> +			interrupts = <0 56 4>;
> +			reg = <0x0 0xffa50000 0x0 0x800>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			#io-channel-cells = <1>;
> +			ranges = <0 0 0xffa50800 0x800>;
> +
> +			ams_ps: ams-ps@0 {
> +				compatible = "xlnx,zynqmp-ams-ps";
> +				status = "disabled";
> +				reg = <0 0x400>;
> +			};
> +
> +			ams_pl: ams-pl@400 {
> +				compatible = "xlnx,zynqmp-ams-pl";
> +				status = "disabled";
> +				reg = <0x400 0x400>;
> +			};
> +		};
> +

The patch should also add the xilinx_ams node to
arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi as:

	&xilinx_ams {
		clocks = <&zynqmp_clk AMS_REF>;
	};

Otherwise the driver fails to find the clock during probe.

Michael

>  		zynqmp_dpdma: dma-controller@fd4c0000 {
>  			compatible = "xlnx,zynqmp-dpdma";
>  			status = "disabled";
> -- 
> 2.17.1
