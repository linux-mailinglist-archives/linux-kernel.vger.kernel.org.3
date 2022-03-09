Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663D74D2F57
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiCIMsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbiCIMr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:47:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE80A177746
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 04:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646830017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oIOQIxDPG94ZGWbVYq8GHTXPCYDThRtLt2a1oXRhNkM=;
        b=D5xUlyYrmYGXf6TwNQoWW7R72XOtFSFFhNjQsGIaRzZsVvfq0T2iCAkwsA/mHkXHFmU7Nb
        qdFrBSl6AZF+SEMuwptUbJG8OJkNOAvksnIOHvgfdK6hEdtuO4czOS2fmOdAvI3gtIy+uQ
        koAvpmyAmcJbaDKhGokymo7EYoeOa6s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-tkXmgvMBNZqbmY_xdORR8A-1; Wed, 09 Mar 2022 07:46:55 -0500
X-MC-Unique: tkXmgvMBNZqbmY_xdORR8A-1
Received: by mail-wm1-f71.google.com with SMTP id k41-20020a05600c1ca900b00389a2b983efso753835wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 04:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oIOQIxDPG94ZGWbVYq8GHTXPCYDThRtLt2a1oXRhNkM=;
        b=133CY9++cxvotgBxQK7hNWyeCVAsrhigb0zn/Ffud3k980Ra6Re8dQaE6FyXsfFvWO
         scyS4Aoi0PQgOmDS91VrOXc/a5C/ZQuABtgOe/Vmp08Q45G+IuVatyp/A9FGbz1nvDf1
         3OcYFn4TCqhEPV1NZN9yyR2FXtyJvE3L0vej6D3NOqE6iYiAOzv6Mt5KT+gVZr5l+kHQ
         eftiocz5pM1+XUIQO/KyH4YXMiMbto4Y1ZzMaE0xK7T0sBvQmw4eT1Dj1eGg55yKFRRV
         toKphvzAy9SqwlMxNUgSsd6H3eq7Q3JUoN81W0+JizKcO9GrhIYl8nzR4LWguB40PE/f
         O6Pg==
X-Gm-Message-State: AOAM532NdcknDF8DXZ/BgtbzzdIP9zebzJuxMkqunATfMCuHHci7toAz
        kVfVQYq9vXy8cjv+pD9ZRdwjmXjZgcQ4zFW0BycBiraopd6xt+X/nfha6ep+zptYIYbPfcGVDWp
        YKEg1Jxl+Y9u/HjPm6br2wDeo
X-Received: by 2002:a5d:5986:0:b0:1f1:f971:f02 with SMTP id n6-20020a5d5986000000b001f1f9710f02mr10080745wri.578.1646830013678;
        Wed, 09 Mar 2022 04:46:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzYK8FPaxzfg7PUDh96l/6CFuHhsdjJQ1VHODD7GNxUOFUkDD6tWylERnxyi/EG6sZs8v7gEQ==
X-Received: by 2002:a5d:5986:0:b0:1f1:f971:f02 with SMTP id n6-20020a5d5986000000b001f1f9710f02mr10080724wri.578.1646830013470;
        Wed, 09 Mar 2022 04:46:53 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j7-20020a5d5647000000b0020372c969d9sm1673557wrw.29.2022.03.09.04.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 04:46:53 -0800 (PST)
Message-ID: <f6186885-5bcf-01a8-56f5-b87ad0b53e3e@redhat.com>
Date:   Wed, 9 Mar 2022 13:46:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 01/10] drm/fourcc: Add drm_format_info_bpp() helper
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
 <eab1fe866c0ffd4ac097e66ff48725dd39893105.1646683502.git.geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <eab1fe866c0ffd4ac097e66ff48725dd39893105.1646683502.git.geert@linux-m68k.org>
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

Hello Geert,

On 3/7/22 21:52, Geert Uytterhoeven wrote:
> Add a helper to retrieve the actual number of bits per pixel for a
> plane, taking into account the number of characters and pixels per
> block for tiled formats.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

