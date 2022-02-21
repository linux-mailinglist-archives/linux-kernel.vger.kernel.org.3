Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA8B4BDE04
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358439AbiBUM66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:58:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiBUM6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:58:54 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384401EAD5;
        Mon, 21 Feb 2022 04:58:30 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21LCwI27047020;
        Mon, 21 Feb 2022 06:58:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645448298;
        bh=zJPkUq5bndr8qfbg5WIBf/HuUb+QSE7Kcn6n8iOJ4gU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Xix/xZcWtlSkqka3uGCAoboZQFohva0T2zZu93RneAZaStraEU8uCUh28fIkSYXxv
         Ngt5guRsBnBV2GhcFu/gr/S1Xeitq9pwA34d/8QQVncSRP5QuKvqTxyiE2XgEQ48R+
         hF18EocxkGyJS2S1Vkjp1PE5cflc3pWWhjCluARg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21LCwI3Z035992
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Feb 2022 06:58:18 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 21
 Feb 2022 06:58:18 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 21 Feb 2022 06:58:18 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21LCwHha021570;
        Mon, 21 Feb 2022 06:58:17 -0600
Date:   Mon, 21 Feb 2022 06:58:17 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Drew Fustini <dfustini@baylibre.com>
CC:     =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>, <devicetree@vger.kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>, <s-anna@ti.com>,
        <khilman@baylibre.com>
Subject: Re: [PATCH 00/11] soc: ti: wkup_m3_ipc: support vtt toggle, io
 isolation & voltage scaling
Message-ID: <20220221125817.eg2rf6ktrhiq7eck@overbook>
References: <20220219215328.485660-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220219215328.485660-1-dfustini@baylibre.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:53-20220219, Drew Fustini wrote:
> Improve the wkup_m3_ipc driver to better support the TI Wakeup Cortex M3 
> device found on TI AM33xx and AM43xx SoCs.
> 
> This series derives from these commits in the ti-linux-5.10.y branch of
> the TI Linux repo [1]:
> 
>   6ab4eff1034b ("remoteproc: move rproc_da_to_va declaration to remoteproc.h")
>   2a9be39a26f7 ("dt-bindings: wkup_m3_ipc: Add vtt toggling bindings")
>   c65263f9e12c ("wkup_m3_ipc: Add support for toggling VTT regulator")
>   5c6c821803e1 ("dt-bindings: wkup_m3_ipc: Add ti,io-isolation property")
>   196c46f7577d ("wkup_m3_ipc: Add support for IO Isolation")
>   c28acc847e5d ("soc: ti: wkup_m3_ipc: Add support for i2c voltage scaling")
>   a4f9ef4ab5ca ("ARM: dts: am437x-gp-evm: Enable wkup_m3 control of IO isolation")
>   94de756f1771 ("ARM: dts: am33xx: Add scale data fw to wkup_m3_ipc node")
>   b7ae4b063793 ("ARM: dts: am43xx: Add scale data fw to wkup_m3_ipc node")
>   451ec7871ae7 ("soc: ti: wkup_m3_ipc: Add debug option to halt m3 in suspend")
> 
> Minor changes have been made to some patches to resolve conflicts and 
> to split i2c voltage scaling dt-bindings into separate patch.
> 
> [1] git://git.ti.com/ti-linux-kernel/ti-linux-kernel.git
> 
> Dave Gerlach (10):
>   dt-bindings: wkup_m3_ipc: Add vtt toggling bindings
>   soc: ti: wkup_m3_ipc: Add support for toggling VTT regulator
>   dt-bindings: wkup_m3_ipc: Add ti,io-isolation property
>   soc: ti: wkup_m3_ipc: Add support for IO Isolation
>   ARM: dts: am437x-gp-evm: Enable wkup_m3 control of IO isolation
>   dt-bindings: wkup_m3_ipc: Add scale-data-fw property
>   soc: ti: wkup_m3_ipc: Add support for i2c voltage scaling
>   ARM: dts: am33xx: Add scale data fw to wkup_m3_ipc node
>   ARM: dts: am43xx: Add scale data fw to wkup_m3_ipc node
>   soc: ti: wkup_m3_ipc: Add debug option to halt m3 in suspend
> 
> Suman Anna (1):
>   remoteproc: move rproc_da_to_va declaration to remoteproc.h


This series seems to needing to go to various maintainers here

Series should cleanup (example: txt files to yaml bindings),
prior to creating patch series for each maintainer. I'd suggest bindings
and drivers in 1 kernel rev and follow it up with dts updata for the
next rev.


> 
>  .../bindings/soc/ti/wkup_m3_ipc.txt           |  91 ++++++++
>  arch/arm/boot/dts/am335x-bone-common.dtsi     |   4 +
>  arch/arm/boot/dts/am335x-evm.dts              |   4 +
>  arch/arm/boot/dts/am335x-evmsk.dts            |   4 +
>  arch/arm/boot/dts/am437x-gp-evm.dts           |   5 +
>  arch/arm/boot/dts/am437x-sk-evm.dts           |   4 +
>  arch/arm/boot/dts/am43x-epos-evm.dts          |   4 +
>  drivers/remoteproc/remoteproc_internal.h      |   1 -
>  drivers/soc/ti/wkup_m3_ipc.c                  | 208 +++++++++++++++++-
>  include/linux/remoteproc.h                    |   1 +
>  include/linux/wkup_m3_ipc.h                   |  13 ++
>  11 files changed, 334 insertions(+), 5 deletions(-)
> 
> -- 
> 2.32.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
