Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2C34FD9B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385496AbiDLIwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 04:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358873AbiDLHmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:42:17 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB0754684
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:19:30 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id p1so1027653qtq.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xyL71GiM2/e/dyyT/yEb4d7+EMuYsObEg/Dyt4eILbY=;
        b=nA8ctyPSPuri++x6vLOyXkOaUNHCq5IuA3AOqCwwYvw1EKGJmoff3VDiTszNIAuenV
         RIGW+Eoykzb9j4JKCzfDeHKKNwgaK1VADtJEdR4DvFjYmm9wRLhgkiXGYFNtt//+bMsR
         wraKmfKu3RrAGhrbYQif3lcRPzePO93vkB6uTiyb/lAMGAywFLf0rtNFrKYn2dA+pzQD
         Q/Vu4d7WPchEoaGpHxOjY9uvo3ezonyHS9P7InnvRj4L60F7Rvy8Eazhku2HUfP+Gvhz
         tk7Dm7UYd2D2Q+gaP3OLury/HM3Qs0D/GS1mklkwKbLansoIT7trDHCkGX5zWwcMHXE0
         GbuQ==
X-Gm-Message-State: AOAM533PXVWXuu21EWFFfCjvNb9yzOlp/IQVnCMVus5Lp2qcjF5nqlX8
        3rWjOklT+a+XHxmM5dwyAHPpbS6/8labRnR8
X-Google-Smtp-Source: ABdhPJzsNqE/7s5P5WQcyJTIhJP+YPMNpvbqmEyvVArXuaMbPqw4WeMGzflalKRIhnXDuFJJZB13Dw==
X-Received: by 2002:ac8:71c8:0:b0:2f0:58d6:80b6 with SMTP id i8-20020ac871c8000000b002f058d680b6mr1589827qtp.14.1649747969092;
        Tue, 12 Apr 2022 00:19:29 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id i4-20020a05620a074400b0069c1a39e0c3sm3472962qki.88.2022.04.12.00.19.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 00:19:28 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2edbd522c21so30681267b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:19:28 -0700 (PDT)
X-Received: by 2002:a81:c703:0:b0:2d0:cc6b:3092 with SMTP id
 m3-20020a81c703000000b002d0cc6b3092mr28862513ywi.449.1649747968233; Tue, 12
 Apr 2022 00:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220411211243.11121-1-javierm@redhat.com> <20220411211243.11121-4-javierm@redhat.com>
In-Reply-To: <20220411211243.11121-4-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Apr 2022 09:19:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWVZ2+YYkLUjCYLjCQx27AvMUPkwrUkTX52w0dyjVjOEg@mail.gmail.com>
Message-ID: <CAMuHMdWVZ2+YYkLUjCYLjCQx27AvMUPkwrUkTX52w0dyjVjOEg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] drm/solomon: Add ssd130x new compatible strings
 and deprecate old ones.
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
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

Hi Javier,

On Mon, Apr 11, 2022 at 11:12 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> The current compatible strings for SSD130x I2C controllers contain an "fb"
> and "-i2c" suffixes. These have been deprecated and more correct ones were
> added, that don't encode a subsystem or bus used to interface the devices.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> ---
>
> (no changes since v1)

That's not really true ;-)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
