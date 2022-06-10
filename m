Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1DD546997
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 17:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243085AbiFJPkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345716AbiFJPjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:39:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4602C2945D3;
        Fri, 10 Jun 2022 08:39:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x17so37038818wrg.6;
        Fri, 10 Jun 2022 08:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=lDs0f6JF55MHIk/t/TfjogcLJDmfZp7/A5wIaXzlaf8=;
        b=li59IGhcLOA4Pkjsd+Vtes147qjbfhFlmRxWyiIrDnZMN2emNvY6BXUsjOZGdrcWk0
         yVSGQ7wR3K0cdRfFLdo6u2K24ap8exuX5l7DBhkE1/pHzFJqGD7mPNBgGOrG6K8FErTU
         lm1v53nbf0GaGZWqxot0/um58pMUOW9mpF+gbx6nYx4YzjR3KhjBBzGWbxwr8Vjw5ukG
         JZzyTRKcA58Ot511yq8s/MCd11UQIaKSbg37tZhEDavyWBweLqqswGJtyjPYhZhH6wO3
         T3/UBAqj7k4E4DIF1w045/yqBQoadxokIBdet1PIxahLCuL/BIP6Q0f8H/0eKS8iyRoP
         2cTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=lDs0f6JF55MHIk/t/TfjogcLJDmfZp7/A5wIaXzlaf8=;
        b=pJLFHG8ealbei0T7CeaR0/yuaRAacG8VfMsL5DX3EWzoZ3tzn/S8bQE5Tf9tSh20fg
         vvJg11sCGI8mmoliwbzP+QoiC8IgIMYsYA1VjTljrZTt5WAEBEPEz3Hhnlfiko8LjOd9
         MV6DELQiR12PlPF/5HpUfrvEXiwEIwgTafndRc7BIbiDPZwAgDMstImgJ8GdmZ3YwNbX
         EwOUZC2F/AoS5u4yeBqzL5YgtOUMlMiIgPBoivEjaneqE3hp2fM/3B3aqWadkky+Vdfh
         UpbBZJCbsWUSATA25wTPXd22Echo9xXmuxC+sQT7P0uHdt50I8NvZsLmxUxAapwAdjFe
         uc6A==
X-Gm-Message-State: AOAM533FZN6c03EGP9STZ4QYYZ/160RIXtLmxQpU2X4CPZiZ/rynuhn7
        3ehCojCT/YJUVOq0HenzX8c=
X-Google-Smtp-Source: ABdhPJwGmqYpYsIC0t+NWmaEktPoWU3Qlz6ypFrPjd/068LoqvQJ936cDgELud2OB0igQUGMsYKX8g==
X-Received: by 2002:a5d:47c1:0:b0:217:1bfc:56c2 with SMTP id o1-20020a5d47c1000000b002171bfc56c2mr31072848wrc.336.1654875559184;
        Fri, 10 Jun 2022 08:39:19 -0700 (PDT)
Received: from localhost (92.40.202.174.threembb.co.uk. [92.40.202.174])
        by smtp.gmail.com with ESMTPSA id q2-20020a05600c2c0200b003942a244f51sm3334095wmg.42.2022.06.10.08.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 08:39:17 -0700 (PDT)
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
 <20220607155324.118102-3-aidanmacdonald.0x0@gmail.com>
 <YqDLflKTsYaupArl@sirena.org.uk>
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
In-reply-to: <YqDLflKTsYaupArl@sirena.org.uk>
Date:   Fri, 10 Jun 2022 16:40:20 +0100
Message-ID: <6YJcC5wyOg6x6Ny4Os8ujFbK2qB4alkU@localhost>
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

> On Tue, Jun 07, 2022 at 04:53:09PM +0100, Aidan MacDonald wrote:
>
>> -	if (!chip->sub_reg_offsets || !chip->not_fixed_stride) {
>> +	if (chip->get_irq_reg) {
>> +		reg = chip->get_irq_reg(base_reg, i);
>> +	} else if (!chip->sub_reg_offsets || !chip->not_fixed_stride) {
>
> It seems like it would be cleaner and clearer to refactor things so that
> we always have a get_irq_reg() with standard chips getting given a
> default implementation which implements the current behaviour.

I don't think that is a good way to clean things up. I only intended
get_irq_reg() to be a quick hack to solve a problem; in my opinion it
would be a poor abstraction to base the API around.

What I'd suggest is something that will simplify regmap-irq. Instead of
defining the base registers, etc. in the chip, introduce a new struct
to describe a register group:

    struct regmap_irq_reg_group {
        unsigned int status_base;
        unsigned int mask_base;
        ...

        unsigned int irq_reg_stride;

        int num_regs;
    };

The idea is that the registers in a group are linearly mapped using the
formula "base + (i * irq_reg_stride)". Then it's possible to allow for
multiple register groups in regmap_irq_chip:

    struct regmap_irq_chip {
        const struct regmap_irq_reg_group *groups;
        unsigned int num_groups;

        unsigned int main_status_base;
        unsigned int num_main_status_bits;
        int num_main_regs;

        ...
    };

It should be straightforward to fit existing chips into this model.

- "Normal" chips which do not use sub_reg_offsets or not_fixed_stride
  will have a single register group describing their register layout.

- Chips which use not_fixed_stride=1 (eg. qcom-pm8008.c) will define
  multiple register groups instead of using sub_reg_offsets, so they
  will look more like a normal chip.

- Chips that use a main status + sub-block IRQ layout will define
  one register group for each sub-block and continue to describe the
  location of the main status registers inside of regmap_irq_chip.
  A group will only get polled if the corresponding main status bit
  is set -- n'th group is polled if n'th bit is set.

I think this scheme is easier to understand than having three or four
different hacks to deal with minor deviations from the simple cases.
It's also more flexible because groups do not need to be homogenous,
unlike the way sub_reg_offsets works.

For the AXP192, I'd just need to add two register groups, one for IRQ0-3
and another with IRQ4 off by itself. So this would remove the need for
get_irq_reg() entirely.

On the other hand, basing the public API around get_irq_reg() doesn't
appear to simplify any existing use case.

What do you think? If you're happy with the idea I don't mind doing the
refactoring in a separate patch series.

I had hoped to avoid a big refactor just to add one chip, though.

Best regards,
Aidan
