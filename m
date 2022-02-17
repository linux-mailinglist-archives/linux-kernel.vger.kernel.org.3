Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D1F4BA701
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243668AbiBQRV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:21:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbiBQRVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:21:55 -0500
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2F165F5;
        Thu, 17 Feb 2022 09:21:39 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id e5so7022531vsg.12;
        Thu, 17 Feb 2022 09:21:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mDJqoFZz0dz3Q1I37x7okE1Q7HMXJStYbJXkk2d13x4=;
        b=seO/xDPaXkxZDHFacKoggtganAFkKTlND89OCWoNcZ99Zl7b7OYzhQ+LEvjgtQoXC8
         Hd4qBYJfoFZgdDXoBxq3aE4A8io9V641O9HCdqlT3I4nlkksAgw/oqO1UttUyhgzUhOD
         QaMMx9jKU51LpxynYgCXimtkICxc8A+ril3ZOUx/pjkBhX5Pfynu/WD/PjN2IBacYsg+
         rACC7GbOaadZ05AvBGL8i708VlSk5zmxwo7dA0TkgV7rmNkfoqP/nFMnGChmiuo9j4Lz
         gNvibh6azwHf+f8DZ3ArheIRFzTtOUgzMnBJ3+7VGkjPLSa+0mj2fcyWCODKVS4cRTqj
         mgzg==
X-Gm-Message-State: AOAM531MuN0DgkFAdEE2+9K0jLrI5tk9duD9AVHqDzxuzIextY6fAMaV
        jK/tZNsnXpoToB8cJ4Y02ZL35oQ6U2eMsw==
X-Google-Smtp-Source: ABdhPJyBGvrDRIH7jsK3uqWORRSOhGUnqT6zXuk3lCyaSLH8jlp4pw+ZcgTe7kNab/FY35aQqoDjow==
X-Received: by 2002:a05:6102:1622:b0:30f:8678:5bb7 with SMTP id cu34-20020a056102162200b0030f86785bb7mr1721707vsb.59.1645118498870;
        Thu, 17 Feb 2022 09:21:38 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id e9sm342847vsl.31.2022.02.17.09.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 09:21:38 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id d11so3039885vsm.5;
        Thu, 17 Feb 2022 09:21:38 -0800 (PST)
X-Received: by 2002:a67:b00e:0:b0:30d:dc98:6024 with SMTP id
 z14-20020a67b00e000000b0030ddc986024mr1803164vse.57.1645118498172; Thu, 17
 Feb 2022 09:21:38 -0800 (PST)
MIME-Version: 1.0
References: <20220215165226.2738568-1-geert@linux-m68k.org>
 <20220215165226.2738568-3-geert@linux-m68k.org> <4fff0c08-adab-c1d5-4a7e-1513cb2bf7ca@suse.de>
 <CAMuHMdVK7eWfod73JQAntO=7BAMEcS-ktH4NJmDjna3zUn7giw@mail.gmail.com> <z7NQYyKnuywG0bUt7Wr9e53SGgSZgbMVNKpLAOIP0mH3GljFQI3hd_aQFc8qaqwTbBq8yF3QvR9ugLxlivX-ogj508Vc60XHQPAN3IL5Uik=@emersion.fr>
In-Reply-To: <z7NQYyKnuywG0bUt7Wr9e53SGgSZgbMVNKpLAOIP0mH3GljFQI3hd_aQFc8qaqwTbBq8yF3QvR9ugLxlivX-ogj508Vc60XHQPAN3IL5Uik=@emersion.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Feb 2022 18:21:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVeqOj1VfMC6EHHJSX1ttRW3RzaP5tw3aSM4=+SBcz3vg@mail.gmail.com>
Message-ID: <CAMuHMdVeqOj1VfMC6EHHJSX1ttRW3RzaP5tw3aSM4=+SBcz3vg@mail.gmail.com>
Subject: Re: [PATCH 2/8] drm/fb-helper: Add support for DRM_FORMAT_C[124]
To:     Simon Ser <contact@emersion.fr>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
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

Hi Simon,

On Thu, Feb 17, 2022 at 5:18 PM Simon Ser <contact@emersion.fr> wrote:
> On Thursday, February 17th, 2022 at 17:12, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > What is C0?
> >
> > A non-existing color-indexed mode with zero colors ;-)
> > Introduced purely to make a check like in the comment below work.
> > What we really want to check here is if the mode is color-indexed
> > or not...
>
> Maybe it would be worth introducing a drm_format_info_is_color_indexed
> function? Would be self-describing when used, and would avoid to miss
> some places to update when adding new color-indexed formats.

Yep, and a .is_color_indexed flag, cfr. the existing .is_yuv flag.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
