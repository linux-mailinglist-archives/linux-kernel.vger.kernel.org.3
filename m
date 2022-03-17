Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09764DC4F5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiCQLlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiCQLlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:41:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D7061E3E38
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647517202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S0GPDzZRGu9yOKrwYapaocFp6V53jwtR479N3pP5zYg=;
        b=OP8+KWPZrCOIacl3z4uPi9Hn9ozS6CbZSTOk19HPcWpbFk33G7jR98o/TFGt+UfOobhnr9
        bF06Gp0lm38FRZbsVBro3b7EvUfr+yg4ltrjy7W05OoJ6bXXfvWUmD1Gsy006K/Krd3nbw
        WCSG+5p2wIkoVGS7HqYQOhsZa6F1AEA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-Mtfvk6ZBMcikn4IfGhTu5w-1; Thu, 17 Mar 2022 07:40:00 -0400
X-MC-Unique: Mtfvk6ZBMcikn4IfGhTu5w-1
Received: by mail-wm1-f71.google.com with SMTP id q65-20020a1c4344000000b0038c7c65e120so327392wma.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S0GPDzZRGu9yOKrwYapaocFp6V53jwtR479N3pP5zYg=;
        b=qJoLl5ZWpe2KoKChPP+aHOWjFoTorHDSWtFgk1QvHbzkEllfPlHxu0b5xrVLYynakv
         4iTkqzWrF8J5zslSoU1e79jR89OL6EQxiLDw6H0iEN1+TuB2HrJQopW2UgIF0YJiZBuv
         XAAza+sXXes7IZjL2UblkzufRIyATpZJge5MGWqp2ZjqWPpw6hSHOmsxi6vXz7B3uNxq
         SK6vBneOAg8FY2enks447iMt7oBE78MWWtfObydN6f34Zd0nwTy/mcNwYxCIKZqwD/Cm
         FrKUkTy0p/BaSNYaspsst7MvFRrl/onlDJJPZDMVAttgVHCTBpTs2oDtosUgpyhdb1zN
         XiRw==
X-Gm-Message-State: AOAM532P86gV3e4Dw2UTqb0WdYn3SOoAAk2GulJiuYgxrKZuRc6YzXTF
        Xgpmq+LG9dlvBxbFgKl1zlVZCQy3D8WXCPCjdPSxkRTAbDEojgeNTa+9/d6cy/FcTnwcJGhcp2l
        a1wD3PCRkG1v9TvceKvT+Vs/2
X-Received: by 2002:a5d:4f12:0:b0:203:f0cc:da04 with SMTP id c18-20020a5d4f12000000b00203f0ccda04mr563363wru.248.1647517199314;
        Thu, 17 Mar 2022 04:39:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJQe+TzlCkwrcKAsgJu9Uxvo9kmJPknXmxL33nxErHnUYSKMO7U0NlsOT7yuGusesX59ASrA==
X-Received: by 2002:a5d:4f12:0:b0:203:f0cc:da04 with SMTP id c18-20020a5d4f12000000b00203f0ccda04mr563342wru.248.1647517199097;
        Thu, 17 Mar 2022 04:39:59 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m185-20020a1ca3c2000000b0038c836a5c13sm224338wme.20.2022.03.17.04.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 04:39:58 -0700 (PDT)
Message-ID: <f94c0f44-36f1-e1a9-5963-5da0bafb8c90@redhat.com>
Date:   Thu, 17 Mar 2022 12:39:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/5] drm: Fix monochrome conversion for sdd130x
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
References: <20220317081830.1211400-1-geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220317081830.1211400-1-geert@linux-m68k.org>
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

On 3/17/22 09:18, Geert Uytterhoeven wrote:
>         Hi all,
> 
> This patch series contains fixes and improvements for the XRGB888 to
> monochrome conversion in the DRM core, and for its users.
> 
> This has been tested on an Adafruit FeatherWing 128x32 OLED, connected
> to an OrangeCrab ECP5 FPGA board running a 64 MHz VexRiscv RISC-V
> softcore, using a text console with 4x6, 7x14 and 8x8 fonts.
> 
> Thanks!
> 
> Geert Uytterhoeven (5):
>   drm/format-helper: Rename drm_fb_xrgb8888_to_mono_reversed()
>   drm/format-helper: Fix XRGB888 to monochrome conversion
>   drm/ssd130x: Fix rectangle updates
>   drm/ssd130x: Reduce temporary buffer sizes
>   drm/repaper: Reduce temporary buffer size in repaper_fb_dirty()
>

Thanks for re-spinning this series and again for fixing my bugs!

I pushed patches 1-4 to drm-misc (drm-misc-next) but left patch 5 since
would like to give Noralf the opportunity to review/test before pushing.

By the way, you should probably request commit access to the drm-misc tree:

https://drm.pages.freedesktop.org/maintainer-tools/commit-access.html

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

