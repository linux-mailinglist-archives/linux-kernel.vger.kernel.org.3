Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366C84D3020
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbiCINmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbiCINm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:42:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F273617B0E0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646833285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ssBZVyi4+h9kP2qv31uprsTOl0+0RRXY3OyMT9dWw3w=;
        b=Z5a4hrKsr2dPkMlgsGPgW1Kw8YljupKRlvlI0UeN3SHhGpstpwX624wjmLp06O+lXLKBk3
        Yab8j1fRVqbFWEM9Lx5shCgaSnavfz80rMFOwzpgsKh4+gJBl18B4dzDyNFCDSLM5H7G+e
        O4EHiTKYzn62g9LiNa+gjNNAgNi3hJg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-4BsrzUBxPqaAXz_8KgS_pQ-1; Wed, 09 Mar 2022 08:41:24 -0500
X-MC-Unique: 4BsrzUBxPqaAXz_8KgS_pQ-1
Received: by mail-wr1-f72.google.com with SMTP id p18-20020adfba92000000b001e8f7697cc7so768954wrg.20
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 05:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ssBZVyi4+h9kP2qv31uprsTOl0+0RRXY3OyMT9dWw3w=;
        b=hBPtpkstLmIpGH3npa7NGprr7Lxdwnoj4LQpv3UA+BShcJzKUqZYPw8wp4GzLjc9hT
         VX5RGZfAhmggszBn4b6uj32Q8o0DUI8hmkgtiX/bmb+tnPhcw5Sol6qY9ukO8iHLkkN6
         JwooUMCv1A+nAfG+mgQe61kpQ9KfU0lrhneuLvMomIOJ5GUJLCcvqSbQxj4PJGs/n6eZ
         wJbfwcP/7cw4jdXY0bGkGBJCppZBGZNhi81IdlqZN/MXjV+viJ0bd+TvibN0UiEqVlhr
         5N0rHH1o4YtRq2ho1VdrkLLu7uNKk9cKUyPrSc98kZkREF44YQfP1Dq8GpnZGNOGya/j
         cCCg==
X-Gm-Message-State: AOAM533ogY9lYbeV8RtoO4R0Uppm4iG5ztxhk8tWnY5hwTgezlrlvG0p
        CJ1k943hMGGyI+X0Zb2W7gjbQov30wV1jbGhGulyhBxfr4v5r6bUIG3vLWVgWuWN/5BSwf9wwYo
        T73DzWRztUiSpF09xaMICm19q
X-Received: by 2002:a5d:538b:0:b0:1f1:e60b:20c2 with SMTP id d11-20020a5d538b000000b001f1e60b20c2mr13695568wrv.294.1646833283586;
        Wed, 09 Mar 2022 05:41:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyES6IHb68vtll06LYWTE9X9Tv+reEFiMr6+v6lhyVKOWCvdsUheCN8hBAtdi7CCeUXh3nUHQ==
X-Received: by 2002:a5d:538b:0:b0:1f1:e60b:20c2 with SMTP id d11-20020a5d538b000000b001f1e60b20c2mr13695542wrv.294.1646833283309;
        Wed, 09 Mar 2022 05:41:23 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bl20-20020adfe254000000b001f1fa450a3asm2676460wrb.72.2022.03.09.05.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 05:41:22 -0800 (PST)
Message-ID: <09acb08a-7b96-69d0-2fb9-80381e234877@redhat.com>
Date:   Wed, 9 Mar 2022 14:41:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 RFC 10/10] drm/fourcc: Add DRM_FORMAT_D[1248]
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
 <e05254ba67598b3973010a7b6f31dd6b20a66844.1646683502.git.geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <e05254ba67598b3973010a7b6f31dd6b20a66844.1646683502.git.geert@linux-m68k.org>
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
> As Rn is light-on-dark, and Cn can be any colors, there are currently
> no fourcc codes to describe dark-on-light displays.
> 
> Introduce fourcc codes for a single-channel dark-on-light frame buffer
> format with two, four, sixteen, or 256 darkness levels.
> 
> As the number of bits per pixel may be less than eight, some of these
> formats rely on proper block handling for the calculation of bits per
> pixel and pitch.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

