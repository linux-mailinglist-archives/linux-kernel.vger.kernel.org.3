Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3EE49C3C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbiAZGm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:42:29 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:41594 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbiAZGm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643179349; x=1674715349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hzPPq4isgNfFzq9vN+MNEiO/zlWFlWHgofFezQJOQ/Q=;
  b=H75/SU07g8WkbOiI5OvkfRvvMHsA8Huqbw2DI+QFxEzn3RD1VqFjgy6x
   4w8ZJy3QWOg0gkGtzsehHC/x7TFZwpFQSvvc9PtGJfQn6G3MqUg6RAj3h
   A8kuvEzkjRU4lqStpIKXEZk8BM05i/HSY+QyLCqTQo5CKYy5FbJenSPMg
   yBBCUXv7W8QtUmxCs8GEpV+W+8Lnq0yHWIeW+W8kVGNUfzk5fv6ZSUDNn
   U4wZRANrA7eu7AgxYx/3c0RUba6uPl7c79hvAB1UiE3XDHkbdbPK0DKJ0
   xSsMAZC/02LqO1tBzVz35nbArMeo5GADRPwUnN1X1DGBK6ZT8wV8tQw2Z
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,317,1635199200"; 
   d="scan'208";a="21710555"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 26 Jan 2022 07:42:26 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 26 Jan 2022 07:42:26 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 26 Jan 2022 07:42:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643179346; x=1674715346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hzPPq4isgNfFzq9vN+MNEiO/zlWFlWHgofFezQJOQ/Q=;
  b=SoezRi0go/RoYqZ7DSfpecFGn5iNSoUacCrpgOGSTsjv8BdhtIMqrq4f
   8GQQdc4U8sLgjNa7Lw65J0ryYi6XXF/IwceR/S3KVTi9oQXJrTufL5xPm
   VMCYzKnwKEbOgE2TsJEOxbC6VHuiEjzPJZHnmwO7oHoE/NELrJ1KknR3j
   jWQaEURzvbJf7DP1Zj152W2fjnpzj3bLOBjUNbFBX/ufDxPvrjF8SZcjC
   vhmEq0V72t7MCgA7Kj+tWie15djzWlvYuqUW2Vm2bJypkIIrK/Ne6sAK9
   DjJA8RoA+i3o9sqr/+piRK/fx6sBWwM+M6Tk8RclJQd823SsInpZ7VxkU
   A==;
X-IronPort-AV: E=Sophos;i="5.88,317,1635199200"; 
   d="scan'208";a="21710554"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 26 Jan 2022 07:42:26 +0100
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 65492280065;
        Wed, 26 Jan 2022 07:42:26 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-media@vger.kernel.org, aford@beaconembedded.com,
        cphealy@gmail.com, Adam Ford <aford173@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: (EXT) [PATCH V4 01/11] arm64: dts: imx8mq-tqma8mq: Remove redundant vpu reference
Date:   Wed, 26 Jan 2022 07:42:24 +0100
Message-ID: <5426078.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220125171129.472775-2-aford173@gmail.com>
References: <20220125171129.472775-1-aford173@gmail.com> <20220125171129.472775-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 25. Januar 2022, 18:11:18 CET schrieb Adam Ford:
> The vpu is enabled by default, so there is no need to manually
> enable it.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi index
> 8aedcddfeab8..38ffcd145b33 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi
> @@ -272,10 +272,6 @@ &usdhc1 {
>  	status = "okay";
>  };
> 
> -&vpu {
> -	status = "okay";
> -};
> -
>  /* Attention: wdog reset forcing POR needs baseboard support */
>  &wdog1 {
>  	status = "okay";




