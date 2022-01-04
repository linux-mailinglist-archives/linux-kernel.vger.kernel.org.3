Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643F0483D5A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiADIBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:01:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:36311 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230057AbiADIBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641283267; x=1672819267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=x35rRbB6k5VnCl4KOtjGJaJeQfTU/z2Rl3wpU7MzsPk=;
  b=iwmhxkJKTu2trpn2NLDIiBwNmhPMKVffPr6SMkyNN4j74jDla4ylB5OI
   R/himbXjz61+u8KDZvRiiBtWmWYfktBit+yMDiMd+mFzjuhlehlJqWGMp
   DYMsf1d4Fla4/u5JHn87WAU+FxZjtnFqAH//6O+dpNXuMwMtkGFbSxcLO
   B9lJwUMnHni0uWYEiWvPj4QtPSvdg6Gs9r8FcaEkVL2hGkrgQ2cF9juJk
   mDclIJB3ZxwdWxvqSv9/AlNbWD6KbbzBis1+ka0ZHykRsaPVR8CvLsFh0
   X/wTBW4BOAMPwSWsmyFtr3m6qIb/D0Z21JaLcNESqYj6aL65RNlibqd/X
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="240997787"
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="240997787"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 00:01:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="556089628"
Received: from louislifei-optiplex-7050.sh.intel.com (HELO louislifei-OptiPlex-7050) ([10.239.154.151])
  by orsmga001.jf.intel.com with ESMTP; 04 Jan 2022 00:01:04 -0800
Date:   Tue, 4 Jan 2022 16:01:57 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     zhou1615@umn.edu, kjlu@umn.edu, reinette.chatre@intel.com,
        zhi.a.wang@intel.com, linux-kernel@vger.kernel.org,
        fei1.li@intel.com
Subject: Re: [PATCH] virt: acrn: fix a memory leak bug in acrn_dev_ioctl()
Message-ID: <20220104080157.GA7225@louislifei-OptiPlex-7050>
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
> > > 
> > 
> > Signed-off-by: Fei Li <fei1.li@intel.com>
> 
> For the multiple obvious reasons (not the least being you didn't even
> run it through our normal testing scripts), I am not going to take this
> change, sorry.
> 
> Fei, please be more careful in the future.
> 
Hi Greg

Thanks for your kind reminder. I will.


> greg k-h
