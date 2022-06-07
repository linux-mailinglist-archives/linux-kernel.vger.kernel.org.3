Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BE053BD8E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 19:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbiFBRtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 13:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbiFBRti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 13:49:38 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E073613B2E2;
        Thu,  2 Jun 2022 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=iyck+wOifMpSZlLxRfCrWDgusCm3mWKdpT17Ia+B9wY=; b=rnaKQUhn8m0zyN0RqZEYQDjsXS
        bQq3WwRpeKjVK1qMYZK6mfxOtb/vSCH4EYY+RMt8unUUNIFPAn8qkWOpu0WY8P+7ycxavtU8c1x42
        GL4bMz3u3uliqUKkk/rKHRiF6ip5UbjhpBdiEMfIJ6nrjfPr/5Sq6euvL6HgLOAijk7z3HlBHP7ls
        pcXQ0r9j5pF9NW3clGalNpKN8L7zkm/dgY51Cgy5nTN+GYoKstvVBkAR/a/aEoyXotFUOBWnP/yvp
        eUKOoQvmroULemDQpPRn3ppgTUJ3ZUx9YNJrBF5YBjbqtvmxd7j82k4fvWwyzEA+XJ6DtYonhy2aI
        X2SqWSig==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nwoww-00EP6z-6D; Thu, 02 Jun 2022 11:49:35 -0600
Message-ID: <251c6028-c53a-28dd-2bbf-d5c8ec2496b3@deltatee.com>
Date:   Thu, 2 Jun 2022 11:49:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-CA
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
        Ralph Campbell <rcampbell@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
 <20220527125501.GD2960187@ziepe.ca>
 <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
 <20220527190307.GG2960187@ziepe.ca>
 <d336cfe8-2451-04c3-a2ce-0e8e47afd1e3@deltatee.com>
 <20220602000038.GK2960187@ziepe.ca>
 <400baba7-1cd6-09d4-4de9-2a73f08afc79@deltatee.com>
 <20220602163059.GL2960187@ziepe.ca>
 <51cc6645-2504-6d01-5626-238ed6ffff04@deltatee.com>
 <20220602172811.GN2960187@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220602172811.GN2960187@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, dan.j.williams@intel.com, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, bhelgaas@google.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v6 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-06-02 11:28, Jason Gunthorpe wrote:
> On Thu, Jun 02, 2022 at 10:49:15AM -0600, Logan Gunthorpe wrote:
>>
>>
>> On 2022-06-02 10:30, Jason Gunthorpe wrote:
>>> On Thu, Jun 02, 2022 at 10:16:10AM -0600, Logan Gunthorpe wrote:
>>>
>>>>> Just stuff the pages into the mmap, and your driver unprobe will
>>>>> automatically block until all the mmaps are closed - no different than
>>>>> having an open file descriptor or something.
>>>>
>>>> Oh is that what we want?
>>>
>>> Yes, it is the typical case - eg if you have a sysfs file open unbind
>>> hangs indefinitely. Many drivers can't unbind while they have open file
>>> descriptors/etc.
>>>
>>> A couple drivers go out of their way to allow unbinding while a live
>>> userspace exists but this can get complicated. Usually there should be
>>> a good reason.
>>>
>>> The module will already be refcounted anyhow because the mmap points
>>> to a char file which holds a module reference - meaning a simple rmmod
>>> of the driver shouldn't work already..
>>
>> Also, I just tried it... If I open a sysfs file for an nvme device (ie.
>> /sys/class/nvme/nvme4/cntlid) and unbind the device, it does not block.
>> A subsequent read on that file descriptor returns ENODEV. Which is what
>> I would have expected.
> 
> Oh interesting, this has been changed since years ago when I last
> looked, the kernfs_get_active() is now more narrowed than it once
> was. So manybe sysfs isn't the same concern it used to be!

Yeah, so I really think *not* blocking unbind indefinitely is the better
approach here. It's what has always been done with device dax, etc.
mmaps in userspace processes get unmapped and will fault with SIGBUS on
next access and unbind will actually unbind the device relatively
promptly. Userspace processes can fail or try to handle the device going
away gracefully.

Logan
