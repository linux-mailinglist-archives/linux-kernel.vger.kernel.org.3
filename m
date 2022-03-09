Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDBD4D3012
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiCINkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiCINkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:40:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BFB64C7A6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646833172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hxJPMn5J6L7pDstxJt5mOgE1pVrNFlShCuIhtS3CI8s=;
        b=TFYWktsgqqwZ67O/n7tL3HSIba6ugwInPiRRLqe8sEJwa0liIWmYg2j+VbZXlrZuTEtJa+
        3JJNfOup+GJTgJ2fpoRliYWWZl0MJzphmR3FEAtipttZieBNlYHU3d1bxXcSmUqiKeeW9E
        ykANW/y7fSBWu6gs8umJnHY3DAVePhc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-m4PhONyXODGkfMrS_TCmiQ-1; Wed, 09 Mar 2022 08:39:30 -0500
X-MC-Unique: m4PhONyXODGkfMrS_TCmiQ-1
Received: by mail-wm1-f71.google.com with SMTP id z9-20020a7bc7c9000000b00389bd375677so977393wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 05:39:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hxJPMn5J6L7pDstxJt5mOgE1pVrNFlShCuIhtS3CI8s=;
        b=Xu+w0RYyO7GqXIP+Ljnya0z4wljYcw9OkhOrVvRby6ya1DJ+p3dGb20NUcqfN2mDWq
         egp8KmI3eVDaKduNJioRvDS7ltvE9Xu5YV6RPEDQDzPQl2h9OZJoX4uonawE+Df27t8F
         Ppq6Ao16RKW28/YXhWw69SZJ1FHCaj9GWD1/tiFDeHiOsV9MbAnjioZDuE43SBCzddos
         AxrvY0eCX4UpYJ2Ac/Bk1R8sQATVY3dRNdOlhEp8/LwLpFcl4mrlVbmM01GHZgW4vlXz
         5mbl+x3JIjJXbTsTY7qigrwKEc3FXQsxHhBdVwNlvMi3LINKpRvy/N6loCF29wr+uaLr
         kNFg==
X-Gm-Message-State: AOAM53052aweyHGtvMSgYXURU4iWt1uJ7lbEMWe13z2PJJEDpqiZnXBD
        mDCnIDep1seAWgzp2SgBcDYID1KtWittCxkD76cRblSToRtc4md/gNnieAPunt6SnK7yJvrJc1s
        frIaCVChyOm0YNbcXlFHJC2K4
X-Received: by 2002:a1c:6a01:0:b0:37f:1b18:6b17 with SMTP id f1-20020a1c6a01000000b0037f1b186b17mr7467014wmc.146.1646833169796;
        Wed, 09 Mar 2022 05:39:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUiXVqoM47oNz6ncRVRIq/E3m1+h7KnHuneTo0rnDdEN8qOnGhuo4BXntkJRz7KSBVfpVw1Q==
X-Received: by 2002:a1c:6a01:0:b0:37f:1b18:6b17 with SMTP id f1-20020a1c6a01000000b0037f1b186b17mr7466991wmc.146.1646833169595;
        Wed, 09 Mar 2022 05:39:29 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y10-20020adfee0a000000b001f0639001ffsm2618429wrn.9.2022.03.09.05.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 05:39:29 -0800 (PST)
Message-ID: <d1003594-dc26-23d4-a402-2951b3ed395d@redhat.com>
Date:   Wed, 9 Mar 2022 14:39:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 RFC 09/10] drm/fourcc: Add DRM_FORMAT_R[124]
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1646683502.git.geert@linux-m68k.org>
 <98c062f1b5c71427d5ba6c7bca706d04b1892162.1646683502.git.geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <98c062f1b5c71427d5ba6c7bca706d04b1892162.1646683502.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/22 21:52, Geert Uytterhoeven wrote:
> Introduce fourcc codes for single-channel light-on-dark frame buffer
> formats with two, four, and sixteen intensity levels.
> 
> As the number of bits per pixel is less than eight, these rely on proper
> block handling for the calculation of bits per pixel and pitch.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

IIRC the agreement was that it was worth to have both Cx and Rx fourcc
formats separately, so this patch makes sense to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

