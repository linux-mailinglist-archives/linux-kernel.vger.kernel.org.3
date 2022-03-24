Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2A74E6304
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349972AbiCXMRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344936AbiCXMRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:17:39 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC416CA75
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:16:07 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t13so2439580pgn.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m5SvKyabfRKTyH82OgFdVvvJnlwVkNv0fDThfHIXFUQ=;
        b=niH7iQ3/VlgTMwUsYe4wazrFLfQOfOLXpJv7Rmxx7hrFDU6YjidCPPNxLpfTEY4ZYj
         EsPEE1k9pnTR7ES3YjPBJQhRW+wszDh08kB8kAol9QAhD6P0sh5ABkOWxgE+sIvbFVA/
         dfyiAz95yldf4tCT/p2T3cZx7BxlRl4Q7Pvjy6k05ZyZMqDHWdwF1IIKmMN/J0GOu48l
         kycmu1tjEY5mVv7Tl4oMruHpvRpF78kuvmLHYjsFKikYoehsD+dg5NYysDGVVUg9BD+1
         Vir90MCqzET5MYX6PbZ3qBVu86U4V1EaggZLdzOsCCAkMiy14m68srV7aXHd/TbhsF6Y
         vGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m5SvKyabfRKTyH82OgFdVvvJnlwVkNv0fDThfHIXFUQ=;
        b=I10HE0GmcRCf0s7fAKYFJu5bzv/jxSk49jmtDbtGZI6Fnc5K1Esi+zxNNWoab44CKF
         2cbIbzi7wVjoKvtp5qNZKUb6c28aTrZ8AmMm7ifmEZ3a7HQaYGmXA00VriKqn/IPBv3O
         dLvtzTHtYMGXgRc7QP+U0UtGo5te/ZGLT99bqteKIEmAAQS4bK2bmwmfp2oiGkhFM/4V
         LKWbaqo0CusKOzqe4vTUyMpiSfoazo0pjirxeLBm2g3+xlESfDwDDOd+NYTspR86jer5
         a6StUM8voHikC/OwoUj7Upikj/6GzZ8uJ4vjBvJfHEKbvL8GyUddLnxW4TnsdSbexjk4
         SqNg==
X-Gm-Message-State: AOAM5314Qcr8ALgBfAngSPdVLqsEN4cAs/jUXSFrkyMgr167WhRMlM9d
        E7vKZGlky3pu+4e7qXe+30cS
X-Google-Smtp-Source: ABdhPJy2e8U/PkJumWyZaEl5mUjkdKWLsWW2GEQX91NqrMkW62XOJ9VYnqHDyHBzcFYLILHzAeiHmQ==
X-Received: by 2002:a65:4681:0:b0:382:b4f5:84c2 with SMTP id h1-20020a654681000000b00382b4f584c2mr3803455pgr.218.1648124166920;
        Thu, 24 Mar 2022 05:16:06 -0700 (PDT)
Received: from thinkpad ([220.158.158.107])
        by smtp.gmail.com with ESMTPSA id w24-20020a639358000000b00385fcbf8e55sm2731172pgm.28.2022.03.24.05.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 05:16:06 -0700 (PDT)
Date:   Thu, 24 Mar 2022 17:46:01 +0530
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
Subject: Re: [PATCH 07/12] PCI: dwc: Add trailing new-line literals to the
 log messages
Message-ID: <20220324121601.GG2854@thinkpad>
References: <20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru>
 <20220324012524.16784-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324012524.16784-8-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 04:25:18AM +0300, Serge Semin wrote:
> There are two places in the DW PCIe controller driver, which omit the
> trailing newlines in the log info and warn messages. Not having them there
> will cause leaving the messages in the printk ring buffer until a next
> '\n'-terminated message is printed (it will consequently cause the buffer
> flush). As it isn't what the corresponding code implies let's add the
> new-line characters in the messages.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  drivers/pci/controller/dwc/pcie-designware.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index a048d88e0c30..8364ea234e88 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -657,7 +657,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  		}
>  
>  		if (pci->num_ob_windows <= atu_idx)
> -			dev_warn(pci->dev, "Resources exceed number of ATU entries (%d)",
> +			dev_warn(pci->dev, "Resources exceed number of ATU entries (%d)\n",
>  				 pci->num_ob_windows);
>  	}
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 9f4d2b44612b..3bd1cfd12148 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -706,7 +706,7 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  	dev_info(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
>  		"enabled" : "disabled");
>  
> -	dev_info(pci->dev, "Detected iATU regions: %u outbound, %u inbound",
> +	dev_info(pci->dev, "Detected iATU regions: %u outbound, %u inbound\n",
>  		 pci->num_ob_windows, pci->num_ib_windows);
>  }
>  
> -- 
> 2.35.1
> 
