Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE8B53231B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 08:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiEXGZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 02:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiEXGZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:25:52 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDA55DA79
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:25:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n10so33197490ejk.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D6CrZTvd23rvlgUVmBlktvH0Lw16RsXxIKRFjL+U34c=;
        b=QXnt/DwtsuMT9HJBssgL3VJNo9GWJaQqQaVDMl+s0Hm2bPiuqcNnZn5lqx/D2ev8x1
         0nb13D8QWy4GI9MsPHyK3mU6aaMU8vWqc5TO1yb9nZahDepktJeY87rv784dh5+WqCmK
         lsJiDsyIY3gmrrz2qzfxCih9mP5ndvlImauw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D6CrZTvd23rvlgUVmBlktvH0Lw16RsXxIKRFjL+U34c=;
        b=JXjJHjrqdeW5bgSXWaCVBQBlBtWNXUdIxyXOrGi3um/aMckgHwuGaC4OwTMXokG9Av
         iPvDKFTaTzC92CgKOpftVvjvA5OW8SRe6RJZzmA+F5dtUHQJzh28nDAmm919shUPqBED
         plIOm4ItpjQoxipwmjDh4JNKBAQcjmw9msArtvSmaFTiZIBvJo4K2oB8i4m/RnHMA714
         eFhjSFwl0ktXUI/kvOphC/yIb8Bam8ntrizMbNWMmgXB18iuXuWmDlrn3IyU+/5Vq6za
         3Y53zE1B3jwGw73h0tKw/l5g/XZdz62ovrh42EzlBX4lPesYPGj9Fv7Kcme+XS5vdrma
         U7Fg==
X-Gm-Message-State: AOAM533WSqrCtpPB3HTCFQnMwuYiCOECCZny1RqPTaU5X7yWA6a8WkwM
        2b9RB66e3c2kqdW3NEouPakY9kKSJXwZ5G5z5UaZ5A==
X-Google-Smtp-Source: ABdhPJyJ4eZQIwLnHC81UPge6C/F40nOdAKPI+hfZ0h+dhfs8oDDZ0QMG8iJQXX0hFsf5XrQuRjqGuQCwPKXFrhXFIA=
X-Received: by 2002:a17:907:9717:b0:6fe:b4cd:e0a with SMTP id
 jg23-20020a170907971700b006feb4cd0e0amr16054099ejc.152.1653373549810; Mon, 23
 May 2022 23:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220523160053.1922-1-miles.chen@mediatek.com> <20220523160053.1922-9-miles.chen@mediatek.com>
In-Reply-To: <20220523160053.1922-9-miles.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 24 May 2022 14:25:38 +0800
Message-ID: <CAGXv+5Gswa7UWD-P3SwMFOHpRbZ+d10z3Aerh=zMbNXzfyA0tg@mail.gmail.com>
Subject: Re: [PATCH 8/8] clk: mediatek: mt8192: add mtk_clk_simple_remove
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 12:01 AM Miles Chen <miles.chen@mediatek.com> wrote:
>
> mt8192 is already using mtk_clk_simple_probe,
> but not mtk_clk_simple_remove.
>
> Let's add mtk_clk_simple_remove for mt8192.
>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
