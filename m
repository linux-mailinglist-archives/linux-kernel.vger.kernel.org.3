Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41374D2FCB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiCINR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiCINRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:17:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EE34172247
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646831785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9L4wXSzrzpGMIVEQW9rtUhalBtem2aX0icrd1WDGeA0=;
        b=TkP7KNWluANN8eo7El/ggpBqaotJA48FRSHZmko3g6GOdHCgSMV736ezgKTyOnocJ5UOCs
        5JjCpqvfvPfx57wQ3zYo2w1hgYXNxKXbCKdNcIrsq397ppfHI3fH38/CQv/dQdnnIfx8Qz
        fPdwgZjwK2+1j0o3/sOeA9SpUEx3tFw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-PjLKrLZ4N5G-NGiI0NRd0A-1; Wed, 09 Mar 2022 08:16:24 -0500
X-MC-Unique: PjLKrLZ4N5G-NGiI0NRd0A-1
Received: by mail-wm1-f72.google.com with SMTP id v125-20020a1cac83000000b0037e3d70e7e1so2586105wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 05:16:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9L4wXSzrzpGMIVEQW9rtUhalBtem2aX0icrd1WDGeA0=;
        b=Y5cn+n2Ptbd82yxGKDRhAD66r1PrF2FOGY4/Glmv+ggC0le0IEN4SnkFOGvNLKFpRz
         AQy5EG+ejGrWnjLWtVY4/m8Gu+lHeeTl/7kE7TAp9dfWaojbUrLkZ4nVfWkWdwTvN8Rc
         fn1TVZMZTNXpy2eHRzEishaiLpQRroOX+CZ1oT52TmSEQbDIQzlPrBo0Fl+Rnm6bC5yE
         jXDJ+m9ck/dZLd2V13YOiuSuzX+9DbOVKeB38VKx4ojDFHoGDP0CgEuDHXTh3fy+mO37
         2sECyEPOl2FgKjI/7O2A0m5dHleSvjzalBNKVQQ9dYcmNPBZb2Ut3qf8jvkt1Fz1GmHF
         g4CQ==
X-Gm-Message-State: AOAM531Sh7SAGFffVjflFKx2HV2xeLj+pqRUK787fieetcmfddbGogVI
        cmQnQXlKZ8syf/6om94EmHfpjoUYMeEcOxGKbQZstldpXuh/IC6WupEaoGTc5WGQZaCen38mwzi
        t5D1QxcdSQvMJjSDa3qLAlyJy
X-Received: by 2002:a1c:a4c6:0:b0:389:7269:5044 with SMTP id n189-20020a1ca4c6000000b0038972695044mr3162299wme.129.1646831782863;
        Wed, 09 Mar 2022 05:16:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLVGtK4mTCwqDFDUxuBL3MHtSqW+jHIdMFxcBe9+YpVz8cxRLKpK8ygkT8GVaau+FzvEgBlw==
X-Received: by 2002:a1c:a4c6:0:b0:389:7269:5044 with SMTP id n189-20020a1ca4c6000000b0038972695044mr3162281wme.129.1646831782620;
        Wed, 09 Mar 2022 05:16:22 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t184-20020a1c46c1000000b003814de297fcsm4964440wma.16.2022.03.09.05.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 05:16:19 -0800 (PST)
Message-ID: <d9d8b17a-26a2-3c34-7308-539d5b08454f@redhat.com>
Date:   Wed, 9 Mar 2022 14:16:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 RFC 07/10] drm/gem-fb-helper: Use actual bpp for size
 calculations
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
 <842ab0a286ff743b625277e655d9bef505b630c1.1646683502.git.geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <842ab0a286ff743b625277e655d9bef505b630c1.1646683502.git.geert@linux-m68k.org>
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
> The AFBC helpers derive the number of bits per pixel from the deprecated
> drm_format_info.cpp[] field, which does not take into account block
> sizes.
> 
> Fix this by using the actual number of bits per pixel instead.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> RFC, as this code path was untested.
>

Looks good to me but haven't tested either.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

