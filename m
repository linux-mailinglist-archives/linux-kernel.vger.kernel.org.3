Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEA04E6347
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345007AbiCXM0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244214AbiCXM0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:26:18 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75546A66C5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:24:46 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v4so4586440pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QxjC77/AG75v2VbEzHzDJddv3BOZKFG+BN1obowdbeM=;
        b=wZamSwGHrvBdyO4Q2dpcKPbHF0iVv/vgPMOqnQHHXxXyvCMZW9RsT2+pQhmmJ4uy/r
         elafkhjGL3lEzC1xrHY438WM3FecrbOg4sRK9ZUrCyZ9QeQqIQUCyJO8pz5qDGM0ieON
         q25V45p5s7lI0nyazNjCdNv06eFYz8jLCDLMvuDejX37hawZK2+UoR9fyQVHsnpXCtJH
         LikFtRw+NV/gs4bhWdpShfGqeKwdtVDMOKid+bXFLa8+NvIrXtpg6VpU4cv0NAFbD8ys
         HGWUbWFJDFX7xpHU4bQYruclDKDJPrf5PkRD+gMVA5KGDcF8PZK7ul5pY/oevT6ffjHP
         R96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QxjC77/AG75v2VbEzHzDJddv3BOZKFG+BN1obowdbeM=;
        b=xK6CQYH+3TaZxm3ukTQly7IReJCRDsmV5cPnNLK5wW8F+6V6IkpIsv9OCPPMNOM5Kz
         kOZX/JEOjnlKSx6LrvWQovg3fubiR6OG4rNnqJudbldxnN7Nude2XzCEu0q1/kNFbOcL
         gt7Jon/niFw0k4hzLAhov36SEfIKQTViXiRRZGUvAfBN/mCTyKG+MQTD1lVpQPLTfGmh
         //N8fPAOUl93Jj5UfLeFM1h7ToNkN71njCGcTLdkn40Xww3JRSnQzce9xJ6CNMEmKBO2
         41PJDV1gtjbmUb0Xu1JuLxlEk1+NM4kMGxS5G4giHbXEL+iqRyTonodChDOzu0/GjNL8
         Ay9A==
X-Gm-Message-State: AOAM530rlpxq34k36+UUSN8C+baON6G2eTaGy3i9/PTApGE0rAOi2jDZ
        iAOeeAVgBrYz1XPGxTIwV2Ii
X-Google-Smtp-Source: ABdhPJwOaNNyUJ5HdUnz+nscJzh+cyXkOeP5AwavPCeBrAcfzKJBvsIwEmNo25guWT7RDEea3jAoKQ==
X-Received: by 2002:a17:902:f70d:b0:14f:a1e1:b9b3 with SMTP id h13-20020a170902f70d00b0014fa1e1b9b3mr5750034plo.36.1648124685926;
        Thu, 24 Mar 2022 05:24:45 -0700 (PDT)
Received: from thinkpad ([220.158.158.107])
        by smtp.gmail.com with ESMTPSA id k17-20020a056a00135100b004fa9df39517sm3546388pfu.198.2022.03.24.05.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 05:24:45 -0700 (PDT)
Date:   Thu, 24 Mar 2022 17:54:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] PCI: dwc-plat: Discard unused regmap pointer
Message-ID: <20220324122440.GK2854@thinkpad>
References: <20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru>
 <20220324012524.16784-12-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324012524.16784-12-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 04:25:22AM +0300, Serge Semin wrote:
> The regmap pointer was added into the dw_plat_pcie structure in
> commit 1d906b22076e ("PCI: dwc: Add support for EP mode"), but it hasn't
> been utilized neither in the code submitted in the denoted so far nor in
> the platform driver evolving afterwards. Drop it then for good.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware-plat.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
> index fea785096261..99cf2ac5b0ba 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> @@ -17,13 +17,11 @@
>  #include <linux/platform_device.h>
>  #include <linux/resource.h>
>  #include <linux/types.h>
> -#include <linux/regmap.h>
>  
>  #include "pcie-designware.h"
>  
>  struct dw_plat_pcie {
>  	struct dw_pcie			*pci;
> -	struct regmap			*regmap;
>  	enum dw_pcie_device_mode	mode;
>  };
>  
> -- 
> 2.35.1
> 
