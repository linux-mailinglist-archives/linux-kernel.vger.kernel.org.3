Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84056466033
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352867AbhLBJQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241170AbhLBJQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:16:41 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD09C06174A;
        Thu,  2 Dec 2021 01:13:19 -0800 (PST)
Received: from [192.168.1.111] (91-156-85-209.elisa-laajakaista.fi [91.156.85.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 507B22FD;
        Thu,  2 Dec 2021 10:13:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638436396;
        bh=tzJsDh0PPZKdq6o7K1b10saCi/GCGiVRY0/vySx5B+o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W+EZQEwdk7uVG3Ce8g0fb5qTNQBY2owueStf1g4tFKY5lEC2FnaEAL2YCSue2jNZD
         G5+KvoW/o213OUM/T3KMcIk6/Ofau/+SCFI814WGoJilRLd3rWPsOaBOdPdtBxt9yi
         4+H5XeTT8f0ick5yOgfekfiEWuTDzO9vrexawzEU=
Subject: Re: [PATCH v3] drm: omapdrm: Export correct scatterlist for TILER
 backed BOs
To:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc:     matthijsvanduin@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        merlijn@wizzup.org, philipp@uvos.xyz,
        laurent.pinchart@ideasonboard.com
References: <3e9307e5-1f03-9854-2b2b-859173e8f2ae@gmail.com>
 <1637309180-31032-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Message-ID: <56fc4b66-c7c6-586e-229d-6850d561c6f7@ideasonboard.com>
Date:   Thu, 2 Dec 2021 11:13:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1637309180-31032-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/11/2021 10:06, Ivaylo Dimitrov wrote:
> Memory of BOs backed by TILER is not contiguous, but omap_gem_map_dma_buf()
> exports it like it is. This leads to (possibly) invalid memory accesses if
> another device imports such a BO.
> 
> Fix that by providing sg that correctly describes TILER memory layout.
> Align TILER allocations to page, so importer to be able to correctly set
> its MMU if have one. Set export size accounting for the alignment. Also,
> make sure to destroy sg on unpin, as it is no longer valid.
> 
> Tested on Motorola Droid4 by using GPU (sgx540) to render.
> 
> Suggested-by: Matthijs van Duin <matthijsvanduin@gmail.com>
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>   drivers/gpu/drm/omapdrm/omap_gem.c        | 79 ++++++++++++++++++++++++++++++-
>   drivers/gpu/drm/omapdrm/omap_gem.h        |  2 +
>   drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c | 34 ++-----------
>   3 files changed, 85 insertions(+), 30 deletions(-)

I'll pick this to my work branch which I use every day, and let it be 
there for a few days. If I don't see any issues, I'll push to drm-misc-next.

  Tomi
