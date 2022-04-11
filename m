Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64264FC1FD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244714AbiDKQOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348560AbiDKQOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:14:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F94331502
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649693490; x=1681229490;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=W1z6zKLM2c2LCFtJFuhaiwB43NVpO3XwYlP7KVT17K0=;
  b=Yn3rjt0NU+RL9X4ploLZZhy6orT4Qpo6IHGH74Zl+hryXldmAnbQgyWo
   seYC6LdVA/q/SpY+UDfETL5+A1emnU15rXCug6mvP5ZbL1SACvD7w0h7f
   bZxIZEcnRoDjyhffdPcZ+zm9PNaFJtVGNhXd8/k2kOMlI8YPk57VCeKnp
   TZoxBdY8RHEK8ZkLD9hdI8brCIHVEV7WwP4M3k6IszE20eKvogC06K5eX
   GO5fWT6yYHTAdfeCvLyOlyUzQGOca8xW7MeoZwZrySH3jiGfjJYPTuogL
   IC7PbxCdTOCLPV/wT5BZ2VRWqFzGv0prHVQD9rFU70Lk9tPJlAMvb1uP0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="262332117"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="262332117"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 09:11:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="551212099"
Received: from lwit-desk1.ger.corp.intel.com (HELO localhost) ([10.249.143.43])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 09:11:05 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/34] drm/i915/gvt: cleanup the Makefile
In-Reply-To: <20220411152508.GH2120790@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220411141403.86980-1-hch@lst.de>
 <20220411141403.86980-6-hch@lst.de> <20220411152508.GH2120790@nvidia.com>
Date:   Mon, 11 Apr 2022 19:11:03 +0300
Message-ID: <87zgkrha7c.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2022, Jason Gunthorpe <jgg@nvidia.com> wrote:
> On Mon, Apr 11, 2022 at 04:13:34PM +0200, Christoph Hellwig wrote:
>> Match the style of the main i915 Makefile in the gvt-specfic one and
>> remove the GVT_DIR and GVT_SOURCE variables.
>> 
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>  drivers/gpu/drm/i915/gvt/Makefile | 29 +++++++++++++++++++++++------
>>  1 file changed, 23 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt/Makefile
>> index 4d70f4689479c..f2f6ea02714ec 100644
>> +++ b/drivers/gpu/drm/i915/gvt/Makefile
>> @@ -1,8 +1,25 @@
>>  # SPDX-License-Identifier: GPL-2.0
>> -GVT_DIR := gvt
>> -GVT_SOURCE := gvt.o aperture_gm.o handlers.o vgpu.o trace_points.o firmware.o \
>> -	interrupt.o gtt.o cfg_space.o opregion.o mmio.o display.o edid.o \
>> -	execlist.o scheduler.o sched_policy.o mmio_context.o cmd_parser.o debugfs.o \
>> -	fb_decoder.o dmabuf.o page_track.o
>>  
>> -i915-y					+= $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
>> +i915-y += \
>> +	gvt/gvt.o \
>> +	gvt/aperture_gm.o \
>> +	gvt/handlers.o \
>> +	gvt/vgpu.o \
>> +	gvt/trace_points.o \
>> +	gvt/firmware.o \
>> +	gvt/interrupt.o \
>> +	gvt/gtt.o \
>> +	gvt/cfg_space.o \
>> +	gvt/opregion.o \
>> +	gvt/mmio.o \
>> +	gvt/display.o \
>> +	gvt/edid.o \
>> +	gvt/execlist.o \
>> +	gvt/scheduler.o \
>> +	gvt/sched_policy.o \
>> +	gvt/mmio_context.o \
>> +	gvt/cmd_parser.o \
>> +	gvt/debugfs.o \
>> +	gvt/fb_decoder.o \
>> +	gvt/dmabuf.o \
>> +	gvt/page_track.o
>
> Up to you but I usually sort these lists

Yeah, please do. Otherwise matches what I sent, so ack.

BR,
Jani.

>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>
> Jason

-- 
Jani Nikula, Intel Open Source Graphics Center
