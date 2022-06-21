Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35964552F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349401AbiFUJp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiFUJpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:45:54 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FE327B3F;
        Tue, 21 Jun 2022 02:45:53 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id o10so18580215edi.1;
        Tue, 21 Jun 2022 02:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CTHYGS8g7sCFv5p4IGpE8ByIK0vfNIUXHpKKS2cHepQ=;
        b=aZan9a+4JhusAULYzHK4QFgDvTJUfc7zekQyAVoRGCyOHUagzlr3IY3SntNiCuk2D1
         NQjyRuwmILTBnDHyj8RbP6weJG7bsYc7fpeAX5WMX7NI80xLjR2pEQelEAuHWyLISW03
         dZaw/laN5sK9zCYrzCpBc92fUeGmzlgcNNnV+C/p3f0do3S2Xro53gDdPjHT4fWtJj81
         rYkou1ikTNpl6+XOXXlO5K890puNv8x9VBAb1IKHcoUKaWjKVctK6anPKEkAjSj3/2W5
         5VnldB0KCYV6EffLfKh44jApav4JdfNauC+sb7GhpOh85EPNh735t0b35swaLkY44kt/
         +liQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CTHYGS8g7sCFv5p4IGpE8ByIK0vfNIUXHpKKS2cHepQ=;
        b=kZUo2jRznMp5XfjLcAuBeECKC8lzI+QsrE70OpVq5nC5q5O9ihG9d6rp2lAlPR/xAb
         zltZSQlGuK1WzBpBoy7IKOyrbkf6zOIfbjcPLkOA2QCkGP32i1GfwR0QJht0jYSPwjsb
         twQAxEj/AWrTp2BXgPRyqA1/I+OEaJ3y02Oi23YqiGdKeBGXGWlf6YEyNs3rnK3MnVIR
         s15QPax3CIrY+vZNto8dpEvi4UDkmrzaYNGQf+LSp9IZdLTpP8Au+zuHPeyf/6OsRqEQ
         A15twnYf2srpKYdMwShgUF+ktJEttgRJ29o1UuuaGpgcD1mr5w85tAsr80DjelB56rMI
         R5Ng==
X-Gm-Message-State: AJIora+7j6MNdvZ9wR8Fo4UTzv+8y9g0YeDx7X0ovV2EIKlXUKYVuwa+
        36JCxSctVAQG9AxXjjbGJs/rArVYDqBN9cK/SkM=
X-Google-Smtp-Source: AGRyM1u+LlqfMEeQQX/kZr8ewmIWAzmzCCS9cETMG4/8g63994DOIJmrlDmEJXOU2GEP6EkqBPGnv4N6VF0F7gWLvvI=
X-Received: by 2002:a05:6402:f8d:b0:435:6df2:68a with SMTP id
 eh13-20020a0564020f8d00b004356df2068amr20143116edb.209.1655804752004; Tue, 21
 Jun 2022 02:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com> <20220620200644.1961936-47-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220620200644.1961936-47-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jun 2022 11:45:15 +0200
Message-ID: <CAHp75VcidJzb+1-uNMuDCKPSaxKkCdKnB=iF33g_PqaiyHAN8g@mail.gmail.com>
Subject: Re: [PATCH 46/49] regmap-irq: Refactor checks for status bulk read support
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

On Mon, Jun 20, 2022 at 10:11 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> There are several conditions that must be satisfied to support
> bulk read of status registers. Move the check into a function
> to avoid duplicating it in two places.

...

> -       } else if (!map->use_single_read && map->reg_stride == 1 &&
> -                  data->irq_reg_stride == 1) {
> +       } else if (regmap_irq_can_bulk_read_status(data)) {

>

While at it, you may drop this unneeded blank line.

>                 u8 *buf8 = data->status_reg_buf;
>                 u16 *buf16 = data->status_reg_buf;

-- 
With Best Regards,
Andy Shevchenko
