Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6801F4B8A97
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiBPNqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:46:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiBPNqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:46:44 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6C2F1F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:46:30 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id p5so5994271ybd.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HmFgTFOaUrdQsLp+zoYLJYAEZzFKWR4iy8oL8R7YJhA=;
        b=piQF2bXbfQ3jAL9Wl9KHIEI/BE7pYDU1IMut0lIzmEScSrQTTjteMmCEzJpApNZRX4
         MiSZndY1LTZdnjzdE1PtqAozUueAsk+eHh1cDep+IbGnB9QWT9qZ4gaC5sqvfGpS3BE9
         bR1twOpbY9SOcG8uuHnhoXL91tdBw9gU9UmxqJIwGeWaiNwWUjTkd+EOa9X7qSRiP4Ic
         m8Zx0IpBhy5xVNK8CZj7uL7qa6SdAHfv0MJRk3F6unvP/KZRr7iVVemKX545Vw1/i6nD
         UkmckP1LIoEqUm8uWPqlNTOC8MeC8E9tZaCEeo4E97rXfUl6R7bkc7GrBneAs4SoAtK4
         JANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HmFgTFOaUrdQsLp+zoYLJYAEZzFKWR4iy8oL8R7YJhA=;
        b=MhI5bG4Uk822UJPnIWswJMIL5xZ9XDqvAnULQ6ahq6oZ5rPAMYa9nzu6Q4di3n3+Yl
         NzhrixHS6KSr635wEbg1OgT1jZYoCyXksKxaRTUnrie0ddEnKA4fgfxt07WXlAhFRYVS
         R5Rk0Y3M2po/53E2OTiDsggXaC04gbp/44VzOnXf346WciaQITR1ZI0zrstZsuYQd8z9
         bhczmBGimRVpTkUTto/cSqn0RHNEbRgVtAGnIL1MBKnm+RNxDkrbOk/fAvL5pUzafyBw
         JfE24fj03g1YkYWi2CR1nVLJ5FQ1WVUaWikDkkRFwFIzXdNln6HW/wRtQLzBxoqFa03c
         9tiQ==
X-Gm-Message-State: AOAM532+B+cABc8zilXqwCqcWnSx9YW7fEHU5ZRLH7OI0y1KHj8zCpOG
        L0As+syM+vtUvFnyjis+3djT5XPoTCdL53HCUlsN9A==
X-Google-Smtp-Source: ABdhPJwDrfO0XNqq06G1iySq3VTrmWTvdn5Z6vOL0Eb4ZcCuGh6EN5CLGZDUWZYdveKOCjkOHjTGRR1Iq8a+ERSnC3g=
X-Received: by 2002:a25:6807:0:b0:61a:79a9:526e with SMTP id
 d7-20020a256807000000b0061a79a9526emr1995117ybc.376.1645019190069; Wed, 16
 Feb 2022 05:46:30 -0800 (PST)
MIME-Version: 1.0
References: <20220203082546.3099-1-15330273260@189.cn> <20220203082546.3099-2-15330273260@189.cn>
 <20220203085851.yqstkfgt4dz7rcnw@houat> <f5381561-25da-61e3-5025-fa6dd61dd730@189.cn>
 <20220209084331.fpq5ng3yuqxmby4q@houat> <def50622-fe08-01f7-83bd-e6e0bc39fe1b@189.cn>
In-Reply-To: <def50622-fe08-01f7-83bd-e6e0bc39fe1b@189.cn>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Wed, 16 Feb 2022 13:46:18 +0000
Message-ID: <CAPj87rOgk8A8s6MTqxcTO5EkS=ABpHQV3sHsAp7Yn2t3-N_SoQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] drm/lsdc: add drm driver for loongson display controller
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        suijingfeng <suijingfeng@loongson.cn>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Roland Scheidegger <sroland@vmware.com>,
        linux-mips@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2022 at 15:41, Sui Jingfeng <15330273260@189.cn> wrote:
> On 2022/2/9 16:43, Maxime Ripard wrote:
> > More fundamentally (and this extends to the CMA, caching and VRAM stuff
> > you explained above), why can't the driver pick the right decision all
> > the time and why would that be under the user control?
>
> The right decision for ls7a1000 is to use VRAM based helper, But sometimes
> we need CMA helper based solution. Because: The PRIME support is lost, use
> lsdc with etnaviv is not possible any more.
>
>   Buffer sharing with etnaviv is no longer possible, loongson display controllers
>   are simple which require scanout buffers to be physically contiguous.

Other systems have this limitation, and Mesa's 'kmsro' concept makes
this work transparently, as long as your driver can export dmabufs
when running in 'VRAM' mode.

Cheers,
Daniel
