Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A2B5AF2FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiIFRph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIFRpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:45:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871F94D4D2;
        Tue,  6 Sep 2022 10:45:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92FFDB819D2;
        Tue,  6 Sep 2022 17:45:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489F8C433C1;
        Tue,  6 Sep 2022 17:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662486327;
        bh=9JOGS+DmMCZRcR+ue1CWAsQbzUKVC+BdBUjpVyMqD1E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cVagUGZ5rXx2aXKE0qH2oo2yEuZx+EjlKrBLx0BoQZ0GMmFtU/6bJFoBoocueQXxj
         lnk4scbOL/b/lmlNZW0X4kKlQWrOwaV6UcIfbAvIYmy4h57CSKOSjTsttV7neyIVsf
         T01B0T/rWr08KrUixfYnLcivKPya5o4ZGEkwAL7rid/39LBl9OXltN5b58a/2Ma4pf
         t0PRSV4oDyMJPCmBGnt9OVMwygY87Sczc8PTKoaGe7ycl4VrgPyPq3opFznwlozCYa
         +/zxXRN+j3pJXHSb5q/7uqlx7mVFeJP8wQAXMrBw4qbPBgUmD/5rxXj7eSAFrTGMSf
         Oiv+BjVzsGwIQ==
Received: by mail-vk1-f179.google.com with SMTP id i67so5887270vkb.2;
        Tue, 06 Sep 2022 10:45:27 -0700 (PDT)
X-Gm-Message-State: ACgBeo2ol0tGXTOGQuG4mbKtM+H+F8arc0Yr3gWCbxpWWFYHly5jszXy
        twa95PpDgYZ9OS9KSSQvHVU0Abz9ciJmuFFHuw==
X-Google-Smtp-Source: AA6agR4QgQXp/ntiocLHUxEHId1vX4FahEcMw4sf8AAlkUaloq3asnMm2cm0LQtbOZ7hWcgiplL7EnK9jP3qXbBmaK4=
X-Received: by 2002:a1f:23c6:0:b0:38c:88f3:f55c with SMTP id
 j189-20020a1f23c6000000b0038c88f3f55cmr15615940vkj.19.1662486326264; Tue, 06
 Sep 2022 10:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220906095943.60296-1-alexander.sverdlin@nokia.com>
In-Reply-To: <20220906095943.60296-1-alexander.sverdlin@nokia.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 6 Sep 2022 12:45:15 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLhXE9E5UkGy+=t5Eas1KfTxmjm=mQcVVQ0MdAs7eYAtw@mail.gmail.com>
Message-ID: <CAL_JsqLhXE9E5UkGy+=t5Eas1KfTxmjm=mQcVVQ0MdAs7eYAtw@mail.gmail.com>
Subject: Re: [PATCH] of: irq: Report individual failures in of_irq_init()
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 4:59 AM Alexander A Sverdlin
<alexander.sverdlin@nokia.com> wrote:
>
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
>
> Rewrite pr_debug() as pr_err() to faciliate debugging.
>
> This change was inspired by a long lasting debugging of the
> octeon_irq_init_ciu() which fails completely silently and leaves the
> interrupt controller half-way configured which in turn had very non-obvious
> effects.

With this, if a node skipped completely won't be obvious. Please keep
the debug line and just add the error print.

>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> ---
>  drivers/of/irq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index d22f605..45e4392 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -586,12 +586,12 @@ void __init of_irq_init(const struct of_device_id *matches)
>
>                         of_node_set_flag(desc->dev, OF_POPULATED);
>
> -                       pr_debug("of_irq_init: init %pOF (%p), parent %p\n",
> -                                desc->dev,
> -                                desc->dev, desc->interrupt_parent);
>                         ret = desc->irq_init_cb(desc->dev,
>                                                 desc->interrupt_parent);
>                         if (ret) {
> +                               pr_err("%s: Failed to init %pOF (%p), parent %p\n",
> +                                      __func__, desc->dev, desc->dev,
> +                                      desc->interrupt_parent);
>                                 of_node_clear_flag(desc->dev, OF_POPULATED);
>                                 kfree(desc);
>                                 continue;
> --
> 2.10.2
>
