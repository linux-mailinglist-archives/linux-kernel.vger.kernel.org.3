Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6132C4FC1F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348034AbiDKQND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiDKQMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:12:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF9C3C49C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649693361; x=1681229361;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=y1V561DsC8ai3Gqb7cZYWzHmr8pZatljnnPprOuneD4=;
  b=V80Gsx1AEANgsH35tEjhZ2QRDjrlTs1n7PBd5hu3We33pG6nZLj7diAK
   8nprzLfJaClDgfNvRNNUWVWaXYJzFhyZj+e+I9aAIliMjO+uv4MJqExPu
   OLPsm19YKs8qhgfazZy1SwG8NNazKqJvIJVmYXvlTqhk5abgPpKG9kMg/
   wT/U10+pgxsmpFJAIkwLaSKVzWEks1kw4Qp3l6hVidAN3IY0Fa3jWcMX+
   DrIzwmV7MhU9r+BFyjcefJqn41Qy1NBT2G6GtDq8RtWQlRWsQBYthyFLJ
   2hbPwd6g2LizjGLBP4fPQECMzdV8YDUXJnmSq1n90YpuY5GUEHmzQRXQ7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="259748514"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="259748514"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 09:09:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="572274334"
Received: from lwit-desk1.ger.corp.intel.com (HELO localhost) ([10.249.143.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 09:09:15 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/34] drm/i915/gvt: don't override the include path
In-Reply-To: <20220411141403.86980-5-hch@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220411141403.86980-1-hch@lst.de>
 <20220411141403.86980-5-hch@lst.de>
Date:   Mon, 11 Apr 2022 19:09:12 +0300
Message-ID: <8735ijiouv.fsf@intel.com>
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

On Mon, 11 Apr 2022, Christoph Hellwig <hch@lst.de> wrote:
> drivers/gpu/drm/i915/gvt/Makefile is included
> from drivers/gpu/drm/i915/Makefile and thus inherits the normal include
> path relative to drivers/gpu/drm/i915/.  Fix up the gvt-specific trace
> header and just do away with the include path manipulation.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/i915/gvt/Makefile | 1 -
>  drivers/gpu/drm/i915/gvt/trace.h  | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt/Makefile
> index ea8324abc784a..4d70f4689479c 100644
> --- a/drivers/gpu/drm/i915/gvt/Makefile
> +++ b/drivers/gpu/drm/i915/gvt/Makefile
> @@ -5,5 +5,4 @@ GVT_SOURCE := gvt.o aperture_gm.o handlers.o vgpu.o trace_points.o firmware.o \
>  	execlist.o scheduler.o sched_policy.o mmio_context.o cmd_parser.o debugfs.o \
>  	fb_decoder.o dmabuf.o page_track.o
>  
> -ccflags-y				+= -I $(srctree)/$(src) -I $(srctree)/$(src)/$(GVT_DIR)/
>  i915-y					+= $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
> diff --git a/drivers/gpu/drm/i915/gvt/trace.h b/drivers/gpu/drm/i915/gvt/trace.h
> index 6d787750d279f..348f57f8301db 100644
> --- a/drivers/gpu/drm/i915/gvt/trace.h
> +++ b/drivers/gpu/drm/i915/gvt/trace.h
> @@ -379,5 +379,5 @@ TRACE_EVENT(render_mmio,
>  #undef TRACE_INCLUDE_PATH
>  #define TRACE_INCLUDE_PATH .
>  #undef TRACE_INCLUDE_FILE
> -#define TRACE_INCLUDE_FILE trace
> +#define TRACE_INCLUDE_FILE gvt/trace

This is not actually correct. Please see my gvt Makefile cleanup [1][2].

BR,
Jani.

[1] https://lore.kernel.org/all/20220331082127.432171-1-jani.nikula@intel.com/
[2] https://lore.kernel.org/all/20220331082127.432171-2-jani.nikula@intel.com/

>  #include <trace/define_trace.h>

-- 
Jani Nikula, Intel Open Source Graphics Center
