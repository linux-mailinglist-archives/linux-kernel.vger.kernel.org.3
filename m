Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB66250C68D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 04:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiDWC2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 22:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiDWC2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:28:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EFA1DB076;
        Fri, 22 Apr 2022 19:25:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DC986135F;
        Sat, 23 Apr 2022 02:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12F3C385A0;
        Sat, 23 Apr 2022 02:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650680741;
        bh=ArGHhgbdlHjKWbPeB+8c0u0ViOzzzUuy497doDzrEaY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jK/9zgIeTIm8RlKZGOcSF3oBPkR0dPTvs2UzoFurZ6y5CJzEdnKdDn0OvZeaKFWA4
         8E5XNdUQihWTCTb5bMAxnpCK3Yat0a6tGWidLP1sWdROsbDYcQ+CVj9Rf5tZrOjH2e
         3Fq9j8+RYVzuDem9X3JF/Zr6rNSyOicK4trYxpj4S7Ft+8JCB7P2phfidfFGtQsfPf
         AwNl3beD1qNAb/U+k26wOsBxl3isvQK51gs6h3ADwRpxfDJOhiVNaRnGmI8c/EVXiN
         38mCkSFHmkHnLN7qi0GaggpucOBiLnJMAl8aWY9Eh541KX8b79zR0hUbEoATnkV7a4
         /9viIpBT/lM/A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFBinCC=Dp4bXT9sbmT=ZTiVfC1Mj=oRVxeDXfKbDczq45iekQ@mail.gmail.com>
References: <tencent_FE734C50BC851F2AB5FE1380F833A7E67A0A@qq.com> <CAFBinCC=Dp4bXT9sbmT=ZTiVfC1Mj=oRVxeDXfKbDczq45iekQ@mail.gmail.com>
Subject: Re: [PATCH] clk: meson: meson8b: fix a memory leak in meson8b_clkc_init_common()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        mturquette@baylibre.com, khilman@baylibre.com,
        p.zabel@pengutronix.de, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        xkernel.wang@foxmail.com
Date:   Fri, 22 Apr 2022 19:25:39 -0700
User-Agent: alot/0.10
Message-Id: <20220423022541.B12F3C385A0@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2022-04-18 09:39:57)
> Hello,
>=20
> first of all: thank you for this patch!
>=20
> On Thu, Apr 7, 2022 at 11:28 AM <xkernel.wang@foxmail.com> wrote:
> >
> > From: Xiaoke Wang <xkernel.wang@foxmail.com>
> >
> > `rstc` is allocated by kzalloc() for resetting the controller register,
> > however, if reset_controller_register() fails, `rstc` is not properly
> > released before returning, which can lead to memory leak.
> > Therefore, this patch adds kfree(rstc) on the above error path.
> In general I am fine with this approach. There's some more "return"
> statements below. Should these be covered as well?

Probably!

>=20
> Also a note about meson8b_clkc_init_common() itself: failures in that
> function will result in a non-working system.
> If we can't register the reset controller then most devices won't
> probe and CPU SMP cannot work.
> If registering any clock or the clock controller doesn't work then the
> system also won't work as clocks are not available to other drivers.
> So freeing memory in case of an error is good to have, but the end
> result is still the same: the system won't work.
>=20

Can we get far enough to record this fact into either a pstore ramoops
location or the serial console? That would be ideal to make debugging
early problems easier.
