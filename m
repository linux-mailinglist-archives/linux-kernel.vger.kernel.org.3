Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9134E68A8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352646AbiCXS3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350493AbiCXS3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:29:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1C8CD1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:28:02 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a17so6612981edm.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ygG+HH337q5v9sz6PqzrvY4iKgWE93C7S5i0O4f63g=;
        b=oc8kTVbhwa6wJC/gXWdCu77hRiGAU4REtV7s9DWb3cpLca+yc8cuMzLzxSzy+v+GxU
         U3bM2+ZjbgoFLF18bj3GlU9iSeUSayVsnczoCwX0VDcahl/YjTIEt0PxQsL03TSeC6Up
         FabZWtlpAud5LOAXBRyg7zWRZcO2ow0PkmLss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ygG+HH337q5v9sz6PqzrvY4iKgWE93C7S5i0O4f63g=;
        b=eGRvooFIhFz3FtF4HeszBL0JgIhuXSs4++Q2j1r685aYGU7HNj7jC0I/NU0+3u/SoI
         ZSP3k++xL4DTOHY5dyFvkj49ZEU3L60vGQNpzvv9ZxUBuQLO/zkuFGJh17oe4VBD9R0x
         Ekc5p8ulKIAUSykp+mKS1fYxqdICbZVszndkxDaaFR8G3lQrD9dwu940/c/Q5GqdUUca
         9BdZKd4Zy6EOhKUMpPAjsvPpUrPAzfZugILAopQkLHDINCYBC6QpPK6fPPxmhnXaNZH1
         H7UT1UvqEMl2H9sxH/nlfBU8T61sYAPIl3g5RLk9SLigL11GOf3/gDFOSapz9uV6gC80
         48kg==
X-Gm-Message-State: AOAM530w4WRPOMGtUOc89hzBmLUY8WwYGW7dw/k68YRCO0UUI3FLjcRz
        PVKahrAC+7/9YWoGLX4W90XD+8KuXqdJYAzJ
X-Google-Smtp-Source: ABdhPJxp1IQOIjLmtuSVsRIzkIdncKtACNEJDCvVrMXBUqBa9opzus3NgLF8nOO0LhkkrVg9ulZppQ==
X-Received: by 2002:aa7:d156:0:b0:419:bc7:acd6 with SMTP id r22-20020aa7d156000000b004190bc7acd6mr8278825edo.239.1648146480652;
        Thu, 24 Mar 2022 11:28:00 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id js20-20020a17090797d400b006dfad24c5efsm1432429ejc.44.2022.03.24.11.27.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 11:27:59 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id p26-20020a05600c1d9a00b0038ccbff1951so1781229wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:27:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4f10:b0:38c:ae36:d305 with SMTP id
 l16-20020a05600c4f1000b0038cae36d305mr15523519wmq.34.1648146478374; Thu, 24
 Mar 2022 11:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220324111335.1.I1131d63cbefbfa9ff107a284e2e51f880c5bf7c8@changeid>
 <20220324111335.2.I816014b6c62da5a33af5021f3cc35cea66552c00@changeid>
In-Reply-To: <20220324111335.2.I816014b6c62da5a33af5021f3cc35cea66552c00@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 24 Mar 2022 11:27:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X_a9aU0ZvXg1AkGS5j1oKDJmPdZt0Hs22eEcWWczTe_A@mail.gmail.com>
Message-ID: <CAD=FV=X_a9aU0ZvXg1AkGS5j1oKDJmPdZt0Hs22eEcWWczTe_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel-edp: Add AUO B133UAN01
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 24, 2022 at 11:14 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Add support for the AUO B133UAN01 13.3" WUXGA panel.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> output of edid-decode:
>
>   Block 0, Base EDID:
>     EDID Structure Version & Revision: 1.4
>     Vendor & Product Identification:
>       Manufacturer: AUO
>       Model: 34196
>       Made in: 2020
>     Basic Display Parameters & Features:
>       Digital display
>       Bits per primary color channel: 8
>       DisplayPort interface
>       Maximum image size: 29 cm x 18 cm
>       Gamma: 2.20
>       Supported color formats: RGB 4:4:4
>       First detailed timing includes the native pixel format and preferred refresh rate
>     Color Characteristics:
>       Red  : 0.6513, 0.3271
>       Green: 0.2900, 0.6279
>       Blue : 0.1503, 0.0517
>       White: 0.3134, 0.3291
>     Established Timings I & II: none
>     Standard Timings: none
>     Detailed Timing Descriptors:
>       DTD 1:  1920x1200   60.026 Hz   8:5    74.192 kHz 156.100 MHz (286 mm x 178 mm)
>                    Hfront   16 Hsync  16 Hback 152 Hpol N
>                    Vfront    3 Vsync  14 Vback  19 Vpol N
>       Manufacturer-Specified Display Descriptor (0x0f): 00 0f 00 00 00 00 00 00 00 00 00 00 00 00 00 20 '............... '
>       Alphanumeric Data String: 'AUO'
>       Alphanumeric Data String: 'B133UAN01.0 '
>
>  drivers/gpu/drm/panel/panel-edp.c | 32 +++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

I can review this patch and it can be landed if you really need it,
but I'd prefer not to. Instead I'd rather see the panel added to
_just_ the "edp_panels" structure. That maps the panel ID to the
delays. If we do it that way:

1. We don't need the binding.

2. We don't need to hardcode the mode in this file.

3. We support second sourcing the panel.

4. We simplify our device tree files.


Let me know if we can just go that way. If we really have a reason to
support the old hardcoded mode we can land something like this but I'd
rather avoid it if possible.

Also: note that even if we land this, adding the entry to the
"edp_panels" structure would help future-proof us a bit.

-Doug
