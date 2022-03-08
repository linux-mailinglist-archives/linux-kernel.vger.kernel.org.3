Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C49F4D1CB8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347898AbiCHQFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243540AbiCHQFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:05:44 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837544FC59
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:04:47 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 577761F445B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646755486;
        bh=hOiZ9ykiaBDPKQzbGHfm3j2FlBLb1AlaOgBoAKkcoPg=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=FBtBWn9E/pS7cuhC9BkGYA5+Me1Js9aqgIplk3YYC1XpdPiYgr4/OV47uPbqINlQ2
         ePGG2EkSTYr/as5sSE0KgnvoLJs8H4t9MOXFrE/VCAYlOewQaXfLrZVIC1xFnCmJ3H
         +eS+TT3G+Ntg7T7LQxZkgEghutet5hVU/muOQ7z7nU+03X0Lh7dpQNLqsjmXRbN7qq
         330vN5NO2lS2lsBQuKoaIc0ULCjmHKjrUQiLNgR0WLoopfs/3T4Rte7UH3uS9xJ2Sq
         GR/NFtcru+JD4/hatzxB+pmDr4oOWhoPoAQ1lN38owV+9Yj8AgmFi8/uWVZ0mXd5q7
         tsTT0/7BvMSVw==
Message-ID: <d9c0cdc7-9650-d9e3-e872-4bf22f0c4baa@collabora.com>
Date:   Tue, 8 Mar 2022 19:04:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 5/5] drm/virtio: Add memory shrinker
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        dri-devel@lists.freedesktop.org, Dmitry Osipenko <digetx@gmail.com>
References: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
 <20220308131725.60607-6-dmitry.osipenko@collabora.com>
In-Reply-To: <20220308131725.60607-6-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/8/22 16:17, Dmitry Osipenko wrote:
> @@ -246,20 +246,28 @@ static int virtio_gpu_plane_prepare_fb(struct drm_plane *plane,
>  	struct virtio_gpu_device *vgdev = dev->dev_private;
>  	struct virtio_gpu_framebuffer *vgfb;
>  	struct virtio_gpu_object *bo;
> +	int err;
>  
>  	if (!new_state->fb)
>  		return 0;
>  
>  	vgfb = to_virtio_gpu_framebuffer(new_state->fb);
>  	bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
> -	if (!bo || (plane->type == DRM_PLANE_TYPE_PRIMARY && !bo->guest_blob))
> +
> +	err = virtio_gpu_gem_pin(bo);
> +	if (err)
> +		return err;

I just noticed that this produces a refcount debug warning because I
missed to initialize the refcount when BO is created. That warning splat
was hidden by a huge lockdep splat produced by
drm_aperture_remove_conflicting_pci_framebuffers(), which probably
should be fixed. I'll correct it in v2.
