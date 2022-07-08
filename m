Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1705056C26F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240107AbiGHVtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239971AbiGHVtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:49:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E077F9B1AF;
        Fri,  8 Jul 2022 14:49:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57649615F1;
        Fri,  8 Jul 2022 21:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55BCC341C7;
        Fri,  8 Jul 2022 21:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657316956;
        bh=qwoHft6J7YF3D/O6Rf3RXkjJ9VReVvmsa+QIcOA1fLs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kcodp16Edx1u8nlbErKaVGsHMvdxsifaar78IjBZvPTbB1mc4m9Q2vA0dgKt3kGQH
         19c5AsLzHLpatC9RmCJvkkt6TCluslWS12A1p07Cz7Rf0ZIwLVRDySnJTbCHW+GjWn
         Y1NZ1bJpNsRBi8/V51Cr2KBhiMe7qaKb/51Meq1anbJRCgUYyADs2qkc/CvnJBxjjj
         6KqkrwjCOVjO9MwIQ5leOgSquOHXk6iXrn0gIXRQqX2hnQfO8q/UMlrsItUqPhaQw+
         XTXAGQLjmDM0Y9A4x21x1YGb9f8R6leYzDfItlBgFnr04tdv42Ax/ICoGBUuhfcKhm
         hk3JEsGWMRSuw==
Received: by mail-vk1-f176.google.com with SMTP id u204so37948vkb.7;
        Fri, 08 Jul 2022 14:49:16 -0700 (PDT)
X-Gm-Message-State: AJIora+b/8RW+89grl147NsLxOhdRPTCJdbA9IopmH9DWxJ+gkAicHKx
        mm1Zhn0REGSY6oZ0lpvx2YGqO2viw8S9nrw4ZA==
X-Google-Smtp-Source: AGRyM1u17X2pv7TEGdk37nw9uxpDz0qNObsUa18T3drP30RZT5i4eIxnhV0/CJfBgdEfulEEw/XHnFmvcHdWz6nY3wU=
X-Received: by 2002:a1f:2a86:0:b0:370:8ff3:d5f with SMTP id
 q128-20020a1f2a86000000b003708ff30d5fmr2506541vkq.35.1657316955600; Fri, 08
 Jul 2022 14:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220708165225.269192-1-ben.dooks@sifive.com>
In-Reply-To: <20220708165225.269192-1-ben.dooks@sifive.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 8 Jul 2022 15:49:03 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+TZpAK-X02ANoYBMfUKkwPh3Z-gjGjim6WwFwsMa7zSA@mail.gmail.com>
Message-ID: <CAL_Jsq+TZpAK-X02ANoYBMfUKkwPh3Z-gjGjim6WwFwsMa7zSA@mail.gmail.com>
Subject: Re: [PATCH] of/irq: parse interrupts-extended during irq init
 heirarchy calculation
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 10:52 AM Ben Dooks <ben.dooks@sifive.com> wrote:
>
> When the irq controler code works out the heirarchy for initialialisation
> it only looks at interrupt-parent properties, but controllers such as the
> RISC-V PLIC use a extended-interrupt property and therefore do not get
> properly considered during initialisation.
>
> This means that if anything changes in the driver initialisation order
> then the PLIC can get called before the CLINT nodes, and thus interrupts
> do not get configured properly and the init continues without noticing
> the error until drivers fail due to having no interrupts delivered.
>
> Add code to the of_irq_init that checks for the extended-interrupt
> property and adds these parent nodes so that they can be considered
> during the calculations of whether an irq controller node can be
> initialised.

Isn't this already fixed by commit e91033621d56 ("of/irq: Use
interrupts-extended to find parent")?

Rob
