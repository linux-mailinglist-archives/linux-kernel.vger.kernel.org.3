Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15B8539FD7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349847AbiFAIvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349557AbiFAIvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C22345DE73
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654073469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HBHQYgVvAGQCOdoDn9ARukR15hBNns7Yswk58R28Ni4=;
        b=bAYf5CnuVZN+2DfB22clC0NFG3vxRYedfdpREoWxnlYdvAQz9gmQ5/lk6JlR+BqZNRkEdn
        ztgBwQ/VqqF9+oRj80PzvCvjfHKsJMgoafp4g2FOU00dHgPPtChTWP9ZxoXA/G2wbcvY14
        vYvLlWoo3YJcISn1Iv71ekkr/h1KBYw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-V39knXgdO3yVQkx6i6Mfww-1; Wed, 01 Jun 2022 04:51:09 -0400
X-MC-Unique: V39knXgdO3yVQkx6i6Mfww-1
Received: by mail-ed1-f71.google.com with SMTP id k7-20020aa7d8c7000000b0042dd4a5a393so793387eds.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HBHQYgVvAGQCOdoDn9ARukR15hBNns7Yswk58R28Ni4=;
        b=emkxmbBRl+JXNb2jNsurD68kPNTWeBjmTMENmO/gasoVHdxK95ZgqczP2mXtZu8EmQ
         R6D+wIm3CUX6VkxGc1OlTn5j7/rf30/6lRfTYZmGDJRiDMNj7dlqO97Pzvf7lBs8cV/f
         QDCCusAPh9DhjyCVIyGSjFoVPFpBMllULtwVdV4tkVfD0LJoPwoLgXc6wQfPqMw0hhEM
         /TF8Cf+Sxfx0KsO8BQvoHFYeNyFF5F35LaBNP+KtiJejK+q2C+76izKGTSAtxp6oileO
         6riqBAucTWYZ3uA/PEVz/zYHSDQAGW5dql02///mVHRi3KsPf8JxbZ/BwQlqMb+SEr2R
         hBXw==
X-Gm-Message-State: AOAM533+hTUl++JHR64hjrj6goQH3rAki/cMTwuY9gc0VLVKVplBAkfq
        lWI1AxmvXvhloU9OEFnXqwd5cOe209cu8SMYr8KNTe08hFtASZa8nTe0ugW8NaTZ+0JnnvwMuGP
        R48fwG742n7SKiP7BqGdknIke
X-Received: by 2002:a17:907:8a19:b0:6fe:e146:d107 with SMTP id sc25-20020a1709078a1900b006fee146d107mr41841300ejc.763.1654073467613;
        Wed, 01 Jun 2022 01:51:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxz8yVDyEKGplWHg06AJJJSo0c8yw6I0zgv0YRyM+Fjpk6u4VdWfLi5qC40pTYsTW3vPqqmA==
X-Received: by 2002:a17:907:8a19:b0:6fe:e146:d107 with SMTP id sc25-20020a1709078a1900b006fee146d107mr41841278ejc.763.1654073467428;
        Wed, 01 Jun 2022 01:51:07 -0700 (PDT)
Received: from [192.168.43.127] ([109.36.130.134])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906058c00b006fed787478asm444046ejn.92.2022.06.01.01.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 01:51:06 -0700 (PDT)
Message-ID: <6072f500-30fd-c0a4-29dc-4fde7072018a@redhat.com>
Date:   Wed, 1 Jun 2022 10:51:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/8] Add a panel API to return panel orientation
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220601081823.1038797-1-hsinyi@chromium.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220601081823.1038797-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/1/22 10:18, Hsin-Yi Wang wrote:
> Panels usually call drm_connector_set_panel_orientation(), which is
> later than drm/kms driver calling drm_dev_register(). This leads to a
> WARN()[1].
> 
> The orientation property is known earlier. For example, some panels
> parse the property through device tree during probe.
> 
> The series add a panel API drm_panel_get_orientation() for drm/kms
> drivers. The drivers can use the API to get panel's orientation, so they
> can call drm_connector_set_panel_orientation() before drm_dev_register().
> 
> Panel needs to implement .get_orientation callback to return the property.
> 
> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/20220530081910.3947168-2-hsinyi@chromium.org/

Thank you for implementing this.

Patches 1-7 look good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I've a few small remarks on patch 8, see my reply
to that patch.

Regards,

Hans


> 
> Hsin-Yi Wang (8):
>   drm/panel: Add an API drm_panel_get_orientation() to return panel
>     orientation
>   drm/panel: boe-tv101wum-nl6: Implement .get_orientation callback
>   drm/panel: panel-edp: Implement .get_orientation callback
>   drm/panel: lvds: Implement .get_orientation callback
>   drm/panel: panel-simple: Implement .get_orientation callback
>   drm/panel: ili9881c: Implement .get_orientation callback
>   drm/panel: elida-kd35t133: Implement .get_orientation callback
>   drm/mediatek: Config orientation property if panel provides it
> 
>  drivers/gpu/drm/drm_panel.c                    |  8 ++++++++
>  drivers/gpu/drm/mediatek/mtk_dsi.c             | 14 ++++++++++++++
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c |  8 ++++++++
>  drivers/gpu/drm/panel/panel-edp.c              |  8 ++++++++
>  drivers/gpu/drm/panel/panel-elida-kd35t133.c   |  8 ++++++++
>  drivers/gpu/drm/panel/panel-ilitek-ili9881c.c  |  8 ++++++++
>  drivers/gpu/drm/panel/panel-lvds.c             |  8 ++++++++
>  drivers/gpu/drm/panel/panel-simple.c           |  9 +++++++++
>  include/drm/drm_panel.h                        | 10 ++++++++++
>  9 files changed, 81 insertions(+)
> 

