Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE07554C36B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243611AbiFOIZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiFOIZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:25:39 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A6E220E0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:25:37 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id m20so21659958ejj.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=42THmoY9ZwUf7E9pXMyKG0cEp/ni0i9p0WfpREB2n10=;
        b=IzXbdm+MSDrAUM/lNjl81RFo6yj1cN4/UWpTi2VyoC8cuXokTBY/XslJ6f8EgwlHHR
         Nqv+vLJCcvriZm89d5qLtZ9vWefp92+txsJV3xA0TJKJRWaBC0X0xB7n8kwB+ZjvEjFd
         UwuD1M6X9yi0TmtYRspTDQSK/ydvBdHIkBXUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=42THmoY9ZwUf7E9pXMyKG0cEp/ni0i9p0WfpREB2n10=;
        b=mX6bmkgzpQHyGiIYBJ8OfDnI95VsRQvJ5y/cHV7CWRas4WkB//rlQrs8tFlUzLN+gM
         6jiYNfnigvp96EHkT8o0pOi2SGvWkcL9h+FUTUKPyBnaNGMyUUXIK/9mgUWHTL2uHFl7
         1Is9EDyzzx8An7cKs4xBGExctMeGQmhbqPmHz/8nao8robln+43yzMMmek4oGZeyfGOY
         ge/zK2UKaRmEfYT+rQmTZJOhTjwzNgzgghJvLl4I++ngoAQLjI9Rb0QCQQ31uvmP5DGC
         3neSlYzm58fc3nS03YLyNw0frXvPwStt4ALzLUY4F0QN05p5Ohv9hxifj1i+PmRvedbc
         vbIw==
X-Gm-Message-State: AJIora95Z+s9BDcB8gPMSm6c9e6382elXvbt+kYTn9/EU88NARpv0RZp
        w/Di0PeE6favdt/8Ahug3vnn9bdvSfLEMVUJEJV7YQ==
X-Google-Smtp-Source: ABdhPJzwhpiEvPHgnYKirBM5dhwCXY18u70ilKxIbysLJLQFgRqgBSktW8XVTVC7cX35FBuWGfmGK84g72VBIQQ80rQ=
X-Received: by 2002:a17:906:a10e:b0:6f3:e70b:b572 with SMTP id
 t14-20020a170906a10e00b006f3e70bb572mr7595326ejy.546.1655281536262; Wed, 15
 Jun 2022 01:25:36 -0700 (PDT)
MIME-Version: 1.0
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 15 Jun 2022 16:25:25 +0800
Message-ID: <CAGXv+5G9j_XVhuH2XO8g0YQn=NT3Typ0OYkKtr7qHkZM9XKpwQ@mail.gmail.com>
Subject: Dealing with temporary clock parents for PLL consumers?
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        matthias.bgg@kernel.org
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

As part of getting Panfrost to support devfreq on MediaTek SoCs, we've
been trying to internalize PLL consumer reparenting during PLL
reconfiguration into the clock drivers. This was previously done by
the individual clock consumer hardware drivers, Panfrost in this case.

I posted some patches for temporarily reparenting PLL consumers while the
PLL is reconfigured on MediaTek platforms [1]. This is based on a similar
mechanism in the Allwinner sunxi-ng clock driver. This works OK for the
MT8183, but as Angelo recently discovered, there are complications for
MT8192 and MT8195 due to how the clock tree is.

On MT8183, the clock tree for the GPU looks like this:

  <XTAL>     ----------------\
  <GPU PLL>  ------- <gate>--\\ <mux> --> GPU
  <stable PLL 1>  -- <gate>--//
  <stable PLL 2>  -- <gate>--/

Since we temporarily reparent the GPU to the XTAL, everything is OK.

On MT8192 / MT8195, the clock tree is more complicated with a fast mux:
(same parent with different dividers omitted)

  <GPU PLL>  <gate> ----------------------------\
                                                 \
  <XTAL>     ---------------\                     <fast mux> --> GPU
  <stable PLL 1> -- <gate> --- <mux> -- <gate> --/
  <stable PLL 2> -- <gate> -/

As shown, we now have a gate in the temporary clock parent (the other side
of the fast mux) that needs to be ungated. The question is how do we deal
with this, since the temporary muxing away from the GPU PLL is done without
updating the clk core's view of the clock tree.

Angelo and I discussed various solutions:

a) We could mark it as a critical clock so that it's always ungated,
   but that seems a bit heavy handed.

b) (by me) Add clk_prepare_enable() / clk_disable_unprepare() calls in
   the clk notifier that handles the temporary muxing. This might trip
   up the clk core in unexpected ways.

c) (by Angelo) Tie the temporary clock parent to the GPU's power domain.
   This means the clock is only enabled when the GPU is in use. I think
   this is a bit hackish though.

d) Add support for such a mechanism to the clock core. I assume this is
   a common requirement across platforms, as PLLs tend to overshoot when
   being reconfigured on the fly, and can cause glitches in their consumers.

We'd like to get opinions from folks about:

1. Whether (b) is acceptable from the clk subsystem's perspective.
2. Whether (c) is acceptable in the platform maintainer's view.
3. Whether there is interest in (d), assuming it is doable.


Thanks
ChenYu

[1] https://lore.kernel.org/linux-mediatek/20220523085923.1430470-1-wenst@chromium.org/
