Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723AA59CA9C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 23:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbiHVVPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238048AbiHVVPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DBD13F17
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661202938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W99ikbboaJjO+6FHQ4eYoJSNppDNkQvI/eXvuOgjNJE=;
        b=gal/QNw0mfk889K9/IPoF6ACcfSDCXooDoJUFjj6CeR0PRBtmn3XYagUTo9XsQ2wym/1Ao
        wgdMrqKMU/YYO67YV189lUTpjNKrCRp+lsiQb+Gnf/NeJ74Z6BlX0iV/YgKMqOdPoHldPj
        UsmzGTU07ydvZONt6Gt0l0LiyiHhvFM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-297-G-xI4O7hOEeZEA5_E2AePw-1; Mon, 22 Aug 2022 17:15:37 -0400
X-MC-Unique: G-xI4O7hOEeZEA5_E2AePw-1
Received: by mail-qk1-f200.google.com with SMTP id u15-20020a05620a0c4f00b006b8b3f41303so10538763qki.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc;
        bh=W99ikbboaJjO+6FHQ4eYoJSNppDNkQvI/eXvuOgjNJE=;
        b=oVIa917od413yf1ZGH1yN+K3mapTEdg43CjK5azO0SDg67c+DuzH1VTd7zwuvIXV3B
         /jfvS06Cp5cnh92kTqoSd9Am/QnkaBQ7x6jp9KLAMR5LI5n5C+LYrEYyVSCWMMDaiaDz
         TvhwAHp6C0HGdaVzj7HoKrmHYEXWg0HnU2sCTPuzYIZigC3+6LjbYTdAwWNkBwFVzBhi
         c9GIS0dYHx64eq10Rz+QzOFJ80eG9w4G4GvhHzV9iOC1pZV2WTK86s5cAtXro6FrX1hC
         92EeVr4ovgQTg+vbB7I6TRqcRRTmQig6H3eHPCsWv+0OYHWHP7k00PcAOgQ9o646i0Dr
         6gMg==
X-Gm-Message-State: ACgBeo15kN3qw+ZHPz0Rn1j5RzW5Odpp/L+2wL4CreKXlZRYptBYxTt4
        FA8Xd1OpSDbb1pxuZN9A9zb4FYxR2Lmjvk2r1fyPVSnC0bHdBBrSP2HeDEXBuG2LoxcHSCBFvl6
        P86epPrBzAuRF2Hyt88lPEkHO
X-Received: by 2002:a05:622a:392:b0:343:738e:6f6b with SMTP id j18-20020a05622a039200b00343738e6f6bmr17200982qtx.174.1661202936871;
        Mon, 22 Aug 2022 14:15:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5EnIC47AD0HBg/p8AcS7SZGGBNwPKTx0oDmr3tOt7DoWa5vhMJb3HcnPkR2X3yyJinWb3S5A==
X-Received: by 2002:a05:622a:392:b0:343:738e:6f6b with SMTP id j18-20020a05622a039200b00343738e6f6bmr17200952qtx.174.1661202936595;
        Mon, 22 Aug 2022 14:15:36 -0700 (PDT)
Received: from [192.168.8.139] (pool-100-0-245-4.bstnma.fios.verizon.net. [100.0.245.4])
        by smtp.gmail.com with ESMTPSA id w25-20020a05620a0e9900b006b5bf5d45casm11352206qkm.27.2022.08.22.14.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 14:15:35 -0700 (PDT)
Message-ID: <26a6f44c4b2a24d01b23d692416bf3f73103410d.camel@redhat.com>
Subject: Re: [PATCH] nouveau: explicitly wait on the fence in
 nouveau_bo_move_m2mf
From:   Lyude Paul <lyude@redhat.com>
To:     Karol Herbst <kherbst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, stable@vger.kernel.org
Date:   Mon, 22 Aug 2022 17:15:34 -0400
In-Reply-To: <20220819200928.401416-1-kherbst@redhat.com>
References: <20220819200928.401416-1-kherbst@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Fri, 2022-08-19 at 22:09 +0200, Karol Herbst wrote:
> It is a bit unlcear to us why that's helping, but it does and unbreaks
> suspend/resume on a lot of GPUs without any known drawbacks.
> 
> Cc: stable@vger.kernel.org # v5.15+
> Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/156
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_bo.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
> index 35bb0bb3fe61..126b3c6e12f9 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
> @@ -822,6 +822,15 @@ nouveau_bo_move_m2mf(struct ttm_buffer_object *bo, int evict,
>  		if (ret == 0) {
>  			ret = nouveau_fence_new(chan, false, &fence);
>  			if (ret == 0) {
> +				/* TODO: figure out a better solution here
> +				 *
> +				 * wait on the fence here explicitly as going through
> +				 * ttm_bo_move_accel_cleanup somehow doesn't seem to do it.
> +				 *
> +				 * Without this the operation can timeout and we'll fallback to a
> +				 * software copy, which might take several minutes to finish.
> +				 */
> +				nouveau_fence_wait(fence, false, false);
>  				ret = ttm_bo_move_accel_cleanup(bo,
>  								&fence->base,
>  								evict, false,

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

