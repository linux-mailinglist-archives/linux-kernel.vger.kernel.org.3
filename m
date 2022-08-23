Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B4B59D204
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241019AbiHWH0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240976AbiHWH0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:26:25 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F0E62AA7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:26:24 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id by6so12674682ljb.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=BiwaO+tJ6D9uFFRuqrFJ6Lk+1eZHbSFwYlokO8SI9kY=;
        b=YD8vBeQEgbua10OlF5G7F7MHSy5oYfrAV/X3+6j11WcGONzNMADqmn/n2onWuanIy6
         U02noFuouG/A0/KelIXPUOJESqawCX9/EE07hno/z3a2GELw/INFZFBRwNJS4AaOz5T9
         1NPvqkL0PxaweziqFGP00M7xjrJITjLDpP/XaG9o0GWsQvjeXqNJqXunLAj2Wk3OzZX7
         foFfbhSUMobOqwJ32QqawF7mSzy42KIjBP8CDdcJmzZ0y8qsJVfsBE9T945tir/LTbBT
         gAt6F258wGRySck2Ow9oZ9ScGw/XnFDz15fRNYs9ffbvOmN+BXdRV+mOkob26biy26iD
         QkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=BiwaO+tJ6D9uFFRuqrFJ6Lk+1eZHbSFwYlokO8SI9kY=;
        b=69WzesWKvrUembXL8jmYtAJMYBp9aZivSqsZ3ILyNDGAwm8Yw/3ENN9N1iYFb8WKrJ
         FUNi0YUjyH+hFTjg1V532nMsnUVcn+fElmTzPdYAXxjF/E4Im5wdfuaLrs08P0M2z3q9
         0Npgj1TmS9uIFZI0+3vbhrHEXWHp/tOVov7nbtj4+2ZAr/fGQ8NbsELw3vuK0mZuf/+G
         crMKLYZJa2p8VyW83nEuxAVO4pt30k9r1aoXUoWxwD1xpanYi8n5zXkOhqrneNJceuHF
         b4JDiV2SllIbAF2ogGb5jZnRPM1g1ie5UqCWfmWmTxcPSpnQ7MxjHzriyNaxn4uADxkw
         D2kQ==
X-Gm-Message-State: ACgBeo1ZJuxpLMxKv4sx2M7d6GNDlODOOiszvj+OF1COl+p9SJXhX9WN
        232WwY9aIiW2LaN9lGUVUIP1KA==
X-Google-Smtp-Source: AA6agR54KJxfGU8ZHsWZgTp1U/cK9UNGx+bhRs55yUskY6DvKcheUuSilY9tKPgpyRuXBtqjH8IX+g==
X-Received: by 2002:a05:651c:2227:b0:25e:cc38:a1e6 with SMTP id y39-20020a05651c222700b0025ecc38a1e6mr7088816ljq.84.1661239582903;
        Tue, 23 Aug 2022 00:26:22 -0700 (PDT)
Received: from krzk-bin.. (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id i24-20020a196d18000000b0047f8e9826a1sm2357410lfc.31.2022.08.23.00.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 00:26:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>, chanho61.park@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v2 0/3] fixes for exynosautov9 clock
Date:   Tue, 23 Aug 2022 10:26:15 +0300
Message-Id: <166123956379.357728.7509148041951328796.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220727021357.152421-1-chanho61.park@samsung.com>
References: <CGME20220727021823epcas2p2d924128dab9d449c2c6794d16aac617c@epcas2p2.samsung.com> <20220727021357.152421-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 11:13:54 +0900, Chanho Park wrote:
> There are some fixes for exynosautov9 such as clock id numbering,
> missing clocks and register offsets.
> 
> RESEND PATCH v2 with:
> - Add Krzysztof's R-B tags for #2
> - Add Chanwoo's A-B tags for all patches
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: clock: exynosautov9: correct clock numbering of peric0/c1
      https://git.kernel.org/krzk/linux/c/b6740089b740b842d5e6ff55b4b2c3bf5961c69a
[2/3] clk: samsung: exynosautov9: add missing gate clks for peric0/c1
      https://git.kernel.org/krzk/linux/c/6ac24a3a24a9e88f5e1ee8e96fd9d39fcab28b3f
[3/3] clk: samsung: exynosautov9: correct register offsets of peric0/c1
      https://git.kernel.org/krzk/linux/c/67d98943408bce835185688cb75ebbb45b91e572

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
