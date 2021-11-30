Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5181462CB0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhK3GZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhK3GZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:25:03 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B901DC061746
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 22:21:44 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r5so18619541pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 22:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BNaQ1hDuscW75z1YF4ysySX4DClCVbFg/bAqlB9bjTA=;
        b=JpZKn0dQNw4SaDRhbKCy6bvTYOFQdEUy/S2mLRaIEOxUSw+zgvINeBpRFKs2bqR/m4
         R4eU3o23NmomIEpSRQ+D+L0ArvfYU9I31WlbCBw8oP8qFGT496XBayp7jjrR3SYvZShh
         G4/KGroea3lGe97dZFxrBgr9LotGDTYpxZDsTitVJqT3hRcJ4wEH3/kZ6+1UCo6IX0Em
         rUOJuZ/hQwu6F8l50fTXBtUwCBkHuqH57dlx7p7wjW5ErhoPm/oH2mNygNivlhJ77lCL
         3ZXeiEZ8RPJ9ji36+7K4arn4iW01Z4jfkZMEb5VGWIVOAVVoXA19Yi5IM0nmySlULQ3G
         P4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BNaQ1hDuscW75z1YF4ysySX4DClCVbFg/bAqlB9bjTA=;
        b=GrfoOPeGh263b2/sQAxNc4sXYJmyFJrY5X0cqjMvh/Y6JYQMJAQaQd9j2EMIyW1orc
         lyS1JW7k9G7pyOcHsbinTaH5DVFIGN6MJxEUxI3d4+hqnlmb+KksRyL+LtiWma+/f+oU
         cAlf5xMvMyuD5qUF0C14XIh1Z+CtSPRN/xHZWB1Hz1KoMYU07w16C7AUK6/bj/0bzQgB
         0+dwbXT/ZXE5/BjXuPgodlTUKfRugbgetS90bEHOmFE7QEFQGO42eHBv6btMue5iFiTj
         uqBSO27OF8bguTJ0NOnahH/ErSZHKKNJNK6vS4bDbCFBpGHZqpGENXH8kILIRyOF1n2P
         Qr1w==
X-Gm-Message-State: AOAM532NyiuSOGse5TG/uY/uH5dg5QpZSGLyip1jmb0mQLRb5x/kSUxQ
        l7nyEwpy2LyEIX15tUqBgJH1
X-Google-Smtp-Source: ABdhPJw2PbJ5Slja2wWTy5l+4BFh02gP0AkYfjBXDS6dhpNRcSsftMJMVLU6lDFCb5F+iq/uIpjYXA==
X-Received: by 2002:a65:40cd:: with SMTP id u13mr39088261pgp.450.1638253303818;
        Mon, 29 Nov 2021 22:21:43 -0800 (PST)
Received: from thinkpad ([202.21.42.3])
        by smtp.gmail.com with ESMTPSA id t8sm18701201pfe.28.2021.11.29.22.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 22:21:43 -0800 (PST)
Date:   Tue, 30 Nov 2021 11:51:37 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        svarbanov@mm-sol.com, bjorn.andersson@linaro.org, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] PCI: qcom: Fix warning generated due to the incorrect
 data type
Message-ID: <20211130062137.GD205712@thinkpad>
References: <20211124140424.51675-1-manivannan.sadhasivam@linaro.org>
 <20211130033614.GA2721688@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130033614.GA2721688@bhelgaas>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Mon, Nov 29, 2021 at 09:36:14PM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 24, 2021 at 07:34:24PM +0530, Manivannan Sadhasivam wrote:
> > Fix the below sparse warning due to the use of incorrect initializer
> > data type (u16) for bdf_be variable that receives the return value of
> > cpu_to_be16(). The correct type should be __be16.
> 
> I think the patch looks OK, but the reason to change this is not to
> "fix the warning".  The reason is to fix the *problem*, i.e.,
> cpu_to_be16() returns "__be16", which is incompatible with "u16".
> 
> The warning is only a helpful hint, and should not be part of the
> subject line.  "cpu_to_be16" or "iommu-map" would be much more
> useful information in the subject.
> 

okay

> I'm also curious why pcie-qcom.c is the only driver that does this.
> "iommu-map" is not specific to qcom, but no other drivers do similar
> things with it.
> 

Yes, on the recent qcom platforms starting from sm8250 we need to program
the BDF to SID mapping in the controller and that's the reason we are
extracting the "iommu-map" property in DT.

Thanks,
Mani

> > sparse warnings: (new ones prefixed by >>)
> > >> drivers/pci/controller/dwc/pcie-qcom.c:1305:30: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned short [usertype] bdf_be @@     got restricted __be16 [usertype] @@
> >    drivers/pci/controller/dwc/pcie-qcom.c:1305:30: sparse:     expected unsigned short [usertype] bdf_be
> >    drivers/pci/controller/dwc/pcie-qcom.c:1305:30: sparse:     got restricted __be16 [usertype]
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 8a7a300163e5..6c3b034e9946 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1312,7 +1312,7 @@ static int qcom_pcie_config_sid_sm8250(struct qcom_pcie *pcie)
> >  
> >  	/* Look for an available entry to hold the mapping */
> >  	for (i = 0; i < nr_map; i++) {
> > -		u16 bdf_be = cpu_to_be16(map[i].bdf);
> > +		__be16 bdf_be = cpu_to_be16(map[i].bdf);
> >  		u32 val;
> >  		u8 hash;
> >  
> > -- 
> > 2.25.1
> > 
