Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6AB592932
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 07:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbiHOFxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 01:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiHOFxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 01:53:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B403315FC5;
        Sun, 14 Aug 2022 22:53:40 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n4so7872072wrp.10;
        Sun, 14 Aug 2022 22:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4k3XjB+4LYnFTHTQc06HeHgf83PeLYusgDwA++J3410=;
        b=dfmCVs778K80OWQFcn8EB4/k84u6gHEUIaP4gJ7dLnudhJwfdQo6Obe/7dPL/5RktJ
         6JM0Thox2k6H9omxHW9YJ0NeevockYiQk5NzaDyH+gxnJhj+nbd9rMMYxCjwchMRhj10
         vfysOHHWh7YsgcGixO3Vu8qM48HACXe7M4mOfvL2aBLF8zWM6Hb363CBfL9hgOBs0T7w
         FNGqiy55HaFLr/OvNRDq5n/gI4jDPA2P+rU/1lZkAVFNE80SYlX35zXbbWFRv8ysyGR3
         AOjB/Yb0F+yfDnL9Ej+uhxz7X29wUhzoVr0IrLO6vsNzb6m6mZF2LzCxLK1P+uwCe7ND
         PhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4k3XjB+4LYnFTHTQc06HeHgf83PeLYusgDwA++J3410=;
        b=rOnczuntHIgMgXzAQoJnOVGtckLkK31h1aKz4pMJ1F1/p2OaBBlPsMzJNvAWG9WExE
         ckxp81s2nyeJ6eZimO4qGzQLNO97wJzEiYSd556z19qZvnMgj5r5CAacquCkFmbiL/SA
         IMEIkgigDbXMBXLAZybxlGoDSybYSCTv1ZGe0RU36gUKkqgz3Dk31Y2BrXPii1NW63Ea
         2ruy9T/3iigw0eRygl9M75ixjpSloKLS1wzE7Ny9MudvD9mUtQnWKygIM7asRPPrBzm4
         LYn73OJ4C/leOcVTS8QCvgjM1atH8spJmQnxXWTg2BfYz3PYfEwfOMEng21RUqShrxdb
         FOMw==
X-Gm-Message-State: ACgBeo2O1hDOJlsievaXCaf9k2/7lflQcLoKQSLpB2ceZ/fgfZ2e2g5k
        mtz8Q/7dTP/Ry4BvqmOMIZv26MfK4jYeNlBeCNg=
X-Google-Smtp-Source: AA6agR6W8AuZ6BQ/MgIIWbpAGIu6f2OF3gwtK46K3zEnBleB6myTFzgvziQMXVw0wKPFb2023msjXmbODxXNGngOc9g=
X-Received: by 2002:a5d:64e2:0:b0:220:7dc6:1353 with SMTP id
 g2-20020a5d64e2000000b002207dc61353mr7902778wri.411.1660542819332; Sun, 14
 Aug 2022 22:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <1660225318-4063-1-git-send-email-u0084500@gmail.com> <1660225318-4063-3-git-send-email-u0084500@gmail.com>
In-Reply-To: <1660225318-4063-3-git-send-email-u0084500@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Mon, 15 Aug 2022 08:53:28 +0300
Message-ID: <CANhJrGMnjSu3MMQ2PgvSWztNgG1r-PdyLBdsT3JVqZZSfqky-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] power: supply: rt9471: Add Richtek RT9471 charger driver
To:     cy_huang <u0084500@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Sebastian Reichel <sre@kernel.org>, alina_yu@richtek.com,
        ChiYuan Huang <cy_huang@richtek.com>, alinayu829@gmail.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ChiYuan,

Thanks for the patch :)

to 11. elok. 2022 klo 16.43 cy_huang (u0084500@gmail.com) kirjoitti:
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> Add support for the RT9471 3A 1-Cell Li+ battery charger.
>
> The RT9471 is a highly-integrated 3A switch mode battery charger with
> low impedance power path to better optimize the charging efficiency.
>
> Co-developed-by: Alina Yu <alina_yu@richtek.com>
> Signed-off-by: Alina Yu <alina_yu@richtek.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---

> +
> +static const struct linear_range rt9471_chg_ranges[RT9471_MAX_RANGES] = {
> +       [RT9471_RANGE_AICR] = { 50000, 1, 63, 50000 },
> +       [RT9471_RANGE_MIVR] = { 3900000, 0, 15, 100000 },
> +       [RT9471_RANGE_IPRE] = { 50000, 0, 15, 50000 },
> +       [RT9471_RANGE_VCHG] = { 3900000, 0, 80, 10000 },
> +       [RT9471_RANGE_ICHG] = { 0, 0, 63, 50000 },
> +       [RT9471_RANGE_IEOC] = { 50000, 0, 15, 50000 },
> +};

I just jumped in to ask if that could you please use the field names? Eg.
 { .min = 50000, .min_sel = 1, .max_sel = 63, .step = 50000 },

This would make it less error prone in case someone changes the
members in struct linear_range.

