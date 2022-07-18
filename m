Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E365785EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbiGRO5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbiGRO5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:57:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E395F2610C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:57:08 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y8so15670229eda.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GLp8K++n9KMgI9eZk9401SwTQ2J7JPpZzm1JjFRZrUQ=;
        b=BGJvgeBAvkSdbeQGW/dHUHI0Y88d1+TbTCt+BW1YVWT2SBD5nDHWgK/ab6P0qWFGDL
         7I3zL/jX7wt5o+UtASkPTwY0XxD7p0aK/BeiZFNzxWEjX0xw/sGBqR1KvxFGooNGyS04
         V4y8FN0I9rqIVw2ic7edFAbFgJ5xpw1j/LJGxwQG8pQE9xL0fLUepfRRzHupDW0ZxHh8
         rwa03d7VKVaQhngb7IaaSLG67qruEXWzPxEurtQshqOK8hmJ2SCANrng5EBfjYgZDYPE
         tLtHPf6K5lA9e8ZPSJG5kbl1VjOfStYp8q4WB+pbiXD3S+3Anx46fV6BCq9xTc2kEWx7
         9Y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLp8K++n9KMgI9eZk9401SwTQ2J7JPpZzm1JjFRZrUQ=;
        b=NZRXq7JDbVsedgNBAu1nqLzKpj/p1R7oMvyCZnlAPfKNuy96ruAhpioAi9KasCFqDp
         pDEna35Rqh3TdCQ4P/bUxde+dPCyFor7Ud1wq2m4nchkFuUGbE1VRrsj/ZTcxgEmVRsl
         nk1NY+amit7Y0y+ESKPz/iMQL42BRanS4UTV9mtFh8TfFsPoUVxJXSS95TAOcLFp/V2Q
         Uh41glDw4dU35RsfQS32id4wT1lqkQVmoVtdMfGJXps0dsQKpdYeyN2McZrxzXON9W5b
         ASXLQLIWDW+obs9Zk0VIq9F+Ij6TQV/GJn831LYb7WbaTFzOkppHGg6j9joEtfuV+srv
         TjMg==
X-Gm-Message-State: AJIora+i6+7YsS+H1ZfhnzssPb3o9wB9Zw2gsVF9n8diVvlYm7BlHw5i
        7Ls8Vu4QQs1VVaKh+Tzbhf3g+t0Hbruq/Vy05iItHMgMCBs80A==
X-Google-Smtp-Source: AGRyM1tF7nG5nEk3jJFLsgDlXZSXZg9czq75bC/OsMF5KBmxQUk03bCv3Q8Lgaf/trizJ44Uc6xGhmgpUIob3G+0U7I=
X-Received: by 2002:a05:6402:42c8:b0:43a:a1ee:a097 with SMTP id
 i8-20020a05640242c800b0043aa1eea097mr37145301edc.150.1658156227476; Mon, 18
 Jul 2022 07:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220712163823.428126-1-sudip.mukherjee@sifive.com>
 <20220712163823.428126-4-sudip.mukherjee@sifive.com> <d918c4d3d91adac247ebae6418b409b7@walle.cc>
In-Reply-To: <d918c4d3d91adac247ebae6418b409b7@walle.cc>
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
Date:   Mon, 18 Jul 2022 15:56:56 +0100
Message-ID: <CAHyZL-cUJ7Zu=r5ZGD3p4XY9Ypdc-YuaqbKmdHjYQfAT6Fu_fA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mtd: spi-nor: issi: is25wp256: Enable Quad Input Page Program
To:     Michael Walle <michael@walle.cc>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Mon, Jul 18, 2022 at 8:39 AM Michael Walle <michael@walle.cc> wrote:
>
> Am 2022-07-12 18:38, schrieb Sudip Mukherjee:
> > The flash chip is25wp256 supports Quad Input Page Program. Enable it
> > in its no_sfdp_flags flags.
>
> Are you sure, that chip doesn't have SFDP? Even the oldest datasheet
> I've found [1] mention SFDP.

Yes, that is what I expected from the datasheet. But from the driver code,
spi_nor_init_params() is calling spi_nor_init_params_deprecated() as
'parse_sfdp' is not true.
and looking at issi_nor_parts[], I can see is25wp256 is not marked
with 'PARSE_SFDP' so it
will skip parsing SFDP. The same datasheet also has is25lp256 which is
marked with 'PARSE_SFDP'
in the driver.
I tried to add 'PARSE_SFDP' to is25wp256, and I can see its mostly
working but its not using
Quad Input Page Program. I guess this support was not discovered from SFDP.


--
Regards
Sudip
