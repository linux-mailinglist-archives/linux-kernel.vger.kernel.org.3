Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A833539786
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347596AbiEaUAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347617AbiEaUAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:00:20 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1218FD6A
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:00:15 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id f21so28654261ejh.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/5hFp0lMWC4dYsgyS8F7d3AZ1PIyvtWlhq+Sm07wFE=;
        b=BfAzztMNm1Jp/TdVi0t4iVReEv4ID5XLse+uh2O08vd5p45IIiN2ru9VwuJU6Um5Nv
         0qh6aXb3IQyqKe5AJz5SZ3TUw59Bs/A9IZpkkj26xiglqeckNDZL6KrBNR2L9m0gzOW9
         xN8FWpowprhXG7MbtRfuG5IEYYtXp1UOcQ2cjuare7jC91K6A1IVfw9NE4TttMwgjjjN
         mkiznqExdK01IwGOBpobCBk5lXWvmApbyMdx+Zp6iOQuLn696fC3m+i1EsKvqenaRQXY
         jia0fUobMIA/yV+n357zIRHHq3K9HD5P47G3l49XAHkYdD/+A/ITVdWhi2yroIFq60s2
         mgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/5hFp0lMWC4dYsgyS8F7d3AZ1PIyvtWlhq+Sm07wFE=;
        b=MLTIKN2TjfK5EgtNXr/b4W/RmyQ/kkAyjNQCS1BeIOXP1RW9jE5W1CE/xLra66YFHj
         LfTyEJ1w3Bj5UXBzeoMkNEMB4+xg2Lfm/oSTHQdd10hnIwMxunNfumeLWDs4jy2zvqGy
         9I2CYtTWLE21Ft07voHhl/7K3nPPTfmE5JSGJbprvT1doannKzbQiOlZaVgVp6HN7Mdu
         ILCqrVUwrcS34y041GGhWeQRDH67c5vCAmzoeX4DXw+IvdnzUN/e/69sbazDCBKUWiLU
         +AFFan83CdQTlrCeNBMA4b85R4fJf/g9MS1m4lhH3vOPf1tfnV6Lfmr3a/DlQHFXm5gr
         BJTw==
X-Gm-Message-State: AOAM53146IUSoxHzMvylBZqFHXHh3gNUN5Ntbz3o5hzMc7zL0ZYRiNki
        TZ/Qvuobmfq/frcBVtq8PG4cGbhAtiBmrWFlZ1sjRb2X0Rw=
X-Google-Smtp-Source: ABdhPJy10QXI2/ZkHtl9TZrO9ctuZkG39qUaTuGRRuWnMdaywHiIXFoOLxMbU2TIJIGuNyp5YTDWSwDcDQgsRT5WYgM=
X-Received: by 2002:a17:907:381:b0:6fe:9ca8:c4b4 with SMTP id
 ss1-20020a170907038100b006fe9ca8c4b4mr52565612ejb.147.1654027203570; Tue, 31
 May 2022 13:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220531144818.26943-1-linmq006@gmail.com>
In-Reply-To: <20220531144818.26943-1-linmq006@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 31 May 2022 21:59:52 +0200
Message-ID: <CAFBinCDrnUXS+djchc=68jPVZwqbgPcJy6WKFus7L3JKTSsdZg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/meson: encoder_cvbs: Fix refcount leak in meson_encoder_cvbs_init
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

On Tue, May 31, 2022 at 4:49 PM Miaoqian Lin <linmq006@gmail.com> wrote:
>
> of_graph_get_remote_node() returns remote device nodepointer with
> refcount incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: 318ba02cd8a8 ("drm/meson: encoder_cvbs: switch to bridge with ATTACH_NO_CONNECTOR")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
