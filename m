Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F5F5674A0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiGEQmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiGEQmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:42:04 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E721C91C;
        Tue,  5 Jul 2022 09:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=C8Lk5zmtX8e6o/NFY86TvQ45i0l4+E0mfisBAA1KmfA=; b=K6XgjV5zJgzurqFOh3H10ZC+lZ
        sUOdc71G0WJz5hTQAbh6bf2AcHhJclo/g4AOwGPkLNfCmRojltAtRExhvHJnoH9avPf8waMiFwdfR
        6QfEUWvhSAqff6L/H0Hg4F7xEVNd+PGjGUzrlqyRDBPkMnt61QaopxIJ9uchDWmlJA7qsH+OIR+Fd
        pLimKgtUIBwdevI9TLxxwqXaUfrqq5GmOO+kWs84rj0e+uugVEPeqnUGI/rZ9/9lzs6c4QbXv5MML
        z1G4DBTFmxGcsqb2cTCmQ6DcD8WjWnmt6IOZySclbQ+N0osicOYOzPz+sx+SlezlGNGG4gwbElr4t
        eTgsjL8w==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1o8lcb-007Svi-Gn; Tue, 05 Jul 2022 10:41:58 -0600
Message-ID: <a509b13c-244b-23fc-f989-339750a733a5@deltatee.com>
Date:   Tue, 5 Jul 2022 10:41:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-CA
To:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-21-logang@deltatee.com> <20220629064854.GD17576@lst.de>
 <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com>
 <20220629175906.GU23621@ziepe.ca> <20220705075108.GB17451@lst.de>
 <20220705135102.GE23621@ziepe.ca> <20220705161240.GB13721@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220705161240.GB13721@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, dan.j.williams@intel.com, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, bhelgaas@google.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v7 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-07-05 10:12, Christoph Hellwig wrote:
> On Tue, Jul 05, 2022 at 10:51:02AM -0300, Jason Gunthorpe wrote:
>>> In fact I'm not even sure this should be a character device, it seems
>>> to fit it way better with the PCI sysfs hierchacy, just like how we
>>> map MMIO resources, which these are anyway.  And once it is on sysfs
>>> we do have a uniqueue inode and need none of the pseudofs stuff, and
>>> don't need all the glue code in nvme either.
>>
>> Shouldn't there be an allocator here? It feels a bit weird that the
>> entire CMB is given to a single process, it is a sharable resource,
>> isn't it?
> 
> Making the entire area given by the device to the p2p allocator available
> to user space seems sensible to me.  That is what the current series does,
> and what a sysfs interface would do as well.

Yes, I think Jason is assuming the sysfs file would behave like the
existing mmio resource files where the process doing the mapping
specifies the offset and length into the BAR. That is not what we want
here, but I don't see why I don't see why we can't do the same thing in
sysfs as we do with the char device with a bin_attribute->mmap() callback.

mmapping the char device was convenient in user space, but it's not much
more work to dig through sysfs and mmap an attribute from there.

Using sysfs means we don't need all the messy callbacks from the nvme
driver, which is a plus. But I'm not sure how we'd get or unmap the
mapping of a sysfs file or avoid the anonymous inode. Seems with the
existing PCI resources, it uses an bin_attribute->f_mapping() callback
to pass back the iomem_get_mapping() mapping on file open.
revoke_iomem() is then used to nuke the VMAs. I don't think we can use
the same infrastructure here as that would add a dependency on
CONFIG_IO_STRICT_DEVMEM; which would be odd. And I'm not sure whether
there is a better way.

Logan
