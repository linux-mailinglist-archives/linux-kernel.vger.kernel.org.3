Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7237A471A65
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 14:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhLLNZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 08:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhLLNZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 08:25:39 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1025FC061714
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 05:25:39 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id i63so20173032lji.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 05:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ve598KfcQjMxrN8DF+2cp9+JVJ390WXc4dmmTe7HN5c=;
        b=WSF3+HDisDiQZ8snqo5VYAJMjQ6TsEhaBTf9cGpbPVJEhDcFlIqzko6Y9w4FOpfLPI
         a2IbhnUJP5wdzkMdJ6BuhWMjVf8QJ0dyJS0TpxAqke8i0kH7wqfNqE4scEBhI4ob3ub3
         y51OBOl5gYffizYK2frAmpWuSaSCizO9qv5UtWzLNKp3/YFTtWX1/r/P2UD2LyU6BwjG
         XEeqawPZiJDHhfIfXCeTA8reAJEEML2+TkibGcqqbv40GZiNeQbxP3GiHlsDpjzNE+xh
         0lAm0kHB9huo8Kw3yb6w6ASRzqamGJl+l+iOsoo7mj++MuyL5rPhzNNBcXONb4eeaMmG
         qkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ve598KfcQjMxrN8DF+2cp9+JVJ390WXc4dmmTe7HN5c=;
        b=o/lyqqnK7GzxtCnUlDWCTFL271lQ/F3k2pinltSb4zro23Nbgu0C0utOJd78wT4v/A
         ndOMh6li3VHgFPhrJfd3xt/gzjqCb7Cly8yXVHe1scAfJHDnsvFUZvKMuP4jINi6s4Xk
         FY3bSKktzpWlriLCTaakB2pccfqOWOLPSr54Bz7UQ0ojW9c9B9tRywHeO5fAcKCQ5wpJ
         q661JKY5fD6iYi1jQrOvR3OP3FoUYuLGucaa9P+NdXFMmuPBAisZFticrfNPALtQ2tsr
         ItKBxp4RWjV4VZkygn13cFt5bqfT6JJ9X6RTKODDUEFarlsfvsKi/OWsaRhIiBN9LYRL
         cRdg==
X-Gm-Message-State: AOAM532cybEHyuTZu7FNACTaQBB/HY8CUhXsrxILAklcV+p0rbzxzYbU
        XPM/i7qzZGzPDCnm4qkhvlw=
X-Google-Smtp-Source: ABdhPJxrAW+qcnMprjTjS7C6EU0UJV8c47Plc/QFwingZzCya+B1SR+noXjcPHs6Wxk/7N+p8qZ7cA==
X-Received: by 2002:a2e:894e:: with SMTP id b14mr23592116ljk.216.1639315537349;
        Sun, 12 Dec 2021 05:25:37 -0800 (PST)
Received: from rikard (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id x23sm1061671ljm.36.2021.12.12.05.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 05:25:36 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Sun, 12 Dec 2021 14:25:33 +0100
To:     "Wang, Zhi A" <zhi.a.wang@intel.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/9] drm/i915/gvt: Constify static structs
Message-ID: <YbX4TYifpiUJ4txx@rikard>
References: <20211204105527.15741-1-rikard.falkeborn@gmail.com>
 <d612055c-e433-4bd0-b819-82e866619b23@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d612055c-e433-4bd0-b819-82e866619b23@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 09:00:56AM +0000, Wang, Zhi A wrote:
> On 12/4/2021 12:55 PM, Rikard Falkeborn wrote:
> > Constify a number of static structs that are never modified to allow the
> > compiler to put them in read-only memory. In order to do this, constify a
> > number of local variables and pointers in structs.
> >
> > This is most important for structs that contain function pointers, and
> > the patches for those structs are placed first in the series.
> >
> > Rikard Falkeborn (9):
> >    drm/i915/gvt: Constify intel_gvt_gtt_pte_ops
> >    drm/i915/gvt: Constify intel_gvt_gtt_pte_ops
> >    drm/i915/gvt: Constify intel_gvt_irq_ops
> >    drm/i915/gvt: Constify intel_gvt_sched_policy_ops
> >    drm/i915/gvt: Constify gvt_mmio_block
> >    drm/i915/gvt: Constify cmd_interrupt_events
> >    drm/i915/gvt: Constify formats
> >    drm/i915/gvt: Constify gtt_type_table_entry
> >    drm/i915/gvt: Constify vgpu_types
> >
> >   drivers/gpu/drm/i915/gvt/cmd_parser.c   |  2 +-
> >   drivers/gpu/drm/i915/gvt/fb_decoder.c   | 24 ++++-----
> >   drivers/gpu/drm/i915/gvt/gtt.c          | 68 ++++++++++++-------------
> >   drivers/gpu/drm/i915/gvt/gtt.h          |  4 +-
> >   drivers/gpu/drm/i915/gvt/gvt.h          |  2 +-
> >   drivers/gpu/drm/i915/gvt/handlers.c     | 12 ++---
> >   drivers/gpu/drm/i915/gvt/interrupt.c    | 10 ++--
> >   drivers/gpu/drm/i915/gvt/interrupt.h    |  2 +-
> >   drivers/gpu/drm/i915/gvt/sched_policy.c |  2 +-
> >   drivers/gpu/drm/i915/gvt/scheduler.h    |  2 +-
> >   drivers/gpu/drm/i915/gvt/vgpu.c         |  4 +-
> >   11 files changed, 66 insertions(+), 66 deletions(-)
> >
> Thanks so much for the contribuition. You only need to refine the PATCH 
> 2 a little bit and re-send it.
> 

Thanks for reviewing. Just to clarify, did you mean patch 7 (since
that's the one you commented on)? And is it enough to send just that
patch or do you want the entire series resent?

Rikard
