Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9626A58A3EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 01:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbiHDXbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 19:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiHDXbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 19:31:00 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2F56E8B3;
        Thu,  4 Aug 2022 16:30:59 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 274NUNmE128600;
        Thu, 4 Aug 2022 18:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1659655823;
        bh=HUDX6vDFz8YIrTjZ3w2uA6MHjjFNKz+nOiOMOApIlwo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=QXdaSe0dmFO3V/910XSiFZ2GSl7OasFfKaR5JOdJrTlwCSpiSO3pD9EScDXWLF2qO
         XGG3X8jPPLBwY79j5SvhYI5kdRZ59+sIBaJsDtoz7lJL/BfJClTPQEI61n28bfFcP4
         7iV5Z7v5Jy0ha2J10ITgGoeYlj26V75KdhgI019I=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 274NUMbK014332
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Aug 2022 18:30:22 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 4
 Aug 2022 18:30:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 4 Aug 2022 18:30:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 274NUMad019136;
        Thu, 4 Aug 2022 18:30:22 -0500
Date:   Thu, 4 Aug 2022 18:30:22 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
CC:     <daniel.lezcano@linaro.org>, <rafael@kernel.org>,
        <rui.zhang@intel.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <khilman@baylibre.com>,
        <abailon@baylibre.com>, <lukasz.luba@arm.com>,
        <broonie@kernel.org>, <damien.lemoal@opensource.wdc.com>,
        <heiko@sntech.de>, <hayashi.kunihiko@socionext.com>,
        <mhiramat@kernel.org>, <talel@amazon.com>,
        <thierry.reding@gmail.com>, <digetx@gmail.com>,
        <jonathanh@nvidia.com>, <anarsoul@gmail.com>,
        <tiny.windzz@gmail.com>, <baolin.wang7@gmail.com>,
        <f.fainelli@gmail.com>, <bjorn.andersson@linaro.org>,
        <mcoquelin.stm32@gmail.com>, <glaroque@baylibre.com>,
        <miquel.raynal@bootlin.com>, <shawnguo@kernel.org>,
        <niklas.soderlund@ragnatech.se>, <matthias.bgg@gmail.com>,
        <j-keerthy@ti.com>, Amit Kucheria <amitk@kernel.org>
Subject: Re: [PATCH v5 21/33] thermal/drivers/banggap: Switch to new of API
Message-ID: <20220804233022.xmbaapjco47dldj6@bryanbrattlof.com>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
 <20220804224349.1926752-22-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20220804224349.1926752-22-daniel.lezcano@linexp.org>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
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

On August  5, 2022 thus sayeth Daniel Lezcano:
> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach. The ops are no longer device
> tree specific and are the generic ones provided by the core code.
> 
> Convert the ops to the thermal_zone_device_ops format and use the new
> API to register the thermal zone with these generic ops.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>

Reviewed-by: Bryan Brattlof <bb@ti.com>

> ---
>  drivers/thermal/k3_bandgap.c       | 12 ++++++------
>  drivers/thermal/k3_j72xx_bandgap.c | 12 +++++-------
>  2 files changed, 11 insertions(+), 13 deletions(-)
>

Thanks for updating the drivers!

~Bryan
