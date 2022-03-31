Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF684ED58F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbiCaI1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiCaI1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:27:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C5A1C4040
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648715131; x=1680251131;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=KCSXDm3RC4aQp01a11FrJWqsx450JrWrRKmLFEH0CtQ=;
  b=OPE5H/W3jyGGQFvUYE0lUohQH8EaZ6qrW5N25yY39rAc52KqJBP8gicr
   jYcaooiMsI/729GrD46flnM5F5zXU4SGcLmQCeB1MyI2mEZia4VEBDrJl
   X30rk9bZm/vdUbmqvT/y8SmWcZAx9f6xQu2fkrvlSVog5OAyyFt4fnmD7
   dZC6SZBcaSRmHc2dm8mz+K4oN1Q7/AXtQ3t/3X/yr4FkG3E2zaK6LnmBI
   OXegOScptBOFYhGvDm/tRsCRuvtMxwWjUtglAx5SIvksEcyzqYfIFnSTn
   4ouaVI3J/sINl99DR1W12kXh6gKVF/b0hd6GLvxWxPBoP5wHK6wvRZZBe
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="247254177"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="247254177"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 01:25:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="566269025"
Received: from cgarnier-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.62.224])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 01:25:27 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     "Wang, Zhi A" <zhi.a.wang@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        Zhi Wang <zhi.a.wang@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v7 1/3] i915/gvt: Separate the MMIO tracking table from
 GVT-g
In-Reply-To: <4af59d97-b583-4022-3ec3-360e7df43689@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220325175251.167164-1-zhi.a.wang@intel.com>
 <20220328065008.GA29798@lst.de>
 <4af59d97-b583-4022-3ec3-360e7df43689@intel.com>
Date:   Thu, 31 Mar 2022 11:25:25 +0300
Message-ID: <871qyibkay.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022, "Wang, Zhi A" <zhi.a.wang@intel.com> wrote:
> Hi Jani and Joonas:
>
> Are you OK with these patches? I noticed I need to change the license
> of the new file. Will do that when check-in if you are OK with these.

Use SPDX license header instead of the full text?

I don't know much about the actual contents, I'll leave that part to
others.

Seems that you are dropping const in a number of places where I thought
you could perhaps retain it.

Also in drivers/gpu/drm/i915/intel_gvt_mmio_table.c:

#include "gvt.h" 

looks bad. It should be "gvt/gvt.h". I realize you can do that because
gvt/Makefile has:

ccflags-y += -I $(srctree)/$(src) -I $(srctree)/$(src)/$(GVT_DIR)/

which I think should be removed.

I sent patches fixing this to give you an idea. No need to queue them
first, I can rebase them later. But please make sure this builds without
the ccflags.


BR,
Jani.


>
> Thanks,
> Zhi.
>
> On 3/28/22 6:50 AM, Christoph Hellwig wrote:
>> On Fri, Mar 25, 2022 at 01:52:49PM -0400, Zhi Wang wrote:
>>>
>>> v7:
>>>
>>> - Keep the marcos of device generation in GVT-g. (Christoph, Jani)
>> 
>> The changelog go under the "---" line (also for the other patches).
>> 
>> Otherwise looks good:
>> 
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> 
>

-- 
Jani Nikula, Intel Open Source Graphics Center
