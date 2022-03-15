Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E524D9AC9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348124AbiCOMBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348123AbiCOMBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC5ED52E10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647345601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EfHwLZ6WtwFkxJceJihq9t4icqNtwFmMvMop7qIav68=;
        b=bXv6wqA4rVgQgqFNdGVTdjaIc0mh7ZJWPaH5C/AqXuTMszh3TnITsn6iAKZh/qqntBcbE0
        tP+RebvngWIz7/Te1LwT00ZP93Q9EJUd+hkL36UhE+TvPvel8S7B/eOoHPgu8CnuFtnmfr
        TD7dI8J1yhYvTczs4HDdLzdC+OCt7Mc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-x4uekkyNNX-NgR5n81u8Eg-1; Tue, 15 Mar 2022 07:59:59 -0400
X-MC-Unique: x4uekkyNNX-NgR5n81u8Eg-1
Received: by mail-wm1-f72.google.com with SMTP id l1-20020a1c2501000000b00389c7b9254cso829965wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EfHwLZ6WtwFkxJceJihq9t4icqNtwFmMvMop7qIav68=;
        b=e8w+w61HmVsm9LewuV6pywxyHISM4iitlhne4utKDYb05z+QGclf0tmFsPETCPUs8U
         Q/clxV7krersb76P4kPFdDhVJqNMFzgcNDB1RGlWcpaX0sl2U5ZGzGmzdh7rnuu9FeIm
         xknNNvu1rZIZmXzmRoo0SCiFRDXR+05y76cHfoSvIgw9ozgYoCee3xgqC/DjKL1UiFbF
         JHXLuW9niAoXMHInR8KIUxPT9xs4S5A8wgNLQWJjvAYdiDak8oauJpYOlhROmVo/otdv
         rr8BhJL4mDLHMbw7UItlqsnHW2UNibU/LaqtqYCgvZld6CGR1ZyW1C3rl9XaST4DKyfD
         IJiQ==
X-Gm-Message-State: AOAM531u5+ry/RKlQaE1WEzkxVjQvGRqWON+vmzFhhMk0N87EX3WbHeZ
        mCd006iUpsQwMk3HN/oD1jh1ECrUvT81lAnPfer79otIMTzrYyzYfCSZOSR3K9yTKZPB7NyDbqP
        qOE8ZHIWmxDNQ5uWZnT8Ltoic
X-Received: by 2002:adf:f18f:0:b0:1f0:761:491d with SMTP id h15-20020adff18f000000b001f00761491dmr19493106wro.505.1647345597811;
        Tue, 15 Mar 2022 04:59:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3q7Jx4Hf6PlL7mAci9EOXtUzatt6VVmdN2f4A2ddwH+xm8/PGXivwu6Wk/5IPV5J/w+aB6Q==
X-Received: by 2002:adf:f18f:0:b0:1f0:761:491d with SMTP id h15-20020adff18f000000b001f00761491dmr19493097wro.505.1647345597567;
        Tue, 15 Mar 2022 04:59:57 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i8-20020a1c5408000000b00389bf11ba0csm2079941wmb.38.2022.03.15.04.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 04:59:57 -0700 (PDT)
Message-ID: <8d672df4-0078-2777-bde7-89f65b1e60c0@redhat.com>
Date:   Tue, 15 Mar 2022 12:59:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/5] drm/format-helper: Rename
 drm_fb_xrgb8888_to_mono_reversed()
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220315110707.628166-1-geert@linux-m68k.org>
 <20220315110707.628166-2-geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220315110707.628166-2-geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

Thanks for your patch.

On 3/15/22 12:07, Geert Uytterhoeven wrote:
> There is no "reversed" handling in drm_fb_xrgb8888_to_mono_reversed():
> the function just converts from color to grayscale, and reduces the
> number of grayscale levels from 256 to 2 (i.e. brightness 0-127 is
> mapped to 0, 128-255 to 1).  All "reversed" handling is done in the
> repaper driver, where this function originated.
> 
> Hence make this clear by renaming drm_fb_xrgb8888_to_mono_reversed() to
> drm_fb_xrgb8888_to_mono(), and documenting the black/white pixel
> mapping.
> 
> Fixes: bcf8b616deb87941 ("drm/format-helper: Add drm_fb_xrgb8888_to_mono_reversed()")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
As you mentioned the function originally came from the repaper driver
(that uses white-on-black) and I wrongly assumed that the destination
buffer for the OLED panels were also monochrome reversed.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

