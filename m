Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBB84A9877
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiBDLep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:34:45 -0500
Received: from 8bytes.org ([81.169.241.247]:53978 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358414AbiBDLen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:34:43 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 83EDA491; Fri,  4 Feb 2022 12:34:41 +0100 (CET)
Date:   Fri, 4 Feb 2022 12:34:38 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     John Garry <john.garry@huawei.com>
Cc:     iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu/amd: Fix loop timeout issue in
 iommu_ga_log_enable()
Message-ID: <Yf0PTlYNn/fmIUZU@8bytes.org>
References: <20220131161749.4021-1-joro@8bytes.org>
 <48a674ae-f5cd-fc06-4505-6d863e6dad69@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48a674ae-f5cd-fc06-4505-6d863e6dad69@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 05:06:03PM +0000, John Garry wrote:
> > diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> > index dc338acf3338..d2e09d53851f 100644
> > --- a/drivers/iommu/amd/init.c
> > +++ b/drivers/iommu/amd/init.c
> > @@ -834,6 +834,7 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
> >   		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
> >   		if (status & (MMIO_STATUS_GALOG_RUN_MASK))
> >   			break;
> > +		udelay(1);
> 
> Maybe readl_relaxed_poll_timeout_atomic() could be used instead

I sent another version of this patch which uses
readl_poll_timeout_atomic(), but it didn't fix the issue. I take this
approach for now and leave using the helper as a future improvement.

Thanks,

	Joerg
