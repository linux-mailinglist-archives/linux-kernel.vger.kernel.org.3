Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D815C4F4FD2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839529AbiDFBEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457671AbiDEQc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:32:58 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261B6BF00C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:30:57 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2eb543fe73eso82962807b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 09:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KMTS6ZzHfqr0cBt89fdY6xnjYm43a4DPuwzvi/5KFcU=;
        b=GfRipIriW+4Gj99TqghbKjqPOWjqvQue0SDRC4xYdndLHj14kAu4g3o3HbRpq6OgaD
         Sn5pT4Z+6R1oJj23BSQ3wpF7CHtOUv1KqyofptkTp7Zjl47B9Y3A3JwDNhcn3tuTwLvP
         Ur2dd8w+slSKU4TcOWV01cvwPCEC1SpHjBtjbb5VvcqSJGQCubjtJbLpzVirhDpU+S8w
         pQBn9XJtkFGu1pwS/xFAkRR612gGqFmLkKD5w4ZeCdC1JeNlITkXhKL/EI3/g/5k1qXR
         JYfMlyH0cOCO2YB8okcmQzy934x3VMAmYrn20RlsTdQON1UeQZGjZbsdDhgXhNHVxOdi
         mV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KMTS6ZzHfqr0cBt89fdY6xnjYm43a4DPuwzvi/5KFcU=;
        b=t34DoLdAbC8m0ngyTZrb1w1BvYOiXBGW/VlkPFCJ1oSOB8AWcbAFp0uUne8nz4Kjla
         rff/OdCEJf+Ir46XvclE8ZKbhS8UD9YG9IHu0sEeFqYmnRVqJYgsLmE14vTQsc5zJk//
         AEBT16KzH2HycPKHM/x4Jl6ZmCRIFOCqg+7QBaHGDJzSOI5PxH+H8ogETSrHOfgDfeqN
         ull/jfy7YP943MBex6V+RNn4ewfDQhC+uFuoXWKFZ1OIJaQixUMdD9Dbnymd/WSuU+9r
         FeS6kk1NaHATX5g0wAjA6Rqa3g8CNkNiyiitE1gdeRT4j23m7UANWW2KI4dheEF7459K
         +JDA==
X-Gm-Message-State: AOAM533TEzPV7NL24BCuETnys9vl6jl7Gz1ZjBBQrwFpYGmrVUjG4jY6
        dJZIEYJCdzZtOX52+QF5IFvRuHXQXShza/PD0UiCig==
X-Google-Smtp-Source: ABdhPJyIgna9axSeomjEBQ4XMEGPKbQbe9lvwwQnq3ep9YudH9QmF87Opki8o1yO4mskUXTOYwEcNk+E7wb+6fxKfmM=
X-Received: by 2002:a0d:cc55:0:b0:2eb:994c:1b56 with SMTP id
 o82-20020a0dcc55000000b002eb994c1b56mr3445672ywd.437.1649176256367; Tue, 05
 Apr 2022 09:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220405091750.3076973-1-arnd@kernel.org> <20220405091750.3076973-2-arnd@kernel.org>
In-Reply-To: <20220405091750.3076973-2-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Apr 2022 18:30:43 +0200
Message-ID: <CACRpkdZHFmxB+dHyeFSJjgXeBc-KPtBNS50m-EZDUOjd2EHKZw@mail.gmail.com>
Subject: Re: [PATCH 01/12] ARM: versatile: move integrator/realview/vexpress
 to versatile
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hubert Feurstein <hubert.feurstein@contec.at>,
        Lukasz Majewski <lukma@denx.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 5, 2022 at 11:18 AM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> These are all fairly small platforms by now, and they are
> closely related. Just move them all into a single directory.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Tested-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I can't test much right now, but I sure trust you with this!

Yours,
Linus Walleij
