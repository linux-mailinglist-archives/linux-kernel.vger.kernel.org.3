Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA012567035
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiGEOEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiGEOEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:04:14 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1B05FF3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:51:04 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g14so13695875qto.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 06:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aXXqCO4eYEW7ihl1nkLRPlC9zfL+9NshKktoq8vfUqo=;
        b=cDfN+bQczbdMb2leah0e/N44YCVFwIYBhS6uK2yvKAxV/VrnPHyc+hyWjNAaUg1PfL
         kVcyYs7o5yY5RdPBbZ1Uy12G+gaOeGz7GPvyLzJpp7K+3AfzkxCHdfURo3kwOoQVGHsB
         CgYT4nV/UQd7IrmpI3kE+7IkazWCK3VkAF/AOUDIg9vA84UJqgb+kOFEqstZkexFUiOW
         t4uMNrJQXIZB/yeHytTtD8UoGO1NLRJoiAFfgFOvXzUbr67CkUchXLiOTkdsKPw7QrA5
         0GMzIsPAHjhYnDnVJ1sJYE4BoAvaoerhS04hqo2hF28Qc0NfnJdWsyByjW3v2jzln7ab
         r2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aXXqCO4eYEW7ihl1nkLRPlC9zfL+9NshKktoq8vfUqo=;
        b=ckPrGCIQLMIlSc/UHqfvb1G3IJu5uX/XnFWd58wvba+6ChT39PlLtoF/vsRqdK92j8
         c8jC32WF9urplINEpePDr5jcPHp6Dvl4WpUEdG16Fdy872aTGmVh70U5CmEGOrdqVbCV
         pPptcbj5zIcRtr97stzL5Ijlh830ZY74bNPSU4vFk9xoG/s3LC9bzh2YfSwqpFAKyX7d
         ZBilSTjNkE24w2+W4Rg8xUopFO0HTPI2OHXT92Ff1FH9KMLmPJefgEFciqiFCsR2bXxC
         uGyE1PxWdbmGjj52wOs1BpWK5eAzvoynhgRfVsB45Yoruxgee867BQ9/qX3KrnVQSa2F
         ChHQ==
X-Gm-Message-State: AJIora8t99sjQHl76tVAKbBYAhscEpDV9tZxkvE5ssTIyjoFrBWTS2/q
        75DEttxSTqXVou7BCExSMf7j1A==
X-Google-Smtp-Source: AGRyM1tiQ1fXhmwo7QGB7JVrZMkNllap136sZt6NhU7vlDBe2k8co+srzJapO8MDIuFHQGrnlFDnUA==
X-Received: by 2002:a05:6214:5005:b0:472:e6b0:1fb2 with SMTP id jo5-20020a056214500500b00472e6b01fb2mr12627413qvb.124.1657029063626;
        Tue, 05 Jul 2022 06:51:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id f10-20020a05620a280a00b006a69d7f390csm27745242qkp.103.2022.07.05.06.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 06:51:02 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o8ixC-006VQ4-6E; Tue, 05 Jul 2022 10:51:02 -0300
Date:   Tue, 5 Jul 2022 10:51:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220705135102.GE23621@ziepe.ca>
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-21-logang@deltatee.com>
 <20220629064854.GD17576@lst.de>
 <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com>
 <20220629175906.GU23621@ziepe.ca>
 <20220705075108.GB17451@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705075108.GB17451@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 09:51:08AM +0200, Christoph Hellwig wrote:

> But what also really matters here:  I don't want every user that
> wants to be able to mmap a character device to do all this work.
> The layering is simply wrong, it needs some character device
> based helpers, not be open code everywhere.

I think alot (all?) cases would be happy if the inode was 1:1 with the
cdev struct device. I suppose the cdev code would still have to create
pseudo fs, but at least that is hidden.

> In fact I'm not even sure this should be a character device, it seems
> to fit it way better with the PCI sysfs hierchacy, just like how we
> map MMIO resources, which these are anyway.  And once it is on sysfs
> we do have a uniqueue inode and need none of the pseudofs stuff, and
> don't need all the glue code in nvme either.

Shouldn't there be an allocator here? It feels a bit weird that the
entire CMB is given to a single process, it is a sharable resource,
isn't it?

Jason
