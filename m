Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC35533B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbiEYLHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbiEYLHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:07:13 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C6E3B298
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 04:07:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t13so10442078wrg.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 04:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=joRdFOrikAvLBCPLRckLtagnr5zAnbbJe1mok1pXiSw=;
        b=ZUCXEQxRycox4CR+XIe37Y/zMHlkCMd0dT68FX0waAx1GkzWURFMnfELqyxuQGZR/T
         mg+fiyemIz0D8Y/JwhX8LiTotWRgJ7/381Qc3jxsJ1kyAh0jrdY0i3I0MMjN2PYCfY4X
         tmjLRKQ9uh1RJsyLlfHrUmtCu6tsXRxb5dpf8pG4/mOhvcewaJs1AqWTCYkEQn9dGe5f
         k/M7rP1GoX9dH2gH2aRjUUMrrg/meRnh/kJNy+C0uerR6Mc2VSgpkGDTV7QjUckM+4jZ
         oHGOsxAUkFsW+xnn2zbXR7/5EbdF3sifZs6Th0VlQ0bQubEelqdaIh9fVg0nROLEwZus
         pUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=joRdFOrikAvLBCPLRckLtagnr5zAnbbJe1mok1pXiSw=;
        b=YAWQ0S0E+QRi0c8skIZO34UxpkVfhegDynVzGgMg+DbaeogFeq0qduSx5OJyKk4Tmb
         pjMBvtI3/Dqu/KeYaOBCc1GM6nJt2iX04AIV1PZMgB/IYxOmI56TxexM8x97PYHjhpmY
         MPlttg3G4izXryH7mth27eofuwuIAMnLByBQ/aUCU/rA3C2WhnEfbx3aWqk4JKGSvU40
         sXYAYTbaOcX1UBlODxz5sVOEYWnU5vWK4CjRN67mUswghwxovnRHelKEKyYzwIhtBEZQ
         xzSr32sioCtOBhRiSsKA9X9iLKC9MMfWz0Xk0Ce+wlBSHsvcWX6DIVnQL5fMGR4jHr2y
         WNNg==
X-Gm-Message-State: AOAM532laM2IeBOShpju2rcB0mv1mCEdmP2MaCRaisVw/goWhnAcEgtH
        nCxHM7a9a5iMtJlWwEb1vtfqFA==
X-Google-Smtp-Source: ABdhPJzrYJnqGw1yZiQCDAklTrlieqOiqwchoSzelXSLzjGcwtCmct9j1gilMqHVnxUp+Q5VzeMrEA==
X-Received: by 2002:adf:d1c9:0:b0:20f:c3dc:e980 with SMTP id b9-20020adfd1c9000000b0020fc3dce980mr18878297wrd.552.1653476828879;
        Wed, 25 May 2022 04:07:08 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d55c7000000b0020c5253d8d3sm1797656wrw.31.2022.05.25.04.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:07:08 -0700 (PDT)
Date:   Wed, 25 May 2022 12:06:43 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Jacob jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Message-ID: <Yo4Nw9QyllT1RZbd@myrica>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
 <f3170016-4d7f-e78e-db48-68305f683349@arm.com>
 <ff8f23c0-8763-1fac-6526-9095101ca0e5@linux.intel.com>
 <567dffd4-8f15-ffb2-da69-4f47017c35fd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <567dffd4-8f15-ffb2-da69-4f47017c35fd@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 11:07:49AM +0100, Robin Murphy wrote:
> > Did you mean @handler and @handler_token staffs below?
> > 
> > struct iommu_domain {
> >          unsigned type;
> >          const struct iommu_domain_ops *ops;
> >          unsigned long pgsize_bitmap;    /* Bitmap of page sizes in use */
> >          iommu_fault_handler_t handler;
> >          void *handler_token;
> >          struct iommu_domain_geometry geometry;
> >          struct iommu_dma_cookie *iova_cookie;
> > };
> > 
> > Is it only for DMA domains? From the point view of IOMMU faults, it
> > seems to be generic.
> 
> Yes, it's the old common iommu_set_fault_handler() stuff (which arguably is
> more of a "notifier" than a "handler"), but I assume that that's irrelevant
> if SVA is using IOPF instead?

Yes IOMMU drivers call either the newer iommu_report_device_fault() or the
old report_iommu_fault(), and only the former can support IOPF/SVA. I've
tried to merge them before but never completed it. I think the main issue
was with finding the endpoint that caused the fault from the fault
handler. Some IOMMU drivers just pass the IOMMU device to
report_iommu_fault(). I'll probably pick that up at some point.

Thanks,
Jean
