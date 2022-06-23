Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D210855888E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiFWTVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiFWTVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:21:37 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C1213AE86
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:26:15 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3137316bb69so2500547b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t2pPTveqS8s0fQwgl1QSUsYJHYeVq24X4ly2h9r9nhQ=;
        b=JI7eGjD6gcvb1OtYyNkvDVvmzIcgzS2gXraBsPiY8g19hZY7naRTOsxp8yJbg8WMo3
         8cdScN4v03cm1r2YSPVydtD2Wy9l30VkjHPC9tELAm3ZggABJyFKJUs8Rvq8lJakpJYn
         fI1X2h0xMa3dfiFVlq/+qyhZWLjEZ9CB04NTDxCfXHW73dRWcqmYIdTWCg13NnABJB5N
         IWqNzHdIBkPMqsImCzZnAFh0PntU+9or1MMvQQ1+T47lwU8ThoWQ0FotRy/f36K2ILRU
         xNvMIx7hWLNFa3xXbDcS+3AVcRLpXxwhiQxaYPjaEgw4m/zqbAlF3c0RTErvRCU5tbOe
         ZT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2pPTveqS8s0fQwgl1QSUsYJHYeVq24X4ly2h9r9nhQ=;
        b=CJbjvF8DzclNf7DqEY08wEkFUArKZ8iGBg68aCk0rjDkG790XXucLFsVF4Fll+3br1
         Y2mg4jpL169g9gZvF0+myja44dtHWw9rcaiiKCG3RlNEFEEPanYQYTR+GgOxIrxm5XlH
         8SEF6G75EwbeiFXIYamk3gEgXEm8oQOUiYludF/Cvx2AvwjGXzhS1bafK2LgjYQdJ/tX
         9rMpmW/0K5kSzjuIdshAujRKiNo8LqyszK4pb/Gicnn9s+dS8+96G/cVpfknYxoz3gUo
         7uE03/L8WWVvME3gGeBOh9auYFRE5qY0iClc6HFGm03pFpeIhJQFLSwveejyzs2+NtYh
         BeWg==
X-Gm-Message-State: AJIora+Fl4R7r5IRXjxXOcSUxU8gC4uNwpzqP80CYCbbJpeF9fkpGLmK
        P26qsbtL717zCU5fqfGWqsP0bzdR//xo7yXs1asY7A==
X-Google-Smtp-Source: AGRyM1sQy/JXhU8eD3Pb6xhcXuB3hionujBBnRmgD/UkAV9fEcd0LgNheLlFkUMKyWzkTa03FeMKTS978V9kvxspb3I=
X-Received: by 2002:a81:7557:0:b0:317:6536:d404 with SMTP id
 q84-20020a817557000000b003176536d404mr11532503ywc.459.1656008774402; Thu, 23
 Jun 2022 11:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220622062027.994614-1-peng.fan@oss.nxp.com> <20220622072435.GT1615@pengutronix.de>
 <CAGETcx9JpTbYtGFoKttWLeiBB73QzzBM1o-OL0o-XuFouLcEog@mail.gmail.com>
 <CAOMZO5DFX72xuxWwAPsuk4Q667Ap7Dk+pR89cWDQJkzT0D2osA@mail.gmail.com> <CAOMZO5Ccu_v_G9DEwrEfVHq83-hfrXCP_h20Rv0=oFTLux5AkQ@mail.gmail.com>
In-Reply-To: <CAOMZO5Ccu_v_G9DEwrEfVHq83-hfrXCP_h20Rv0=oFTLux5AkQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 23 Jun 2022 11:25:38 -0700
Message-ID: <CAGETcx85z_hkhKFHUwnihqcD0UQG3xtSZjw=BZxqwQB0D1CMgw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: drop dmas property for uart console
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, hvilleneuve@dimonoff.com,
        Lucas Stach <l.stach@pengutronix.de>,
        abbaraju.manojsai@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Teresa Remmet <t.remmet@phytec.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, t.remmet@phytec.deh,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 11:20 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Thu, Jun 23, 2022 at 8:35 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> > It didn't work for me on an imx6q-sabresd board. I could not find a v2.
>
> Ok, found your v2 and tested it.
>
> It solves the console problem on an imx6q-sabresd.
>
> > Also, would this solution work when stdout-path is not passed in the devicetree?
>
> I have confirmed that v2 does not fix the case when stdout-path is not
> passed in the devicetree.
>
> While it is a good practice to describe stdout-path in dt, not all
> devicetree files do this,

I don't think it'll be hard to fix the console= case either. In the
case where you are not using stdout-path, how are you setting the
console? Just want to make sure I'm handling that case too.

-Saravana
