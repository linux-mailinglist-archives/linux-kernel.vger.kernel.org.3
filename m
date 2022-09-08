Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589D55B1430
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 07:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiIHFt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 01:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIHFtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 01:49:52 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A004F18B11;
        Wed,  7 Sep 2022 22:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662616191; x=1694152191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=29FOG/05C6CfZJ2KGlkFFdslxcHqhGghDDdbqMYZeak=;
  b=LOOCXtXwN47C+k5gGbxV/JZR4EbEmOFjq2RfzSp9gifOpOQnR5zgHg7v
   H7wHCsS+QiKTVyLeUNbOG/fLpxpNonMxdVoWM4Jmo9bGHx6naYPg/OfCR
   MYEWwBVjJwdKiZ8g4YpgAL3OYg4fwHswol6Z/pyCycUw6mhWSY3yb8mLA
   cGfgICPNQKRL9cC7h2e2ZitsIuFmDt2y4ngzVbsRwEfzbD39SLydpV2zK
   hj8aQhHNrmivTekG/aTPhWKrrkMvTelgz4ZXGfda1aWa7pvkJY3MzU7Id
   TCDNukjTTGQjvetUMPwzU+a1rJwr3C1G5umJyht6Ud4cR15S0AeEpkjN7
   w==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654552800"; 
   d="scan'208";a="26056366"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 08 Sep 2022 07:49:48 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 08 Sep 2022 07:49:48 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 08 Sep 2022 07:49:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662616188; x=1694152188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=29FOG/05C6CfZJ2KGlkFFdslxcHqhGghDDdbqMYZeak=;
  b=TFJlNMjObpxmbrGPesWS7wtLdqBUxjWhk+y073sFIgISZuf5hnyzHj/L
   zRbnrXM/4vb1I3nAk6l2l3mV8GsA1Z4yI4hQt/pUeF7+bq8Ly/DOMQuce
   Tqgvwy21W4RmMZY4vw1PkTci6acr/YVG2bJtky07BMu5wRKkm37nT2yTS
   HYxPOHAABQMNV9gnTOb0VPJ1kzij3itkIdvHdyKOv4p5h5PWAMPOzp75x
   44+49HuICroT4X3KRAR3EtW8mFtC23JEqQJyoUIVt9ZpaMBdWp/7h+EkZ
   agsnW4h+feFg8qO/gG4PkLN3+yuQiDlxRgn47W14fgZEJ0VbYdRc9wW5I
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654552800"; 
   d="scan'208";a="26056365"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Sep 2022 07:49:47 +0200
Received: from steina-w.localnet (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 9D309280056;
        Thu,  8 Sep 2022 07:49:47 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, Jun Li <jun.li@nxp.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/4] USB host support for TQMa8MPxL + MBa8MPxL
Date:   Thu, 08 Sep 2022 07:49:45 +0200
Message-ID: <3126965.5fSG56mABF@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <PA4PR04MB9640CB3CA93301CA1571D85789419@PA4PR04MB9640.eurprd04.prod.outlook.com>
References: <20220907144624.2810117-1-alexander.stein@ew.tq-group.com> <PA4PR04MB9640CB3CA93301CA1571D85789419@PA4PR04MB9640.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 7. September 2022, 18:08:25 CEST schrieb Jun Li:
> Hi
> 
> > -----Original Message-----
> > From: Alexander Stein <alexander.stein@ew.tq-group.com>
> > Sent: Wednesday, September 7, 2022 10:46 PM
> > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring
> > <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; Shawn Guo <shawnguo@kernel.org>;
> > Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; dl-linux-imx
> > <linux-imx@nxp.com>; Jun Li <jun.li@nxp.com>
> > Cc: Alexander Stein <alexander.stein@ew.tq-group.com>;
> > linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: [PATCH 0/4] USB host support for TQMa8MPxL + MBa8MPxL
> > 
> > Hi everybody,
> > 
> > this is a series based on the RFC at [1] for USB host support on TQMa8MPxL
> > + MBa8MPxL. The main difference is that USB DR support has already been
> > added and has been removed from this series.
> > 
> > The DT configuration itself (patch 4) is rather straight forward, but
> > leads
> > 
> > to the following dmesg errors regarding superspeed ports:
> > > [    8.549243] hub 2-1:1.0: hub_ext_port_status failed (err = -110)
> > > [   22.885263] usb 2-1: Failed to suspend device, error -110
> > 
> > This hardware works fine using the downstream kernel, because for imx8mp
> > this ITP sync feature is enabled conditionally [2] & [3].
> > Hacking this into mainline resulted in a working superspeed setup as well.
> > I also noticed that on some android kernel [4] depending in IP core
> > version
> > either GCTL.SOFTITPSYNC or GFLADJ.GFLADJ_REFCLK_LPM_SEL is enabled
> > unconditionally.
> > So I opted for the latter one using some quirk (patch 1-3).
> > 
> > I have to admit I do not know what this is actually about, nor why my
> > setup
> > does not work without this change or why this fixed my problem. So maybe
> > someone with more knowledge can say if this is the way to go or what this
> > is about.
> 
> This can be updated:)
> 
> > I also added snps,dis_u3_susphy_quirk to the board level as for some
> > reason
> > USB Superspeed U3 does not work. Detecting the onboard hub takes much
> > longer and once all devices are diconnected from the hub it is put into
> > runtime suspend (U3) and new attached devices are not detected at all.
> > Until the cause is known and fixed runtime suspend has to be disabled.
> 
> For this issue you are reporting, I am not sure if this is caused by a USB
> clock change merged on v5.19, if you use latest kernel, can you try with
> below patches applied to see if U3 can work for you?

