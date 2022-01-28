Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E4049FB91
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349086AbiA1OWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245002AbiA1OWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:22:53 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5D8C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 06:22:53 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id k4so5936234qvt.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 06:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hOJwMUY5Bby5v0yKsY6i8lpR9Ki3WovrYD+I2hctsmg=;
        b=U6c+XkFY8s+Ffl7FMQbVxlp2XqdxMulpeXig888uzfihlBCtxwuxIolRJkxjXzaeEX
         eIVyFvkbbf1xDb6SPEgSmnVCw9pDRfPJMYU4oslaqMl3i67iHf7KZeS/e0PmUBODdSZZ
         AowH8T2WlGQ4lht/OCyvJWxyWbcXEvFC6taxlenfQBvCzsa6ZLxsUregxcSiDD43dffE
         wyxXaf1wb+uEKWMD1qAmtSSmLQmslFUsrWqqlGvzI9Koh8SJ+5/r0xM1DEOICXREV+1R
         hc7uSuZaF6wJJ5ERb4Bbz+7wa78dvtPacUGiJQdQuCom+zLYAupwohfFwPnp5nzy05HC
         7X4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hOJwMUY5Bby5v0yKsY6i8lpR9Ki3WovrYD+I2hctsmg=;
        b=Ae9TkEWjmrtmmgnJ5OatQm8I9yOupBkKknxgGHZ2vyHHxClcxKu34d81j3VrlF03gR
         U6BIMBS6Wb9g0J92hDUql7jAtgy1c1f4IfJLPozG+v4Qu/UasV0SVMlzaiVcxwb5MUi6
         OvTjrnLsHr/Val4NxEcD3ghhIxlkHi5qcwEalXXrlk1aAmB3jwbZdPRBxsWVy1Vs0Oe1
         S9nIogi1jk/xUfJeIHNxaz+suJWFPNVPVqVhvpgTYgzVz/R09pnKsx5Oh3TTk/kSBnkD
         5GYjSRvWO4DhBRdPPs2STO2WGla9aJU616ODnOEDOxIAx4TW+BFn/HUmGMEUu7hxq5R7
         6nKQ==
X-Gm-Message-State: AOAM53058kD4X8vjfErpSqTYc+FnSbyRoDN5uE8/YCD6IDm7javzjykp
        22TNkfzrKksNpcPOKHwqSQBWYA==
X-Google-Smtp-Source: ABdhPJxVRgqXNs0AEB/UOEkxwovAuD7L4ajDVFitY42TUAFuPNOZiD9bQ3/LB4azis3UeruHH3Md/w==
X-Received: by 2002:a05:6214:29e7:: with SMTP id jv7mr7547390qvb.114.1643379772621;
        Fri, 28 Jan 2022 06:22:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id v22sm1250520qtc.96.2022.01.28.06.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 06:22:52 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nDS9L-007UYx-Hy; Fri, 28 Jan 2022 10:22:51 -0400
Date:   Fri, 28 Jan 2022 10:22:51 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v5 22/24] mm: use custom page_free for P2PDMA pages
Message-ID: <20220128142251.GV8034@ziepe.ca>
References: <20220128002614.6136-1-logang@deltatee.com>
 <20220128002614.6136-23-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128002614.6136-23-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 05:26:12PM -0700, Logan Gunthorpe wrote:
> When P2PDMA pages are passed to userspace, they will need to be
> reference counted properly and returned to their genalloc after their
> reference count returns to 1. This is accomplished with the existing

It is reference count returns to 0 now, right?

Jason
