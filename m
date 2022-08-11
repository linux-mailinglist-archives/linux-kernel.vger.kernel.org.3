Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F6758FEA0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbiHKOyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbiHKOya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:54:30 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16966F0B
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:54:30 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id i13so5776340qkm.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9BmF3Ji5gJTAQfOQyztWwt7GQUoCWmH9+aqwzCjq0dQ=;
        b=TQztfiRuGaGUPImsK40GDpnlDmv6mP5VjqPjFGfx1nVk30MIAaLM4d61LzLrNw0pkv
         /o8K0bA6c58TbJ9ilJ4iMgsAR0gUwkaetSEV1G9fU9nbtjDsvFg5hG1dGwQ8kHJg+t1W
         BEUSnCEQyw2PYFT1FulkvuBMS+j8iRFezRruug9h8tNrN/XCN6A0nJKvfvFGYuYD/Ggd
         3qbjByYqu67VCFM2QvR/RA4q1211o2C9r+3eV8C714UWBPmofazC+15y+Q1IMA9taihS
         cn+oASkhm4tMGmEGEQU2BwlMJ0U2slkdBthdBloRyBIZ4nxLWmN9KvLFiPal7LxYJ1uZ
         cZqg==
X-Gm-Message-State: ACgBeo3tUhxdosvMrFMsPKvijNXHTDCRI2nvRUzZbXvd9g+Ob4FqOfbS
        pSRp7PDJsc/GMgdOmb5SrHEOoWEQjOIFY984
X-Google-Smtp-Source: AA6agR70tU/vhPcpAxFozPXYPZgDX+wtc+sM+i/0XdxKl2UpCXut17igUviIED41fCqd6VNz0C8ZWw==
X-Received: by 2002:a05:620a:25c8:b0:6ae:bf82:8f36 with SMTP id y8-20020a05620a25c800b006aebf828f36mr25660615qko.354.1660229668779;
        Thu, 11 Aug 2022 07:54:28 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id o22-20020a05620a2a1600b006b62c252d07sm2208003qkp.76.2022.08.11.07.54.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 07:54:28 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-328303afa6eso174856897b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:54:27 -0700 (PDT)
X-Received: by 2002:a81:b049:0:b0:324:7408:94b with SMTP id
 x9-20020a81b049000000b003247408094bmr32604328ywk.283.1660229667766; Thu, 11
 Aug 2022 07:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220811144850.215377-1-strochuk@ispras.ru>
In-Reply-To: <20220811144850.215377-1-strochuk@ispras.ru>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Aug 2022 16:54:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXSnHJpy=27pkAfQC0v+tkpx7Q4Ze1=nvTmy+aMBeVPFg@mail.gmail.com>
Message-ID: <CAMuHMdXSnHJpy=27pkAfQC0v+tkpx7Q4Ze1=nvTmy+aMBeVPFg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/fb-helper: add virtual screen size check to drm_fb_helper_check_var()
To:     Andrey Strachuk <strochuk@ispras.ru>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org
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

Hi Andrey,

On Thu, Aug 11, 2022 at 4:49 PM Andrey Strachuk <strochuk@ispras.ru> wrote:
> Add virtual screen size check to drm_fb_helper_check_var() in
> order to validate userspace input.
>
> Found by Linux Verification Center (linuxtesting.org) with syzkaller.
>
> Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>

Thanks for the update!

> Fixes: 785b93ef8c30 ("drm/kms: move driver specific fb common code to helper functions (v2)")

I'd drop the Fixes tag completely, as the bug was present in the
intel and radeon drivers before. But probably it doesn't matter, as no one
is gonna backport this to v2.6.31 and earlier ;-)

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
