Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68664D72D5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 06:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbiCMFmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 00:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiCMFmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 00:42:06 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDAB3C498
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 21:40:59 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id k25so14615247iok.8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 21:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GSJXVOht+hxS+hKjGxwt1A2kwmz24g3we9uVLX8KopE=;
        b=YKGzICi38ZdGllMCcDcm5P019Hzk9qjMGjdUtEOTG6PrbMVwtdJED138/+dcUNJW37
         M4YDt8UYxW0rGnnszHqbINRl77Hy57S1GXAeN2NANfA12J3+gfXP8O4fazpmxCCkTOFM
         HcaMKQbX0E0+Jk14W7fQEaLurkevYy7+ez4GFFBwQ5QNZ7Mr9gnNEAIgw0eUdhWUc6mX
         vbpVvf6+7acpdDUkGFWnMdhwCP15pnvL3YFI3WuN02hmF6Y7cghfZr4ejvTHduHlte0q
         h9wKR8u3YcHJpGf2lw3JtCj1KIXj+bwHr0F65o0dzhMxNIoswE7zCM9peC4iNGbk28kw
         DgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GSJXVOht+hxS+hKjGxwt1A2kwmz24g3we9uVLX8KopE=;
        b=w8wU+9kJNj0mvTaDTwnSYkgiEi/eLLv4fJfV/5oTCIwwzn8rsW/wtlXV68jUdEfH9e
         eQCRSMsXWNGvvrHTdBa5OfVERM5cN7G54tKgKnp6xbOncji0cns88m4qFsysC6Yn9Ns1
         pi0a7cXhHV5axVkrHmDcVHN9AfCotpOrzb4Uwq6+yjHJZr+XzYt0IpUzRk2TnKwYBd31
         WnBm7VnK++nDpm/+RD2joWVIh6163M+DbaSd11sHdM7Pg8etocoQNQwpfAwSdIRCaY2g
         I+MpjoxsQ7rohQE92PDHk3lirRhOHv249KcwP+RJPIEWMhftxJa0uHLSa3cX7umgzlLT
         2rmw==
X-Gm-Message-State: AOAM5315JQFnI97cDxLtQmtQSYI1Mko0JwvsZ92R3r1uALxlio1Az9jZ
        TDOmwL4BpJlLdBONtBZBfy5WKAVhteo+JCV19iw=
X-Google-Smtp-Source: ABdhPJxu7ye+5lUKnrkn1bUsxZOh3PujZfDdrVrbl47wn8G69XzlTWbp5OhrlNhDuwFwRjkewn9FUbk/Ra5fo2kWG+0=
X-Received: by 2002:a05:6602:1341:b0:637:d4dc:6f85 with SMTP id
 i1-20020a056602134100b00637d4dc6f85mr13993251iov.155.1647150058869; Sat, 12
 Mar 2022 21:40:58 -0800 (PST)
MIME-Version: 1.0
References: <20220312002429.16175-1-steve.lee.analog@gmail.com> <009acb4c-d59c-c1ad-60b0-cc85fe7ad73d@kernel.org>
In-Reply-To: <009acb4c-d59c-c1ad-60b0-cc85fe7ad73d@kernel.org>
From:   Lee Steve <steve.lee.analog@gmail.com>
Date:   Sun, 13 Mar 2022 14:40:48 +0900
Message-ID: <CA+Fz0PZ0+Fn3_X8vtcL52pQFn3kQCnU1cBFNwif3XkP76HYXYA@mail.gmail.com>
Subject: Re: [RESEND V2] ASoC: max98390: Add reset gpio control
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
        perex@perex.cz, tiwai@suse.com, ckeepax@opensource.cirrus.com,
        geert@linux-m68k.org, rf@opensource.wolfsonmicro.com,
        shumingf@realtek.com, srinivas.kandagatla@linaro.org,
        jack.yu@realtek.com, "Sa, Nuno" <nuno.sa@analog.com>,
        ryans.lee@maximintegrated.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
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

On Sat, Mar 12, 2022 at 7:40 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 12/03/2022 01:24, Steve Lee wrote:
> >  Add reset gpio control to support RESET PIN connected to gpio.
> >
> > Signed-off-by: Steve Lee <steve.lee.analog@gmail.com>
> > ---
> >  sound/soc/codecs/max98390.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
> > index 40fd6f363f35..9a9299e5cc5a 100644
> > --- a/sound/soc/codecs/max98390.c
> > +++ b/sound/soc/codecs/max98390.c
> > @@ -1022,6 +1022,7 @@ static int max98390_i2c_probe(struct i2c_client *i2c,
> >
> >       struct max98390_priv *max98390 = NULL;
> >       struct i2c_adapter *adapter = i2c->adapter;
> > +     struct gpio_desc *reset_gpio;
> >
> >       ret = i2c_check_functionality(adapter,
> >               I2C_FUNC_SMBUS_BYTE
> > @@ -1073,6 +1074,17 @@ static int max98390_i2c_probe(struct i2c_client *i2c,
> >               return ret;
> >       }
> >
> > +     reset_gpio = devm_gpiod_get_optional(&i2c->dev,
> > +                                          "maxim,reset-gpios", GPIOD_OUT_LOW);
> > +
>
> I don't know why did you CC me, but since I am looking at this - you
> have to update bindings.
>
> Do not add random properties to drivers without updating bindings.
>
> Best regards,
> Krzysztof

Thanks for comment. Yes, I update bingding too.
