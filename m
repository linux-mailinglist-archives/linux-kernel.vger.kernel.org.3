Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B2D47D788
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345141AbhLVTP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:15:57 -0500
Received: from mga18.intel.com ([134.134.136.126]:4390 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234913AbhLVTP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640200556; x=1671736556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TeYxz3KQe/lbMhq6pt4M9UXFRISH6KSuuJ/067pvTBI=;
  b=R7s3jOAlf0CBszKHi4VE1yWc0N5MVhh9+Fj8NDLeuF2glM7bFgQaDRb8
   ACCWFpjHsXPRIW/hz2/Bf7lMXX/97i1NEmFQW3YoaLtJUqgmqUoJeESvC
   Kuc9zHw7T+DQTG2v6jNcp2qh5/NCXQu1IVSS0xrW5M8HapTs42Dj2pZh4
   0gfB71S8cMEQjwx3DExe57q0Icm0XGB6IeWt73pX1mNlyW+nGP8GqudIN
   4QDVoYDojo07woDsU/BY5nsq/NOAkxQ/Qnq1P/BDh4L6K2lvvw/WpmDvl
   ctrAMxGypwN3kIbisK/2JIPX/5MIH4VrAUyVwio5ibb01mivbjBROP/hk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="227540775"
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="227540775"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 11:15:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="685131404"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 11:15:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n074G-000vp5-O0;
        Wed, 22 Dec 2021 21:14:28 +0200
Date:   Wed, 22 Dec 2021 21:14:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v1 1/1] KVM: arm64: vgic: Replace kernel.h with the
 necessary inclusions
Message-ID: <YcN5FKnbT9BHLn9f@smile.fi.intel.com>
References: <20211222165552.69288-1-andriy.shevchenko@linux.intel.com>
 <8735mk1pgt.wl-maz@kernel.org>
 <YcNtpnxbyDA/CGgc@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcNtpnxbyDA/CGgc@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 08:25:43PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 22, 2021 at 06:09:22PM +0000, Marc Zyngier wrote:
> > On Wed, 22 Dec 2021 16:55:52 +0000,
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > 
> > > When kernel.h is used in the headers it adds a lot into dependency hell,
> > > especially when there are circular dependencies are involved.
> > 
> > Which circular dependencies? What problem are you solving?
> 
> In particular moving bitmap_*alloc() APIs to the headers.
> 
> But this may be a side effect of what I realized during the attempts
> of solving that issue. In any case there is no need to take entire
> mess of kernel.h in another header.

For the record  `make headerdep` doesn't make any difference with
or without this patch. But I consider it's better not to use kernel.h
in the headers due to a full mess behind it.

-- 
With Best Regards,
Andy Shevchenko


