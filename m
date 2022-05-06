Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E5751D322
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389987AbiEFISn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382746AbiEFIS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:18:29 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C4168308
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:14:46 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p189so3961023wmp.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 01:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xa612yVHb6HXBQzlDy/uT4iwCUAq6n6m6URF8UDTFTU=;
        b=pAiRgKNTrhEaUnUs+8tjgRIqQlOirjUVrUZP7kH10tLCeLNd5ytCQoxAx8PJ5aoK7D
         R/M4OEQtf9Vb4b98mzjUWya4daurbyQyZhbb+r6kjf7fGBG/dWPrJAak1wztEi5whqNu
         xi0l3ylZEt1E3HtxEuwpwhxnRiV4PIUC4o7yHxMPHUtREvsyHjwWNfn58HTitNuWKuFl
         kD3Tur6t5HWrRZWxDNIS4aXwmQii1XKxqU1iZNaeKv9ySfKcpE42spFewIK9XAqVSBIM
         u3zQ4mQx1uNnrFVxq4x7+Tq/mxgdamJlXNPSQ93a9ukGEOXBzW1bKaDg5EShaIXcjjxk
         4YAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xa612yVHb6HXBQzlDy/uT4iwCUAq6n6m6URF8UDTFTU=;
        b=T8wfw+JCV7BrczG6w/yCyTRXbf4ql7c3aTVAw81V0Mt+JjE+/hKcBk1CPslBZpZuMR
         IaRL3Tn2PpP7j6WAKt5J+texjvOtE+Yw5+9TEt6Tm7VNTMwanPDfWMA3zF8aC2Mc4AQx
         884fAckuK3jXgQFpqIEuIeAqC1y4jXYwDFv79oLk8JjQ8fChU1wiLZYJPYCPyBzf6fz4
         AZ9JqnzcXCdVNQ+V0fDSmdPFMfH8QWTAydtAQ8Bm0Voj87SgOqH5A8J5JAiWD5kSdBGF
         FWVGLqh/qS6ZFXG5559Mv9u5ZKd/1cSus2nAJBAmGrxHE8ZhNo0fnqPDtDUmDfqQeVSI
         UI5Q==
X-Gm-Message-State: AOAM531+PtmvpQijWvUe9eoMZFMxt5XGCGKi6+D0QuxIizGgkhZJggcx
        dplu9LCHG/YnW4SIXDE9sGsZNw==
X-Google-Smtp-Source: ABdhPJwEacI0vG9xsyOL4YvQY1+ii+HmvrdPQD6nUpZtBIX974o17ZgCm6xXecCjVVYHxwlQh90a2w==
X-Received: by 2002:a7b:c8d6:0:b0:394:25ff:2de with SMTP id f22-20020a7bc8d6000000b0039425ff02demr8490338wml.154.1651824884930;
        Fri, 06 May 2022 01:14:44 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c14-20020adffb0e000000b0020c6fa5a797sm3059657wrr.91.2022.05.06.01.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 01:14:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 2/6] ARM: dts: various cleanup for v5.19, part two
Date:   Fri,  6 May 2022 10:14:34 +0200
Message-Id: <20220506081438.149192-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220506081438.149192-1-krzysztof.kozlowski@linaro.org>
References: <20220506081438.149192-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
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

Hi,

On top of previous pull.

Set of cleanup patches for various ARM archs.  Some of them were acked by
respective maintainers, some were waiting a bit so I decided to push through my
tree.

Best regards,
Krzysztof

