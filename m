Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776AF4842C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiADNrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:47:08 -0500
Received: from mga18.intel.com ([134.134.136.126]:25689 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232396AbiADNrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641304027; x=1672840027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=giCDfeerhSB/M4N2G4n+FT62UWoiMv/yX0S2mawmUU4=;
  b=S4B/gEl8yIsDVUVPetNhDcwbKuwLxux6Q0Mo9BGvx4dgwen0bWTrI3J5
   IxnoAxlOaTYVtY1wCnD4WtYwfucGRUOP4OpMc6qnNy8AsB2qtdQVrAEHj
   PaWFkkBFpyVgUYqA8uXvGquIfKZ0FwxmUbWpd90/6Sr48xNxhmxA/l4//
   UrTYDomKCEnx+QnocHjbekQmgwr4LoDZj+1M0YS77WkqVA3M5zifQ4uP2
   IV0cAZ3Z+YlgcQ+Q1FjkPRYjsvsUal+A4AfWv9d+g8a3n3XHqxV0hWLwV
   eqJ1cuMQoFdtxSyJQO0/ofIFHO3jiYwOBIUNvOewjr4rD2W0xItIBODRf
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="229043697"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="229043697"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 05:47:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="488198643"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 05:47:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n4k8J-006DjC-Hk;
        Tue, 04 Jan 2022 15:45:47 +0200
Date:   Tue, 4 Jan 2022 15:45:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v1 1/1] KVM: arm64: vgic: Replace kernel.h with the
 necessary inclusions
Message-ID: <YdRPi65NyiigKPPG@smile.fi.intel.com>
References: <20211222165552.69288-1-andriy.shevchenko@linux.intel.com>
 <8735mk1pgt.wl-maz@kernel.org>
 <YcNtpnxbyDA/CGgc@smile.fi.intel.com>
 <YcN5FKnbT9BHLn9f@smile.fi.intel.com>
 <87iluzvcn4.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iluzvcn4.wl-maz@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 01:44:31PM +0000, Marc Zyngier wrote:
> On Wed, 22 Dec 2021 19:14:28 +0000,
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Dec 22, 2021 at 08:25:43PM +0200, Andy Shevchenko wrote:
> > > On Wed, Dec 22, 2021 at 06:09:22PM +0000, Marc Zyngier wrote:
> > > > On Wed, 22 Dec 2021 16:55:52 +0000,
> > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > 
> > > > > When kernel.h is used in the headers it adds a lot into dependency hell,
> > > > > especially when there are circular dependencies are involved.
> > > > 
> > > > Which circular dependencies? What problem are you solving?
> > > 
> > > In particular moving bitmap_*alloc() APIs to the headers.
> > > 
> > > But this may be a side effect of what I realized during the attempts
> > > of solving that issue. In any case there is no need to take entire
> > > mess of kernel.h in another header.
> > 
> > For the record  `make headerdep` doesn't make any difference with
> > or without this patch. But I consider it's better not to use kernel.h
> > in the headers due to a full mess behind it.
> 
> Can you then please write a commit message that matches what this is
> actually doing instead of mentioning a problem that doesn't seem to
> exist?

Sure, thanks for review!

-- 
With Best Regards,
Andy Shevchenko


