Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE41059D20D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240984AbiHWH0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240970AbiHWH0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:26:25 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5499062AB8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:26:23 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id v10so12679988ljh.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CA1NcfupXZ+Y6O5apZ33IyMSf0uTLHJCgwtbwnzVlTQ=;
        b=kN3UxZ5jQk66vj9Su+ZQ7GYkclKZvTAn3m8JcOOwUvPNa9VZmtk5lWVg54v7hwbNFH
         mR08MXf7TLbR7V5vSiHvO6CfCBOo1znLq/oDEJFt+KXRr5SItTMkhIqxDmUO7TZDcipQ
         yqy+xHhHDMZFSRE3vOUIIjL0XTu/mjKA3gQSHEUzU080meF9H1TjDUBqFgQzNd4Yt94Q
         sbSRvW5lv5ZTxo11/ZP3rFGboTCy8whSgTrjUhqPLamMlwAqY+hEHhhjrj8VtK33RoBn
         DnddGeqNzIqIFIxHmHfDyFnIXdF6NUzb/GyMTB7k+MidE7xtpC7wYQcQhPeXVeJOcuG/
         esag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CA1NcfupXZ+Y6O5apZ33IyMSf0uTLHJCgwtbwnzVlTQ=;
        b=JPSqaYHdYu7iXmDFwBY75FHCjipEFy+9391HqQfec8LiGXlvxZ6jsAYgk0ZyTHGFZ5
         YYZ2PrWpbhjDMGbYYUhzT3G2yFOVT650eXSSMKe6SPYkwL2TKWhiz5h9fmQDssbKhQir
         Pot8iP30piM+7xSA3yQL4bYlX2MDFPfvRNJFmlHZgnBiRs+fqz1fWqzDuPkn78TFXAoO
         MXKnjUQYOf2ZjpYar8Wn7TpwK/Kq03IgQKOsLrE1h1NccT8vrKYtaX43eP6pumqFg5c/
         8mA+a9amXO79OsZxxHBXERv8GFmY68CJSNEjKhXzusbfS/IZOcswOK4YfbOtbRzjUaJN
         /Mog==
X-Gm-Message-State: ACgBeo17v8uURpA1RbmgrLDepDT/O+wFuSU0bd8GA+48Ik8Mgi8oUUDb
        KwLpW8Y6wn148U/ujnMxoqSXMw==
X-Google-Smtp-Source: AA6agR7cuT1wbQ8NAVGM14stFo89z7n8AfpUfMyk3jcEgGYXkZ7wggrqNluPg66t8QJ5BhnaEYE8Eg==
X-Received: by 2002:a05:651c:1047:b0:261:d925:1e16 with SMTP id x7-20020a05651c104700b00261d9251e16mr137808ljm.483.1661239581718;
        Tue, 23 Aug 2022 00:26:21 -0700 (PDT)
Received: from krzk-bin.. (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id i24-20020a196d18000000b0047f8e9826a1sm2357410lfc.31.2022.08.23.00.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 00:26:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, chanho61.park@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-samsung-soc@vger.kernel.org, semen.protsenko@linaro.org,
        devicetree@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 0/6] fsys0/1 clock support for Exynos Auto v9 SoC
Date:   Tue, 23 Aug 2022 10:26:14 +0300
Message-Id: <166123956380.357728.6170161868396064504.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1659054220.git.chanho61.park@samsung.com>
References: <CGME20220729003611epcas2p1fe80f3eb06160c48c41f10b35d7c03eb@epcas2p1.samsung.com> <cover.1659054220.git.chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2022 09:30:18 +0900, Chanho Park wrote:
> CMU_FSYS0 block provides clocks for PCIe Gen3 1 x 4Lanes and 2 x 2
> Lanes. Similarly, CMU_FSYS1 provides clocks for USB(2 x USB3.1 Gen-1,
> 2 x USB 2.0) and mmc. For MMC clocks, PLL_MMC(PLL0831X type) is also
> supported as a PLL source clock provider.
> 
> Changes since v1:
> - Patch 0002 and 0006: Put FYS1 prefix for CLK_MOUT_MMC_PLL as pointed
>   by Chanwoo
> - Add Chanwoo and Krzysztof A-B and R-B tags to 0001/0003/0004 and 0005
>   patches
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: clk: exynosautov9: add fys0 clock definitions
      https://git.kernel.org/krzk/linux/c/153da489e5e7c9aed7e6445b9450d98d5ebd5a5b
[2/6] dt-bindings: clock: exynosautov9: add fsys1 clock definitions
      https://git.kernel.org/krzk/linux/c/3c073243c5df0146fef619f7aa5874b2e9d234a3
[3/6] dt-bindings: clock: exynosautov9: add schema for cmu_fsys0/1
      https://git.kernel.org/krzk/linux/c/4b6ec8d88623fed87088f141bcce79f67d82f301
[4/6] arm64: dts: exynosautov9: add fsys0/1 clock DT nodes
      https://git.kernel.org/krzk/linux/c/ac94f66521a5488eccdded4036b0ec039ceb87d5
[5/6] clk: samsung: exynosautov9: add fsys0 clock support
      https://git.kernel.org/krzk/linux/c/3477b3c3a9fbb6422874c7f24a35249e1773c687
[6/6] clk: samsung: exynosautov9: add fsys1 clock support
      https://git.kernel.org/krzk/linux/c/65522e7d86c986df77bd3106de1ef7712070ee7e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
