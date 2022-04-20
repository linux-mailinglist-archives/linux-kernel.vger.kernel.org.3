Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDA8509397
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383199AbiDTX1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383193AbiDTX1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:27:50 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AA313E22
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:25:03 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2eba37104a2so35421277b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=faX+8xEq5cxeln2IAgBzOZYC6emkLLqmLHlpGzsrZsI=;
        b=IdysWrk64gPASP4iboMXdeQr8OBqMtOScTiocxTj/PrXpZ3MpyJ7PLa30ylu64mytC
         dNZJ48LUjpecPRUYztsGI+HRaMLrBaDd/kcZaLV36ygFMFvmDY057Y+HEiWLnX8GNMwh
         zze4Y1X6WoKVDIaAGotw8iPC/K8l1onAsVljpkbYO8mFC4YRPbjpiKuiKdaF631UerU7
         ti+4EtfpHTfW3DMrUIqjmE+KiLWxhORMBfjPtP60A/UoWuR7wTx2P7q+WOBQloAXxCtG
         qRwDmPi3kFPBahDbTJXN2rIts8IFZDSrsrgjbq8RbD36cnyF6n/kd7e/lTwEP0I1lCt6
         WPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=faX+8xEq5cxeln2IAgBzOZYC6emkLLqmLHlpGzsrZsI=;
        b=3yrGQNFwpAbn9az1qjv+iXa87C1Hle9nqNvyW2I+qjHpd0wM88yD03d5HnkRxflfrF
         ZbRPSP9Yk9aLXnQ6aaG6EznqPX4MrjfCHnPnR56IRG3WhBcLP8Qe5Y6amZS6XD5/KeZB
         AXOCKFLamsH4Oh6CFy3r/m8h8dlAZnJu7M1C6weqQHUzaCzqss5xpJUmb0fx8dYYQ5CE
         mRYGig+u1Lk/qmmVFkvFkhRaE/oXEsZto5vFz4naGxrEh+6XIHb7oXEkJhRWMAxeIsb1
         ACwU02o5mrygzLNozMmywO2WP15zhIBMSNegr5jCQtRlgonfFgpcB8nE5CflY0NrrEXq
         gW8A==
X-Gm-Message-State: AOAM532RYy8shpSXdG5v0P4bClNudEmUyj3m2d8M1Pj2hwGPq9pW3zaH
        GJ5/+jDyjnpFVKmy9wdxzBVyi7naMnSgTX4uW5MUdl+DveU=
X-Google-Smtp-Source: ABdhPJza/ohc+w9rdaX0OxSl3QRR+W9TuPshb4dunNAUPl5XzezXZp8QbAzXuRYReRzLiYb+1tYgVyY2qzk5SSpHy3I=
X-Received: by 2002:a81:2154:0:b0:2f4:d79e:35dc with SMTP id
 h81-20020a812154000000b002f4d79e35dcmr227895ywh.126.1650497102573; Wed, 20
 Apr 2022 16:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <YYCOTx68LXu1Tn1i@fedora>
In-Reply-To: <YYCOTx68LXu1Tn1i@fedora>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Apr 2022 01:24:51 +0200
Message-ID: <CACRpkdYmw4yBm3Y1P42TcRs4fFNEiy3LXxmO_j=zeTv_usDR+g@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: imx6: Replace legacy gpio interface for gpiod interface
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Cc:     hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        helgaas@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maira and sorry for being slow on reviews.

On Tue, Nov 2, 2021 at 2:04 AM Ma=C3=ADra Canal <maira.canal@usp.br> wrote:

> -               gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> +               gpiod_set_raw_value_cansleep(imx6_pcie->reset_gpio,
>                                         !imx6_pcie->gpio_active_high);

Hm I see you got advised to use the raw api. I'm not so sure about
that I like v1 better.

> +       imx6_pcie->reset_gpio =3D devm_gpiod_get_optional(dev, "reset",
> +                       imx6_pcie->gpio_active_high ?  GPIOD_OUT_HIGH : G=
PIOD_OUT_LOW);
> +       if (IS_ERR(imx6_pcie->reset_gpio))
> +               return dev_err_probe(dev, PTR_ERR(imx6_pcie->reset_gpio),
> +                               "unable to get reset gpio\n");

Where is this descriptor coming from? Device trees? Can't we just fix the
DTS file(s) in that case given how wrong they are if they don't set
GPIO_ACTIVE_LOW flag on this IRQ.

Yours,
Linus Walleij
