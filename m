Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D92B463BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243985AbhK3QiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243996AbhK3QiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:38:20 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82CFC061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:34:59 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 137so18013958wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sVBcHRn6XhRgKrNxDSzVe9awm1/8zE1c8t30yxDxCRI=;
        b=xuygAaQuliB1uV19EACuXbaX++7P0zyTKkADKvsO9mZ/IF67E4vH6m5bvZemQbtNkV
         tFrsMqJ0PPZZMszPTYIHQ6nXCE9m57yedoz70VmOFjayWaKojQE48523Twth0GHTJg2g
         d59mvMnqcg38+it+wF88AQT06Js5rzGKzTdWu3VTxLUcf+2ja0zKW018c7QP/IJKu4qQ
         MfK3sKWFLY2SqQH8bre4XLDpP5QuSgfYPw/mG1pFiAa+44GOBnXwxgTOM4XGwbq8WzWZ
         c24i0XwJEwDo8oEsNvxPD4iN4WLYl0ujqawvzDZqjP1+ZBHTD3HNHL4UO5lnkv25CEC1
         Cohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sVBcHRn6XhRgKrNxDSzVe9awm1/8zE1c8t30yxDxCRI=;
        b=QbEMXu3fB2THKsDuqvdsqCszUBi2+2j1e88t46w2f+/izKLtR30bZbpnI/yXaBO3Qo
         RE8tHAuVF+Orf6I4ohSJXfXMzTBsDSLoct8YQZ44B8W0MhcVbCSrhdHkqExntA3TLP4n
         uz87iNPeAZK0AEWRW74nP+Qt6c3JJ/M+4SZKm6FWqEF6qpUyeGzo0k1TxbJwxGGE8Z00
         4VgRTXn4dXAnJMN3ZEbRn1rzpt7Sf2ueAKz+lkcWc4FKmNDvw9e0CxPeeJdzYdZdRsPg
         C/iHZK/EBL2ag1ZHPOZLox0oGTAcMq0IiMW+/daoH8e/2cRzRZnu7MV7zKwnhvthKwvI
         tIxg==
X-Gm-Message-State: AOAM532Q07/1pYnh4V3Y1LurUZ/d+jDK24Gq0qLmqGlV4fpZIsYPhEQR
        eAjOlR6krfx/EmJTQ7VYUg1GQQ==
X-Google-Smtp-Source: ABdhPJzbASU0G517H6mvwWDHq+lGU4Xu5RKHvfwThu92WEepEJHdfV8bfjSLIz+12Bm27Gl+YtBK1g==
X-Received: by 2002:a05:600c:3658:: with SMTP id y24mr546060wmq.161.1638290098124;
        Tue, 30 Nov 2021 08:34:58 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:f80b:b9bd:4d6e:b61a? ([2001:861:44c0:66c0:f80b:b9bd:4d6e:b61a])
        by smtp.gmail.com with ESMTPSA id n2sm2983591wmi.36.2021.11.30.08.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 08:34:57 -0800 (PST)
Subject: Re: [PATCH v7 0/9] drm/omap: Add virtual-planes support
To:     tomba@kernel.org
Cc:     linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
References: <20211117141928.771082-1-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <797a3b9a-be04-26ef-9d1a-e5283198ab15@baylibre.com>
Date:   Tue, 30 Nov 2021 17:34:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211117141928.771082-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

