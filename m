Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4B7552E82
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349089AbiFUJgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349072AbiFUJga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:36:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C4B2715F;
        Tue, 21 Jun 2022 02:36:27 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g26so4839519ejb.5;
        Tue, 21 Jun 2022 02:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3mXXvSs4qGpLiVTug5tdC+fphrM4PCUnQdpfU/r3B4=;
        b=GZTXPEfS47hEV7elN7AWU0dyhKzNKwdabIk8g/G/aEeYWfI/AEfKiiKKiJ0evIjaEd
         FtH51zPQdYz0Wv0AmPXOMQLodWRlV7HyTinHEw6fgJQgOlyjsTl6fQZSl/ybu604W4F+
         UxX4FRJSL6jlr9oxoyyq/C/sBcO8EH2byvWx7KEErHyh/iWfN8aNrTMTHnPVZ2W1J4lS
         1/7esI1emn382GWt20lYVLjXhb37rvclxIVWEiEfxWQVq7ufkcL+iuwCEDXuZqtEs1hI
         31L1rsZzI7J12QKbgN32jIG+MHsmRs2cNl3LB3qH6J7/PgBIg4Xu7+4egEgkvTA5IXOX
         L5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3mXXvSs4qGpLiVTug5tdC+fphrM4PCUnQdpfU/r3B4=;
        b=bUkG6p78RZgOenmMJnBtDnetyk0ZI6GZPHDiMOryYm4MBh/Nx637LrLqr0XI7EzHzC
         +uU4PiqECmz3UNkcIhCdDnwE56h/hwJSzMH7TVX3AR73Z8T+sAyyLpF1h/UXRY7xOPM4
         5Im8pRb4he4CoivKXyNdccrSogHsHDFCFfbPL25GjNYx4thD14mBks21DFsubTwSl4zO
         WDHoUPgUYdL+UaBhlXZsv+Kzb7arjmM2scEHMQj8Izvd2uvsxjRWuvOza8jpWy3UVwXy
         T91q/iBGRpLeDmTldnTEn1NkSVNkYR77xk5BNiYOEh6RSrPsENOr7rf7q80/nvECfXNA
         1ZCg==
X-Gm-Message-State: AJIora/RgVFat76sdVIQPgUFp7vjRTXnprS6NazyAkryu/eSlYf73xC0
        +nzD1uFJrO6sAnNcPSIkvM+eZUGKy8ANHC8e4h0=
X-Google-Smtp-Source: AGRyM1sRYgfxiRNVCrgQTqEdasUCfu0meMegNlwo9FOn+D5YKqJkROr+llcEryQym3oDDQnhAyovKBjYaNBAW2RF8Ek=
X-Received: by 2002:a17:907:9721:b0:70c:65e7:2aa5 with SMTP id
 jg33-20020a170907972100b0070c65e72aa5mr24694089ejc.132.1655804186418; Tue, 21
 Jun 2022 02:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com> <20220620200644.1961936-20-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220620200644.1961936-20-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jun 2022 11:35:49 +0200
Message-ID: <CAHp75Vc9=fcUCAZuTAg9FTWCAtsOo8PaCdGj3NNyOwkN9PJHUA@mail.gmail.com>
Subject: Re: [PATCH 19/49] mfd: stpmic1: Add broken_mask_unmask irq chip flag
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
> The STPMIC1 has a normal "1 to disable" mask register with
> separate set and clear registers. It's relying on masks and
> unmasks being inverted from their intuitive meaning, so it
> needs the broken_mask_unmask flag.

Same comment as per previous patch and continues to all patches of a kind.

-- 
With Best Regards,
Andy Shevchenko