Awesome, This does the trick!
I was already running with patches [1] & [2], but was missing patch [3]. With 
all of them applied, USB detects a newly attached superspeed device when the 
HUB is in runtime suspend (U3).

I forgot: thanks for checking with synopsis regarding soft ITP sync feature.

Best regards,
Alexander

> [1]
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/1662547028-2227
> 9-1-git-send-email-jun.li@nxp.com/ [2]
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/1662547028-2227
> 9-2-git-send-email-jun.li@nxp.com/ [3]
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/1661328612-3932
> -1-git-send-email-jun.li@nxp.com/
>
> Li Jun
> 
> > Thanks and best regards,
> > Alexander
> > 
> > [1]
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
> > kernel.org%2Fall%2F20220622130440.955465-1-alexander.stein%40ew.tq-grou
> > p.com%2F&amp;data=05%7C01%7Cjun.li%40nxp.com%7Cd1bdfb58b364464e957d08da
> > 90dfc29f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63798158796971424
> > 0%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6I
> > k1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=WSQHERVO9SCWk%2B%2Fmq8g
> > K78yluy5VE7T%2BhUaDMlNhbWk%3D&amp;reserved=0
> > [2]
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsourc
> > e.codeaurora.org%2Fexternal%2Fimx%2Flinux-imx%2Ftree%2Fdrivers%2Fusb%2F
> > dwc3%2Fdwc3-imx8mp.c%3Fh%3Dlf-5.10.y%23n134&amp;data=05%7C01%7Cjun.li%4
> > 0nxp.com%7Cd1bdfb58b364464e957d08da90dfc29f%7C686ea1d3bc2b4c6fa92cd99c5
> > c301635%7C0%7C0%7C637981587969870477%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> > 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7
> > C&amp;sdata=9%2FxYZoZSelekGcWIZZNwRQqy8LTGPnnn13Rf4L5a0iY%3D&amp;reserv
> > ed=0
> > [3]
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsourc
> > e.codeaurora.org%2Fexternal%2Fimx%2Flinux-imx%2Ftree%2Fdrivers%2Fusb%2F
> > dwc3%2Fcore.c%3Fh%3Dlf-5.10.y%23n333&amp;data=05%7C01%7Cjun.li%40nxp.co
> > m%7Cd1bdfb58b364464e957d08da90dfc29f%7C686ea1d3bc2b4c6fa92cd99c5c301635
> > %7C0%7C0%7C637981587969870477%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> > DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;s
> > data=Or9hvtM%2F9DhPZbfv%2BKzwAm8QTyXg4y0ddVbMFqOM67Q%3D&amp;reserved=0
> > [4]
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fandro
> > id.googlesource.com%2Fkernel%2Fmsm%2F%2B%2F87a6b154766907020cc74c7726e8
> > a68aaa9d7f6b%255E%2521%2F%23F0&amp;data=05%7C01%7Cjun.li%40nxp.com%7Cd1
> > bdfb58b364464e957d08da90dfc29f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> > C0%7C637981587969870477%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> > QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3
> > tjAzUL81SwFkaoUh56CND%2B27FHqdo6TbY7Z66ldE8Q%3D&amp;reserved=0
> > 
> > Alexander Stein (4):
> >   dt-bindings: usb: dwc3: Add gfladj-refclk-lpm-sel-quirk
> >   usb: dwc3: core: add gfladj_refclk_lpm_sel quirk
> >   arm64: dts: imx8mp: Add snps,gfladj-refclk-lpm-sel quirk to USB nodes
> >   arm64: dts: tqma8mpql: add support for 2nd USB (host) interface
> >  
> >  .../devicetree/bindings/usb/snps,dwc3.yaml    |  5 +++
> >  .../freescale/imx8mp-tqma8mpql-mba8mpxl.dts   | 42 +++++++++++++++++++
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  2 +
> >  drivers/usb/dwc3/core.c                       |  8 +++-
> >  drivers/usb/dwc3/core.h                       |  2 +
> >  5 files changed, 58 insertions(+), 1 deletion(-)
> > 
> > --
> > 2.25.1




