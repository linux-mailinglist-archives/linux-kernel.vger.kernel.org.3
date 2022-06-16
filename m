Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB34354EA9C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378280AbiFPURp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiFPURd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:17:33 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CD9CD1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:17:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id h23so4773201ejj.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DX0lnwq0FoNDe0NHo5zKy58uDrKTU3ba2v/5ACg45Z4=;
        b=Ftx+4afl5YF/5tcf+NRZe6rqNl8IY6qTVKvED70taBft2puuoEEjqrpuI+6wzeM+6A
         nDYdLOMEoyIbdqrTHajuBCSFjvXqcyMgTZFifeNBpEpLFZ1gM0gatIsXSeI+e9eCXpoN
         IYTJ2Jfw6AVvqpaW759a5kHQiTF1p8/HAZIOFYqw0/VesAvnLL7xlhq8WZTJW/Q+girV
         zosFGF9LZoR89rNz2kkNtezOLzvoDRb34Y6ZXHJvTnUOA+iHOKVFQTZIINO0Ci0/+exg
         eTtybAaIBbs0oIoqDj1OUN2E3tcGIdjyU75XOCkNTsl/HCOvD072EqSq0kSJDB1Y5fBw
         CE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DX0lnwq0FoNDe0NHo5zKy58uDrKTU3ba2v/5ACg45Z4=;
        b=jIDNg6LbNjmExBTDDqVHIg/XbrLUlLCgYh/cR/afYiMSLnSoqX/U6+XJIwgmvpXdv3
         PTEk90XBpl8jFmHZt9+wXMasxoVuJ74dk3d81bkSYgo0/kZm/uusrqlk9ADUuzg8CTlw
         SH6v/hBGaloDAwKwyvfMTaJVzvXrxqclD0mvOs85lR4XZx4r48T9bTgya/tNFUwe9Nku
         pJamJCylJ+cmnCSOF+E7bXn7PTPrBcTeRryaScVo8WgdyvnL2Ek7q6J2kGnG6wVun7MA
         oicuXP/B0mFSBoxWKINsZ5zXmr5dQozRxuQDIrgOc41H30K/dPj9PK8IffUxJV1bggrU
         PSaw==
X-Gm-Message-State: AJIora/nwqO8ND06BxEHKI11Os7YMh/BR1WtjQANU2m2mzVTz9IdtLwu
        CaKKJr+gEFR62N8lZ87n4OefI/QziZXl/h7QnlmmsW0YrsQ=
X-Google-Smtp-Source: AGRyM1vReoKWj7a7/tslQx3VnTeuxl59MJHG6jHeVjNgYy9WKSILutmLIGTT07Uc+vE/vpKVxqEUYXfq7AuWDxwygGc=
X-Received: by 2002:a17:906:7386:b0:715:7024:3df7 with SMTP id
 f6-20020a170906738600b0071570243df7mr6017328ejl.543.1655410649682; Thu, 16
 Jun 2022 13:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220616144915.3988071-1-windhl@126.com>
In-Reply-To: <20220616144915.3988071-1-windhl@126.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 16 Jun 2022 22:17:19 +0200
Message-ID: <CAFBinCB-WZmnMtvG1P=sWASQZCg9F9d-Hg0OzVNUsEutUFX0Cg@mail.gmail.com>
Subject: Re: [PATCH] soc: amlogic: Fix refcount leak in meson-secure-pwrc.c
To:     Liang He <windhl@126.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Thu, Jun 16, 2022 at 4:50 PM Liang He <windhl@126.com> wrote:
>
> In meson_secure_pwrc_probe(), there is a refcount leak in one fail
> path.
>
> Signed-off-by: Liang He <windhl@126.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
>         pwrc = devm_kzalloc(&pdev->dev, sizeof(*pwrc), GFP_KERNEL);
> -       if (!pwrc)
> +       if (!pwrc) {
> +               of_node_put(sm_np);
>                 return -ENOMEM;
> +       }
Another approach would be to just move devm_kzalloc() a few lines
further up (above of_find_compatible_node()).
That would catch similar issues in future when someone wants to add
more code right after devm_kzalloc(). That said, I don't think that
this is a likely scenario so the patch is fine for me as-is.

Thanks a lot for submitting this!


Best regards,
Martin
