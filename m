Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B265AA9ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbiIBI0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiIBI0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:26:03 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B5B57201
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:26:02 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id w19so1497242ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 01:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yZ7GI/H/npr8l+qVhno9QYWaE882wgaDO0sWPEtrVzI=;
        b=gBY8OG2XpP3vttfs1RSHEWup1a1iLXJ18Xy6iShnIE/HNIwJph+Hjv9vUaXz/axDCA
         iVd1PNmFNZKCy8mr44bY9s780B3kBdRpDdSAJLWzZqHmPPNv0MmgLE8FgQmGk6MeCYim
         eQbCsVHw1nBiOsX3PwmKhBjTPYGZVbKvKvCNCB/j2NGcUvVfUG4QtfkZm/n90RiUuuse
         +6ym92aIJpO96LxYalFyXhF3gMayHDtAM6TI9mvOcTspQlr/goaxcGLOxLzkGjyKhYiq
         8M4XEf/deUHsFxD1OItXh9OiVX+tlJIFa2OFbUvSmaoB/oipSXfs/TyVEQ1VFlQH8aM6
         HOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yZ7GI/H/npr8l+qVhno9QYWaE882wgaDO0sWPEtrVzI=;
        b=3WFVq33qqjLlfq86ZjQeyk6EBwi+wtewx0g6i1MTUnB4aE9rdq7NrnfOieb2z21eWU
         trgbQ7pnjaoQV+q05d+JZcZ0RCFbWBKCVw3h8OTDK3ZbN8iFedqdg6q+vr9GC829jqcg
         SBw92MGw81GwFNmOHG7L1GmkqBZlQjtm1I0PQUN+Xr+q5rbKKT8xazzMmvy9suAa+9mN
         8Wo07JaB41NzPGO6/3od7oMqXVpnQRGdLsW3OPt4GH/zx1XYAm3/DLjEgpNsr0jPRNwc
         iXqtsRcwjX7sy7fXOcZ2r4JenUa6v8ecCVLEJ1hM0+mD7D5MemtqInxcrQ7BJ4VKnhwf
         L4oA==
X-Gm-Message-State: ACgBeo1wRgU2KZVbRHDmc6BgPU7KFAeo7W/ya573gnuqOqK8EJOeMfrF
        3X7N4SBS9IXe7RzOfOq9hvcslihRFAJ17HbdZVQ=
X-Google-Smtp-Source: AA6agR6HICholv9FC7LpKeoDOUnCvQdkHZTOJxhZ4iQqo4eM6ddVDLKACblmrSS4Nk3c0VjJ0a6i03hsVPNs8Hjweq0=
X-Received: by 2002:a2e:9e48:0:b0:261:c713:37dd with SMTP id
 g8-20020a2e9e48000000b00261c71337ddmr10154143ljk.385.1662107160591; Fri, 02
 Sep 2022 01:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220806122636.43068-1-tomas.winkler@intel.com> <20220806122636.43068-15-tomas.winkler@intel.com>
In-Reply-To: <20220806122636.43068-15-tomas.winkler@intel.com>
From:   Matthew Auld <matthew.william.auld@gmail.com>
Date:   Fri, 2 Sep 2022 09:25:33 +0100
Message-ID: <CAM0jSHO7sDegQysvZgfOXf5B-h6oe7nmfHeuH+KMAmFtnM3d2w@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v7 14/15] drm/i915/gsc: allocate extended
 operational memory in LMEM
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Aug 2022 at 13:34, Tomas Winkler <tomas.winkler@intel.com> wrote:
>
> GSC requires more operational memory than available on chip.
> Reserve 4M of LMEM for GSC operation. The memory is provided to the
> GSC as struct resource to the auxiliary data of the child device.
>
> Cc: Alan Previn <alan.previn.teres.alexis@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
>  drivers/gpu/drm/i915/gt/intel_gsc.c | 91 ++++++++++++++++++++++++++---
>  drivers/gpu/drm/i915/gt/intel_gsc.h |  3 +
>  2 files changed, 87 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
> index e1040c8f2fd3..162bea57fbb5 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gsc.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
> @@ -7,6 +7,7 @@
>  #include <linux/mei_aux.h>
>  #include "i915_drv.h"
>  #include "i915_reg.h"
> +#include "gem/i915_gem_region.h"
>  #include "gt/intel_gsc.h"
>  #include "gt/intel_gt.h"
>
> @@ -36,12 +37,68 @@ static int gsc_irq_init(int irq)
>         return irq_set_chip_data(irq, NULL);
>  }
>
> +static int
> +gsc_ext_om_alloc(struct intel_gsc *gsc, struct intel_gsc_intf *intf, size_t size)
> +{
> +       struct intel_gt *gt = gsc_to_gt(gsc);
> +       struct drm_i915_gem_object *obj;
> +       void *vaddr;
> +       int err;
> +
> +       obj = i915_gem_object_create_lmem(gt->i915, size, I915_BO_ALLOC_CONTIGUOUS);
> +       if (IS_ERR(obj)) {
> +               drm_err(&gt->i915->drm, "Failed to allocate gsc memory\n");
> +               return PTR_ERR(obj);
> +       }
> +
> +       err = i915_gem_object_pin_pages_unlocked(obj);
> +       if (err) {
> +               drm_err(&gt->i915->drm, "Failed to pin pages for gsc memory\n");
> +               goto out_put;
> +       }
> +
> +       vaddr = i915_gem_object_pin_map_unlocked(obj, i915_coherent_map_type(gt->i915, obj, true));
> +       if (IS_ERR(vaddr)) {
> +               err = PTR_ERR(vaddr);
> +               drm_err(&gt->i915->drm, "Failed to map gsc memory\n");
> +               goto out_unpin;
> +       }
> +
> +       memset(vaddr, 0, obj->base.size);
> +
> +       i915_gem_object_unpin_map(obj);

I think this was mentioned before, here we should rather use:

create_lmem(gt->i915, size,
                      I915_BO_ALLOC_CONTIGUOUS |
                      I915_BO_ALLOC_CPU_CLEAR);

That way we don't need to manually map and clear it here. Instead when
first allocating the pages (like with pin_pages), the clear will be
done for you.
