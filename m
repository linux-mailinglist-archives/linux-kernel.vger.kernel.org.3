Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C0954F011
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 06:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379665AbiFQEWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 00:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379984AbiFQEWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 00:22:06 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8786663F0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 21:22:04 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m125-20020a1ca383000000b0039c63fe5f64so1798871wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 21:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QzjBrAgNA1AZjNa+pTInhm7i5DXtxxCJmOaoCVhc67o=;
        b=K+++cDQdr9cYej3ks+qHgpRRO9cxfb7XdyeS8sjTpNBayehaxo6EJtoyuIU2xwI69L
         gx6rZ8BvrkJsYfiM6qT+H6b7ZC6Y4iB70vsimWPatpV5/yNeD7umpUHHG1Eq4x8S5xlk
         V1qHnN3rFJGfWJodZ5SfBe7q5+5+j4aBJrdKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QzjBrAgNA1AZjNa+pTInhm7i5DXtxxCJmOaoCVhc67o=;
        b=e7JrsT6ePFcSVdrbmDzB/3R/PvmXDuwRFnoEwHrtdRCc5OOlap7ap9wYGS9VudRATC
         wq3nPVOhyNtSYnJ/Z8ByHpXHg/cU+mzVnZT6tIgxe6fxsbUcYc+fIrnL3PM56eW8FREm
         a+Y6ekbzr/QOrWFb1yQqPzFGJtlr1XHUyOe84T66qOpPtedwLc3wbcAJuYiQk5wWCm1z
         va3XbY0Jn11no3Y/x168ww/or/ApvdT+RKU1+7ubb3dVRe0swHa6x2H9ad8nN4rQGn9Q
         vPEfeNA0IyQ62ZZQpFMPIXB6VRwLS5QuCZgL7nNmljTxOA9RpdihbR9G3N39oOlMRUX2
         mIdA==
X-Gm-Message-State: AJIora/0Nzwb89pls9oWfD+qAxHhtoEg5qpg7PgK9apmn50Q9AE0AwWl
        6KP68YiiJajfEe0w52Ww0VxRzlCyJhZaAqxb9oHO/A==
X-Google-Smtp-Source: AGRyM1v3sERgOBqTQVjBxagXczYgYpertg9OLvxMVM+dhQu2SW0N8tDt41W3pagb/zDh/CM+9EhiOjkIxW0HRWr5Uq0=
X-Received: by 2002:a7b:c5da:0:b0:39c:542a:a07b with SMTP id
 n26-20020a7bc5da000000b0039c542aa07bmr8159751wmk.83.1655439723483; Thu, 16
 Jun 2022 21:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220616155836.3401420-1-judyhsiao@chromium.org>
 <20220616155836.3401420-2-judyhsiao@chromium.org> <YquXEgHkw08TkNuG@google.com>
In-Reply-To: <YquXEgHkw08TkNuG@google.com>
From:   Judy Hsiao <judyhsiao@chromium.org>
Date:   Fri, 17 Jun 2022 12:21:52 +0800
Message-ID: <CAJXt+b_n=B9VBvgP8hy7g48Bo2VTPXqi+qKHTX1BiwpEgUrOUQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ASoC: rockchip: i2s: switch BCLK to GPIO
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Chen-Yu Tsai <wenst@chromium.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It feels like a lot of the noise in this patch is due to adding
> additional error handling, unrelated to the real change you're making.
> Maybe that deserves a separate patch?
The error handling is to detect the failure of switching LRCLK.
If LRCLK is OFF, we don=E2=80=99t want the BCLK to be ON. So the error
handling in the patch is relevant.

> I mentioned this off-list, but the 2nd-line indentation alignment *used*
> to be in a very particular style, and you've moved that around a lot. To
> match the previous style, it should be:
>
>                 ret =3D regmap_update_bits(i2s->regmap, I2S_DMACR,
>                                          I2S_DMACR_TDE_ENABLE,
>                                          I2S_DMACR_TDE_ENABLE);
>
> (BTW, if you're using Gmail to view this, you're going to have no idea
> what I'm talking about, since it doesn't do whitespace or monospace font
> correctly...)
>
> The same applies throughout; most of the 2nd-line, 3rd-line, ...
> indentation is a little weird.
Yes, let me fix the indentation in V3, thanks!
