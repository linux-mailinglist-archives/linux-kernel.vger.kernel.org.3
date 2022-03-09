Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCE94D2F89
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiCIM6N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Mar 2022 07:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiCIM55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:57:57 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7AE177D14;
        Wed,  9 Mar 2022 04:56:58 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id s16so1610980qks.4;
        Wed, 09 Mar 2022 04:56:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=12vkeayAZrB46KbYGTQzYxqSQYZ5jeg6ghfEwNKBKIY=;
        b=He5SNcNJFrTFGYjfDokRnEDJg46xt+l6qOgjAgmF88IF6Yufq7gwhSnx1mExi1gess
         fpha0tN90C4MyIguMO4m6fZeP+uaHdCiJ1tv0jleSJAFv+AmmuEA2RPUDv9NnInvyX9S
         LoXyfl1NXXKC7ami6TB/qdWiEh7DjlUdmAZKOwnfprpNhWkynYoODg6tQaMvgMmxpp2T
         9+pNKOC9I6qhN+SbOJaduALARJV6Pl4+bFPcA1GhV2idy68PoeXtSjP8b9VsmkZsgIJO
         ZcJOxpnn6f4cgVkHtrKA6EekVBD5h0mIkKolkLoK3KNB+5zDuvS7pSfF6HRJhyqmboK8
         LYJg==
X-Gm-Message-State: AOAM530OSQ8ZoZtDJFaOArZgCbeE7Wi1SnttTRIV9xucJBVHtUTQDxU/
        2sQwo8knM3PftrmrIrLPkNHLMkJqO5C8zg==
X-Google-Smtp-Source: ABdhPJwW+Br3W+o+H84WZLA7xKUAwB4mVRTCIRhFbeErVPPTYhyVRJX290JlQFCYyYYM+/36duDNBw==
X-Received: by 2002:a05:620a:2a05:b0:67d:2fb0:b292 with SMTP id o5-20020a05620a2a0500b0067d2fb0b292mr3241306qkp.343.1646830617857;
        Wed, 09 Mar 2022 04:56:57 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id r184-20020ae9ddc1000000b0067ca2630aa8sm904213qkf.114.2022.03.09.04.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 04:56:57 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2d6d0cb5da4so21365387b3.10;
        Wed, 09 Mar 2022 04:56:57 -0800 (PST)
X-Received: by 2002:a81:618b:0:b0:2db:d952:8a39 with SMTP id
 v133-20020a81618b000000b002dbd9528a39mr16792727ywb.132.1646830616881; Wed, 09
 Mar 2022 04:56:56 -0800 (PST)
MIME-Version: 1.0
References: <20220214133710.3278506-1-javierm@redhat.com> <20220214133710.3278506-4-javierm@redhat.com>
 <CAMuHMdU+29x4ZHLAiPiReyLKw_VYBCCLw0bCoQmw9s6sQ4Bxcw@mail.gmail.com> <fd6ec463-f46d-0813-5d87-a00c07739e01@redhat.com>
In-Reply-To: <fd6ec463-f46d-0813-5d87-a00c07739e01@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Mar 2022 13:56:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUVWKee+Wm=EP49=5TAgqodPsMjkC2MHUfnyBDF_zt_Zg@mail.gmail.com>
Message-ID: <CAMuHMdUVWKee+Wm=EP49=5TAgqodPsMjkC2MHUfnyBDF_zt_Zg@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] drm: Add driver for Solomon SSD130x OLED displays
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux PWM List <linux-pwm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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

On Wed, Mar 9, 2022 at 1:14 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> On 3/8/22 17:30, Geert Uytterhoeven wrote:
> > Unfortunately a regression was introduced since your v3: printed
> > text is mirrored upside-down. I.e. "E" is rendered correctly, but "L"
> > turns into "Γ" (Greek Gamma).
> > I suspect something went wrong with the display initialization
> > sequence.
> >
>
> Could you please try Chen-Yu's fix for the COM scan direction mask ?
>
> https://lists.freedesktop.org/archives/dri-devel/2022-March/345915.html
>
> I made a mistake when converting to use the GENMASK() and FIELD_PREP()
> macros in v4 as suggested by Andy. The SSD130X_SET_COM_SCAN_DIR_MASK
> wasn't correct which would explain the output to be vertically flipped.

Thanks, confirmed fixed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
