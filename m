Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47CB5613C9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiF3Hzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiF3Hzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:55:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5543ED35
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:55:46 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k22so25979406wrd.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cJpP1OkS6rqgrKq9b3POAwWxBCAPWm4YoIECgKmS3yQ=;
        b=BbWdRrgZMdJ1PQyfce9NujC+Cv9Kn+TUQxncoG2TTnGy4BeFv0ZlRlRS3m01fdorNR
         FZseq2tmJLiA0yMcKydgJl6Q92/IT69YiSmFlRAHCvfjH20hwuUf3inAGwYznkg31ZvR
         YqYpktKRMrtuQntm3KQeOflrQtoyrHFsL6N7RMYzbJcFqR/Y6R+MB/JpYdpGQc68To4R
         IUX0Y9rcbFNNL8US3uwCwIMxoVJx+T9w61Ohi9KO07ymvquF5mOxWsGzp+lbjvXYB3SP
         diY8SNgQZ6nzfrTdgfwzvOX/7pDMBdxHfYrFqR2zGpbuSI44NC3c6l0+4jASQef6w6kL
         X5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cJpP1OkS6rqgrKq9b3POAwWxBCAPWm4YoIECgKmS3yQ=;
        b=yC27JwPTryyxafYvcKgXeHhNYm1hJSYWE41QHdTXHsnxRId/xZgOVpz7pDJcYGcri8
         wiTlmEdX0zfT1rmnZg2tJe1tD7zGkTlicmXCmigeVVXSL0N9q8vgA2c0SIB3qCwtvjN5
         9XIABBvQcyMxgoqkLqsWdBKnycCDm/0sFYXY+/hso5w9BDqGfDez/d9ZMZYaQIAcjU5T
         KpdBfTU0yeXFzwq3QIw8f+pkOohXyaRF6tSmZIWE/WC/ykh2VZ9RuTDJS+G5gj+NCrWD
         pyTG2XTPU+Hy9n2hnewRTSpzzh2x7GnzXR45QfTzQYHXwPxuSJ/f6atPQbLNtywkBggw
         U8WQ==
X-Gm-Message-State: AJIora/LBdIAD4VdFrDT2f/KfbWDUgltDQehKhWjB+ddNBui2TEjYQFW
        fkbPOlNqSPdYaRA/B8GKEn5wJRH0UQnrdw==
X-Google-Smtp-Source: AGRyM1uB8V88VxEz2AKA9EorOVdKaOEl38ZHL2JsuaOgJS62ydwWd+4V518CKzvP1GQDbSXI1x4IYg==
X-Received: by 2002:a5d:508c:0:b0:21b:8cd2:2210 with SMTP id a12-20020a5d508c000000b0021b8cd22210mr6726289wrt.527.1656575744886;
        Thu, 30 Jun 2022 00:55:44 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id z9-20020adfec89000000b0021b89f8662esm18282326wrn.13.2022.06.30.00.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 00:55:44 -0700 (PDT)
Date:   Thu, 30 Jun 2022 08:55:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, quic_gurus@quicinc.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Michael Walle <michael@walle.cc>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 00/15] Add support for AXP192 PMIC
Message-ID: <Yr1W/m6UV3792GvF@google.com>
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
 <CAHp75Vc=PWXauEKDNX+vmqv=oO1LDv8-GgU3OFZXjf8yJrG8wA@mail.gmail.com>
 <CAHp75VeqvCnWtWLF1zySPGkfBT5obosu0h_pZEhz+pOQWzMdWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeqvCnWtWLF1zySPGkfBT5obosu0h_pZEhz+pOQWzMdWQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2022, Andy Shevchenko wrote:

> On Wed, Jun 29, 2022 at 11:14 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Jun 29, 2022 at 4:29 PM Aidan MacDonald
> > <aidanmacdonald.0x0@gmail.com> wrote:
> > >
> > > Changes in v4:
> > >
> > > * Drop regmap-irq patches and rebase on top of the regmap-irq
> > >   refactoring series[1], which implements the same functionality.
> > > * Reorder mfd_cells, putting one-line entries at the bottom.
> > > * Fix incorrect example in axp192-gpio device tree bindings.
> > > * Perform adc_en2 flag -> adc_en2_mask conversion in axp20x_adc
> > >   as a separate patch.
> > > * Simplify axp192_usb_power_set_current_max().
> > > * Drop unneeded OF dependency in pin control driver, and document
> > >   tables used for describing register layouts.
> > > * Various style fixups suggested by Andy Shevchenko.
> >
> >
> > For patches 6-11
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Ditto for patches 13-15.

Not sure `b4` will pick these up!

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
