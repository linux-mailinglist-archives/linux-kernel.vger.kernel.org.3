Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FBB46B5AE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhLGI2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:28:01 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50928 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbhLGI16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:27:58 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B78ONH7075955;
        Tue, 7 Dec 2021 02:24:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638865463;
        bh=+iAY871WG3zjLc73AOqWwiWxcvHPXUNXCM3wFsAOOgg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JXUGzAUeuY2NeFFfAGQ2gHVDZdZS98GAkGtDh2sDGZMyM4zMJTxsh1uFTALGefgeU
         ATxoQQFZ4HJuBAg3wTv416WuMqwzHxcvHvm6oXJzB4Tw3Da0DgsApSav94RAykXokB
         +Gtw+jkGTvMOMAaJWuo81TqQ6aM/XtCkgu46eZCI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B78ONNO029060
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Dec 2021 02:24:23 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Dec 2021 02:24:23 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Dec 2021 02:24:23 -0600
Received: from [10.250.232.43] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B78OIai062351;
        Tue, 7 Dec 2021 02:24:19 -0600
Subject: Re: [PATCH v3 0/5] J721S2: Add initial support
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20211207080904.14324-1-a-govindraju@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <432ca537-39f5-480a-20d9-83c131be5aa7@ti.com>
Date:   Tue, 7 Dec 2021 13:54:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211207080904.14324-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/12/21 1:38 pm, Aswath Govindraju wrote:
> The J721S2 SoC belongs to the K3 Multicore SoC architecture platform,
> providing advanced system integration in automotive ADAS applications and
> industrial applications requiring AI at the network edge. This SoC extends
> the Jacinto 7 family of SoCs with focus on lowering system costs and power
> while providing interfaces, memory architecture and compute performance for
> single and multi-sensor applications.
> 
> Some highlights of this SoC are:
> 
> * Dual Cortex-A72s in a single cluster, three clusters of lockstep capable
> dual Cortex-R5F MCUs, Deep-learning Matrix Multiply Accelerator(MMA), C7x
> floating point Vector DSP.
> * 3D GPU: Automotive grade IMG BXS-4-64
> * Vision Processing Accelerator (VPAC) with image signal processor and
> Depth and Motion Processing Accelerator (DMPAC)
> * Two CSI2.0 4L RX plus one eDP/DP, two DSI Tx, and one DPI interface.
> * Two Ethernet ports with RGMII support.
> * Single 4 lane PCIe-GEN3 controllers, USB3.0 Dual-role device subsystems,
> * Up to 20 MCANs, 5 McASP, eMMC and SD, OSPI/HyperBus memory controller,
> QSPI, I3C and I2C, eCAP/eQEP, eHRPWM, MLB among other peripherals.
> * Hardware accelerator blocks containing AES/DES/SHA/MD5 called SA2UL
> management.
> * Chips and Media Wave521CL H.264/H.265 encode/decode engine
> 
> See J721S2 Technical Reference Manual (SPRUJ28 – NOVEMBER 2021)
> for further details: http://www.ti.com/lit/pdf/spruj28
> 
> - bootlog:
>   https://pastebin.ubuntu.com/p/crVdPwQZYt/
> 
> The following series of patches depend on,
> - http://lists.infradead.org/pipermail/linux-arm-kernel/2021-December/700936.html
> - https://patchwork.kernel.org/project/linux-dmaengine/list/?series=583035
> - https://patchwork.kernel.org/project/linux-phy/list/?series=574093
> 
> Changes since v2:
> - Removed mux.h and phy.h header files that were
>   unused.
> 
> Changes since v1:
> - Picked up Rob Herring's acked-bys for patches 1 and 2
> - Removed unnecessary header file in patch 3
> 
> Aswath Govindraju (5):
>   dt-bindings: arm: ti: Add bindings for J721s2 SoC
>   dt-bindings: pinctrl: k3: Introduce pinmux definitions for J721S2
>   arm64: dts: ti: Add initial support for J721S2 SoC
>   arm64: dts: ti: Add initial support for J721S2 System on Module
>   arch: arm64: ti: Add support J721S2 Common Processor Board
> 
>  .../devicetree/bindings/arm/ti/k3.yaml        |   6 +
>  arch/arm64/boot/dts/ti/Makefile               |   2 +
>  .../dts/ti/k3-j721s2-common-proc-board.dts    | 421 ++++++++
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 937 ++++++++++++++++++
>  .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 302 ++++++
>  arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  | 175 ++++
>  arch/arm64/boot/dts/ti/k3-j721s2.dtsi         | 189 ++++
>  include/dt-bindings/pinctrl/k3.h              |   3 +
>  8 files changed, 2035 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2.dtsi
> 

For the series:
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
