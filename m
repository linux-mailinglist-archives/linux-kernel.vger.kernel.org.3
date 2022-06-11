Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9866B5475A4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 16:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbiFKOas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 10:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiFKOar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 10:30:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5A570921;
        Sat, 11 Jun 2022 07:30:46 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v14so1931322wra.5;
        Sat, 11 Jun 2022 07:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version;
        bh=sD6DZtzCxz1XGT4WP0KYWyA1V0wDI+6N4mhrYaf6wNc=;
        b=gvnIOjt4Yjh2RWXfj+r3iQqN9qQzZO9jZpNw7iJIHm91kYhMWKpONFiQTuAQvAOEa9
         xj0ctN5tFYk4q/kwtDS0XATZ4INKq21QyU6qFaxs6T6scR6NmA7obRyBBfhKZYP7xqZo
         3r2SgAtYkpfE5Fsdf0Ny8Pn3+ISy3mEkEjUC79EdrKSdOaBRg+tpddnimAI7hwq/sUqD
         gr0HkaG38EEiPAC49r48WgO2dAHX9iBqGWQau3VLaUUC7rF9f8WUuOmn2ksr6s0pfyG/
         7+iFC5adxxx70Aa74xmp0D9+JirD5g1T/FdytE4AtUg8gm+D7GF606CbHASxiXA2UVxI
         h8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=sD6DZtzCxz1XGT4WP0KYWyA1V0wDI+6N4mhrYaf6wNc=;
        b=EjuDij0Ho1Tr3q8YvbisHHsJKyVvWA2aBbkV4z8+3V5tktoSEVgO8BLJnEmb4JlEpc
         9QeZRJZfCB2Z8/uP93uwNOxspMkBDl7ER8iTS1ZhI9EH2VucTfHmqYcVVbllfIn8L5xx
         uskn5koERzm0bTbS8T4+2gqtmf1hSYLjoa5lto0Wjk4xSWHZxQMEDD+M0wPi4rKtPSdQ
         9EOKrDcqISpXk6T5Bq5hH5ULJY8QCeSh98UfyrSFuzxQpVqNo+RzDvFt6S1WMV99jwj5
         P9jEYcmjHeApvKzCQTD76kPjjNlPoNctMTdBRnh1isZuehoKcWPG09W9cIN1L+gJ1WUN
         quPQ==
X-Gm-Message-State: AOAM530o7psdCxWcPp6+oa+RB2TLZQ8quNaFv99yLR9yzb0C6BFdy6Yb
        ckb/K2OoThCCyiDssMPVcoc=
X-Google-Smtp-Source: ABdhPJzBEpGcZhzolH3y0re0vAoAh7rSVG7272hENxhaAsPczjmKCuMzU2JQfTQY0ee/wUwmBvQHuQ==
X-Received: by 2002:a5d:5885:0:b0:218:3d12:e0eb with SMTP id n5-20020a5d5885000000b002183d12e0ebmr32847579wrf.510.1654957844444;
        Sat, 11 Jun 2022 07:30:44 -0700 (PDT)
Received: from localhost (92.40.203.182.threembb.co.uk. [92.40.203.182])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c2cac00b003942a244f40sm7233181wmc.25.2022.06.11.07.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 07:30:43 -0700 (PDT)
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
 <20220607155324.118102-3-aidanmacdonald.0x0@gmail.com>
 <YqDLflKTsYaupArl@sirena.org.uk>
 <6YJcC5wyOg6x6Ny4Os8ujFbK2qB4alkU@localhost>
 <YqN1iTyyiRx4/CMf@sirena.org.uk>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, gregkh@linuxfoundation.org,
        lgirdwood@gmail.com, lars@metafoo.de, rafael@kernel.org,
        quic_gurus@quicinc.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 02/17] regmap-irq: Add get_irq_reg to support unusual
 register layouts
Date:   Sat, 11 Jun 2022 15:22:30 +0100
In-reply-to: <YqN1iTyyiRx4/CMf@sirena.org.uk>
Message-ID: <xU4ZOVJZM7e2sDSZJ2mAJIBPI1teACp7@localhost>
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


Mark Brown <broonie@kernel.org> writes:

> On Fri, Jun 10, 2022 at 04:40:20PM +0100, Aidan MacDonald wrote:
>> Mark Brown <broonie@kernel.org> writes:
>> > On Tue, Jun 07, 2022 at 04:53:09PM +0100, Aidan MacDonald wrote:
>
>> >> -	if (!chip->sub_reg_offsets || !chip->not_fixed_stride) {
>> >> +	if (chip->get_irq_reg) {
>> >> +		reg = chip->get_irq_reg(base_reg, i);
>> >> +	} else if (!chip->sub_reg_offsets || !chip->not_fixed_stride) {
>
>> > It seems like it would be cleaner and clearer to refactor things so that
>> > we always have a get_irq_reg() with standard chips getting given a
>> > default implementation which implements the current behaviour.
>
>> I don't think that is a good way to clean things up. I only intended
>> get_irq_reg() to be a quick hack to solve a problem; in my opinion it
>> would be a poor abstraction to base the API around.
>
> I'm not sure why you are proposing this change if you are so convinced
> it's a bad idea.  If you want to propose a different rework go ahead,
> but adding the new operation without any form of factoring out is an
> issue.  At first glance your suggestion looked plausible.

This patch isn't a refactor and I don't think it's a bad idea when
viewed as minimal solution to a problem, which was my intention.
I just think it wouldn't be a good abstraction to refactor around.
Thanks for your input anyhow.

Just as a heads up, I'll be resending these regmap-irq patches in v3
so the series stays self-contained while I work on refactoring. Feel
free to ignore them if you don't want to take them.
