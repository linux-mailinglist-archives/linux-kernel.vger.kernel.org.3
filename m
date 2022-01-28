Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C23649F717
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347773AbiA1KSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:18:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56774 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347258AbiA1KR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:17:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E423761E45
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 10:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D34C340EB;
        Fri, 28 Jan 2022 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643365075;
        bh=Wsd8ffzqUJJ+zDgbfdKPUsCAFuCJyeA7XLquQGZ1eDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXdeexPQNSOzFEyxuaoplfy9s0PsJnxDsh5nkqq/QfzRpqOuopR/lEVGwcJ8MU9Kg
         hlBOWTmCLX14ktV8V3GtW4Pqbh3Iyt2BKKOLOgeuFgm4PjqssSvR1jX4J2NYRKCecO
         jcrsYievae9koevYV18tk+4vLJ10l7QHhQQCH1zw=
Date:   Fri, 28 Jan 2022 11:17:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Jude Shih <shenshih@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Nikola Cornij <nikola.cornij@amd.com>,
        Wayne Lin <Wayne.Lin@amd.com>, Roman Li <Roman.Li@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: Fix a NULL pointer dereference in
 amdgpu_dm_connector_add_common_modes()
Message-ID: <YfPCyxqO5zQWv8Xn@kroah.com>
References: <20220124165732.56587-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124165732.56587-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 12:57:29AM +0800, Zhou Qingyang wrote:
> In amdgpu_dm_connector_add_common_modes(), amdgpu_dm_create_common_mode()
> is assigned to mode and is passed to drm_mode_probed_add() directly after
> that. drm_mode_probed_add() passes &mode->head to list_add_tail(), and
> there is a dereference of it in list_add_tail() without recoveries, which
> could lead to NULL pointer dereference on failure of
> amdgpu_dm_create_common_mode().
> 
> Fix this by adding a NULL check of mode.
> 
> This bug was found by a static analyzer.
> 
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: e7b07ceef2a6 ("drm/amd/display: Merge amdgpu_dm_types and amdgpu_dm")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
> The analysis employs differential checking to identify inconsistent 
> security operations (e.g., checks or kfrees) between two code paths 
> and confirms that the inconsistent operations are not recovered in the
> current function or the callers, so they constitute bugs. 
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7f9773f8dab6..9ad94186b146 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8143,6 +8143,9 @@ static void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
>  		mode = amdgpu_dm_create_common_mode(encoder,
>  				common_modes[i].name, common_modes[i].w,
>  				common_modes[i].h);
> +		if (!mode)
> +			continue;
> +
>  		drm_mode_probed_add(connector, mode);
>  		amdgpu_dm_connector->num_modes++;
>  	}
> -- 
> 2.25.1
> 

As stated before, umn.edu is still not allowed to contribute to the
Linux kernel.  Please work with your administration to resolve this
issue.

