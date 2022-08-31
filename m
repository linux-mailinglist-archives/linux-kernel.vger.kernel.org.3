Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66ED55A833E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiHaQay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiHaQat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:30:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA8E82770;
        Wed, 31 Aug 2022 09:30:41 -0700 (PDT)
Received: from [IPv6:2a00:23c6:c311:3401:b599:df6:dba1:bdbb] (unknown [IPv6:2a00:23c6:c311:3401:b599:df6:dba1:bdbb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D41DB6600014;
        Wed, 31 Aug 2022 17:30:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661963440;
        bh=8syKZc8lBVGRD02tm+lxMSpF6i+Oyf8Euvo5Tc3l7rA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VmrWBYy5FTwJI/c8jQsshae6QZyu9MbkJuMGFRXvuSScZp1SmOJ2R0WPTGv/ff039
         C2MCwPfQvY1kgV6nvA3qrWZJYTdvdv+Ze9QVN1nu6SNqEp3x10WbTrAXfOkA+PPriA
         /1SKpkQhG/6ym/PbvdMFs9tkADDlilZM93IHFmcLu0wWzOYonP0SLOUJyIA85u5xwU
         /SEyBwW8usD0/a0ckW3ocCBqzYVNbxkcM2wy7YLyoJtoGCGDuPGyqJJE9cIUvo0++x
         1MLHGiNtlf6fKlh+Xd0WfgQGfy4hdUzXg6W2+dNvxaVFk76HUaJMZgwZKwY2fghj0i
         IN0l3J6HEMNTg==
Message-ID: <e89ccd1ecb675ab899dba0f08624a3dde195c970.camel@collabora.com>
Subject: Re: [PATCH 5/5] gpio: pca953x: Add support for PCAL6534 and
 compatible
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>, kernel@collabora.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 31 Aug 2022 17:30:38 +0100
In-Reply-To: <CAMRc=McbNwLRq_OBo_=xwFJJ-_8C5VfjQt75dvSVC9SqUYTpFg@mail.gmail.com>
References: <20220829133923.1114555-1-martyn.welch@collabora.com>
         <20220829133923.1114555-5-martyn.welch@collabora.com>
         <CAMRc=McbNwLRq_OBo_=xwFJJ-_8C5VfjQt75dvSVC9SqUYTpFg@mail.gmail.com>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-1+b1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-08-31 at 13:57 +0200, Bartosz Golaszewski wrote:
> On Mon, Aug 29, 2022 at 3:39 PM Martyn Welch
> <martyn.welch@collabora.com> wrote:
> >=20
> > Add support for the NXP PCAL6534 and Diodes Inc. PI4IOE5V6534Q.
> > These
> > devices, which have identical register layouts and features, are
> > broadly a
> > 34-bit version of the PCAL6524.
> >=20
> > However, whilst the registers are broadly what you'd expect for a
> > 34-bit
> > version of the PCAL6524, the spacing of the registers has been
> > compacted. This has the unfortunate effect of breaking the bit
> > shift
> > based mechanism that is employed to work out register locations
> > used by
> > the other chips supported by this driver, resulting in special
> > handling
> > needing to be introduced in pca953x_recalc_addr() and
> > pca953x_check_register().
> >=20
> > Datasheet: https://www.nxp.com/docs/en/data-sheet/PCAL6534.pdf
> > Datasheet:
> > https://www.diodes.com/assets/Datasheets/PI4IOE5V6534Q.pdf
> > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> > ---
>=20
> Is this series complete? I don't have patch 1/5 in my inbox and
> neither does patchwork.
>=20

I used get_maintainers to generate the recipients, it's a patch for the
binding documentation relating to the driver so didn't get sent to the
same lists:

https://lore.kernel.org/lkml/20220829133923.1114555-3-martyn.welch@collabor=
a.com/T/

Martyn

> Bart

