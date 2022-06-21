Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3A1552E6B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348978AbiFUJeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348964AbiFUJeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:34:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4B825C7F;
        Tue, 21 Jun 2022 02:34:13 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cf14so8767711edb.8;
        Tue, 21 Jun 2022 02:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c7tGMV7/SSO3JozWEHbkFTrboHXpmm3VDf/oaKBPuDs=;
        b=BUGmrcAUC+BxJxranrDe0YJYzGvQkDLTBZjdzWtcfzrpUMCnxTVONXV0mU3URS5tLL
         aEOSB9xjhNccR9NdTm0PXAB31J+uj3WMdOSSAcTNqu5PPt4bWhBbZj33RozwJCD/yiKw
         aHWzcKV8n5eWavzTVIcGpfPCfSHFkmxIrynAq1xxs+lS4+qvsptHbhl4YwmwptrNB3Nm
         BqUf9oYH5JyI1RkDsf7QjLD7aLBiXMcbClIMDqdNnscmsnklX7J0ionOlcwtPKbTTD6W
         MWo/2NK17ioZE0f4OZTLPJxUbR3T9Flg/zpzKS0On4R8An+t7QKX8I7HCC+lq7kqxQUE
         aL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c7tGMV7/SSO3JozWEHbkFTrboHXpmm3VDf/oaKBPuDs=;
        b=TEaSHaAhNVb8CWbwmRh1vvD/nB/ECDkW+UHJmbfMJi30FMpKohP7w30NU9eEW4Sbro
         5BATQXEcjyCRS1Vlz7XVzSWCeLFDnNo9y/WHEq2gnmS9F46xou9zti4VEi9vqlfClv1P
         wZ7cudz6eHKQAgTcHb8Tn4OAS0vS0q1Fwy5C3Rf8tDvknhkHCs/Fn6ePfhiTjoSPRF2b
         Jc/yWkN6iLmSRHbp1rKy6LpIBgaAIoTpmNg4lZgVVKYn9j7GzdX73Hnw1dgIeh70M6fD
         WvupNsm1hC44aGoGGKoxeDuh7WmppukFtAfybko30VFaavBKXqo0AhtLtSev6b7DT1Uo
         LHHQ==
X-Gm-Message-State: AJIora8olAy+G95ki6va6oxq9ZcMU8udERr6eHHjEdzKjtHmjJO4n0Ay
        oKxpsJJyhDG47FgeHjvoIzocSZPkmka6u8lLgYI=
X-Google-Smtp-Source: AGRyM1vl6qAENnpkydkK4orwRZWx0Z6A0R1L281fxwrvs+ww8MsmgIRorfjJHWF6QSaoxaSyeHSEr2OQ0e5QEiIHYqg=
X-Received: by 2002:a05:6402:4390:b0:42e:b7e:e9ac with SMTP id
 o16-20020a056402439000b0042e0b7ee9acmr34705675edc.97.1655804052209; Tue, 21
 Jun 2022 02:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com> <20220620200644.1961936-18-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220620200644.1961936-18-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jun 2022 11:33:35 +0200
Message-ID: <CAHp75VcN0hf5_AVB-aRBhyvwuojuDC=FbBUqWpUWQR=r=zSRPA@mail.gmail.com>
Subject: Re: [PATCH 17/49] regmap-irq: Add broken_mask_unmask flag
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, tharvey@gateworks.com,
        rjones@gateworks.com, Matti Vaittinen <mazziesaccount@gmail.com>,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-actions@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
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

On Mon, Jun 20, 2022 at 10:08 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> This flag is necessary to prepare for fixing the behavior of unmask
> registers. Existing chips that set mask_base and unmask_base must
> set broken_mask_unmask=1 to declare that they expect the mask bits

Boolean should take true/false.

> will be inverted in both registers, contrary to the usual behavior
> of mask registers.

> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index ee2567a0465c..21a70fd99493 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -1523,6 +1523,7 @@ struct regmap_irq_chip {
>         bool clear_on_unmask:1;
>         bool not_fixed_stride:1;
>         bool status_invert:1;
> +       bool broken_mask_unmask:1;

Looking at the given context, I would group it with clean_on_unmask above.

The above is weird enough on its own. Can you prepare a precursor
patch that either drops the bit fields of booleans or moves them to
unsigned int?

Note, bit fields in C are beasts when it goes to concurrent access. It
would be nice to ensure these are not the cases of a such.

-- 
With Best Regards,
Andy Shevchenko
