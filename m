Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E331553DE91
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 00:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348249AbiFEWHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 18:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238038AbiFEWHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 18:07:14 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813B02AF4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 15:07:12 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id me5so25134552ejb.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 15:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EvdrzNnwpDnDn9YN3OQw+McxNhWHrslS9QPN5TMLp4w=;
        b=jvBhc6+k40HESfBa2/kHjiPXNsmhn9RWusQQuekRCoRpZQxLjI+/bUUbQl40oGkXNZ
         DDlDD3Kts3OXg3AmYrDeujl79CfM+aMVcarycdisbklXcuz9M6WyPexFrr+ZQMwsJ7fn
         dYHoHaT6aA2SCKYliWMEXzOsKPHOWWDi99Y6hRp5dv1oHYwcBWUEXQlnm+bbcGdQQLZH
         LV2qZDFjXplNKazciGbp3xseWSxXEVDm6+uGpG8oJEcAMulX+6vxNeX0qqBb+3f0vEKP
         okp7x7oGotXEuPMC3aAd5a+4/PqZ12tcenMvg6drAosssBmSjmuhpmp/86uuoPdeDk2c
         QyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EvdrzNnwpDnDn9YN3OQw+McxNhWHrslS9QPN5TMLp4w=;
        b=NiRwjn7IfPLul1E/b0U+EKYTM+Z7uK2H4NolP4xn0WWjJwkdqSJ/DDjZRLnl0eE75i
         LyXxAvb1EpG9Yy7vDtPh41kf9EPnKiOEbbilD7ye1j/5PLnfyrErgxdOfh5rLKRq5A6r
         AX75DJFduOHDg97stub/RWGzq1YAvABXZiMuxFDDgTjEZRQ8lHIjVgYStnMLqcn5fet7
         xR9CsYkugVlNUXm+bQfII0ziYA+KqpzZUC/hZDk0n3Kr+RQBMQ0bfubBT0wYtTqUdUtZ
         akJoFLzRL7CaS02ArmhcG86bK1eJdic88ZWsN9d/2UFA7B0gt9XNNyDJzF5lIuqGnRRW
         iNTA==
X-Gm-Message-State: AOAM532xEgaP/4TuV86wRNxhgRMJmiE/kSwf4HUV+OyHcyqDm1rX5cME
        0UmC5RqJNuawOut3ltkTzKCPAX115cUHXuVSleA=
X-Google-Smtp-Source: ABdhPJyum2q6NTjWpptCxZaYoHpCsIXUQommOK3UQGv2TUoY11eOyZCV12TIf8OGUqFO9UJM26QCVQsp7K7VJczHj2I=
X-Received: by 2002:a17:907:1b19:b0:6f0:1022:1430 with SMTP id
 mp25-20020a1709071b1900b006f010221430mr19174262ejc.13.1654466831106; Sun, 05
 Jun 2022 15:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220601033927.47814-1-linmq006@gmail.com> <20220601033927.47814-3-linmq006@gmail.com>
In-Reply-To: <20220601033927.47814-3-linmq006@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 6 Jun 2022 00:07:00 +0200
Message-ID: <CAFBinCCS2ypuv8jWCyhTVruGJTUfq394CySDDaXExHq4R526rQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/meson: encoder_hdmi: Fix refcount leak in meson_encoder_hdmi_init
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

thank you for working on this!

On Wed, Jun 1, 2022 at 5:40 AM Miaoqian Lin <linmq006@gmail.com> wrote:
>
> of_graph_get_remote_node() returns remote device nodepointer with
> refcount incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: e67f6037ae1b ("drm/meson: split out encoder from meson_dw_hdmi")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Note to self: at first I thought the following code needs to be changed as well:
  notifier = cec_notifier_conn_register(&pdev->dev, NULL, &conn_info);
  if (!notifier)
    return -ENOMEM;
But a few lines before this we already have:
of_node_put(remote);
Meaning: this patch is fine as is.


Best regards,
Martin