> +
> +static int rt9471_set_value_by_field_range(struct rt9471_chip *chip,
> +                                          enum rt9471_fields field,
> +                                          enum rt9471_ranges range, int val)
> +{
> +       unsigned int sel;
> +
> +       if (val < 0)
> +               return -EINVAL;
> +
> +       linear_range_get_selector_within(rt9471_chg_ranges + range, val, &sel);
> +
> +       return regmap_field_write(chip->rm_fields[field], sel);
> +}
> +
> +
> +static int rt9471_get_value_by_field_range(struct rt9471_chip *chip,
> +                                          enum rt9471_fields field,
> +                                          enum rt9471_ranges range, int *val)
> +{
> +       unsigned int sel, rvalue;
> +       int ret;
> +
> +       ret = regmap_field_read(chip->rm_fields[field], &sel);
> +       if (ret)
> +               return ret;
> +
> +       ret = linear_range_get_value(rt9471_chg_ranges + range, sel, &rvalue);
> +       if (ret)
> +               return ret;
> +
> +       *val = rvalue;
> +       return 0;
> +}
> +
> +static inline int rt9471_set_hiz(struct rt9471_chip *chip, int enable)
> +{
> +       return regmap_field_write(chip->rm_fields[F_HZ], enable);
> +}
> +
> +static inline int rt9471_set_ichg(struct rt9471_chip *chip, int microamp)
> +{
> +       return rt9471_set_value_by_field_range(chip, F_ICHG_REG,
> +                                              RT9471_RANGE_ICHG, microamp);
> +}
> +
> +static inline int rt9471_get_ichg(struct rt9471_chip *chip, int *microamp)
> +{
> +       return rt9471_get_value_by_field_range(chip, F_ICHG_REG,
> +                                              RT9471_RANGE_ICHG, microamp);
> +}
> +
> +static inline int rt9471_set_cv(struct rt9471_chip *chip, int microvolt)
> +{
> +       return rt9471_set_value_by_field_range(chip, F_VBAT_REG,
> +                                              RT9471_RANGE_VCHG, microvolt);
> +}
> +
> +static inline int rt9471_get_cv(struct rt9471_chip *chip, int *microamp)
> +{
> +       return rt9471_get_value_by_field_range(chip, F_VBAT_REG,
> +                                              RT9471_RANGE_VCHG, microamp);
> +}
> +
> +static inline int rt9471_set_mivr(struct rt9471_chip *chip, int microvolt)
> +{
> +       return rt9471_set_value_by_field_range(chip, F_MIVR,
> +                                              RT9471_RANGE_MIVR, microvolt);
> +}
> +
> +static inline int rt9471_get_mivr(struct rt9471_chip *chip, int *microvolt)
> +{
> +       return rt9471_get_value_by_field_range(chip, F_MIVR,
> +                                              RT9471_RANGE_MIVR, microvolt);
> +}
> +
> +static inline int rt9471_set_aicr(struct rt9471_chip *chip, int microamp)
> +{
> +       return rt9471_set_value_by_field_range(chip, F_AICR, RT9471_RANGE_AICR,
> +                                              microamp);
> +}
> +
> +static inline int rt9471_get_aicr(struct rt9471_chip *chip, int *microamp)
> +{
> +       return rt9471_get_value_by_field_range(chip, F_AICR, RT9471_RANGE_AICR,
> +                                              microamp);
> +}
> +
> +static inline int rt9471_set_iprechg(struct rt9471_chip *chip, int microamp)
> +{
> +       return rt9471_set_value_by_field_range(chip, F_IPRE_CHG,
> +                                              RT9471_RANGE_IPRE, microamp);
> +}
> +
> +static inline int rt9471_get_iprechg(struct rt9471_chip *chip, int *microamp)
> +{
> +       return rt9471_get_value_by_field_range(chip, F_IPRE_CHG,
> +                                              RT9471_RANGE_IPRE, microamp);
> +}
> +
> +static inline int rt9471_set_ieoc(struct rt9471_chip *chip, int microamp)
> +{
> +       return rt9471_set_value_by_field_range(chip, F_IEOC_CHG,
> +                                              RT9471_RANGE_IEOC, microamp);
> +}
> +
> +static inline int rt9471_get_ieoc(struct rt9471_chip *chip, int *microamp)
> +{
> +       return rt9471_get_value_by_field_range(chip, F_IEOC_CHG,
> +                                              RT9471_RANGE_IEOC, microamp);
> +}
> +
> +static inline int rt9471_set_chg_enable(struct rt9471_chip *chip, int enable)
> +{
> +       return regmap_field_write(chip->rm_fields[F_CHG_EN], !!enable);
> +}
> +

//snip

> +
> +static inline struct rt9471_chip * psy_device_to_chip(struct device *dev)
> +{
> +       return power_supply_get_drvdata(to_power_supply(dev));
> +}

While skimming through the rest of the patch... This may just be my
personal preference but wrapper functions with just one line are
rarely beneficial. In the worst case they just add more lines AND hide
the details of what actually is done without any clear benefits. Well,
this is just my view so please ignore this comment if wrappers like
this are a "subsystem standard"

Other than that the patch looks good to me.

--

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
