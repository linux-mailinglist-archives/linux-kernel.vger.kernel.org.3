Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE4457F998
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 08:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiGYGq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 02:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGYGqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 02:46:55 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3393CBF74
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:46:50 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id c131so18424159ybf.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+LHD1Eh7R5NFEh/i7at+5wk7Eyhd6qFs5js/UI+dUc=;
        b=Ibr9q1wIeBGws91HK3qdE1+wGQ7t0MkwzuOm1Xb3FnQkzuTRYcgaObgz8ynZLO2q52
         PA+10trsRKvarVn64dlNZzx6SdntY3tG6R7uP/a3yZTiEgS5/BXsZAPxKqmDTwjgXyyv
         GeBSJ75Ea/cEKXAv60Z9TTrJB0U/3a9uxk09g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+LHD1Eh7R5NFEh/i7at+5wk7Eyhd6qFs5js/UI+dUc=;
        b=kNnknUuRFvkv5ddrapaf/+CIACxxDQGxJKNY2fgqJqRI/hfm4902nAYuMdRHK3C6Ms
         8bJq8+w9bPZ8Qk7/s7pTxPiMig2XluAulNiQ4j3tuomabnrFNFZTIQO9nxbaOS0x6gnS
         UAq52X2o1pKzeQG3eNqsG6IRMOnIoDnt5sDSG0CUSsa3X9WXoiOd6kHP1B++TKO6HW7Y
         FCNzfAJB3eIpEtLHZ/+l4/26gAJqOBY41qL0GI9kbwlfR242MeUgYyuAzlfBwmVtDf0n
         znclJZTp3TUYPXf4Nr+ho3048bfRj7PQRutZ4yoW5OMRghh4K/RGBMWrLdxeDSr0D5lZ
         NO3w==
X-Gm-Message-State: AJIora+cmPy2cXp4tlsT+FlO1qNfMiLBGS9YLaP/C91Y9xES/G0RvB/F
        ATVSkW7h5TsDdypvhBXWbD2NHL7H2eguN8P0O46Akw==
X-Google-Smtp-Source: AGRyM1vJ0Mmq3F2lfrUDVjqxtvHQmzaTShK7/xuF4iFq5a9n1GXpZWltqxF+0o4P2HADFPt1FvB99qvJNv/yVZEJkrQ=
X-Received: by 2002:a25:640c:0:b0:670:91a0:57e3 with SMTP id
 y12-20020a25640c000000b0067091a057e3mr8294122ybb.204.1658731610056; Sun, 24
 Jul 2022 23:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220721172727.14624-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220721172727.14624-1-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 25 Jul 2022 14:46:39 +0800
Message-ID: <CAGXv+5GyOjMxsmP24e-oUMJxhpV_UO_=c6RjCPf60MKn+SNiYA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: dsi: Add atomic {destroy, duplicate}_state,
 reset callbacks
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     chunkuang.hu@kernel.org, jitao.shi@mediatek.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        rex-bc.chen@mediatek.com, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        xinlei.lee@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 1:27 AM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add callbacks for atomic_destroy_state, atomic_duplicate_state and
> atomic_reset to restore functionality of the DSI driver: this solves
> vblank timeouts when another bridge is present in the chain.
>
> Tested bridge chain: DSI <=> ANX7625 => aux-bus panel
>
> Fixes: 7f6335c6a258 ("drm/mediatek: Modify dsi funcs to atomic operations")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on top of next-20220722 with additional DTSI changes for display related
device nodes [1] and modification to mt8192-asurada.dtsi to enable internal
display.

[1] https://lore.kernel.org/linux-mediatek/20220712114046.15574-1-allen-kh.cheng@mediatek.com/
