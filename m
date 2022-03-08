Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A084D123B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245503AbiCHI3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbiCHI3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:29:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADA23F30A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:28:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2710BB81686
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1B3C340EB;
        Tue,  8 Mar 2022 08:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646728122;
        bh=LmTt6qQQP0XkYMoZQar+hciBceY5wUpzOfDL2qp0/aM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ym3sMQo1fM9JBon0wFT7Wa73ahE9ARjcD6RcFSbFx3hvgRMcXBozrZ3thvNugBiW+
         4S959oBIjdUUQL2bTr+1EsVDvnF8BowDy7GX1InlAYCgUn0+MVqgeD5Q8xz2/RHhiF
         JisOY97woHkFCvsErLBE+NhYY4jlNN2CEJ9CgFtYi6FQADYVogFMezVyD8zrnpNvmo
         gONNPoQ3Wgii6+RraFfNKaBMKvMqRDktFbKUCcp9ZyVrDO06Sgm/eKEgaZytyyMayN
         3TQQAyoyuk25YCgCegLtMsQQ7CYyWTUfGGNQSftpdrpi5uTwRdoG7EEXvrjXRu0FaP
         m3NFlZclSdopQ==
Message-ID: <ef9575ab-d566-908f-9a45-291207316266@kernel.org>
Date:   Tue, 8 Mar 2022 10:28:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/omap: fix NULL but dereferenced coccicheck error
Content-Language: en-US
To:     Wan Jiabing <wanjiabing@vivo.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     kael_w@qq.com
References: <20220307095612.409090-1-wanjiabing@vivo.com>
From:   Tomi Valkeinen <tomba@kernel.org>
In-Reply-To: <20220307095612.409090-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/03/2022 11:56, Wan Jiabing wrote:
> Fix the following coccicheck warning:
> ./drivers/gpu/drm/omapdrm/omap_overlay.c:89:22-25: ERROR: r_ovl is NULL
> but dereferenced.
> 
> Here should be ovl->idx rather than r_ovl->idx.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>   drivers/gpu/drm/omapdrm/omap_overlay.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/omap_overlay.c b/drivers/gpu/drm/omapdrm/omap_overlay.c
> index 10730c9b2752..b0bc9ad2ef73 100644
> --- a/drivers/gpu/drm/omapdrm/omap_overlay.c
> +++ b/drivers/gpu/drm/omapdrm/omap_overlay.c
> @@ -86,7 +86,7 @@ int omap_overlay_assign(struct drm_atomic_state *s, struct drm_plane *plane,
>   		r_ovl = omap_plane_find_free_overlay(s->dev, overlay_map,
>   						     caps, fourcc);
>   		if (!r_ovl) {
> -			overlay_map[r_ovl->idx] = NULL;
> +			overlay_map[ovl->idx] = NULL;
>   			*overlay = NULL;
>   			return -ENOMEM;
>   		}

Thanks, I'll pick this up.

  Tomi
