Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F374E6E50
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 07:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356494AbiCYGny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 02:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354294AbiCYGnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 02:43:51 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C50C6ED0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 23:42:17 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m22so6763740pja.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 23:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TlbCL6RW6dYnP7/Z3HsS7ysuAk05cXSMOHQcAK+OE3w=;
        b=oU8e1xATeNZJ9ypnX9s18oyOGKCF+BTTBpqqt5valvk/JAHrRfwNn1To3IUSWHREsk
         C3UZMU24HYxEjk6Ly5PRWM9gQ0YdQO2NNmYn1I+qY+ycBJ5oyh0PncTO6P+d4lzZv4Xx
         8tuhcUepE0a3PNrP43aC6aTZ2ue0UFidW3/HRYKm+eTugdQnMUpswluc1wdXG0jaXMly
         OcMBQY0ActwAdl8Tjcgvw9hBMEYvG0mlrWkq2ijeMS9bBuolpfG462m8tmSgpQgwb+tO
         qeiEj9LtIW4BUDOUzdaBAB1Xew3PP1DjHX7zajOEy/YDTxE2U6KTbl6ONN1I0NPOIS0o
         pX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TlbCL6RW6dYnP7/Z3HsS7ysuAk05cXSMOHQcAK+OE3w=;
        b=e80u0L/Y+UG4cgrIH6CeAz++Lp7Av2ecK4mzgdVwpuNriWuZ85NXoVlQdfNkx8cdde
         gXQRvYhA2xKN9a4rZLeTDJGMy8x4T0qRgpbYmdI3ks3i2o4jD+7GsKzIRsWol3lU2jAJ
         A+S++9P4V07RBFj46KPwn5QgByIJYC+Sa/VPFNb+0YNFmn8ovi3S4xXtaY52AoQOYWRm
         VNH1l9Z9nYWLw4EMDvFSqZ/ZklPdiWwEI4CT8mnDCgrGk8z9OpRsqRZppDeaVDM98kp9
         kjL4NdXt9VffBriZpPwXNxLLRZ9gzh+Bi1CX10iXSKrYlNsauko3YyLhXQWjaqFkgdSM
         0dvg==
X-Gm-Message-State: AOAM531STy1NJ353hfoOtfHlapyf3SS6O14FMnNR1hgrNAGT5yc1jMgs
        e6X62u0+i99g+LFyivh5L0zf
X-Google-Smtp-Source: ABdhPJy57GPWiTEW71xktpPJI24IuhMeC87zH7XrpORXbzOffyRtwnN8nw+QP52F9hSv93PQhY1XRg==
X-Received: by 2002:a17:902:e748:b0:153:b484:bdf4 with SMTP id p8-20020a170902e74800b00153b484bdf4mr9931063plf.66.1648190537099;
        Thu, 24 Mar 2022 23:42:17 -0700 (PDT)
Received: from thinkpad ([27.111.75.218])
        by smtp.gmail.com with ESMTPSA id oa16-20020a17090b1bd000b001c72b632222sm11928283pjb.32.2022.03.24.23.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 23:42:16 -0700 (PDT)
Date:   Fri, 25 Mar 2022 12:12:09 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/25] dmaengine: dw-edma: Convert DebugFS descs to being
 kz-allocated
Message-ID: <20220325064209.GE4675@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-16-Sergey.Semin@baikalelectronics.ru>
 <20220325060349.GA4675@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325060349.GA4675@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 11:33:57AM +0530, Manivannan Sadhasivam wrote:
> On Thu, Mar 24, 2022 at 04:48:26AM +0300, Serge Semin wrote:
> > Currently all the DW eDMA DebugFS nodes descriptors are allocated on
> > stack, while the DW eDMA driver private data and CSR limits are statically
> > preserved. Such design won't work for the multi-eDMA platforms.
> 
> Can you please explain why?
> 
> > As a
> > preparation to adding the multi-eDMA system setups support we need to have
> > each DebugFS node separately allocated and described. Afterwards we'll put
> > an addition info there like Read/Write channel flag, channel ID, DW eDMA
> > private data reference.
> > 
> > Note this conversion is mainly required due to having the legacy DW eDMA
> > controllers with indirect Read/Write channels context CSRs access. If we
> > didn't need to have a synchronized access to these registers the DebugFS
> > code of the driver would have been much simpler.
> > 
> 
> I fail to understand how this change is beneficial or the exact issue.
> 

I think I get the reasoning after going through the successive patches.

Thanks,
Mani

> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> > index afd519d9568b..7eb0147912fa 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> > @@ -53,7 +53,8 @@ struct dw_edma_debugfs_entry {
> >  
> >  static int dw_edma_debugfs_u32_get(void *data, u64 *val)
> >  {
> > -	void __iomem *reg = data;
> > +	struct dw_edma_debugfs_entry __iomem *entry = data;
> 
> Why the entry has to be of __iomem?
> 
> Thanks,
> Mani
> 
> > +	void __iomem *reg = entry->reg;
> >  
> >  	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY &&
> >  	    reg >= (void __iomem *)&regs->type.legacy.ch) {
> > @@ -94,14 +95,22 @@ static int dw_edma_debugfs_u32_get(void *data, u64 *val)
> >  }
> >  DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_edma_debugfs_u32_get, NULL, "0x%08llx\n");
> >  
> > -static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry entries[],
> > +static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry ini[],
> >  				       int nr_entries, struct dentry *dir)
> >  {
> > +	struct dw_edma_debugfs_entry *entries;
> >  	int i;
> >  
> > +	entries = devm_kcalloc(dw->chip->dev, nr_entries, sizeof(*entries),
> > +			       GFP_KERNEL);
> > +	if (!entries)
> > +		return;
> > +
> >  	for (i = 0; i < nr_entries; i++) {
> > +		entries[i] = ini[i];
> > +
> >  		debugfs_create_file_unsafe(entries[i].name, 0444, dir,
> > -					   entries[i].reg, &fops_x32);
> > +					   &entries[i], &fops_x32);
> >  	}
> >  }
> >  
> > -- 
> > 2.35.1
> > 