The following changes since commit c9bdd50d2019f78bf4c1f6a79254c27771901023:

  ARM: dts: socfpga: align interrupt controller node name with dtschema (2022-04-07 21:30:22 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/dt-cleanup-5.19-2

for you to fetch changes up to 361736cf495ccc49df5ae66d0f9f10a55976d2da:

  ARM: dts: socfpga: drop useless 'dma-channels/requests' properties (2022-05-04 10:26:14 +0200)

----------------------------------------------------------------
Minor cleanup of ARM DTS for v5.19, part two

Align SPI NOR node names to DT schema and drop unused/undocumented
dma-channels/dma-requests.

----------------------------------------------------------------
Krzysztof Kozlowski (5):
      ARM: dts: nuvoton: align SPI NOR node name with dtschema
      ARM: dts: omap: align SPI NOR node name with dtschema
      ARM: dts: marvell: align SPI NOR node name with dtschema
      ARM: dts: zynq-7000: drop useless 'dma-channels/requests' properties
      ARM: dts: socfpga: drop useless 'dma-channels/requests' properties

 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi        | 2 +-
 arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi        | 2 +-
 arch/arm/boot/dts/am335x-phycore-som.dtsi                | 2 +-
 arch/arm/boot/dts/am335x-sl50.dts                        | 2 +-
 arch/arm/boot/dts/am3874-iceboard.dts                    | 2 +-
 arch/arm/boot/dts/am437x-cm-t43.dts                      | 2 +-
 arch/arm/boot/dts/am437x-idk-evm.dts                     | 2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts                      | 2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts                     | 2 +-
 arch/arm/boot/dts/am574x-idk.dts                         | 2 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts                | 2 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi                 | 2 +-
 arch/arm/boot/dts/armada-370-db.dts                      | 2 +-
 arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi | 2 +-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts         | 2 +-
 arch/arm/boot/dts/armada-375-db.dts                      | 2 +-
 arch/arm/boot/dts/armada-381-netgear-gs110emx.dts        | 2 +-
 arch/arm/boot/dts/armada-385-atl-x530.dts                | 2 +-
 arch/arm/boot/dts/armada-385-clearfog-gtr.dtsi           | 2 +-
 arch/arm/boot/dts/armada-385-db-88f6820-amc.dts          | 2 +-
 arch/arm/boot/dts/armada-385-db-ap.dts                   | 2 +-
 arch/arm/boot/dts/armada-385-synology-ds116.dts          | 2 +-
 arch/arm/boot/dts/armada-385-turris-omnia.dts            | 2 +-
 arch/arm/boot/dts/armada-388-db.dts                      | 2 +-
 arch/arm/boot/dts/armada-388-gp.dts                      | 2 +-
 arch/arm/boot/dts/armada-388-rd.dts                      | 2 +-
 arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi      | 2 +-
 arch/arm/boot/dts/armada-390-db.dts                      | 2 +-
 arch/arm/boot/dts/armada-398-db.dts                      | 2 +-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts                | 2 +-
 arch/arm/boot/dts/armada-xp-crs305-1g-4s-bit.dts         | 2 +-
 arch/arm/boot/dts/armada-xp-crs305-1g-4s.dtsi            | 2 +-
 arch/arm/boot/dts/armada-xp-crs326-24g-2s-bit.dts        | 2 +-
 arch/arm/boot/dts/armada-xp-crs326-24g-2s.dtsi           | 2 +-
 arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s-bit.dts     | 2 +-
 arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s.dtsi        | 2 +-
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts                 | 2 +-
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts            | 2 +-
 arch/arm/boot/dts/armada-xp-db.dts                       | 2 +-
 arch/arm/boot/dts/armada-xp-gp.dts                       | 2 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts            | 2 +-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts           | 2 +-
 arch/arm/boot/dts/dove-cubox.dts                         | 2 +-
 arch/arm/boot/dts/dove-d2plug.dts                        | 2 +-
 arch/arm/boot/dts/dove-d3plug.dts                        | 2 +-
 arch/arm/boot/dts/dove-dove-db.dts                       | 2 +-
 arch/arm/boot/dts/dra7-evm-common.dtsi                   | 2 +-
 arch/arm/boot/dts/dra72-evm-common.dtsi                  | 2 +-
 arch/arm/boot/dts/dra76-evm.dts                          | 2 +-
 arch/arm/boot/dts/kirkwood-dir665.dts                    | 2 +-
 arch/arm/boot/dts/kirkwood-synology.dtsi                 | 2 +-
 arch/arm/boot/dts/nuvoton-npcm730-gbs.dts                | 6 +++---
 arch/arm/boot/dts/nuvoton-npcm730-gsj.dts                | 2 +-
 arch/arm/boot/dts/nuvoton-npcm730-kudo.dts               | 6 +++---
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts                | 8 ++++----
 arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus.dts     | 6 +++---
 arch/arm/boot/dts/socfpga.dtsi                           | 2 --
 arch/arm/boot/dts/socfpga_arria10.dtsi                   | 2 --
 arch/arm/boot/dts/zynq-7000.dtsi                         | 2 --
 59 files changed, 65 insertions(+), 71 deletions(-)
