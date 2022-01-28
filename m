Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0718549F71B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243869AbiA1KSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347830AbiA1KSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:18:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08EDC061755
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 02:18:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9282C61E48
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 10:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5372EC340F4;
        Fri, 28 Jan 2022 10:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643365095;
        bh=K+Wnlf3fVErqV3HKWur25sPL5zJVCNS2YRoj6ofC3uU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2K5AAwMpNEB5WSDMIfE4CWnPMvSJM5Foa4dg6bQ2yBYvplO2/IPP6S3HMSzZK9cZQ
         fMqu/bVGPnH+1QVlxTGjbvhoZwAXxlwwUWhExKHC01M0hNV9GORJByqLt6mzzeVE9D
         NeJA0kga7NahzZmXXN5A/bnqTvhiYJSVeA/Dyu9I=
Date:   Fri, 28 Jan 2022 11:18:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau/acr: Fix undefined behavior in
 nvkm_acr_hsfw_load_bl()
Message-ID: <YfPC3N+H9Fu/gqpz@kroah.com>
References: <20220124165856.57022-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124165856.57022-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 12:58:55AM +0800, Zhou Qingyang wrote:
> In nvkm_acr_hsfw_load_bl(), the return value of kmalloc() is directly
> passed to memcpy(), which could lead to undefined behavior on failure
> of kmalloc().
> 
> Fix this bug by using kmemdup() instead of kmalloc()+memcpy().
> 
> This bug was found by a static analyzer.
> 
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: 22dcda45a3d1 ("drm/nouveau/acr: implement new subdev to replace "secure boot"")
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
>  drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> index 667fa016496e..a6ea89a5d51a 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> @@ -142,11 +142,12 @@ nvkm_acr_hsfw_load_bl(struct nvkm_acr *acr, const char *name, int ver,
>  
>  	hsfw->imem_size = desc->code_size;
>  	hsfw->imem_tag = desc->start_tag;
> -	hsfw->imem = kmalloc(desc->code_size, GFP_KERNEL);
> -	memcpy(hsfw->imem, data + desc->code_off, desc->code_size);
> -
> +	hsfw->imem = kmemdup(data + desc->code_off, desc->code_size, GFP_KERNEL);
>  	nvkm_firmware_put(fw);
> -	return 0;
> +	if (!hsfw->imem)
> +		return -ENOMEM;
> +	else
> +		return 0;
>  }
>  
>  int
> -- 
> 2.25.1
> 

As stated before, umn.edu is still not allowed to contribute to the
Linux kernel.  Please work with your administration to resolve this
issue.

