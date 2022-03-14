Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A79D4D7A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 06:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbiCNFXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 01:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiCNFXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 01:23:30 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68AA3CFE5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 22:22:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id kx6-20020a17090b228600b001bf859159bfso16343232pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 22:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YXYRkkKUPAPMqJg2NjziNouYLGwGqlRoqdP1n5iuVLY=;
        b=HSLYDs5aUaY/BcoZsN4dwJcrhpy14od/2Zt6j8OjXQIEPZTmsyybvsVpuXkXV/xhTG
         /5d328WU4A3IQncbr0EZJX4TGw/LqKvIxs+ROZZUcbqbmUZW4WW3IjcpfgYF6DXmy0FN
         AmvVF4WERpssoFBqqXnXjtsWXgDxwlh208WyahcKtoBznUPVAjOctS+GDEmAcG1QRrL5
         jrOih2M1QFDEmWVYre6u5yS7+VL0RfnPBW/2bVD/XUHtkQvlr/ZGwf+ovYeE2W07LDeL
         L1WUcUUnZw3op54XVX2Wzf0YaIp1PcT6VJVVmLFsdXnrYJ4b+U/uwpVLojlq1vwtK53G
         cvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YXYRkkKUPAPMqJg2NjziNouYLGwGqlRoqdP1n5iuVLY=;
        b=5mE2pTDp0uP7J8bdQdN6ZwlgxdUP/tKzmFpDoYqTb0+F1oKX4hUlZ+GKQ1y3IXvk/d
         UhwbhcQC48MyHkLFGVnmfDDJ8EN6dC0s+dSnCEyVHl31S84TrxJi15ImLT4zVOtgxOI/
         ivjEsLdHfnfklg++mG42RnYOctM0safzcxsjG4CnGMmnEdOOPZXVCmLizjG73my7ShQC
         AkHdlkRA9Y+ZOo/WPK0twT5+i8/Way6OGXoOS2RR+Z0jy4T7WaNf2qog25izD6Pa00kv
         LnphP9IlPLFBoA155ECUjRQxzcaAZvcJQx8x4DPw3g3FWlX1TyMteRu2d4dwUQfzmoYd
         2JEQ==
X-Gm-Message-State: AOAM53387twPPQbxZTPPlz3kzJ6aOoLETaic4fSDhykM9KvDcjrigPFq
        NGjueD0DbNeAafdca/zH9zDt
X-Google-Smtp-Source: ABdhPJyC09LNYIuQkLllMG+RfcIfpSxd18bfbIF/RXyYupw3bFBwhsZ6JGP4PKm/ZRrQiI8Hzb2ChA==
X-Received: by 2002:a17:90b:1e43:b0:1bf:920:8a26 with SMTP id pi3-20020a17090b1e4300b001bf09208a26mr33827130pjb.52.1647235341041;
        Sun, 13 Mar 2022 22:22:21 -0700 (PDT)
Received: from workstation ([59.92.58.163])
        by smtp.gmail.com with ESMTPSA id f4-20020aa782c4000000b004f6f0334a51sm17477313pfn.126.2022.03.13.22.22.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Mar 2022 22:22:20 -0700 (PDT)
Date:   Mon, 14 Mar 2022 10:52:16 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     bjorn.andersson@linaro.org, bhelgaas@google.com,
        svarbanov@mm-sol.com, robh@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Add support for handling MSIs from 8 endpoints
Message-ID: <20220314052216.GA10218@workstation>
References: <20211214101319.25258-1-manivannan.sadhasivam@linaro.org>
 <20220223100145.GA26873@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223100145.GA26873@lpieralisi>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 10:01:45AM +0000, Lorenzo Pieralisi wrote:
> On Tue, Dec 14, 2021 at 03:43:19PM +0530, Manivannan Sadhasivam wrote:
> > The DWC controller used in the Qcom Platforms are capable of addressing the
> > MSIs generated from 8 different endpoints each with 32 vectors (256 in
> > total). Currently the driver is using the default value of addressing the
> > MSIs from 1 endpoint only. Extend it by passing the MAX_MSI_IRQS to the
> > num_vectors field of pcie_port structure.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Need an ACK from qcom maintainers.
> 

I think this one can be merged now.

Thanks,
Mani

> Thanks,
> Lorenzo
> 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 1c3d1116bb60..8a4c08d815a5 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1550,6 +1550,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> >  	pci->dev = dev;
> >  	pci->ops = &dw_pcie_ops;
> >  	pp = &pci->pp;
> > +	pp->num_vectors = MAX_MSI_IRQS;
> >  
> >  	pcie->pci = pci;
> >  
> > -- 
> > 2.25.1
> > 
