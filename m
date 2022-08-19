Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED84F59A97B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237465AbiHSX2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbiHSX2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:28:00 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846E4114196;
        Fri, 19 Aug 2022 16:27:52 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id j2so5904294vsp.1;
        Fri, 19 Aug 2022 16:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=S5hEEHWwiNg2k4v549E4aszQCunYEI4sx3nLM1GzVyw=;
        b=Xo91q4wHdMEv6mkWdK1iVOirDjLT9n3Hl7r1ukV7j2UkFCo69Rc+cAHQMIr1eD12OJ
         FScZar+W3DjhY6S+6le54/2QZIsoh/afIDT24EA6uTWEczNr8RscpQWFedIKwWpqg996
         1J+uRNjyLWZLyH7ziBd3dPGeQnVjPAK7nrs6YF7pv0iK4twegX2QCKjsuRaKZUb5Iizt
         EFAU7Abe29FkXsO5iccQWa0/Yp1yl1y8xl5g6tia4xHtwIff/+MbReupf82asEusb+CF
         UQu54CzuidnIGK99Fb5PihHw8JHX24b9cSoHnjXW6rYAqHfizVxmfwXK3bXSVc4vpdGM
         nxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=S5hEEHWwiNg2k4v549E4aszQCunYEI4sx3nLM1GzVyw=;
        b=MPA/XF1Eb1Z4bQe04Au3F2O0fBCQUD/RGOGcGomDFz4xjHGveZIn1Le0qEu1p+YUGd
         w6tYIA7J+UAoevRkW16NX7JepMxVDHA18dASMzMjKMKJ/fLC9PEFwXbki6Xedfcd3mLk
         pFsRZvW3Fi02FP3pf4pEOuWIVu8SZj2LkSCORTbNNZYIU2etMJrXf8cuVtgshLNAr5Pu
         Y5MJR3CH+5PWMJxW1gssZQzAzzsbeRdu+BvrJHToak/Rvc0SI3avKwrHX+gC9CtFqIxJ
         da5KSvXw2m0IcU3HDG9uzr/1OduIlPYqPDDT9y9yHxE+gTF//56bIgKj3g5oupDByNTb
         IsRQ==
X-Gm-Message-State: ACgBeo0C9pSXx9vZIDjtVSMFbrQQCLqjePVVPz98Oe6D1HnbwBFC2U3E
        ourSwA5GFInkB9jLPENr0J5cqL3MVMgSqe7lMxk=
X-Google-Smtp-Source: AA6agR4aZOaEro5daSKUdeT2RJVo7AImgpeqXvvIo0V84bpkcQrdEfkHLqcHycEYpUgzgMskEPDS+gA/3V8uYDpz4MQ=
X-Received: by 2002:a67:e050:0:b0:390:3963:eb5b with SMTP id
 n16-20020a67e050000000b003903963eb5bmr1017980vsl.7.1660951671566; Fri, 19 Aug
 2022 16:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660934107.git.mazziesaccount@gmail.com>
In-Reply-To: <cover.1660934107.git.mazziesaccount@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 20 Aug 2022 02:27:14 +0300
Message-ID: <CAHp75VfZ+aoo9btTk+8kmOak4PN0Pc7L7RBQMv2SNC2agMbpsg@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Use devm helpers for regulator get and enable
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Alexandru Lazar <alazar@startmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-hwmon@vger.kernel.org, linux-iio <linux-iio@vger.kernel.org>
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

On Fri, Aug 19, 2022 at 10:20 PM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> Use devm helpers for regulator get and enable
>
> NOTE: The series depends on commit
> ee94aff2628b ("Devm helpers for regulator get and enable")
> which currently sits in Mark's regulator/for-next
>
> A few* drivers seem to pattern demonstrated by pseudocode:
>
> - devm_regulator_get()
> - regulator_enable()
> - devm_add_action_or_reset(regulator_disable())
>
> devm helpers for this pattern were added to remove bunch of code from

remove a bunch

> drivers. Typically following:
>
> - replace 3 calls (devm_regulator_get[_optional](), regulator_enable(),
>   devm_add_action_or_reset()) with just one
>   (devm_regulator_get_enable[_optional]()).
> - drop disable callback.
>
> I believe this simplifies things by removing some dublicated code.

duplicated

> This series reowrks a few drivers. There is still plenty of fish in the

reworks

> sea for people who like to improve the code (or count the beans ;]).
>
> Finally - most of the converted drivers have not been tested (other than
> compile-tested) due to lack of HW. All reviews and testing is _highly_
> appreciated (as always!).

...

>   docs: devres: regulator: Add new get_enable functions to devres.rst
>   clk: cdce925: simplify using devm_regulator_get_enable()
>   gpu: drm: simplify drivers using devm_regulator_*get_enable*()
>   hwmon: lm90: simplify using devm_regulator_get_enable()
>   hwmon: adm1177: simplify using devm_regulator_get_enable()

hwmon uses a different pattern for the Subject line.

-- 
With Best Regards,
Andy Shevchenko
