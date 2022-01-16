Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FEF48FA0A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 01:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbiAPAtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 19:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiAPAtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 19:49:22 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485F7C06161C
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:49:22 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso15052726otf.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6p/O50RxDfDXj8F2gSC4MowoUivvHCS0e3BL4NSTAKw=;
        b=Nqgh49Px5R7DO0fvkf4emRtIOPPQB1ttBHl54nYcwmBVbUpKe7zRYYoEOON3g2eQPv
         QJOJItR3O3Dc+BAkBVkFgpFYEBSupFrLgugavxkviSYjapY90x4yxiPniMP4TsU7ItsM
         P2Jfc6yQwusXu2K+yPH3ShITezD8pC5FidTndQN/5MHwQZl8Sxh56IHann3//4D3Phgp
         KifPPZDSt8Of2hhf/y49TMj2RTdZWeWz9x0noEmw9TSBoDfyVUX++qf/tlx+EQwGKV4/
         uhinoC1O4mN8heUYf240pRmcE3Jq7LY1bJ7l4hAxYIKBNJkfdY1WC691m8M1M7zG29Qr
         KrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6p/O50RxDfDXj8F2gSC4MowoUivvHCS0e3BL4NSTAKw=;
        b=TQE2wHl1VlXle40OIKrc11/fzmz9AY/UPDcdjX/gqt63i/LrfKkknJWssgdlBBaWib
         kh1z/kY7vrh9ydbc8jAHiznCKVikFjhnx9VgfIPocN1VaC0uLcTXYvc1GmIHDKY+1Qgr
         OBd3JRm3xBgkY0Wv2zWzrdUoMH9/ke2rc8bv+J4IGT7HSDFifAooZjmRKOSxC6w//q6l
         YIbpIsnLz4+eaDUYLPhptgewBwGb3V7JOosvyts6CQvnNWDXuFGfFA7VPYNugQB36SES
         Mwkz1IxIXdOuH9CrKC94q3Lx44atKNiuN6HiNHxmGdGiE35vFyc5cayq4NkOPXAepfHp
         RGzw==
X-Gm-Message-State: AOAM533IMUDQM2AaJaw+QAFD63Wnctb1wF4sZBMNfTMHhD2n47pk4ahX
        9kINKAJhO0A3Ewg0utbUqO8u0iqD+CT0bGYn93CNDg==
X-Google-Smtp-Source: ABdhPJxTODp48xHCKhFaUN9ucAxJTdT/iwAFvpUSSRbtaQ4yeE5aXxbrG02X11dyWHsA3S9x2XjGL7EAntPOyAudiKo=
X-Received: by 2002:a9d:465:: with SMTP id 92mr11681452otc.35.1642294161540;
 Sat, 15 Jan 2022 16:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20220111112244.1483783-1-wenst@chromium.org>
In-Reply-To: <20220111112244.1483783-1-wenst@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jan 2022 01:49:10 +0100
Message-ID: <CACRpkdZCtEwZiVwoW+QNL4nTf-10fBDRfGkwVJavf1n_w-8q_Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] pinctrl: mediatek: Fixes and minor improvements
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 12:22 PM Chen-Yu Tsai <wenst@chromium.org> wrote:

> Here are some fixes and minor improvements to generic pinconf and the
> Mediatek Paris pinctrl driver.

Looks good to me, can you rebase this on v5.17-rc1 once it is out
and I will queue it!

Yours,
Linus Walleij