On 17/11/2021 15:19, Neil Armstrong wrote:
> This patchset is the follow-up the v4 patchset from Benoit Parrot at [1].
> 
> This patch series adds virtual-plane support to omapdrm driver to allow the use
> of display wider than 2048 pixels.
> 
> In order to do so we introduce the concept of hw_overlay which can then be
> dynamically allocated to a plane. When the requested output width exceed what
> be supported by one overlay a second is then allocated if possible to handle
> display wider then 2048.
> 
> This series replaces an earlier series which was DT based and using statically
> allocated resources.
> 
> This implementation is inspired from the work done in msm/disp/mdp5
> driver.
> 
> Changes since v6 at [3]:
> - Patch 1: Added comment for drm_atomic_helper_check_plane_state, added Reviewed-by
> - Patch 2: added Reviewed-by
> - Patch 3: added Reviewed-by
> - Patch 4: added Reviewed-by
> - Patch 5: added Reviewed-by
> - Patch 6: No changes
> - Patch 7: No changes
> - Patch 8: Reformatted omap_plane_atomic_print_state() output for overlays
> - Patch 9: Added a comment of the utility of the local omap_atomic_update_normalize_zpos() + atomic_print_state() reformat
> 
> Changes since v5 at [2]:
> - Patch 1: renamed width/height_fp to max_width/height
> - Patch 2: no changes
> - Patch 3: removed possible_crtcs stuff,
> 	added cleanup on failure to allocate,
> 	removed name in omap_plane struct & plane_id_to_name in omap_plane.c,
> 	switched all omap_plane->name to plane->name or omap_plane->id
> - Patch 4: aligned omap_plane_atomic_duplicate_state the the crtc style
> - Patch 5: removed glob_obj_lock & reformated global state declaration in omap_drv.h
> - Patch 6: moved drm_atomic_helper_check_plane_state() from atomic_check() in separate commit,
> 	removed zpos change, updated debug messages to be useful,
> 	renamed omap_overlay_disable() to omap_overlay_update_state(),
> 	added useful comments for omap_overlay_assign() & omap_overlay_update_state(),
> 	simplified omap_overlay_assign() & omap_overlay_update_state() for actual use-cases,
> 	refactored omap_plane_atomic_check() changes to be cleaner & simpler
> - Patch 7: no changes (except possible_crtcs print removal)
> - Patch 8: Reformated omap_plane_atomic_check() & omap_overlay_assign() changes to match previous patches layout 
> 
> Changes since v4 at [1]:
> - rebased on v5.15-rc2
> - adapted to drm_atomic_get_new/old_plane_state()
> - tested on Beagle-x15
> - checked for non-regression on Beagle-x15
> - removed unused "state" variable in omap_global_state
> 
> [1] https://lore.kernel.org/all/20181012201703.29065-1-bparrot@ti.com/
> [2] https://lore.kernel.org/all/20210923070701.145377-1-narmstrong@baylibre.com/
> [3] https://lore.kernel.org/all/20211018142842.2511200-1-narmstrong@baylibre.com
> 
> Benoit Parrot (8):
>   drm/omap: Add ability to check if requested plane modes can be
>     supported
>   drm/omap: Add ovl checking funcs to dispc_ops
>   drm/omap: introduce omap_hw_overlay
>   drm/omap: omap_plane: subclass drm_plane_state
>   drm/omap: Add global state as a private atomic object
>   drm/omap: dynamically assign hw overlays to planes
>   drm/omap: add plane_atomic_print_state support
>   drm/omap: Add a 'right overlay' to plane state
> 
> Neil Armstrong (1):
>   drm/omap: add sanity plane state check
> 
>  drivers/gpu/drm/omapdrm/Makefile       |   1 +
>  drivers/gpu/drm/omapdrm/dss/dispc.c    |  31 ++-
>  drivers/gpu/drm/omapdrm/dss/dss.h      |   5 +
>  drivers/gpu/drm/omapdrm/omap_drv.c     | 196 +++++++++++++-
>  drivers/gpu/drm/omapdrm/omap_drv.h     |  24 ++
>  drivers/gpu/drm/omapdrm/omap_fb.c      |  33 ++-
>  drivers/gpu/drm/omapdrm/omap_fb.h      |   4 +-
>  drivers/gpu/drm/omapdrm/omap_overlay.c | 212 +++++++++++++++
>  drivers/gpu/drm/omapdrm/omap_overlay.h |  35 +++
>  drivers/gpu/drm/omapdrm/omap_plane.c   | 349 +++++++++++++++++++++----
>  drivers/gpu/drm/omapdrm/omap_plane.h   |   1 +
>  11 files changed, 832 insertions(+), 59 deletions(-)
>  create mode 100644 drivers/gpu/drm/omapdrm/omap_overlay.c
>  create mode 100644 drivers/gpu/drm/omapdrm/omap_overlay.h
> 
> 
> base-commit: 49c39ec4670a8f045729e3717af2e1a74caf89a5
> 


Gentle ping,

Neil
