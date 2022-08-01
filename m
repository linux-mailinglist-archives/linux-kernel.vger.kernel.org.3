Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AA9587447
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 01:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiHAXMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 19:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiHAXMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 19:12:10 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E885819029
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 16:12:09 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id x2-20020a17090ab00200b001f4da5cdc9cso6678334pjq.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 16:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vcne+DijzvkGGojl7ODwtHBhru6f6mHbW8Yh6JWpaSo=;
        b=BSFh9Y/3Bqf/eS6bf/VCEmnc4PQDR2RyCgFyqmlEFpQpCNlbiH1W0gCWFDtQ7rUKT9
         Kl93q+bIPvOnfXkMMWeMVnZuTXEaO4BXGXKTibfb5rBQ8tvlJd80aS7YXjl9Wjxr0VQt
         53i2nwUa9LLbSM4WpBK6CG3zOKyeTykIBaXoVQsjaNFLRSqzoIaQ/z6mkjeWlgcETkhz
         04vtV67FjJCyiiUA+NQsymzh7cRXmXYoX99X9hwG/PMyyHqZDxB30IPXvcJvQXMryq+f
         3krV0vPaUpSNlT7vywfNl+nuXcT9dkBniEyn7b8QncxUhaFwZZawz1xry3cj99hUKBO/
         vkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vcne+DijzvkGGojl7ODwtHBhru6f6mHbW8Yh6JWpaSo=;
        b=v//BaXhVK3/JlkaUNCIuDEjNFIZHWFgVdUXcC6f46WKPazxdUTCm47rtCwTnKzap9P
         Cc7HJ9NYE6G8/LJPvvkRmJBUOM6YTXmgj03nvjDpu1e3id7tG9RkG/T3axJaLXhaICVl
         LglVtyxCT3qYiEVlRFw8RvKPE7dri8ybAOFL7N28UaY2A5XotSc+Abnk7KbfOudFuA+u
         rp2Arfulypdljdy9ipbKiMSvKmJqGwfnaFpBmHlV2Stee0v8Ii2aPQUXle2Nb850pqaU
         Xgv/MndpDSrvd1jNOBtziH8FTiBxjmw/z47BzySw2kit4WPa8GBNv53p7Ozd88LEK0rO
         Oy4Q==
X-Gm-Message-State: ACgBeo1c67lbnr9jQ2FAvk0sL+nxAA7tJEKSrdcdQN/lCNiL4p1D4DGE
        SRYaw7l55KXf2Tn7YIB76YoilqRMp730ni/h0hs=
X-Google-Smtp-Source: AA6agR5MQkRVnpQvn23Dqex9iHEwjfhYODOQ7uDrOBdjfp44M0noFu3cGl/T0SboflHe+rhf23b2iHPvWRoDJuJ2liU=
X-Received: by 2002:a17:902:e746:b0:16e:f7cf:671f with SMTP id
 p6-20020a170902e74600b0016ef7cf671fmr4205003plf.168.1659395529356; Mon, 01
 Aug 2022 16:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xJ=N1vWVTBjArskJ59fyaLzmAGWfc0E=_iGizrDNR_Udw@mail.gmail.com>
 <CAOMZO5BAheG4r1Umnd7bLhOqezsxJgE0x1c-858EcabbpPm6Pg@mail.gmail.com> <20220801225538.qtdb5zd66g6ipewz@pengutronix.de>
In-Reply-To: <20220801225538.qtdb5zd66g6ipewz@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 1 Aug 2022 20:11:55 -0300
Message-ID: <CAOMZO5DUTxQKbpTVOgaVC0V7hPqJG77sgmkW8p=aNpG8th-aLw@mail.gmail.com>
Subject: Re: imx8mm lcdif->dsi->adv7535 no video, no errors
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>,
        Stefan Agner <stefan@agner.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Foss <robert.foss@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Jagan Teki <jagan@amarulasolutions.com>, robert.chiras@nxp.com,
        laurentiu.palcu@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Mon, Aug 1, 2022 at 7:55 PM Marco Felsch <m.felsch@pengutronix.de> wrote:

> Question is, does your setup work for all modes after applying your
> patches and without using the NXP-downstream porches settings? We also

Without Frieder's patch:
"drm/exynos: Fix horizontal timing settings in MHPORCH/MSYNC
registers", I get no HDMI output.

Regards,

Fabio Estevam
