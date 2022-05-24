Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4A85324EF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 10:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiEXIJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 04:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiEXIJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:09:11 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368B176296
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:09:10 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id g72so1501034ybf.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dkLTcxs8LVH0sqAqHX3zwE0YhNnh+xIZuZ0uAeaShmw=;
        b=musaGlIUesSSFQdYuAzfEmgjChU/RErADTpoJGqFYDxCjSKWv4SZgrtDjy2TU2cJ7V
         6IcuLSp4qou81OsuCdHC8fOLeimdtdOQGQnqdkPprKogeMQ33ZnzhIDjIDCzbl+BGrOT
         9gljfGF/KKtyhiBggP6XepXiQhNVSbx7DCLzz76L8nCVN723cAbgYo8Z3pxo14FzA+Fk
         NuX2oNJKs21TPwEJlzAbXd8x6LyzNhDDD/EwaVQF7MSHy6WTZ8mYYjGC6Timo3iszaY/
         FDzE+T18UfrMu5qO0fIWDjDS7Vvm2GgGuGV5tOlzybHZNxMcLOYyMPWoQd8P14IX4Cmk
         3FqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dkLTcxs8LVH0sqAqHX3zwE0YhNnh+xIZuZ0uAeaShmw=;
        b=oeXbaLLSiQ5ASBkspSkuFxxEDQm9JkiCvvLELRHuwYkFzFkl8qSASha9wGKvyP7m0r
         lqmIR3bY3jz3ySDbL0LJWhupDq0D94b23QIgINRHDWboeOmxjF4KQjbVJFQgQ0FSQOpO
         fNiClhp0BJTruZZngemlZq+GbhKxS+XI9Lqfcoj4e1kMKOKTT3xoP3Bp3f1caAtIzOZb
         mKuq9tLiz2t9qRKJ6okBwdXmEAhC1BoZ9txSJJBe1pZtZIBfocDj57RVg2ndmItFzm4U
         q4oYT62u+iEzCfD+3Q4N1CDu1/QXeoOAhIe3xpyBjS7kDYiQx9+RrBZ2mM/nWnH9hBL3
         7SQQ==
X-Gm-Message-State: AOAM531Xr6mWFAxFXH+GBXNnDG9pFESiU9AtVikUJ7EXOQl3NkUUhhZ3
        NugQ2bsWKo/ldQRckyt3LujkrcJ6q28H0DCGdcDnkw==
X-Google-Smtp-Source: ABdhPJyf5gbDLLFA40Cy6Js44+0uWmYjUNjCN43UMga6ZpyrkAqN6ZT1g0cZE+VhRqLEzvShzX0tpLzLf20WBd/xV48=
X-Received: by 2002:a25:6cd6:0:b0:64f:c489:5382 with SMTP id
 h205-20020a256cd6000000b0064fc4895382mr10347226ybc.514.1653379749486; Tue, 24
 May 2022 01:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220524055642.1574769-1-a.fatoum@pengutronix.de> <20220524055642.1574769-2-a.fatoum@pengutronix.de>
In-Reply-To: <20220524055642.1574769-2-a.fatoum@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 May 2022 10:08:58 +0200
Message-ID: <CACRpkdZm0XHfPpWwBB0Nn1h=_oOgj6xKDj24iAVqFPxtextSoA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_bcm: Add BCM4349B1 variant
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     kernel@pengutronix.de, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 7:56 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:

> The BCM4349B1, aka CYW/BCM89359, is a WiFi+BT chip and its Bluetooth
> portion can be controlled over serial.
>
> Two subversions are added for the chip, because ROM firmware reports
> 002.002.013 (at least for the chips I have here), while depending on
> patchram firmware revision, either 002.002.013 or 002.002.014 is
> reported.
>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> v1 -> v2:
>   - No changes

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
