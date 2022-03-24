Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52744E6A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 21:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349175AbiCXUzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 16:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354112AbiCXUzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 16:55:05 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AAB25EBC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:53:31 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x34so7010969ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFSr1woZwQXcWxiIeXMBTdkSmylSGPSvw4l7QhCcJdk=;
        b=UWOwijb6tG4M9q5CzVe8FLlKtNmcdWmo3x+k5WAD0Lt4E7cx8AILpBG8mEMI+DnmqR
         WL38ld57I7KlKmg/69QrQdqARexREhJnmXWz1eZsisBYV0TJxrVX+c7li7f8/tBXOD7O
         y54nz6+M26mmk6N5pwX7PTdnHSVcUN2rsLmQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFSr1woZwQXcWxiIeXMBTdkSmylSGPSvw4l7QhCcJdk=;
        b=ZWr1vORr+vWhPqTZrSMQFBEvPwvRDjADdJn75EyZqj6KSRZPIm8An0ihjbSmb3zLmn
         0190K5XIhg0kHoaO+sDGN8kMm6cjGdCu3Z16RdEbGzVt8DGWKcDnhQbpSA7AZQ7zwP6e
         +g6u9kPqopi58mvp5ePTpiWH79wPHaAgmfHmEnfIsCCc7L60VeSRC14d1qGLubBMJqVg
         WI6vCWoE5IanAa6NZJxdDYUcPfaUvisip2rncS9I6uP0Am69bgT3PHuetBo2wCgVUjol
         5WzGt06zq3C2tABZ9L0we+RcY/KAsVXICIokG48fV1++/SJWn1sRWm/BAsU36S6IkYSC
         IevQ==
X-Gm-Message-State: AOAM5328XsHdWGJ7wQCEoeglMdmemedfk68robxIwiAIVZ3xuUuTb/lE
        e/jhJJ8oJ4d+F+heOM1H+eD02X3eoC2kGMWq
X-Google-Smtp-Source: ABdhPJzFIWzmJ3a2EAikSOkaWI4rggIJUnzgCcvRuqjF4MgiqXoCXSrn+ltFbFtbx3lw+HGf8mDUOg==
X-Received: by 2002:a05:6402:51c6:b0:419:8269:f33d with SMTP id r6-20020a05640251c600b004198269f33dmr8853271edd.264.1648155210093;
        Thu, 24 Mar 2022 13:53:30 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id d1-20020a50fe81000000b004197f2ecdc2sm1875670edt.89.2022.03.24.13.53.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 13:53:28 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so3309619wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:53:28 -0700 (PDT)
X-Received: by 2002:a1c:7518:0:b0:37c:7eb:f255 with SMTP id
 o24-20020a1c7518000000b0037c07ebf255mr15649886wmc.29.1648155208026; Thu, 24
 Mar 2022 13:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220324111335.1.I1131d63cbefbfa9ff107a284e2e51f880c5bf7c8@changeid>
In-Reply-To: <20220324111335.1.I1131d63cbefbfa9ff107a284e2e51f880c5bf7c8@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 24 Mar 2022 13:53:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XG-JqqjcoAUoLWHjOyOSQMxD2vyXi9WVJNSaUawtvthg@mail.gmail.com>
Message-ID: <CAD=FV=XG-JqqjcoAUoLWHjOyOSQMxD2vyXi9WVJNSaUawtvthg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: simple: Add AUO B133UAN01 panel
To:     Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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
> Add binding for the AUO B133UAN01 panel. It is 13.3" TFT LCD panel
> with WUXGA (1920x1200) resolution.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 1eb9dd4f8f58..e5cd45c81d02 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -49,6 +49,8 @@ properties:
>        - auo,b133han05
>          # AU Optronics Corporation 13.3" FHD (1920x1080) color TFT-LCD panel
>        - auo,b133htn01
> +        # AU Optronics Corporation 13.3" WUXGA (1920x1200) color TFT-LCD panel
> +      - auo,b133uan01

Breadcrumbs to save Rob Herring from responding is that we're moving
to do this using the eDP autodetect feature instead of adding a new
compatible. v2 is at:

https://lore.kernel.org/r/20220324134819.v2.1.I816014b6c62da5a33af5021f3cc35cea66552c00@changeid/

-Doug
