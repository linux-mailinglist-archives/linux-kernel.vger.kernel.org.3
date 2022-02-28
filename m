Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7DD4C6223
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 05:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiB1EWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 23:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiB1EWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 23:22:03 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930543FDAF;
        Sun, 27 Feb 2022 20:21:24 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id z66so9457578qke.10;
        Sun, 27 Feb 2022 20:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xu7L991BbclWOd1sSCiHVHwv23FKEvTPahHlqfmOUAI=;
        b=bV7ogvkPtbvPpHCldXcuINpGbSUEnOvppBm9rqxRGEL0gSVsOIN7FP+EWjQxNeiEsc
         JgwZi3P4vducm62191kOMrTwIUyg04bMbbQsGZkYXbl4R47UxWcXjDyhD8IlXv1F0vVG
         hwPyiZ9kiuRnyw2IZmvef12q6Zfo6Y5tmFEAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xu7L991BbclWOd1sSCiHVHwv23FKEvTPahHlqfmOUAI=;
        b=jXvq59P7OFu+JJuPKCF1wyGz+tRriEH2/2DhRkTc3R4arnG8uPl8/t7tMkGCESbsnl
         bdya3nXNC07/DGDV2va6RyhKnW3EI8xeDAj8XhmVHujPoviYLls6TP1SAGAnaxlP2CtT
         /uPNO/fuUT/4KzMAlHklg10vSRntQoKUjWpT2zwl79FMuhBvH+0j+DCsf9H6K69LrpW+
         VmuINn+5KT1o/qSy9Q/J3HzUga2Af1DQwb1jJPu0322k0+3a0vh+ToLjOb3LHZXhJeWB
         ICMSgOMffooEbWDFvp3rGkPVxgkwVdm3xijPEozssBDFujIotT8S/bLSx2iHxErLoAJ0
         wbNw==
X-Gm-Message-State: AOAM530ToUBxkQ6T9Dh/7e8cIwkwON0t8C1dtecdeY4qhwEL8wT3ZGpw
        wUwIxqRtXZ35y4ZzrXJ9b5MynUPoJHKmTrWN9Ms=
X-Google-Smtp-Source: ABdhPJzjZJ2sb6YqyKtiQJ8UdreFdmA+9mR4ZseA6RQbUE7DGqgL+UfI5GuUZ5+PkfNbadU7W9b6EdllKdHYwz/lzsY=
X-Received: by 2002:a37:f903:0:b0:648:ca74:b7dc with SMTP id
 l3-20020a37f903000000b00648ca74b7dcmr10116556qkj.666.1646022083557; Sun, 27
 Feb 2022 20:21:23 -0800 (PST)
MIME-Version: 1.0
References: <20220228000242.1884-1-quan@os.amperecomputing.com>
In-Reply-To: <20220228000242.1884-1-quan@os.amperecomputing.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 28 Feb 2022 04:21:11 +0000
Message-ID: <CACPK8XfCskh7KPhXJqOR9ZLnoBdd64SL9D1z5HoDC+_VVs4LCg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Enable second flash, update gpios pin and merge
 adc channels
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022 at 00:03, Quan Nguyen <quan@os.amperecomputing.com> wrote:
>
> This patchset adds the second flash support, merge all ADC channels to
> single iio-hwmon node and update various gpios pin name.
>
> Link:https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md
>
> Quan Nguyen (5):
>   ARM: dts: aspeed: mtjade: Enable secondary flash
>   ARM: dts: aspeed: mtjade: Update rtc-battery-voltage-read-enable pin
>   ARM: dts: aspeed: mtjade: Update host0-ready pin
>   ARM: dts: aspeed: mtjade: Rename GPIO hog nodes to match schema.
>   ARM: dts: aspeed: mtjade: Move all adc sensors into iio-hwmon node

These look good.

Reviewed-by: Joel Stanley <joel@jms.id.au>

I'll apply them for v5.18.

>
>  .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 26 +++++++++----------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>
> --
> 2.28.0
>
