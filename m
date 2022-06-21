Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC983553D72
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356069AbiFUVVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355933AbiFUVUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:20:46 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AB1427E2;
        Tue, 21 Jun 2022 14:06:20 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w17so20598954wrg.7;
        Tue, 21 Jun 2022 14:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=B+AifBFHSjsojzLa/Un/BRuE3LfBPqi3dOTl8DfRwag=;
        b=jUd5EpK/oDVgY0PrmyIj4MbqMNgKMDJSXTdrkx7aDI+kKFIwzflLFxbl8tnmBcS4Tp
         gB4gaM7Xma3+XSg+VGLSGTTgAuKWgIh6oZEa3B1gj7CGcxjYDaT+mvOLqiK71CJ9lCAf
         VLJs+n52lPXvDYIMyuayGTeKnVXRXd+7SYpLLXlfBBqdyIzNsIzgV1Pov6IBTxeWpOLA
         y2WofGIr0wPjngMAcYFM5cXxiNo4M8n8MEvUAduAxgAsmqhRyoZLMLWAdXvCTVIIBRWG
         Zr/aISNe4jZxXrKY34Xe5QxN9wI5wZzSkhMqFa50UXd8ZPYof9DpGUqyIGw0r9T09fDC
         iUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=B+AifBFHSjsojzLa/Un/BRuE3LfBPqi3dOTl8DfRwag=;
        b=FA7hlEJhmVDaLCVRP6TwLLfR13LrYkKswmyxLeYOraK895gcr0C7mnMeZBpjTDkbcY
         dSa7rc52SOw7pLnln5eaq8ZeVJFPUXILL5TpuhlwSYlxWp/SVh5VHacJLg02eu4Mgp5z
         w1uFtWJ13oSrP5Lm6vpqTPvgXKDSjXFQRJA9FvoQWc7byK9DNADESI+dg6B8dBWHgK/W
         jNCplxjz8ZHQ033FW8oXYl3NUCT7OlEl8EXFjaXBhzt3V/Tylqp4KlEOlprZLD0Rp6Vh
         z4l0FOkBZ2wc0JpCH3Z4pH1Sze18HcsXzywaeHC1Ca8q6k1bvW0QGQUZJorqkUHXNwRX
         AygA==
X-Gm-Message-State: AJIora8XbEDEpnX5oSa3dMSwKy6p0mkEhuEazFsp3DnUOocG3pVktwFD
        qd/Z4lSC1Caw+QjcOnEsrMU=
X-Google-Smtp-Source: AGRyM1ts9ak9btzFswFUFoMElfPqueKySjcD1ty3sVAYSJ8wBUDzoTa0DLvFqOB9/wbjCt3Z3zA1LA==
X-Received: by 2002:a5d:47a5:0:b0:210:2b96:a952 with SMTP id 5-20020a5d47a5000000b002102b96a952mr31343094wrb.248.1655845578965;
        Tue, 21 Jun 2022 14:06:18 -0700 (PDT)
Received: from localhost (92.40.168.124.threembb.co.uk. [92.40.168.124])
        by smtp.gmail.com with ESMTPSA id j1-20020adfff81000000b00210bac248c8sm16976883wrr.11.2022.06.21.14.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 14:06:18 -0700 (PDT)
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
 <20220620200644.1961936-18-aidanmacdonald.0x0@gmail.com>
 <CAHp75VcN0hf5_AVB-aRBhyvwuojuDC=FbBUqWpUWQR=r=zSRPA@mail.gmail.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH 17/49] regmap-irq: Add broken_mask_unmask flag
In-reply-to: <CAHp75VcN0hf5_AVB-aRBhyvwuojuDC=FbBUqWpUWQR=r=zSRPA@mail.gmail.com>
Date:   Tue, 21 Jun 2022 22:07:24 +0100
Message-ID: <6DVb6JaRd4bhUPBIyfXXiqm668jAPyls@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Mon, Jun 20, 2022 at 10:08 PM Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> wrote:
>>
>> This flag is necessary to prepare for fixing the behavior of unmask
>> registers. Existing chips that set mask_base and unmask_base must
>> set broken_mask_unmask=1 to declare that they expect the mask bits
>
> Boolean should take true/false.
>
>> will be inverted in both registers, contrary to the usual behavior
>> of mask registers.
>
>> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
>> index ee2567a0465c..21a70fd99493 100644
>> --- a/include/linux/regmap.h
>> +++ b/include/linux/regmap.h
>> @@ -1523,6 +1523,7 @@ struct regmap_irq_chip {
>>         bool clear_on_unmask:1;
>>         bool not_fixed_stride:1;
>>         bool status_invert:1;
>> +       bool broken_mask_unmask:1;
>
> Looking at the given context, I would group it with clean_on_unmask above.
>
> The above is weird enough on its own. Can you prepare a precursor
> patch that either drops the bit fields of booleans or moves them to
> unsigned int?

Sure.

> Note, bit fields in C are beasts when it goes to concurrent access. It
> would be nice to ensure these are not the cases of a such.

These are read-only so there's no danger here.
