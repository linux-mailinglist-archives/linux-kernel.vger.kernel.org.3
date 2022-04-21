Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CEC50A133
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387557AbiDUNw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387543AbiDUNwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:52:33 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED6C387A8;
        Thu, 21 Apr 2022 06:49:42 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23LDnPct064964;
        Thu, 21 Apr 2022 08:49:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650548965;
        bh=sOz3H5JVFZa8DXo43LjtHrPf7nI/khmshY2meABrkFQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=IlKi3DBHGtzAgBYQLAsXVp1JMjJvok3pPIWUXfGXmPonilChCKKCwa0bI8C/hSX0B
         VRBO8rftr9ZGNLprfjducb/NvIqC8WxohZA793oKR+uuRxdyfpcB2xKnMuLTjPPLzc
         8dE0XefoWFF377o6OHtFFJqGS0VbEbNR3otANW0c=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23LDnPKu096354
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Apr 2022 08:49:25 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 21
 Apr 2022 08:49:23 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 21 Apr 2022 08:49:23 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23LDnNEs035425;
        Thu, 21 Apr 2022 08:49:23 -0500
Date:   Thu, 21 Apr 2022 08:49:23 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jai Luthra <j-luthra@ti.com>
CC:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/3] Enable audio output on AM62-SK
Message-ID: <20220421134923.5n546sckyfugfyp4@matador>
References: <20220421132224.8601-1-j-luthra@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220421132224.8601-1-j-luthra@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:52-20220421, Jai Luthra wrote:
> This patch series adds support for audio output via headphone jack on the 
> AM62-SK board. The jack is wired to TLV320AIC3106 (codec), which is 
> connected to McASP (serializer).
> 
> The same 3.5mm jack can be used for combined playback+recording, but audio 
> input is currently disabled on McASP until further testing and debugging.
> 
> Please apply this series on top of 
> https://lore.kernel.org/all/20220415131917.431137-1-vigneshr@ti.com/ 
> 
> Jai Luthra (1):
>   arm64: dts: ti: am625-sk: Add audio output support
> 
> Jayesh Choudhary (2):
>   arm64: dts: ti: k3-am62-main: Add McASP nodes
>   ASoC: ti: davinci-mcasp: Add dma-type for bcdma
> 
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 51 ++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am625-sk.dts   | 89 ++++++++++++++++++++++++
>  sound/soc/ti/davinci-mcasp.c             |  2 +
>  3 files changed, 142 insertions(+)
> 


Please split this series up. Send out the sound/soc/ti/davinci-mcasp.c patch as it's own.

dts changes are their own series.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
