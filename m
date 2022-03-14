Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1211D4D7D24
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbiCNIGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238194AbiCNIDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:03:41 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD98845500
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:00:37 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso1118875wmr.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Cfv85awAmoyZzNe4XhXxrHLPFirYqlR4GxEuXMqMPG0=;
        b=DpH1bJNPog08D3meVY94qXN/ZTbqAbz22x6qEBi18AI0VYBHw6WBAPeMRRQHnLK3ar
         6HYGEv/sONT9p/YzmzdZ6x0n5bTSIzEpRrq8evBqUfUerZXm9mDecwejCayDb70xdG7A
         si5mAoEzOlZ9dvqP5coB2biSOtdVjibaVqwRORZpNfXQ1Guq+mQvlEsWdnkKdQ0KiIRS
         Cw8OHPaLOI7KY6AZESsF9Pl7sTyfKGx+6PnvoM0AbaY+3rToip30Sp2dwCH4yZO/XLXZ
         n3baygYKvIa3OTUtAteiF+YGnrI3kDcuOZyiUdN+6MMRuuF0d/Ik0M4DmI6pU7V3rkmD
         HSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Cfv85awAmoyZzNe4XhXxrHLPFirYqlR4GxEuXMqMPG0=;
        b=MoEwszu7vBe03y3if7yBewfizKoTxlbHzW1A+T40MWPgJ0ADlkow8civhfAaDTTEZ1
         bfs84qzgrayO+2cFJ9xl1q3ysTcfi9YiClmum2Y2GyS8hVfOTHbNlEJQKNlOAw6U3HOe
         whVXmEOLeGFEttomRCdiUTGfWTtoGzpxv+kLfUj0prn7sv0CCTp1WvXBUwlCXDVsehO1
         cX6MSQTTYlmeaxGYHcxmZUk/rbwXUn6b/DYLmG2opNxshyhKKVk923UXu2oTuMBGdZnG
         xMC+9H5QopvvePw2tjTnjRrR+EGCCmU7YDxP3A6tcYUr6McNZ2zgljVbLWoRXs5GkxrE
         AqNA==
X-Gm-Message-State: AOAM531iWKvbpOAnCcr9HsXEiW+1lDDUDe9DlhrVAk5BejmhgwwegOBC
        QjY4g0OLY1tBtXLy2/m9up+fmw==
X-Google-Smtp-Source: ABdhPJzbOI0b73c/qadaAd7iEJGOVJ5hLgp/CgtYvpQSgMgQpjxw37Y+EMVduvNyqB6rfHgzaz11tw==
X-Received: by 2002:a05:600c:4a12:b0:389:9c7d:5917 with SMTP id c18-20020a05600c4a1200b003899c7d5917mr16243062wmp.0.1647244819585;
        Mon, 14 Mar 2022 01:00:19 -0700 (PDT)
Received: from localhost ([2a01:cb19:826e:8e00:bcd3:63d9:c9dc:840d])
        by smtp.gmail.com with ESMTPSA id 10-20020adf808a000000b001edd413a952sm12568861wrl.95.2022.03.14.01.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 01:00:19 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fengping Yu <fengping.yu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v21 2/3] Input: mt6779-keypad - Add MediaTek keypad driver
In-Reply-To: <YiIINpi4zbJq/AZE@smile.fi.intel.com>
References: <20220303154302.252041-1-mkorpershoek@baylibre.com>
 <20220303154302.252041-3-mkorpershoek@baylibre.com>
 <300114e2-6794-db3c-a51c-3f900b6476f9@collabora.com>
 <YiIINpi4zbJq/AZE@smile.fi.intel.com>
Date:   Mon, 14 Mar 2022 09:00:18 +0100
Message-ID: <87ee35rmjx.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ven., mars 04, 2022 at 14:38, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Mar 04, 2022 at 11:31:38AM +0100, AngeloGioacchino Del Regno wrote:
>> Il 03/03/22 16:43, Mattijs Korpershoek ha scritto:
>> > From: "fengping.yu" <fengping.yu@mediatek.com>
>> > 
>> > This patch adds matrix keypad support for Mediatek SoCs.
>
>> > +struct mt6779_keypad {
>> > +	struct regmap *regmap;
>> > +	struct input_dev *input_dev;
>> > +	struct clk *clk;
>
>> > +	void __iomem *base;
>
> Not sure why you need this here.
You are right. There is no point of keeping this __iomem region as part
of the structure, since it's only used in the probe() function to create
the regmap.

Will send an improvement part of a later series.

>
>> > +	u32 n_rows;
>> > +	u32 n_cols;
>> > +	DECLARE_BITMAP(keymap_state, MTK_KPD_NUM_BITS);
>> > +};
>> > +
>> > +static const struct regmap_config mt6779_keypad_regmap_cfg = {
>> > +	.reg_bits = 32,
>> > +	.val_bits = 32,
>> > +	.reg_stride = sizeof(u32),
>> > +	.max_register = 36,
>> 
>> Are you sure that you can't use .fast_io = true?
>> 
>> Another version for the same question:
>> Are you sure that you need to lock with a mutex here, and not with a spinlock?
>> 
>> Since you're performing reads over a MMIO, I think that there's a very good
>> chance that you can use fast_io.
>> 
>> > +};
>
> ...
>
>> Please use dev_err_probe() to simplify error handling in probe functions: you've
>> done a great job with adding a devm action for the error cases, avoiding gotos to
>> get out cleanly.. it would be a pity to not finish this to perfection.
>> 
>> I'll give you two examples for this, so that you'll be all set.
>> 
>> 	if (IS_ERR(keypad->regmap))
>> 		return dev_err_probe(&pdev->dev, PTR_ERR(keypad->regmap),
>> 				     "regmap init failed\n");
>> 
>> P.S.: No need for %pe here, as dev_err_probe prints the error number for you!
>
> Maintainer of the input subsystem is strongly against dev_err_probe() API. See
> other files there. Ditto for other cases you mentioned below.
>
> -- 
> With Best Regards,
> Andy Shevchenko
