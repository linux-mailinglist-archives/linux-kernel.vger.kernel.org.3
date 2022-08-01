Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE49586B9A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiHANMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiHANMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:12:31 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980E7252AA
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 06:12:29 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id u133so3904522pfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 06:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jO1bqIIamDycGg4bu9gqL7wpx+GWJSddw3ScY623t+4=;
        b=ldLqZN/JZgXIMHZSkgb0EPjT4l9tbZFVODBOINq3PjAzp8QoxfEpDQPwr+O7Zyz/q0
         KQi5YMTNOmHy6oSnwh4CoK0Bx7b0Uxtkt6ZPbQybXc+cm0qR8NUGbWNizJYwiXt26bRD
         CyHEpc5F6tuAhNMAucwjsjHe/se9pr5mS23TcNBZ48ecNEMv4HwwI+YUbaOgQM+Npbt1
         /3gAde/DrC4SURPzJnDAJyfDsBqVRWQem1NdGfz81y9cqu0/HSfvBb50BbaoFVX7uLdZ
         M5XR/qIsl+QoaU5s+Y6LCBeiCoh1n8cV62j6o21HWWJF5P/bY2e2AW7oHTU+tuNg5KyB
         aFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jO1bqIIamDycGg4bu9gqL7wpx+GWJSddw3ScY623t+4=;
        b=Tvo7i6bqF9z5lxHsHDnn8NPG0c+USHB3RDbLRCn5QFARFswbgYJAgaAlCjdKyBahfc
         IFL4g3B9Ihl8NRGZ0mgizoXCyvYusLhmtec5sSnbD/GPloq/GVMs1lXQVuPnAj62VhLC
         76fAkO6ai69563Ud9g3msapYJZsygU96TV4QTWAqt537zrIBgB8WqoRepeNzYAr9Wczk
         Di7Eu5ENFMmFRZLuBSgamgQVmbPnQSPEcW1yZHXGAwAymrDKhG6IL4YLtjYEFcLQMZgA
         iY69q1JyMN2Lb7SbSP9ij6hdKIyJUVmp1btwJS7pluHux8VR/PwY0PwardL3etyUFE70
         ZyyQ==
X-Gm-Message-State: ACgBeo3CljhbeGuR6Iqjm2Vw4pDM4H0noiwJYQZEFc+crkAH2qxA3F8O
        N5jb1U+izsRyws/nipLsk3Ar
X-Google-Smtp-Source: AA6agR4S1dUEx4li1cfSqTDjfJx1siavuXv+Qxp1ggsYNxB9BseT82XgYD4ZkmAMk8xZVux8VCJzeA==
X-Received: by 2002:a63:4407:0:b0:41c:30f7:8faf with SMTP id r7-20020a634407000000b0041c30f78fafmr2542123pga.359.1659359548939;
        Mon, 01 Aug 2022 06:12:28 -0700 (PDT)
Received: from thinkpad ([117.217.185.73])
        by smtp.gmail.com with ESMTPSA id u17-20020a170903125100b0016d33b8a231sm9641684plh.270.2022.08.01.06.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 06:12:28 -0700 (PDT)
Date:   Mon, 1 Aug 2022 18:42:19 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 04/15] PCI: dwc: Add IP-core version detection
 procedure
Message-ID: <20220801131219.GD93763@thinkpad>
References: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
 <20220624143947.8991-5-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624143947.8991-5-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 05:39:36PM +0300, Serge Semin wrote:
> Since DWC PCIe v4.70a the controller version and version type can be read
> from the PORT_LOGIC.PCIE_VERSION_OFF and PORT_LOGIC.PCIE_VERSION_TYPE_OFF
> registers respectively. Seeing the generic code has got version-dependent
> parts let's use these registers to find out the controller version.  The
> detection procedure is executed for both RC and EP modes right after the
> platform-specific initialization. We can't do that earlier since the
> glue-drivers can perform the DBI-related setups there including the bus
> reference clocks activation, without which the CSRs just can't be read.
> 
> Note the CSRs content is zero on the older DWC PCIe controller. In that
> case we have no choice but to rely on the platform setup.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Changelog v2:
> - Move the IP-core version detection procedure call from
>   dw_pcie_ep_init_complete() to dw_pcie_ep_init().
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   |  2 ++
>  .../pci/controller/dwc/pcie-designware-host.c |  2 ++
>  drivers/pci/controller/dwc/pcie-designware.c  | 24 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  |  6 +++++
>  4 files changed, 34 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 1e35542d6f72..ffbd3af6d65a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -711,6 +711,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	ep->phys_base = res->start;
>  	ep->addr_size = resource_size(res);
>  
> +	dw_pcie_version_detect(pci);
> +

There is still an ongoing debate about moving all DBI accesses to
init_complete. But this is fine atm.

Thanks,
Mani

>  	dw_pcie_iatu_detect(pci);
>  
>  	ep->ib_window_map = devm_kcalloc(dev,
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 95256434913f..b1437b37140f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -405,6 +405,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  		}
>  	}
>  
> +	dw_pcie_version_detect(pci);
> +
>  	dw_pcie_iatu_detect(pci);
>  
>  	dw_pcie_setup_rc(pp);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index f10a7d5d94e8..cbb36ccaa48b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -16,6 +16,30 @@
>  #include "../../pci.h"
>  #include "pcie-designware.h"
>  
> +void dw_pcie_version_detect(struct dw_pcie *pci)
> +{
> +	u32 ver;
> +
> +	/* The content of the CSR is zero on DWC PCIe older than v4.70a */
> +	ver = dw_pcie_readl_dbi(pci, PCIE_VERSION_NUMBER);
> +	if (!ver)
> +		return;
> +
> +	if (pci->version && pci->version != ver)
> +		dev_warn(pci->dev, "Versions don't match (%08x != %08x)\n",
> +			 pci->version, ver);
> +	else
> +		pci->version = ver;
> +
> +	ver = dw_pcie_readl_dbi(pci, PCIE_VERSION_TYPE);
> +
> +	if (pci->type && pci->type != ver)
> +		dev_warn(pci->dev, "Types don't match (%08x != %08x)\n",
> +			 pci->type, ver);
> +	else
> +		pci->type = ver;
> +}
> +
>  /*
>   * These interfaces resemble the pci_find_*capability() interfaces, but these
>   * are for configuring host controllers, which are bridges *to* PCI devices but
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 6b81530fb2ca..7899808bdbc6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -85,6 +85,9 @@
>  #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
>  #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
>  
> +#define PCIE_VERSION_NUMBER		0x8F8
> +#define PCIE_VERSION_TYPE		0x8FC
> +
>  #define PCIE_ATU_VIEWPORT		0x900
>  #define PCIE_ATU_REGION_INBOUND		BIT(31)
>  #define PCIE_ATU_REGION_OUTBOUND	0
> @@ -279,6 +282,7 @@ struct dw_pcie {
>  	struct dw_pcie_ep	ep;
>  	const struct dw_pcie_ops *ops;
>  	u32			version;
> +	u32			type;
>  	int			num_lanes;
>  	int			link_gen;
>  	u8			n_fts[2];
> @@ -290,6 +294,8 @@ struct dw_pcie {
>  #define to_dw_pcie_from_ep(endpoint)   \
>  		container_of((endpoint), struct dw_pcie, ep)
>  
> +void dw_pcie_version_detect(struct dw_pcie *pci);
> +
>  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
>  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
>  
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
