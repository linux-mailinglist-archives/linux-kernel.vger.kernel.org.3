Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AABE4D1230
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242803AbiCHI2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbiCHI2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:28:33 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B455E635B;
        Tue,  8 Mar 2022 00:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646728057; x=1678264057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7uv8Q1w8wsO9w5Wl3dOSyGo5iztKnC91d7tEWyKbVmo=;
  b=a5sFEHSLp0ksCXl/lD/UuGGLhCMtQX4ItOsg0IYf7OW9iJxm+wvQRYny
   /oQlNYmMNaVryI1w6wTDIa+AHWGhnD7K4hlyJsAUQoXYfNZmLUWZM/oUH
   GPKQ8nwwKLCRZJiJSjMCncsKxF/EmCnjS2vLftSZ1Eofdm2v+xR8SBCMz
   0VCwdWWTSepfyWAGGN7OfAt8uEU+cog869gYKtMmpJHJuqpoNR2e2CfGD
   r573A4ZcEY7SeEijYFDw+D4cMMlpXrVgQQ15vKPvcNG25G6yaG9a0chEr
   OMr44BvxrxJAtyw1CN2aP5qOVkSigzTth8Eu03bMOIsQRc3STeBLcwEZz
   w==;
X-IronPort-AV: E=Sophos;i="5.90,163,1643698800"; 
   d="scan'208";a="148433672"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Mar 2022 01:27:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Mar 2022 01:27:30 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 8 Mar 2022 01:27:30 -0700
Date:   Tue, 8 Mar 2022 09:30:23 +0100
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Michael Walle <michael@walle.cc>
CC:     <andriy.shevchenko@linux.intel.com>,
        <colin.foster@in-advantage.com>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] pinctrl: ocelot: Fix the pincfg resource.
Message-ID: <20220308083023.frr7qz2xga2tas5r@soft-dev3-1.localhost>
References: <20220304144432.3397621-2-horatiu.vultur@microchip.com>
 <20220307124501.3487932-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20220307124501.3487932-1-michael@walle.cc>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 03/07/2022 13:45, Michael Walle wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> > The pincfg resources are in the second memory resource. But the driver
> > still tries to access the first memory resource to get the pincfg. This
> > is wrong therefore fix to access the second memory resource.
> >
> > Reviewed-by: Colin Foster <colin.foster@in-advantage.com>
> > Fixes: ad96111e658a95 ("pinctrl: ocelot: combine get resource and ioremap into single call")
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> There is already this patch pending, which does exactly
> the same:
> https://lore.kernel.org/linux-gpio/20220216082020.981797-1-michael@walle.cc/

Sorry, I have missed your patch.
Should I resend this series where I will drop this patch? What is the
correct approach?

> 
> FWIW, there is also this one:
> https://lore.kernel.org/linux-gpio/20220216122727.1005041-1-michael@walle.cc/
> 
> -michael

-- 
/Horatiu
