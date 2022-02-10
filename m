Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC99A4B1094
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243018AbiBJOjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:39:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiBJOjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:39:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B2BBCD;
        Thu, 10 Feb 2022 06:39:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09422B8255A;
        Thu, 10 Feb 2022 14:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D76C340E5;
        Thu, 10 Feb 2022 14:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644503962;
        bh=cMf1z3wP7NeBeseMjIqYtP1TfS0kXcL2He69HWdeLuI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IxSgGTvf/EvSoYruT2PiaQkFRiE6Ew1VBuuFX3nR4iKqcid6+UJRXa+5+N35Qn/GH
         Ow+X+6MaVKCb0P1IWcCl7wd0oG0MlfMISybY5iL8zap3LB+2zST8L6O0pFMgIM6UUS
         +vW3nATJWc8M/XEc05QCkYCPFQF0xoyx55CjrDtL0dOFwpTntTs4WDE7jHCYAxy5++
         HVLuHIXqub1fRup9VgdcGaUChh3VwElu4jMKYcFr0HtGUNTgd3UhPAFMrd3nuaFb9S
         YuyNt/XW/OgAosV0UY0Rm6LAcCbraX9bdjh2IJ+XjaGUqJ5LVgB0wfs0HlGrdpw+P+
         6hmqjIisufubA==
Received: by mail-ej1-f49.google.com with SMTP id k25so15864336ejp.5;
        Thu, 10 Feb 2022 06:39:22 -0800 (PST)
X-Gm-Message-State: AOAM5310aRVKC+uznPjenEkvavutRF2BWMYwZ6f9oZuJi/lCbJTpmd3o
        js9rDKW0s/UtsLZNr7G7bt3CVs95JWby53UN+A==
X-Google-Smtp-Source: ABdhPJx+AuAxADrHvdwM8twasfxAV19kvrVXLNmJ/T4wMBi49Xr3AAtUec55ECwrlMkUXnh3hsKVjsr5l1JcUPEVrck=
X-Received: by 2002:a17:907:628c:: with SMTP id nd12mr6596093ejc.82.1644503961103;
 Thu, 10 Feb 2022 06:39:21 -0800 (PST)
MIME-Version: 1.0
References: <20220210065132.234341-1-vkoul@kernel.org>
In-Reply-To: <20220210065132.234341-1-vkoul@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 10 Feb 2022 08:39:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKPO0TGDjD1+_Tbg39YRpxRCcH_LTy83SHcMBzFA_tw2g@mail.gmail.com>
Message-ID: <CAL_JsqKPO0TGDjD1+_Tbg39YRpxRCcH_LTy83SHcMBzFA_tw2g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Don't report disabled nodes with duplicate addresses
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
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

On Thu, Feb 10, 2022 at 12:51 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> Duplicated unit address is okay if we have only one such node enabled.
> So, remove '-Wno-unique_unit_address' from DTC_FLAGS.
>
> This helps in reducing warnings in qcom dts from
>
>    6483 unique_unit_address
>    1108 simple_bus_reg
>     764 avoid_unnecessary_addr_size
>     712 unit_address_vs_reg
>     120 graph_child_address
>      32 unique_unit_address_if_enabled
>
> after this patch:
>     277 simple_bus_reg
>     191 avoid_unnecessary_addr_size
>     178 unit_address_vs_reg
>      32 unique_unit_address_if_enabled
>      30 graph_child_address

I'm confused how unique_unit_address changes the count for others?

>
> which would help people focus on the actual warnings and fix them.

Hopefully you do a 'sort -u' on the warnings to dedup them...

>
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  scripts/Makefile.lib | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 79be57fdd32a..7e4f6671d950 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -299,7 +299,8 @@ quiet_cmd_gzip = GZIP    $@
>  # DTC
>  # ---------------------------------------------------------------------------
>  DTC ?= $(objtree)/scripts/dtc/dtc
> -DTC_FLAGS += -Wno-interrupt_provider
> +DTC_FLAGS += -Wno-interrupt_provider \
> +       -Wno-unique_unit_address
>
>  # Disable noisy checks by default
>  ifeq ($(findstring 1,$(KBUILD_EXTRA_WARN)),)
> @@ -307,8 +308,9 @@ DTC_FLAGS += -Wno-unit_address_vs_reg \
>         -Wno-avoid_unnecessary_addr_size \
>         -Wno-alias_paths \
>         -Wno-graph_child_address \
> -       -Wno-simple_bus_reg \
> -       -Wno-unique_unit_address
> +       -Wno-simple_bus_reg
> +else
> +DTC_FLAGS += -Wunique_unit_address_if_enabled
>  endif
>
>  ifneq ($(findstring 2,$(KBUILD_EXTRA_WARN)),)
> --
> 2.31.1
>
