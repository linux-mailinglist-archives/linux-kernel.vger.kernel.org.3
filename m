Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710DA4A8317
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244043AbiBCL0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbiBCL0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:26:44 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10765C06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 03:26:44 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so9719035pjj.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 03:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uq5/DMTs8fRuPax4HLgbapGYZfeXxnRQmS9fqIxNgqs=;
        b=Ef91hNFrpIdlJ9TU0MkJmzlt1Zgbgwl0/NWE6lzlyoS8mLYyBLu9rrWC6zZugLDtpH
         NYa64tCW30GSiQilZSVPNaRDwCnXiaqw3I+uypHDA21Xiip5epi0WrRUnHRVL6l+qsGZ
         1KaYJIBA7EbTvrX6viExwyBhEs3mPjAgruBtlhD7xa1ptDByDQE58TUGs+yht2rFIaeh
         rshLI1i7gZQ4oL4L+rjWj3CJF7v262rHz4Uls8q0zvOcOUmmw6ODxtcuFWyrkZTMmH6D
         YGbHTZ9RoOK/bBaFYK5K4Lnl2Ejgt2Ofg+gbJjTE3nH1DmYEnsaXxA2jZJpJV/EtakD6
         vPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uq5/DMTs8fRuPax4HLgbapGYZfeXxnRQmS9fqIxNgqs=;
        b=W/gXpry0WO7aS/ZUOt5wllVEvE46Gr4R9gpV7GMK4eUZUIRmxmGRbuXx3X/qdbC9PA
         iOxFnKFaEFfqNfRRP4EgNHTK1dkjJx97K+1No242QsdH5UKS/pQB/LshHvVI+1d6yUm2
         yV4FQzCLWq9R79gFVK/pQOXrspMvoUhbtQu2Va6z4WAUdTl32KwY3z0QOjQYno9hhpRo
         tHeZevKAgEJ3/mwkskrw5A3jxG7C3C32OdDrpzTOF1VVy5jHlVApg2Q41WSn99ijPspI
         9rr8X5ArzmZddiP5XqLmZY9IJAmzhXVAiOYxX7eXLtjWObBAVuUyFt0Ts/CK28VbtQ6p
         sr4A==
X-Gm-Message-State: AOAM530invVLxAGNYsP+ahK5Y/j4bpEM4pAiYUJxJ/uo4I/pbRNmO6Ly
        rOzrT6JHPM4N9S7youoCp2Jh
X-Google-Smtp-Source: ABdhPJwyRxdNOAL4umMYNtLN8ekSjgR3NXL/TlOD9cxPIqKiO4jKklp3k+QnPCfNT5qbiC7TGZ9CPQ==
X-Received: by 2002:a17:902:ecc2:: with SMTP id a2mr34308793plh.12.1643887603427;
        Thu, 03 Feb 2022 03:26:43 -0800 (PST)
Received: from thinkpad ([117.217.179.179])
        by smtp.gmail.com with ESMTPSA id gb5sm9984464pjb.16.2022.02.03.03.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 03:26:43 -0800 (PST)
Date:   Thu, 3 Feb 2022 16:56:35 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Alex Elder <elder@ieee.org>
Cc:     mhi@lists.linux.dev, hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/20] bus: mhi: Cleanup the register definitions used in
 headers
Message-ID: <20220203112635.GC6298@thinkpad>
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
 <20211202113553.238011-5-manivannan.sadhasivam@linaro.org>
 <c6b60b30-5a9f-134b-b1fb-b84704a3ccb2@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6b60b30-5a9f-134b-b1fb-b84704a3ccb2@ieee.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 06:23:52PM -0600, Alex Elder wrote:
> On 12/2/21 5:35 AM, Manivannan Sadhasivam wrote:
> > Cleanup includes:
> > 
> > 1. Moving the MHI register bit definitions to common.h header (only the
> >     register offsets differ between host and ep not the bit definitions)
> 
> The register offsets do differ, but the group of registers for the host
> differs from the group of registers for the endpoint by a fixed amount.
> (MHIREGLEN = 0x0000 for host, or 0x100 for endpoint; CRCBAP_LOWER is
> 0x0068 for host, 0x0168 for endpoint.)
> 
> In other words, can you instead use the same symbolic offsets, but
> have the endpoint add 0x0100 to them all?  It would make the fact
> that they're both referencing the same basic in-memory structure
> more obvious.
> 

Okay. I've used REG_ prefix for the register defines in common.h and used it on
host and ep internal.h.

> > 2. Using the GENMASK macro for masks
> > 3. Removing brackets for single values
> > 4. Using lowercase for hex values
> 
> Yay!!! For all three of the above.
> 
> More below.
> 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/bus/mhi/common.h        | 129 ++++++++++++---
> >   drivers/bus/mhi/host/internal.h | 282 +++++++++++---------------------
> >   2 files changed, 207 insertions(+), 204 deletions(-)
> > 
> > diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
> > index 2ea438205617..c1272d61e54e 100644
> > --- a/drivers/bus/mhi/common.h
> > +++ b/drivers/bus/mhi/common.h
> > @@ -9,32 +9,123 @@
> >   #include <linux/mhi.h>
> > +/* MHI register bits */
> > +#define MHIREGLEN_MHIREGLEN_MASK		GENMASK(31, 0)
> > +#define MHIREGLEN_MHIREGLEN_SHIFT		0
> 
> Again, please eliminate all _SHIFT definitions where they define
> the low bit position of a mask.
> 
> Maybe you can add some underscores for readability?
> 
> Even if you don't do that, you could add a comment here or there to
> explain what certain abbreviations stand for, to make it easier to
> understand.  E.g., CHDB = channel doorbell, CCA = channel context
> array, BAP = base address pointer.
> 

I'll check on this.

Thanks,
Mani

> 					-Alex
> 
> 
> > +#define MHIVER_MHIVER_MASK			GENMASK(31, 0)
> > +#define MHIVER_MHIVER_SHIFT			0
> > +
> > +#define MHICFG_NHWER_MASK			GENMASK(31, 24)
> > +#define MHICFG_NHWER_SHIFT			24
> > +#define MHICFG_NER_MASK				GENMASK(23, 16)
> > +#define MHICFG_NER_SHIFT			16
> > +#define MHICFG_NHWCH_MASK			GENMASK(15, 8)
> > +#define MHICFG_NHWCH_SHIFT			8
> > +#define MHICFG_NCH_MASK				GENMASK(7, 0)
> > +#define MHICFG_NCH_SHIFT			0
> 
> . . .
