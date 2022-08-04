Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B136058A050
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239873AbiHDSNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiHDSNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:13:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4467B4E860;
        Thu,  4 Aug 2022 11:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659636810; x=1691172810;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5iohXJB+yV4kt8wNo0jkqP6WbWM7sMLvLkA/LUccLFg=;
  b=Wc83thVFd3rqV5OmPoGxwcRQX6Lt+sWn0+eoLVa33XYxCnvfg2NDoBTt
   nWCmv0Ey6/bAqXGwyfopdvl2/r8bO+CBydRFSyKct7LSBfWMenH73T4/5
   sGBuoRflt3DXIDp2n4+T84FhWyOv90XhdS33zXRdyp9wXDGX6vZd0woxl
   Vz40TbPMHMfSB8BnanmGtmMxbMfiG5oqqWuQjqTRjRId26B9gCNIAPCLs
   4h5sxcCk8tv/d7/2pBw3cbSHnkYZvl89jekAh70E4OyB7LAHuDuchQLoX
   QdmC8brBV5VcBTA95yWcQvnaUUdE4VqRxOGlf5D+BvlWK3a9DtNLqWk3W
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="270391801"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="270391801"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 11:13:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="745566014"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.79.208]) ([10.212.79.208])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 11:13:21 -0700
Message-ID: <bcbe1db2-cb8e-1889-2888-f4618d749bd4@intel.com>
Date:   Thu, 4 Aug 2022 11:13:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 0/2] cxl: BG operations and device sanitation
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, bwidawsk@kernel.org,
        Jonathan.Cameron@huawei.com, ira.weiny@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        a.manzanares@samsung.com, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220804045029.2905056-1-dave@stgolabs.net>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220804045029.2905056-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/3/2022 9:50 PM, Davidlohr Bueso wrote:
> Hello,
>
> The following is a followup to some of the discussions around CXL device security
> and sanitation[0, 1]. It is marked as RFC mostly to see if the background handling
> will satisfy all users, not just sanitize/overwrite. For example there has been ideas
> to avoid command hogging the device and/or interleaving scan media regions instead
> of all in one, etc. More details in each patch, but:
>
> Patch 1 adds the required background cmd handling bits. While this is currently
> only polling, it would be good to know if there are any fundamental blockers for
> supporting irqs (beyond just background ops) between PCIe and CXL. For example,
> are there any requirements/difficulties that is not the standard MSI/MSI-X PCI
> vector allocation + devm_request_irq()? I have not looked at this into details but
> it the topic has come up in the past as delicate', iirc.
>
> Patch 2 implements the sanitation commands (overwrite and secure erase).
>
> As for testing, while I used the mock device to test the secure erase command, I
> ended up hacking up a prototype[2] for qemu to support overwrite and bg commands.
> So while the some of the paths this series introduces have been exercised, there
> is of course a lot more to do.
>
> Applies against Dave's cxl-security branch[2] which deals with the pmem-only bits.

 From the operational sense everything looks good to me. As for the 
polling delay on overwrite, with pre-CXL pmem on Optane, we've 
discovered that overwrite can take a long time depending on the size. 
Sometimes MANY hours if the size is really large. We just opted to 
increment the polling interval as time went on [1] instead of based on size.

[1]: 
https://elixir.bootlin.com/linux/v5.19/source/drivers/nvdimm/security.c#L434


> Thanks,
> Davidlohr
>
> [0]: https://lore.kernel.org/all/20220708172455.gi37dh3od4w5lqrd@offworld/
> [1]: https://lore.kernel.org/all/165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com/
> [2]: https://github.com/davidlohr/qemu/commit/64a93a5b824b59d3b547f06f7fbb1269fb4790ce
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-security
>
> Davidlohr Bueso (2):
>    cxl/mbox: Add background operation handling machinery
>    cxl/mem: Support sanitation commands
>
>   Documentation/ABI/testing/sysfs-bus-cxl |  19 ++
>   drivers/cxl/core/core.h                 |   2 +-
>   drivers/cxl/core/mbox.c                 | 304 +++++++++++++++++++++++-
>   drivers/cxl/core/memdev.c               |  58 +++++
>   drivers/cxl/core/port.c                 |   9 +-
>   drivers/cxl/cxl.h                       |   8 +
>   drivers/cxl/cxlmem.h                    |  65 ++++-
>   drivers/cxl/pci.c                       |   3 +-
>   drivers/cxl/pmem.c                      |   5 +-
>   drivers/cxl/security.c                  |  13 +-
>   include/uapi/linux/cxl_mem.h            |   2 +
>   11 files changed, 461 insertions(+), 27 deletions(-)
>
> --
> 2.37.1
>
