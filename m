Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B321E5A26FF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 13:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245547AbiHZLnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 07:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiHZLnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 07:43:11 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066C5CE493
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 04:43:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u9so2665100ejy.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 04:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=gsShjHRfk1oeXhbIzNvUGv41+jelOVn6LeepzghgVhc=;
        b=y66fvpM6mrqJoSGMNOUuh8/jNAUR1UjVh1GbVfp532iGK3RhG5d3pM7Jj9bQ+lnefL
         R6n2L3gNzDy5eDLXId+bbuwc1Cu97Y4MhATKlxERGzv6CkQeuJyoQJIsXZ8s5V1oEPtp
         6aKR8AcFw3npwDqPvLKq3g5k9qR6jk3JJ6vTblb6kDPvTkk/KMhCqODdTxqX8EbQoir2
         PO8/hJrH9T7PV9EiNvrH2q+otJn/QEHj+0LOrvEmy03mt7XdB97BWoREUkNLQ84jmfHK
         +ACQuqwyhYoRzRH2W4JrBMGWknvz9WE11tfeZIopFrdvz/OUFwip0Ug/FSEJMvGi1XIa
         chGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=gsShjHRfk1oeXhbIzNvUGv41+jelOVn6LeepzghgVhc=;
        b=dauItX/2+BNiiERwp5R0joiINuSEXyiIfXPYCQuX/ttIT4X32XKCdU8FJBSpE907EL
         3EdRwpYkzmBGJRQcj+ZVZ7im3Yb1pGtJja6TW0pi9Yfz94ftyiny1x2PWJA2LS4WgPvI
         kGgPEQWMvOE8j530wmppRJ862ezzQ1sePxPafn+1VqIhCmiO2HzbuwvSv99ucyWFqcS3
         hJ04M7/zQTmjd1fn4tk8BFhNlGiX87PTFGJjH9fyfpbbdRcQsD3eUIWofrz0w/Qt4TJv
         xLjyrv/s3KSIPR8oLIZewRANCtaWyHa03BegUovZVEMYRBq18eqPT9lTxOy4Yisy5Ojw
         k6jA==
X-Gm-Message-State: ACgBeo3RIf2xt9qNy9jAyq17htfbGGhA+D1NBSQTNxLA28HoBAGHouTS
        rB7xaotp98YjbllTEtMaw0USNBSImKh2E4cG3QwNyQ==
X-Google-Smtp-Source: AA6agR56gg8w5KxfHvPutKzL3hZkhLx++8yqikN5B6LKjSxqFmWvyJTzeHuMm+6e32LFnU+nvVfFauABKPr5Zn6hFnU=
X-Received: by 2002:a17:906:478f:b0:73d:7919:b23 with SMTP id
 cw15-20020a170906478f00b0073d79190b23mr4886670ejc.690.1661514189603; Fri, 26
 Aug 2022 04:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220823004227.10820-1-rdunlap@infradead.org>
In-Reply-To: <20220823004227.10820-1-rdunlap@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Aug 2022 13:42:58 +0200
Message-ID: <CACRpkdZGkKXFtdNQGn6CZvh0xArtoWaSGGQHdihifLmiHyzszg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/panel: use 'select' for Ili9341 panel driver helpers
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Dillon Min <dillon.minfei@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 2:42 AM Randy Dunlap <rdunlap@infradead.org> wrote:

> Use 'select' instead of 'depends on' for DRM helpers for the
> Ilitek ILI9341 panel driver.
> This is what is done in the vast majority of other cases and
> this makes it possible to fix a build error with drm_mipi_dbi.
>
> Fixes: 5a04227326b0 ("drm/panel: Add ilitek ili9341 panel driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dillon Min <dillon.minfei@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>

Patch applied to drm-misc-next

Yours,
Linus Walleij
