Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45D6563844
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiGAQrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiGAQrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:47:47 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650564339F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 09:47:45 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id b23-20020a9d7557000000b00616c7999865so2230765otl.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 09:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3aXEKuYhSekfjFf2iaJFFk/57mY9AqJp8+HZ/oMIjzQ=;
        b=NFQb1gvPPgh9l6ruExkaXLZ1hFCZfoyPD99CK1HWB7to7E8wSHjtHLAHs8hQK2c5nM
         FpMJM4l43Kc6cdx0S/XcRRbIGzbRiat3w+G1TAfva2q1K0ZtJCzvIuZpQ2lf96iLM/sP
         RXGhwEwsvIQNicNbaidCfit2HC/ghNX/2Rxbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3aXEKuYhSekfjFf2iaJFFk/57mY9AqJp8+HZ/oMIjzQ=;
        b=mhc26+xnIX711qi9LWIEm0Nd20/8WsABmOLInVvoRYr1BghK6Gr/vQe4OwkISdf8XQ
         39jWzkEr0KPrwJhc3GehCz8CyfcsqgEy36FjgT/jh8TQVYPAfCHtmGGWd6ABURmFA/XZ
         AlfOY0dwCv63XI6X8khjW5hgNdy8cyYhohIECVe4cE9Nvuzn9A2+sVTvaWIbGbDHMf2x
         egeha/IjMh8HjKnd/U9qpP2jZ6K30g6JYgMzoNZoyRST9dgYnIyrcZmFeE/jpUpK7XWt
         CwfTHmnD/sDS7iYdyebe1f7YbqJPW7DLc3JpOp6FI4mMVTbtwyoGCS4W8MTjQ2gq98n7
         gfqg==
X-Gm-Message-State: AJIora+uAzH8VlZY+CzNWzItXNHJRbmcP1zAB7gSBuSZGHozHtPr+Vg0
        hhg7a9OnPzRXXibzqRjiv9hIpymA+wLtaA==
X-Google-Smtp-Source: AGRyM1t59m1aPCaWzDySDHEo5KuscFHSf93b4bdLlbuw/wXyZ58CtYlN4b6FhgFG/NrP4knmR1X+8w==
X-Received: by 2002:a9d:6f06:0:b0:616:d2b5:1799 with SMTP id n6-20020a9d6f06000000b00616d2b51799mr6888989otq.282.1656694064687;
        Fri, 01 Jul 2022 09:47:44 -0700 (PDT)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com. [209.85.160.43])
        by smtp.gmail.com with ESMTPSA id t13-20020a05683019ed00b006168ededf96sm12604384ott.2.2022.07.01.09.47.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 09:47:43 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-fb6b4da1dfso4263275fac.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 09:47:42 -0700 (PDT)
X-Received: by 2002:a05:6870:2326:b0:f1:7485:2a92 with SMTP id
 w38-20020a056870232600b000f174852a92mr9593871oao.291.1656694062616; Fri, 01
 Jul 2022 09:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220701021427.3120549-1-judyhsiao@chromium.org>
In-Reply-To: <20220701021427.3120549-1-judyhsiao@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 1 Jul 2022 09:47:30 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMof_NA0v_PwD6--ojrsEiMvSOpx48UWS0vmVB4xBc_VA@mail.gmail.com>
Message-ID: <CA+ASDXMof_NA0v_PwD6--ojrsEiMvSOpx48UWS0vmVB4xBc_VA@mail.gmail.com>
Subject: Re: [PATCH v1] FROMGIT: ASoC: rockchip: i2s: Fix error code when fail
 to read I2S_CLR
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Chen-Yu Tsai <wenst@chromium.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 7:14 PM Judy Hsiao <judyhsiao@chromium.org> wrote:
>
> Add the error code '-EBUSY' when fail to read I2S_CLR
> in rockchip_snd_rxctrl() and rockchip_snd_txctrl()
>
> Fixes: 44f362c2cc6d ("ASoC: rockchip: i2s: switch BCLK to GPIO")
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>

Apart from the FROMGIT subject:

Reviewed-by: Brian Norris <briannorris@chromium.org>
