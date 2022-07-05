Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A37D5675F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiGERnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiGERnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:43:31 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FE417E1A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:43:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o16-20020a05600c379000b003a02eaea815so8235150wmr.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 10:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BKDOb4xlZp4MaUsVZxk18FvC9MTm4XhyouNs2L3jRNQ=;
        b=G0X8ImN2RMYiGMiFNphfKdlxW6zMCVZIp5lWBwjZ+bL31Vn++3Cur6/ybppQF8izva
         3kR8eoD+QGt6WAxugtpTapdxkEU/XzIo9w0PbBok+y0wZLGG9rrW1gwKxJEUSsqJLuwa
         L3gV0+NajJmYaOKamQ+CudIBUDvwGZj2xZFXq4CnWcVkZr6KVLkmc4F+VliXfTUgnCl0
         0Aps/GnkGGn0jTKmcOwvxfI1pyL34OwidbDnp+5mTkTpjNdgCxWJeJSGZMjnmw0CIFWb
         XM6XnMbettTLuqgIrE/qaetQ47FOFXqYUbB3/lkkv7l/HLNy0zGYopVysXl5C/8PTspB
         u41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BKDOb4xlZp4MaUsVZxk18FvC9MTm4XhyouNs2L3jRNQ=;
        b=7adzI7KRD7Q+F0tx9tYngXQOVj0kR1zVcxiPkO8u2e1KY0QZ8qWAZaF0VXwLtPnKAE
         IcVmbUm2v1Z8HZuxpX0L50Af6CK+h+M5tMWs5rnEHq8nn8CU2VnrjnyWRWAn214Uss4i
         c4fE7FWBEAyb4EgIDjjpglbTq3MSqzFjDz3Tul3RiwrI1KzIMCAVhWdeMYKI9D4JZWpi
         w5AahCV7xFPjUzW9V2TX36U0UHA4Pz0w/AHdPMzyyTP/fUodOP4yTzwrVCr2cE5rI3DM
         qzUoMQQZ7LD2ZRG+W26hbIRcBITmK7oNJTCN0x60edeKQ31X9+cKFCO5hENL/lbmk3eB
         h0CA==
X-Gm-Message-State: AJIora+A1YY1U1lJGW42m0XIuRBm0QsTh6/rFieVccUzZkJe6WKhDMSx
        JI8+juzhMmFsX6kYXN/QcX1CAxF6ZFZFGQ==
X-Google-Smtp-Source: AGRyM1shDXUmV/7o3y063+Nyrzm5QDMjcyksWy5xl5QFnim77i91N380LMA7XTtoDBeD8UufCtcF4Q==
X-Received: by 2002:a05:600c:3491:b0:3a1:8609:ba7e with SMTP id a17-20020a05600c349100b003a18609ba7emr30360640wmq.79.1657043008462;
        Tue, 05 Jul 2022 10:43:28 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id l1-20020a5d4bc1000000b00219e77e489fsm32675353wrt.17.2022.07.05.10.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 10:43:28 -0700 (PDT)
Date:   Tue, 5 Jul 2022 18:43:03 +0100
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
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Message-ID: <YsR4JzFgvm20fs7E@myrica>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-9-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705050710.2887204-9-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 01:07:06PM +0800, Lu Baolu wrote:
> The existing iommu SVA interfaces are implemented by calling the SVA
> specific iommu ops provided by the IOMMU drivers. There's no need for
> any SVA specific ops in iommu_ops vector anymore as we can achieve
> this through the generic attach/detach_dev_pasid domain ops.
> 
> This refactors the IOMMU SVA interfaces implementation by using the
> set/block_pasid_dev ops and align them with the concept of the SVA
> iommu domain. Put the new SVA code in the sva related file in order
> to make it self-contained.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

