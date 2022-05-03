Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71950518C53
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241350AbiECSc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbiECScV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:32:21 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7303CFF5
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:28:47 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id v9so3686731qkp.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iFzlk+xOmTmM/Rg9uDKOcUmWuXtZUa3NXSFCcREp6dA=;
        b=VLAEGb/xxfXFOdK14PjW8BMKhVNfQ2mlyO22SQw42f+1nio4diX27liKNCU1qxLzyC
         W0pcdAVCm0R4VvXyf73HIBA2IdvUlbsG2ttkPo32xoY6eQNDthM0yl3R4uERQqzJocY0
         34ETDcQKarsLbshXTn5fp6uf39lflTa/T+RucHDsBjUGxe6pLDfuBBGr8l053CkgFMt9
         MfV88SN6/q00gvOBqTsX64/X3GT7Ra2JzDjgiA0emPTC4jLxHnPuOgF/aUeetZCl9UcE
         Vj1t9uGRHUWVdjq53ySUhVp6X9ba/xhzVZhIpy/yNbmSY6ZY/iqE8Rd314cVAPEjAnJw
         K1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iFzlk+xOmTmM/Rg9uDKOcUmWuXtZUa3NXSFCcREp6dA=;
        b=V4+RPImoVcDUwXqRPpTIvluQqMHm9x92NDMhMf5/8mFfaJe3gBexAa5NXdcRnVI3q2
         mZag/kFlEWnJs7q4F0hY95l6JiAtRQQ5rBxXHHSLjfPCEzAvaAXYcZ8KHXMBeRFRsc1Q
         jCCrbDlX4W2PW4euZpg7yzgl+1EAJg6ZfYRBdBdrF6uCHgDJj0GXb/GOKDoMT8hEK5nx
         Sr31UJxe1u1beFTPeDUehIaSB1VhH8vjd1DyLHN6FFdhRAkK4NaFve/SEDz+9zxmLesw
         WvjpIxozfnWzW30vKtv9ekIjGKrZ/B+eCe30VfvL1d2wfUzlDOuJMjYxOumzar96MejC
         NDhA==
X-Gm-Message-State: AOAM530FXL+GFDdYIWHQX1LbaxfnQIu/9vDmsBYGxntKgLO5ZnB8xwgO
        2vXuXSepnsgdiHbKmmmi3J5i+w==
X-Google-Smtp-Source: ABdhPJwg5NoW02Rs307zSADt1uOWE4ZSf3AUVJaY1yGF50Rm6gYq2Rh8F9YaWMhdhgT/Sq7hdr36tg==
X-Received: by 2002:a37:f516:0:b0:69f:83cd:f557 with SMTP id l22-20020a37f516000000b0069f83cdf557mr13568196qkk.555.1651602526714;
        Tue, 03 May 2022 11:28:46 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id x19-20020a05620a12b300b0069fc13ce206sm6115930qki.55.2022.05.03.11.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 11:28:46 -0700 (PDT)
Date:   Tue, 3 May 2022 19:28:19 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 12/12] iommu: Rename iommu-sva-lib.{c,h}
Message-ID: <YnF0QwnndI6opJtb@myrica>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-13-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502014842.991097-13-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 09:48:42AM +0800, Lu Baolu wrote:
> Rename iommu-sva-lib.c[h] to iommu-sva.c[h] as it contains all code
> for SVA implementation in iommu core.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/{iommu-sva-lib.h => iommu-sva.h}  | 0
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 2 +-
>  drivers/iommu/intel/iommu.c                     | 2 +-
>  drivers/iommu/intel/svm.c                       | 2 +-
>  drivers/iommu/io-pgfault.c                      | 2 +-
>  drivers/iommu/{iommu-sva-lib.c => iommu-sva.c}  | 2 +-
>  drivers/iommu/Makefile                          | 2 +-
>  8 files changed, 7 insertions(+), 7 deletions(-)
>  rename drivers/iommu/{iommu-sva-lib.h => iommu-sva.h} (100%)
>  rename drivers/iommu/{iommu-sva-lib.c => iommu-sva.c} (99%)
> 
> diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva.h
> similarity index 100%
> rename from drivers/iommu/iommu-sva-lib.h
> rename to drivers/iommu/iommu-sva.h
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 0ace04b27d4b..73a336e17dc8 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -9,7 +9,7 @@
>  #include <linux/slab.h>
>  
>  #include "arm-smmu-v3.h"
> -#include "../../iommu-sva-lib.h"
> +#include "../../iommu-sva.h"
>  #include "../../io-pgtable-arm.h"
>  
>  struct arm_smmu_mmu_notifier {
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 543d3ef1c102..ca2bd17eec41 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -31,7 +31,7 @@
>  #include <linux/amba/bus.h>
>  
>  #include "arm-smmu-v3.h"
> -#include "../../iommu-sva-lib.h"
> +#include "../../iommu-sva.h"
>  
>  static bool disable_bypass = true;
>  module_param(disable_bypass, bool, 0444);
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 46e2eb15197b..b38f50810459 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -27,7 +27,7 @@
>  #include <linux/tboot.h>
>  
>  #include "../irq_remapping.h"
> -#include "../iommu-sva-lib.h"
> +#include "../iommu-sva.h"
>  #include "pasid.h"
>  #include "cap_audit.h"
>  
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 6084f960ba27..38c33cde177e 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -25,7 +25,7 @@
>  
>  #include "pasid.h"
>  #include "perf.h"
> -#include "../iommu-sva-lib.h"
> +#include "../iommu-sva.h"
>  
>  static irqreturn_t prq_event_thread(int irq, void *d);
>  static void intel_svm_drain_prq(struct device *dev, u32 pasid);
> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
> index 8a2bb56e1474..a9ecf6bf5500 100644
> --- a/drivers/iommu/io-pgfault.c
> +++ b/drivers/iommu/io-pgfault.c
> @@ -11,7 +11,7 @@
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
>  
> -#include "iommu-sva-lib.h"
> +#include "iommu-sva.h"
>  
>  /**
>   * struct iopf_queue - IO Page Fault queue
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva.c
> similarity index 99%
> rename from drivers/iommu/iommu-sva-lib.c
> rename to drivers/iommu/iommu-sva.c
> index ae3595d60f38..b631765fa8c0 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -7,7 +7,7 @@
>  #include <linux/slab.h>
>  #include <linux/sched/mm.h>
>  
> -#include "iommu-sva-lib.h"
> +#include "iommu-sva.h"
>  
>  static DEFINE_MUTEX(iommu_sva_lock);
>  static DECLARE_IOASID_SET(iommu_sva_pasid);
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 44475a9b3eea..c1763476162b 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -27,6 +27,6 @@ obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>  obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
>  obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
>  obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
> -obj-$(CONFIG_IOMMU_SVA) += iommu-sva-lib.o io-pgfault.o
> +obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o io-pgfault.o
>  obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
>  obj-$(CONFIG_APPLE_DART) += apple-dart.o
> -- 
> 2.25.1
> 
