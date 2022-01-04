Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54D7483DAC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbiADIIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:08:14 -0500
Received: from mga11.intel.com ([192.55.52.93]:24017 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232556AbiADIIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641283692; x=1672819692;
  h=date:from:to:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to;
  bh=JGVqO0RNhQRkgwtOPexDl3xMWwH0tmSCVRe71/2iLKU=;
  b=a358jR6k8GEjOK5BmvYa5jZ3hoL7yrMl8NsjxncnQATTFgd5vrtHWQpi
   kDufG8+d5mIYdNtiMCAT32Bxu3FoRglLe0EBnRVp8x/GAcrlrRHbr07mI
   JNcnEyTa3czCN0bK91NvnuQGte09V/CqBc7DokNhxiQsndGS9wC4Mg7fn
   iIWKLhuVkT5dCJI+0ApGWROMqKzWWCghV2qdq4JtG5ieRiVHV9DvDqbRq
   O5zGeHC6Tcjb7m6+1OVzFSkDA2Jz7r9bwNr+p5MsEivH8UncwZyQi9eyF
   9Bu7Jk6xfC6OmiipZQnyGN8xE654qizuYeklWPr+/jU3mJD9Rvwy1TzcB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="239720505"
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="239720505"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 00:08:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="470083575"
Received: from louislifei-optiplex-7050.sh.intel.com (HELO louislifei-OptiPlex-7050) ([10.239.154.151])
  by orsmga003.jf.intel.com with ESMTP; 04 Jan 2022 00:08:08 -0800
Date:   Tue, 4 Jan 2022 16:09:02 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     zhou1615@umn.edu, kjlu@umn.edu, reinette.chatre@intel.com,
        zhi.a.wang@intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fei1.li@intel.com
Subject: Re: [PATCH] virt: acrn: fix a memory leak bug in acrn_dev_ioctl()
Message-ID: <20220104080902.GA7254@louislifei-OptiPlex-7050>
References: <20220104024729.GA26952@louislifei-OptiPlex-7050>
 <20220104034501.45715-1-zhou1615@umn.edu>
 <20220104035032.GA27848@louislifei-OptiPlex-7050>
 <YdP5N3lYqF09dLPv@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdP5N3lYqF09dLPv@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 08:37:27AM +0100, Greg KH wrote:
> On Tue, Jan 04, 2022 at 11:50:33AM +0800, Li Fei1 wrote:
> > On Tue, Jan 04, 2022 at 11:45:01AM +0800, Zhou Qingyang wrote:
> > > In acrn_dev_ioctl(), vm_param is not released or passed out on the 
> > > error path of "if ((vm_param->reserved0 | vm_param->reserved1) != 0)", 
> > > which could lead to a memory leak.
> > > 
> > > Fix this bug by adding a kfree of vm_param on the error path.
> > > 
> > > This bug was found by a static analyzer.
> > > 
> > > Builds with CONFIG_ACRN_GUEST=y, CONFIG_ACRN_HSM=y show no new warnings, 
> > > and our static analyzer no longer warns about this code.
> > > 
> > > Fixes: 9c5137aedd11 (“9c5137aedd11 virt: acrn: Introduce VM management interfaces”)
> > > Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> > > ---
> > > The analysis employs differential checking to identify inconsistent
> > > security operations (e.g., checks or kfrees) between two code paths
> > > and confirms that the inconsistent operations are not recovered in 
> > > the current function or the callers, so they constitute bugs. 
> > > 
> > > Note that, as a bug found by static analysis, it can be a false
> > > positive or hard to trigger. Multiple researchers have cross-reviewed
> > > the bug.
> > > 
> > > Changes in v2:
> > >   -  Fix the same bug in ACRN_IOCTL_SET_VCPU_REGS.
Hi Qingyang

I think the "Changes in v2" was not fixes the code in commit "9c5137aedd11 virt: acrn: Introduce VM management interfaces", but in commit 2ad2aaee1bc9 "virt: acrn: Introduce an ioctl to set vCPU registers state".
Would you please to split this patch into two and please replace “...” with "..." in your commit message.

Thanks.


> > > 
> > 
> > Signed-off-by: Fei Li <fei1.li@intel.com>
Please ignore my "Signed-off" here. Sorry.
> 
> For the multiple obvious reasons (not the least being you didn't even
> run it through our normal testing scripts), I am not going to take this
> change, sorry.
> 
> Fei, please be more careful in the future.
> 
> greg k-h
