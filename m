Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050C14ABF7A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448137AbiBGNKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442952AbiBGMVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 07:21:54 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E37C0423D2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 04:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644236041; x=1675772041;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=TgpvuJ0R1lB2H8FhHzTp6Ej42dRZzsbIJPbNKhwWF1s=;
  b=KZ9vv96jzpJ8FjOqk9TIVTGDquBcEH6fZof/qWEf1jHbC6YlmVjymzQF
   wzbWVj/aH3aLt0zqnjHHV7gtY6SQIWsUSUJe9PcijiP9uh3pibyhoUu1z
   fT8Ykj1+C8+fEu/i5IdPc/b+SlLqs7sevwjbi9mR++CTntsGBBnXA5NQN
   QTXkkFAk4rpR6Aol3DJc5PoZkzGmRIQX999N9ph8gQpKjSI/6jA+r2AsP
   MFtKAHgKJbwC8onmY5d0DH8CfDAN1kk4JDBDwsb9hxb/l4Vx0rf66bWgz
   f8piZKZmgqWEMJuMHhvBX/qASR9Sc+51mb6NKS9PfKRKcq5ahvdDi0Vet
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="312000577"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="312000577"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 04:14:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="484401961"
Received: from nbaca1-mobl.ger.corp.intel.com (HELO localhost) ([10.252.18.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 04:13:56 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>, Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "Xu, Terrence" <terrence.xu@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: Re: [PATCH 1/3] i915/gvt: Introduce the mmio_table.c to support
 VFIO new mdev API
In-Reply-To: <20220207120647.GA28851@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220127120508.11330-1-zhi.a.wang@intel.com>
 <20220207073247.GA24327@lst.de>
 <DM4PR11MB5549FE45F8098368114ADE75CA2C9@DM4PR11MB5549.namprd11.prod.outlook.com>
 <20220207083535.GA25345@lst.de> <877da7rlzr.fsf@intel.com>
 <5c916187-8a8c-323a-adb4-8bce141180cc@gmail.com>
 <20220207120647.GA28851@lst.de>
Date:   Mon, 07 Feb 2022 14:13:50 +0200
Message-ID: <87v8xqri0x.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Feb 2022, Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Feb 07, 2022 at 06:57:13AM -0500, Zhi Wang wrote:
>> Hi Christoph and Jani:
>>
>> Thanks for the comments. It would be nice that people can achieve a 
>> agreement. I am OK with both of the options and also moving some files into 
>> different folders doesn't needs me to do the full test run again. :)
>
> The way I understood Jani he agrees that the mmio table, which needs to
> be part of the core i915 module should not be under the gvt/ subdiretory.
> I.e. it could be drivers/gpu/drm/i915/intel_gvt_mmio_table.c.  The
> declarations could then go either into drivers/gpu/drm/i915/intel_gvt.h
> or drivers/gpu/drm/i915/intel_gvt_mmio_table.h.

Correct.

Generally I prefer to have the declarations for stuff in intel_foo.c to
be placed in intel_foo.h, and named intel_foo_*.


BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
