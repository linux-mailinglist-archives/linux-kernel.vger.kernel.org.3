Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3898D4D2F78
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiCIMxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbiCIMxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:53:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4231F177D06
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 04:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646830323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MVrNBje8P4Tjl99yqsqfstxvyHvyJTjfoJ0XzHjnkFs=;
        b=YBu+lGxlOvH8L+YVlsBFtbhqqZmvA084VweXW+9ABzUF5IPsBxegCC4S+rzl1qKAFRF1PH
        xXFOLRv1pcL1Brmys842q9LWK54JJTrXoc3D/gdmwusLEK3g+gLnrouMVX2Sg3aF9FK3cc
        MM0FJJoJjrxX+9VpRzfe35Vjm3arL/s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-EaH9-qWwPm-QnnD8FVsuzw-1; Wed, 09 Mar 2022 07:52:00 -0500
X-MC-Unique: EaH9-qWwPm-QnnD8FVsuzw-1
Received: by mail-wr1-f71.google.com with SMTP id m18-20020a5d4a12000000b00203731460e6so732657wrq.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 04:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MVrNBje8P4Tjl99yqsqfstxvyHvyJTjfoJ0XzHjnkFs=;
        b=8Bb2PyoQJcH6l8nz2AO0gYKns/CuObT29v7U111Zv/T2HPC7WpkKTgCNKmtcgYOuhX
         lfjhHjVKn6zLmfKrB74/La7vvjfCBR9jxKpDwev3Bxut8djTRfGFJvFnEfUB82NSBDWg
         ZudbURhBskSfF5Tp5OD1hHDCWKk5FGWeozIYIio1payyfykKs66xKzwrOnVODAT/GD7B
         5B/DvFrLE3AA127s58vxWMdJKt6gnoF2+XYWmO9LAljuvDwnGsA/fSavNQ8rR4HdlFCf
         SgnMYM/uii9LaDKO4KQyT1DXijMMyehvz7aODg+HcwAO7hURus0yxmTfHtY/ZFbQGDjh
         WoIQ==
X-Gm-Message-State: AOAM532G8h1ha7mHpE7WFmLJuLUDTS3hjaL+2fFEn6JGiyQ0amy+fK7V
        QzrDsEeDt72y3e6CkFmR44Qx+y09lu+fkRsXKjMo++FaHWviC30lAFoDLSepoUR+bWZxmq55U8U
        gnJGVz3XRBa6KvdMu5RVXWhj4
X-Received: by 2002:adf:8b9e:0:b0:1f0:25ca:6d81 with SMTP id o30-20020adf8b9e000000b001f025ca6d81mr15523231wra.247.1646830319032;
        Wed, 09 Mar 2022 04:51:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznCED2hDWfMPlEh09LTikM9n8nFo++5o/PkgFE4Sete3s/9brY/cGIrZsveiDmJHMiONU+4Q==
X-Received: by 2002:adf:8b9e:0:b0:1f0:25ca:6d81 with SMTP id o30-20020adf8b9e000000b001f025ca6d81mr15523208wra.247.1646830318754;
        Wed, 09 Mar 2022 04:51:58 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n2-20020a056000170200b001f1e16f3c53sm1643997wrc.51.2022.03.09.04.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 04:51:58 -0800 (PST)
Message-ID: <d7a8d183-fe2b-99b1-9730-eddb040f6d1e@redhat.com>
Date:   Wed, 9 Mar 2022 13:51:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 03/10] drm/client: Use actual bpp when allocating frame
 buffers
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
 <8f29a983d42d9d68bd8cae2f9481d3c139f8750a.1646683502.git.geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <8f29a983d42d9d68bd8cae2f9481d3c139f8750a.1646683502.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/22 21:52, Geert Uytterhoeven wrote:
> When allocating a frame buffer, the number of bits per pixel needed is
> derived from the deprecated drm_format_info.cpp[] field.  While this
> works for formats using less than 8 bits per pixel, it does lead to a
> large overallocation.
> 
> Reduce memory consumption by using the actual number of bits per pixel
> instead.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

