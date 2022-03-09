Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33A64D2F84
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbiCIM5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiCIM5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:57:15 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA8F160410
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 04:56:16 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id eq14so1863782qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 04:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jFrfJh+TZgGP0j9p3hA56GCX/bbYQBH+vvzpdAJjq0g=;
        b=w7VWQuKooiUHnffdYK6QYyTjBAnSYz6GAkfdvas2LQtuzEXbExSblgzkNg2qiy0/YG
         7uHmHiMU6ZdspMudKtkBYQv3VxWfZdsQGYwGwCT9B790u14eS982qpK+2u2xOB1Xo6RC
         iHRIQzhvUUV0GQfI/WD9TR6tq1ziBA8/gNnG0qC3fqMuIG5PtJ45ZSjxdOT94XMg86vu
         +2uThA2y0jLw/V6yQJtH37GriDqZkQz0Llz9eI3QQ+y8ULsQv6H+axp3MVrVFx/hy0ZV
         yk5UCJsbeXNAftxwSMH3aNIuclshYWOzqU59ybqzYRDfSikyYDgkZs8ASnxNwXpuewUq
         oQ0w==
X-Gm-Message-State: AOAM5319/Hyr/kK024ZoRVrJ8YB9TMJ/65+zeEvN/SDwOMPxn3Z3Qwom
        4K8m+hzSWYOTJt6LfB2Zj6AfU/k05i0xnQ==
X-Google-Smtp-Source: ABdhPJz+qx7giHxK9Bjzp1VzbYrNBrnSRVcW0ArdY2YoEpFtHThTOzKAyJvSxQKu//tqXv9cTMtpsg==
X-Received: by 2002:ad4:5fc5:0:b0:435:4420:d056 with SMTP id jq5-20020ad45fc5000000b004354420d056mr15595328qvb.130.1646830575358;
        Wed, 09 Mar 2022 04:56:15 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id x5-20020ae9e645000000b0067b122fae88sm893007qkl.2.2022.03.09.04.56.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 04:56:14 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id z30so4168230ybi.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 04:56:14 -0800 (PST)
X-Received: by 2002:a25:dc4:0:b0:629:2337:f9ea with SMTP id
 187-20020a250dc4000000b006292337f9eamr14501488ybn.6.1646830574485; Wed, 09
 Mar 2022 04:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20220308160758.26060-1-wens@kernel.org>
In-Reply-To: <20220308160758.26060-1-wens@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Mar 2022 13:56:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWuWFhs5-ezh_UriPzWsZt02A2AJOTJMiszGpu_3hoqfw@mail.gmail.com>
Message-ID: <CAMuHMdWuWFhs5-ezh_UriPzWsZt02A2AJOTJMiszGpu_3hoqfw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: ssd130x: Fix COM scan direction register mask
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 2:57 AM Chen-Yu Tsai <wens@kernel.org> wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> The SSD130x's command to toggle COM scan direction uses bit 3 and only
> bit 3 to set the direction of the scanout. The driver has an incorrect
> GENMASK(3, 2), causing the setting to be set on bit 2, rendering it
> ineffective.
>
> Fix the mask to only bit 3, so that the requested setting is applied
> correctly.
>
> Fixes: a61732e80867 ("drm: Add driver for Solomon SSD130x OLED displays")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Thanks, this fixes the vertically-mirrored display on my Adafruit
FeatherWing 128x32 OLED.
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
