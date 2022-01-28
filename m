Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6574449F713
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243863AbiA1KSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:18:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39578 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347787AbiA1KRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:17:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6E88B8250F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 10:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B43C340E0;
        Fri, 28 Jan 2022 10:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643365069;
        bh=SHk7nsLZVBmrkzHaZ93gwIMjnBT1dr7eQOTPySNEeNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qA460ZBgv/rmRN3I7hCrX4M19ZMSUXuy18zfqE5oMnTvRI0GSUPyb5rqr1U0g+UHc
         g8/rHG4dnuH8GTUtqoqhQxV8r6BgzXQ6Xm72g4ucdFskh+06vAY2ihaBW7gNxoQL0Z
         NAWRgT1aTxRB5pMi0e3dYfpG9tU+Nq/cLApeq2TE=
Date:   Fri, 28 Jan 2022 11:17:41 +0100
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
        Lee Jones <lee.jones@linaro.org>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display/dc/calcs/dce_calcs: Fix a memleak in
 calculate_bandwidth()
Message-ID: <YfPCxX/iiDWUpWjY@kroah.com>
References: <20220124165552.56106-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124165552.56106-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 12:55:51AM +0800, Zhou Qingyang wrote:
> In calculate_bandwidth(), the tag free_sclk and free_yclk are reversed,
> which could lead to a memory leak of yclk.
> 
> Fix this bug by changing the location of free_sclk and free_yclk.
> 
> This bug was found by a static analyzer.
> 
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: 2be8989d0fc2 ("drm/amd/display/dc/calcs/dce_calcs: Move some large variables from the stack to the heap")
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
>  drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> index ff5bb152ef49..e6ef36de0825 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> @@ -2033,10 +2033,10 @@ static void calculate_bandwidth(
>  	kfree(surface_type);
>  free_tiling_mode:
>  	kfree(tiling_mode);
> -free_yclk:
> -	kfree(yclk);
>  free_sclk:
>  	kfree(sclk);
> +free_yclk:
> +	kfree(yclk);
>  }
>  
>  /*******************************************************************************
> -- 
> 2.25.1
> 

As stated before, umn.edu is still not allowed to contribute to the
Linux kernel.  Please work with your administration to resolve this
issue.

