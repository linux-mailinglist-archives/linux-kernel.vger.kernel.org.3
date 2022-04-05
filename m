Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5584F4F3DBE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 22:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbiDEULo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573256AbiDESf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:35:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8AB13F6F;
        Tue,  5 Apr 2022 11:33:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47D3CB81F86;
        Tue,  5 Apr 2022 18:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18183C385B1;
        Tue,  5 Apr 2022 18:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649183607;
        bh=ZUxbSBZ3h5TlMPFt4FZd4UJUlah4Y41D/DcQvCB4HHY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WBNF0PMEz3S24e5ZmkkSTviC1o6JSDDLnvPKMLuOTbq98ijOb1h1anaD+M0MqBCAX
         qGMvBVPYhZ/wl8CkEEvXiGUrIDfIAr57JleW+UEM8+xEglqb+SlKZyTnHsVFm5Ycb+
         4q5KeS/C/5zEqqSjca8c8z+IVGagPpn0u2XWRxZAuChTkv7xI0BM47F1RCopRWn+Qh
         pTpBPx/oRnv8OYcc34iom/1ocD+j1sfG79lZ2yqOLfI2poDodz6U1N3KScczpCTA3T
         VFSG63Xz3mEzOIMFyQ5YJd/HtvEtGBSA12D1fWMMRBM6SveTf8TdT50+dTAyRksByi
         1F+e6Ylz7UJ8w==
Received: by mail-wr1-f45.google.com with SMTP id m30so20695984wrb.1;
        Tue, 05 Apr 2022 11:33:27 -0700 (PDT)
X-Gm-Message-State: AOAM532fuE7J96wWbzwMcHOoosDIDW7JlYNANHegtXZeAoK+JDch5nJN
        f9oqWtxmgfzUhA+f1YCFMm22gP0wOHXgFsaAaq4=
X-Google-Smtp-Source: ABdhPJyewe9dKH4iPAQ2ncrwvBN2zM58zMWaVXuQn/R34OzrtcdUCZ1RyKCpcpZjlkdOFdkiAKfJXKGTnyUo5ALgpXU=
X-Received: by 2002:adf:cd02:0:b0:206:ff2:236 with SMTP id w2-20020adfcd02000000b002060ff20236mr3807678wrm.192.1649183605142;
 Tue, 05 Apr 2022 11:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220405091750.3076973-1-arnd@kernel.org> <20220405091750.3076973-2-arnd@kernel.org>
 <20220405141500.ixjl6qsy4cczghgt@bogus>
In-Reply-To: <20220405141500.ixjl6qsy4cczghgt@bogus>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 5 Apr 2022 20:33:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1T5w3cJG-4Y2WaWZcUmAtcjP-BKNCC3f0bf8=1CTdV6Q@mail.gmail.com>
Message-ID: <CAK8P3a1T5w3cJG-4Y2WaWZcUmAtcjP-BKNCC3f0bf8=1CTdV6Q@mail.gmail.com>
Subject: Re: [PATCH 01/12] ARM: versatile: move integrator/realview/vexpress
 to versatile
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hubert Feurstein <hubert.feurstein@contec.at>,
        Lukasz Majewski <lukma@denx.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>, patches@opensource.cirrus.com
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

On Tue, Apr 5, 2022 at 4:15 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Apr 05, 2022 at 11:17:39AM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > These are all fairly small platforms by now, and they are
> > closely related. Just move them all into a single directory.
> >
>
> I had forgotten about this. When do you plan to merge this ? I guess for
> v5.19. The reason I ask is that one of the branch triggered loads of
> kernel-doc warning[1] and I was bit confused with the file path. I did post
> the fix[2] for kernel-doc and was planning to send it as fix for v5.18, but
> let me know what do you prefer as it conflicts with this patch.

I originally wanted to merge this back in 2019, hoping we can do it
all for 5.19 now. The problem with the warnings is that moving a file
makes lkp think it's a regression when it otherwise ignores existing
warnings that seem harmless.

I can probably apply the warning fixes on top here, and I think it would
also work to have them in a separate branch, since git usually figures
out the merges across renames.

       Arnd
