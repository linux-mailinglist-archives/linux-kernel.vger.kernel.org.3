Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0227513EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 01:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350977AbiD1XO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 19:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbiD1XOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 19:14:24 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A793C0F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 16:11:08 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id j2so11754907ybu.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 16:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NyPCKxTWsziHM5455WCFcGsf6KHq5nbSg+7kc8T1Enk=;
        b=w3EXn5LQ3WggPXlrWTgOz3wh1BiyZZf2RtecVtCXewGw/7/fPCXTcwk5GAbAnabAoP
         j72e6VFAKB0taT8M7pYKXotdMgJotbUtzYM24v91+6Dk0cOvaeSNiCgpHrrh9FrMwBq8
         OQDkQbV1l76unzPts+xKdb+S7UFIYt6q+TcXYpdwgCMGuHxJ+xe3kvg3OEJSIQUcG26m
         ul1rO4zsxklDWbFEI8R7ssN/m+vBtNFiT73ko85PRb1hT8cVlCwapW3m0u3eqdGnvW1w
         snMwu+ApV5B3qrD6YIHEqjMB/TdOaTgUyxDBWxnQqkN2HGSByL9KLTEYdqhHhjvHctV+
         EQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NyPCKxTWsziHM5455WCFcGsf6KHq5nbSg+7kc8T1Enk=;
        b=0ACC4PbJ5daVa65PGbogFKF535dpu8ehULLJipJySxYCNspeRM3r7cEF+8gIQWjitq
         2BjWo2wM/oj2cr4oDILkYmuAf/4nRh4zZXPdxlcK7mHDsqCYcTBPvtVx00LQ3WS/K7um
         r/VSBphOvQWYxsC0W/sixcYljP6Yul8/1Og+DCm9zgLco86mUKiRSjxJnHJkt8h6Bdx6
         ZelBOjaMF3tN/arAyIJO4Wjh1jSY6bh4MBRerKUyKg9Kac2Fl8LSpyaWBCzguE0RyNUX
         oZKbi3c1kxAKd4meUPRb0v281chwT3oObC9kbwGvFBlmodRn78BRtbr/ffTWk3Y82ZXE
         Hyaw==
X-Gm-Message-State: AOAM531kOJeShkjwfiTJo1vlMyCzubCbUy3Urlgy3Umy/XKVUwLm0OmS
        YyU2qnsQgk7zv2wlehr6kvyd3kJXGg07pVAOzIoMvg==
X-Google-Smtp-Source: ABdhPJzRbPWM7IZwhg9ocYRv7Fwg9Etal1Ags93CZRpWHRUtlYK4KKVbBNbF/xd3ph+QJP0hCeUd3Soe2zzp9ElLGAE=
X-Received: by 2002:a25:bcc3:0:b0:648:7360:8e75 with SMTP id
 l3-20020a25bcc3000000b0064873608e75mr20393659ybm.533.1651187467360; Thu, 28
 Apr 2022 16:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220426125714.298907-1-mkorpershoek@baylibre.com>
In-Reply-To: <20220426125714.298907-1-mkorpershoek@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Apr 2022 01:10:56 +0200
Message-ID: <CACRpkdacrj5x-vQZwBOF=oQPvr8Fra-bjTAiuS+NhX67ORcFLg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: mt8365: fix IES control pins
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Youngmin Han <Youngmin.Han@geappliances.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 2:57 PM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:

> IES26 (BIT 16 of IES1_CFG_ADDR) controls the following pads:
>
> - PAD_I2S_DATA_IN (GPIO114)
> - PAD_I2S_LRCK (GPIO115)
> - PAD_I2S_BCK (GPIO116)
>
> The pinctrl table is wrong since it lists pins 114 to 112.
>
> Update the table with the correct values.
>
> Fixes: e94d8b6fb83a ("pinctrl: mediatek: add support for mt8365 SoC")
> Reported-by: Youngmin Han <Youngmin.Han@geappliances.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Patch applied for fixes.

Yours,
Linus Walleij
