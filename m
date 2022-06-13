Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4094754A186
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352480AbiFMVcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343543AbiFMVaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:30:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83102A4;
        Mon, 13 Jun 2022 14:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A80F9B815E5;
        Mon, 13 Jun 2022 21:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E91FC3411C;
        Mon, 13 Jun 2022 21:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655155821;
        bh=RcDh9o9PXC+xSwXW/nZeAZBZrz0xvylKTEyCuXSTkuc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=snI6zuYtunnjEyezYSZyynO4hvrbhn7HnkGB6QhYGneQ/wahpOzZw3iCJp5lNN+Gm
         QNPAkbKF+tgJQp/tto8gvxNroSDEDAhhxoqb3KK0TBr9l4oJDSvT6ilVRP+IENSMB6
         eKZ8lEanu6p1NSI1bMJmKtq05Bl4rgdv3V6VXwRFI7qwPmtxsy1/567ewNXO3J8TFq
         FyJQEKEaG60vXNBCsgqDmd58/y1cpl41JRGJ98MRriLwLxYnPFDM1Zz5awKvZNw2y4
         xa/hxm1KIEijsYnKBtw63+VLBOBgFUV7gSOMtjPBGs3upMqdHCYZvdQ1Vocjq8GdBz
         FqawezRRVvLIQ==
Received: by mail-vs1-f50.google.com with SMTP id e20so7159615vso.4;
        Mon, 13 Jun 2022 14:30:21 -0700 (PDT)
X-Gm-Message-State: AJIora/Sl6RgBY2NP6xuVyuLwWumY0E7YPtBgUTMp+8BoU4WpbvN8v/E
        8oeDb0ndqh+mOkAw6Sl5Ydn7afYVMW70pe5Hyw==
X-Google-Smtp-Source: AGRyM1tLuv8d5QD/UbHdhsN9UvYFl6xc6e+X3OCBXTT+IsNl1tijgv7xEbdvPPY2i3m0s6ecWDB11WH5VFl0fJvUlmU=
X-Received: by 2002:a67:d38c:0:b0:349:d028:c8ea with SMTP id
 b12-20020a67d38c000000b00349d028c8eamr702530vsj.6.1655155820388; Mon, 13 Jun
 2022 14:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <bf04adfd1dae519cb9377bcc7222089399690a22.1655147787.git.thomas.lendacky@amd.com>
In-Reply-To: <bf04adfd1dae519cb9377bcc7222089399690a22.1655147787.git.thomas.lendacky@amd.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 13 Jun 2022 15:30:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ5+vt-1xU4eo+pAWJbVQyA7=-fNquh32kqjLusvr1O6Q@mail.gmail.com>
Message-ID: <CAL_JsqJ5+vt-1xU4eo+pAWJbVQyA7=-fNquh32kqjLusvr1O6Q@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccp - Fix device IRQ counting by using platform_irq_count()
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        John Allen <john.allen@amd.com>, Marc Zyngier <maz@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 1:16 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> The ccp driver loops through the platform device resources array to get
> the IRQ count for the device. With commit a1a2b7125e10 ("of/platform: Drop
> static setup of IRQ resource from DT core"), the IRQ resources are no
> longer stored in the platform device resource array. As a result, the IRQ
> count is now always zero. This causes the driver to issue a second call to
> platform_get_irq(), which fails if the IRQ count is really 1, causing the
> loading of the driver to fail.
>
> Replace looping through the resources array to count the number of IRQs
> with a call to platform_irq_count().
>
> Fixes: a1a2b7125e10 ("of/platform: Drop static setup of IRQ resource from DT core")
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  drivers/crypto/ccp/sp-platform.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
