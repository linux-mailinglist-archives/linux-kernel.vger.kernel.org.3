Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6954C6AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbiB1Lii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbiB1Lie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:38:34 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810BD4CD5C;
        Mon, 28 Feb 2022 03:37:55 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21SBbmsY057976;
        Mon, 28 Feb 2022 05:37:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1646048268;
        bh=nLMr4wVUegS8RsOa7LHrJJ7d3/4Kb1EE8ezBfNCz8bU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=J1dPlluyl0XHLgK7Z7IziHMg3f8wdU9csDudF1XlvqPovtLsZzqPuWDSXOgYg6eIi
         0jGNUrzSFiCxWp1s+vJTyoulz5pZObEMcvCTgzYOM2tWNPdhtDa4lkftVS9ysBmnLE
         n2XZPwJlj2nGIFDTYy/FmzTujNRFVsfer4xYX+PE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21SBbmXn016881
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Feb 2022 05:37:48 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 28
 Feb 2022 05:37:48 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 28 Feb 2022 05:37:48 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21SBbmga115166;
        Mon, 28 Feb 2022 05:37:48 -0600
Date:   Mon, 28 Feb 2022 05:37:48 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marc Zyngier <maz@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
Subject: Re: [PATCH v3 0/5] arm64: Initial support for Texas Instruments AM62
 Platform
Message-ID: <20220228113748.nmoduketo72eaoql@pulse>
References: <20220225120239.1303821-1-vigneshr@ti.com>
 <164604791648.14181.3995342010827414573.b4-ty@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <164604791648.14181.3995342010827414573.b4-ty@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05:32-20220228, Nishanth Menon wrote:
> Hi Vignesh Raghavendra,
> 
> On Fri, 25 Feb 2022 17:32:34 +0530, Vignesh Raghavendra wrote:
> > This adds AM62 SoC support.
> > 
> > The AM62 SoC family is the follow on AM335x built on K3 Multicore SoC
> > architecture platform, providing ultra-low-power modes, dual display,
> > multi-sensor edge compute, security and other BOM-saving integration.
> > The AM62 SoC targets broad market to enable applications such as
> > Industrial HMI, PLC/CNC/Robot control, Medical Equipment, Building
> > Automation, Appliances and more.
> > 
> > [...]
> 
> I have applied the following to branch ti-k3-dts-next on [1].
> Thank you!
> 
> [1/5] soc: ti: k3-socinfo: Add AM62x JTAG ID
>       commit: c1f284b8207bb4e33d021e34dd3be525abc39b8f
> [2/5] dt-bindings: arm: ti: Add bindings for AM625 SoC
>       commit: 52b7a9c87a72aa9798051b271fa7e4fb62910624
> [3/5] dt-bindings: pinctrl: k3: Introduce pinmux definitions for AM62
>       commit: 67cf6b691ec36da1318051c6776ff3523200ebc7
> [4/5] arm64: dts: ti: Introduce base support for AM62x SoC
>       commit: c8c226192205cf536e3e975301b5ad2fcfb2de36
> [5/5] arm64: dts: ti: Add support for AM62-SK
>       commit: e32f766b6e378ec3b6095470b1cd54fdc79792c6

Just a headsup -> I split the patches into two branches. [1/5] is
available in ti-drivers-soc-next Vs the rest in ti-k3-dts-next

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
