Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD5F56D083
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 19:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiGJRar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 13:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGJRaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 13:30:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F399C9FFF;
        Sun, 10 Jul 2022 10:30:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id j22so5334485ejs.2;
        Sun, 10 Jul 2022 10:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=2DGbSjRy5iUZ0tdLoY1pNaKdK+nVu9PN43BI0d+O1As=;
        b=NvhpwGhzPwD1h7L24uhoGt5L58UOqHnjhbV+wyRjMz5deW5Djg9KlExbXwpwY3RL4e
         SXCUhU/eo+f0o7IqMiH3Wy9mnNs8Dqp9bItoUD+vlJFSqG42OyVKWhS/jkSeYTQwRx9/
         RgwZYZkw+x0QdCl+3Pzm9mR7pdqw9nQghC2KSB3+TGt16kxWJ32hAToCZJFjgoH4ytkj
         6erLmGlGW4N2s0UjvPRjVcowx/IsyAk3R/1kIKR1/OAM1WL+sTUGhQUmCeMo8jJvruDa
         Yn06unSPrpuWjfZpUqFvuvtN+ZEGLHGR95vEbcmLMcEdf6aXSWQs8hkHyCKSHhZ6bUIF
         njiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=2DGbSjRy5iUZ0tdLoY1pNaKdK+nVu9PN43BI0d+O1As=;
        b=OnlRERd3pkQkYjmGkOHsnSDELkjq9qgDJwd8K8QjUcCSakmBYenwVYTWSmRZHPhGSJ
         Jly7EufV5v79dRIG2RGvTa8VYSvpy9fFAb2JF0agyi20L+tcETKygwIjYiK9Dlq63cii
         V3B9wrIbvgufiTDnYfBxaPcetTtWMCLVSeS4sBW9LyIlA4giB4U3i/bqP2Oh1dlAsFaV
         vl4n0XRM5miEavZb4egr1BIeTLhl/N08FmtYxfdNJ1Lkt6bwSCE1QoO1Mm/JYC+eQv27
         F4CfCcgBuiyXE3TZMX3FMMdONjAKbZcEDDX5UyAXihZOPuvUy1gUO8Of7eeQ49TbCdda
         w23A==
X-Gm-Message-State: AJIora/MnvBn23Hmr1H6yWfIsOQy/ntAB4+ZSPAYDnoY41w/Gp/OR1MZ
        WzQ/yapaFjml+qXP28Vs34A=
X-Google-Smtp-Source: AGRyM1sR2V0rjsCP5LhY6KsS9fOUpoUcJsF73oyMZ2R75Q4Ek5kSr31vOGXOSNKfGxM7jcTwAF3DZQ==
X-Received: by 2002:a17:906:7482:b0:722:edf9:e72f with SMTP id e2-20020a170906748200b00722edf9e72fmr14589838ejl.92.1657474243448;
        Sun, 10 Jul 2022 10:30:43 -0700 (PDT)
Received: from ?IPv6:2a02:ab88:368f:2080:eab:126a:947d:3008? ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.gmail.com with ESMTPSA id ej24-20020a056402369800b00438a13508c4sm3025323edb.51.2022.07.10.10.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 10:30:42 -0700 (PDT)
Message-ID: <2660a89ccbe160d5bba4b617edf44414d75b6259.camel@gmail.com>
Subject: Re: [PATCH 1/2] clk: samsung: exynos7885: Correct "div4" clock
 parents
From:   David Virag <virag.david003@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Date:   Sun, 10 Jul 2022 19:30:40 +0200
In-Reply-To: <033af024-8acd-e536-0c24-ff30b12a581b@linaro.org>
References: <20220526055840.45209-1-virag.david003@gmail.com>
         <20220526055840.45209-2-virag.david003@gmail.com>
         <2eda61c1-a076-3467-91bc-8c2e14f4f516@linaro.org>
         <033af024-8acd-e536-0c24-ff30b12a581b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-24 at 09:59 +0200, Krzysztof Kozlowski wrote:
> On 26/05/2022 09:21, Krzysztof Kozlowski wrote:
> > On 26/05/2022 07:58, David Virag wrote:
> > > "div4" DIVs which divide PLLs by 4 are actually dividing "div2"
> > > DIVs by
> > > 2 to achieve a by 4 division, thus their parents are the
> > > respective
> > > "div2" DIVs. These DIVs were mistakenly set to have the PLLs as
> > > parents.
> > > This leads to the kernel thinking "div4"s and everything under
> > > them run
> > > at 2x the clock speed. Fix this.
> > >=20
> > > Fixes: 45bd8166a1d8 ("clk: samsung: Add initial Exynos7885 clock
> > > driver")
> > > Signed-off-by: David Virag <virag.david003@gmail.com>
> > > ---
> > > =C2=A0drivers/clk/samsung/clk-exynos7885.c | 4 ++--
> > > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> Sylwester,
>=20
> This goes to v5.20?
>=20
> Best regards,
> Krzysztof

Hi Krzysztof and Sylwester,

What is going on with this patch? What will happen to it? From what
I've seen, Sylwester doesn't seem to be too active lately. I just don't
want it to get lost. With only one of the patches applied, UART is
partially broken on 7885. Don't want to make unnecessary noise, but
this patch should probably be applied sooner than later.

Best regards,
David
