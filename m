Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAB246FD60
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbhLJJKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbhLJJKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:10:23 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522B0C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 01:06:48 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w1so27591590edc.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 01:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p51Nz29s/4zmZ+EPSD75GUmiIaP5D91+aCSEQZKR7mY=;
        b=w0/20eIpOstfeq4XyG6SkmuCg0ION+5jLGBpP6vias0+7A0TxUpXOgqgAoOTZ4QTXN
         wAYFBxEEsCB1XdI237RbMAMOgXiUuIQRB7hnO2KBN3T22RrD0M2HvPKcHqfnxduCWPtL
         CBFRfUVhrE7VGPWNvtwIHwQkKo/+JblWxwlbflPf8kc8ikqftYje0ih6EYKEBcYnhHlc
         zw4jkifcFLQ/ohA3A+4FtKNDC2KuYHsaAJ0qudJumUaejaQMja/v/kYOFlhHSnEW28px
         uFPLpwq9cg9NNnbfvhYKNtMkha7CpwF/2sbn2ST+miB5XzMxb8zF6C9MQRu32KEFjOO3
         UyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p51Nz29s/4zmZ+EPSD75GUmiIaP5D91+aCSEQZKR7mY=;
        b=aT+w5+3RPxCR6NTwGuCb4h2RlgFAX7+vh8U9m1ydIGcpwjC6gdEiz5W5OPKHcN2rcE
         R6nCAg85jIlSX7p14+fFOlvpIvNQCNDjl01MGr40M5Q9zeTRxet32BJMwB7/lFZtKtS2
         CkySsJdoeyE3Ab/d5sQVE869q7VQ1U7wTcpZx2aShWis0pR4obE2wkxlhHAIHoDNDW5U
         HT7P7WObDAaaKMA8JyJblj3WierZlDJuwG+Q+fSNU+XSyRE7pytupRpeMnrvl7GciOS3
         QFigDN7IPYGa+g0tRvlU7my4NAxy7Ggfmzj0h3JuZh0HnS2vB1QVw5d392oKgRlEWOST
         VdXQ==
X-Gm-Message-State: AOAM532zYHe7VgbflDbmBpZ/p/BWTROW0g5XyqyI7vxh/Gijbo2vaARG
        raHQ5ROp2HelvEEIhYMGyKpv/Q==
X-Google-Smtp-Source: ABdhPJzzl9GYf5cjF2Z03Bwf6HwuUK34ncwmWm/jaDIJ7LMJxa/P7TYdoO0r7pqId0sfN/uLkPSH1Q==
X-Received: by 2002:a05:6402:1e93:: with SMTP id f19mr37545678edf.60.1639127206878;
        Fri, 10 Dec 2021 01:06:46 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id mp26sm1135173ejc.61.2021.12.10.01.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 01:06:46 -0800 (PST)
Date:   Fri, 10 Dec 2021 09:06:24 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/4] ioasid: Reserve a global PASID for in-kernel DMA
Message-ID: <YbMYkKZBktlrB2CR@myrica>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <YbHie/Z4bIXwTInx@myrica>
 <20211209101404.6aefbe1c@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209101404.6aefbe1c@jacob-builder>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:14:04AM -0800, Jacob Pan wrote:
> > This looks like we're just one step away from device drivers needing
> > multiple PASIDs for kernel DMA so I'm trying to figure out how to evolve
> > the API towards that. It's probably as simple as keeping a kernel IOASID
> > set at first, but then we'll probably want to optimize by having multiple
> > overlapping sets for each device driver (all separate from the SVA set).
> Sounds reasonable to start with a kernel set for in-kernel DMA once we need
> multiple ones. But I am not sure what *overlapping* sets mean here, could
> you explain?

Given that each device uses a separate PASID table, we could allocate the
same set of PASID values for different device drivers. We just need to
make sure that those values are different from PASIDs allocated for user
SVA.

Thanks,
Jean

