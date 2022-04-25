Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2403F50E402
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242735AbiDYPKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbiDYPJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:09:58 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA6C606FF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:06:55 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2f7d621d1caso40119597b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqiODolKDwfyRALQlYWQcszGWRFH6z+IxhiKOhDhTFo=;
        b=HG1YlSO8m3GLToDGvpIw/Zvu2U9nZ5SndeRDDJRZzwhTyGyEpMsAxW5XPxX3IOWTRs
         mGvIVPSDaRHy3QTsHxyXTARve8aN2WtIy6ova2yzzY8yBXooOL/eJBy9rlWHhiXosZjo
         aMGBCzSNe6GgdoMJQ+aAeYOwvM6Xz2h5Xr2NDt6h4EsVuLdOcc9IAGHXNWJ6LE2+8cjT
         ieq+gd2dQVwDMzWSbvHmF1Rq1dPImaQVS9oV3TeJoDvXhzEDK0IGEYuai6dJBHbdsHa7
         6ifG5Hd1qIJvMevVQy9ygMtTboxW3zHpSvK+ldc5jOgaMmF+oBehT404iwlLts1OYMkU
         F/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqiODolKDwfyRALQlYWQcszGWRFH6z+IxhiKOhDhTFo=;
        b=A9fAsydZRdYOwnj3acQ8NjBuAUEwmUmbhoQGsztGtkmbqftlmjgEDHcUWAwuWZwUgZ
         gvG3Ek/frlTIjAXKuWknjNRuk1TPnSk8Sbzw0JrXjez+4zAftAvzeTz7lh4FrDoEC9rI
         KozJUt6R9iYJseP7DLlTcL3NkTeHRVGNhDdRNNk4tRkg7ZyM4vcwNQDNZ29joP9ZCWhl
         AzEY1r8JVA8cPKsDBV8rUV9lvLm5zxodiJQi2yaKgh1IpyieJksFI8AmjJAtd9A4ec7M
         Xd70K3mpImdWTpldMlOywqxQxIFDxK39sA3mecHQgcDGqHotWSxqkSswmmPHA4a3VJcW
         4JKw==
X-Gm-Message-State: AOAM533oAnjyRc5h0ZH6SL9LuLa225QzLWEc9qeJVvuPz6N057iq9u4M
        tm1wEs7vzzg3A4MVQjEE69tn+7Htph9Emh7mhandsQ==
X-Google-Smtp-Source: ABdhPJwTVuRcAfvc1fO1xeG98w40wfDx7OdmNy1nAU7g1tneXxN06QNrYfNTjYzGAMDWsyK50c82G3B9eEZZeRy29HU=
X-Received: by 2002:a81:1d48:0:b0:2f1:8ebf:25f3 with SMTP id
 d69-20020a811d48000000b002f18ebf25f3mr16690680ywd.118.1650899212383; Mon, 25
 Apr 2022 08:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220419211658.11403-1-apais@linux.microsoft.com> <20220419211658.11403-2-apais@linux.microsoft.com>
In-Reply-To: <20220419211658.11403-2-apais@linux.microsoft.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Apr 2022 17:06:40 +0200
Message-ID: <CACRpkdZz_JGGCv74gQYKMq5fdHLo_6jFuJ2uh8N9Q1VG5+kCFw@mail.gmail.com>
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
To:     Allen Pais <apais@linux.microsoft.com>
Cc:     olivier.dautricourt@orolia.com, sr@denx.de, vkoul@kernel.org,
        keescook@chromium.org, linux-hardening@vger.kernel.org,
        ludovic.desroches@microchip.com, tudor.ambarus@microchip.com,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, nsaenz@kernel.org,
        paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com,
        gustavo.pimentel@synopsys.com, vireshk@kernel.org,
        andriy.shevchenko@linux.intel.com, leoyang.li@nxp.com,
        zw@zh-kernel.org, wangzhou1@hisilicon.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, sean.wang@mediatek.com,
        matthias.bgg@gmail.com, afaerber@suse.de, mani@kernel.org,
        logang@deltatee.com, sanju.mehta@amd.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        agross@kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski@linaro.org, green.wan@sifive.com,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        patrice.chotard@foss.st.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 11:17 PM Allen Pais <apais@linux.microsoft.com> wrote:

> The tasklet is an old API which will be deprecated, workqueue API
> cab be used instead of them.
>
> This patch replaces the tasklet usage in drivers/dma/* with a
> simple work.
>
> Github: https://github.com/KSPP/linux/issues/94
>
> Signed-off-by: Allen Pais <apais@linux.microsoft.com>

Booted on:

>  drivers/dma/ste_dma40.c                       | 17 ++++-----

This DMA-controller with no regressions:
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Also looks good so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
