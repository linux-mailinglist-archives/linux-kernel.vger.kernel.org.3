Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4274A462072
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243251AbhK2TbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242569AbhK2T25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:28:57 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD659C0619E1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 07:43:20 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q3so14907921wru.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 07:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c1tPtK4234RzEJWdk1WuLUNOshhLfQVugRr+E/JBV7g=;
        b=g2iBnLzqE+SGysyAa+bTZmQuY2vqxlkuegiDpA1TflrERCuQyPkBS/gcIY+OW8xC97
         aI8V/5mGz8nis/fl1rwHHXcq5+7Cj8DnrqKVyXHv+5X6f4nqiOOmYctZLU9wEIVh9jI9
         y339j2x5j+cp3EvWpj1Xegqk2EYEWeeWw2b/R2u7GkJdrMetyUq+/DqvfgOtGSVHTEnQ
         064lBcZ4X3h+G4+/lHPwG4biBSxXcuEWwKDzKjia2MbY04zt8+0sfr0XoQAMNyyYNI+G
         Et7XRWkzVbCYJt3ICPCTvZcbmuZkJ7KdWqun7A3PEECN8TJ4pPejUMPBXxqT03KH+Wd3
         tJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c1tPtK4234RzEJWdk1WuLUNOshhLfQVugRr+E/JBV7g=;
        b=esdvqTf47E12yFzhCtSZqMW5DkMPZRoIDB3+R+rDn72v5uAKDQ8N56/EVuG9gkoIVj
         Hsg33W5mrMgUEk2VYXszR9pGat+DE2cJQncbCjlhHCAzm0khaZSwxm4CuKrTATmyQxSd
         EYJkRotOP8LRKdk9VGEqKa06fEMRIuigGq983M9yibbsAAXLV+wfL/4sDKnFeCG3YYqC
         PFIYpyaTorOWzAuSRKsD9WVWItxe8lVk4vHNGWATDcoF1aeMpvJCdXozL78gWrhbOkex
         cQHY31Yaq4YP9VyIdJJD5gBvLMbFpOX7Natuqu4QPGzWaYbhk2cvlUEV1tMa164iwxIV
         VMnQ==
X-Gm-Message-State: AOAM531VyBdHQLK4FoW8o5Py6RqHAbHtPvfgiD3rB5Fw5lRHpbGdJxbg
        Xltmh0OkD4ptNGxsuRUQFmX+4Q==
X-Google-Smtp-Source: ABdhPJwKBmo1MmuxbifKQZpvxvwmsEEyZ57GieBhblMgmCSXKl2ODJEBwBMGXXvNmg5uMFFU0yAMbw==
X-Received: by 2002:a05:6000:188b:: with SMTP id a11mr33970909wri.326.1638200599356;
        Mon, 29 Nov 2021 07:43:19 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id p5sm14473848wrd.13.2021.11.29.07.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 07:43:18 -0800 (PST)
Date:   Mon, 29 Nov 2021 15:42:56 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Eric Auger <eric.auger@redhat.com>, joro@8bytes.org,
        will@kernel.org, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        sebastien.boeuf@intel.com, kevin.tian@intel.com,
        pasic@linux.ibm.com
Subject: Re: [PATCH v2 4/5] iommu/virtio: Pass end address to
 viommu_add_mapping()
Message-ID: <YaT1ACdwq1n4YBug@myrica>
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
 <20211123155301.1047943-5-jean-philippe@linaro.org>
 <7b79fe9b-9d51-8bda-2868-b48781f07fc9@redhat.com>
 <20211127180742-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211127180742-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 06:09:56PM -0500, Michael S. Tsirkin wrote:
> > > -static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
> > > -			      phys_addr_t paddr, size_t size, u32 flags)
> > > +static int viommu_add_mapping(struct viommu_domain *vdomain, u64 iova, u64 end,
> > > +			      phys_addr_t paddr, u32 flags)
> > >  {
> > >  	unsigned long irqflags;
> > >  	struct viommu_mapping *mapping;
> 
> I am worried that API changes like that will cause subtle
> bugs since types of arguments change but not their
> number. If we forgot to update some callers it will all be messed up.
> 
> How about passing struct Range instead?

I gave struct range a try but it looks messier overall since it would only
be used to pass arguments. I think the update is safe enough because there
is one caller for viommu_add_mapping() and two for viommu_del_mappings(),
at the moment.

Thanks,
Jean

