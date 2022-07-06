Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE100568F4F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiGFQiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiGFQiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:38:00 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E47B1AD8F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 09:37:59 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y16so26820604lfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 09:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3JIvP1fLoUDaPL2KDH7rBxoB2fmHYy4Oyai7s7FblzM=;
        b=z8QpHD2g9KR0gRs38I9tQHxuBxZcFspVly256PoFHFttb5ZU65VHEVxW4zL0jDIk1N
         OHb8Ke2HlLC1wovgg8KpnrshVxdq54tWma9NzHHxB9JdIPUAXdZYZh6CmiIeW1v+rZXR
         jeYwxXa7VTcudWJvGa/mR8mye9YsFGb6RJkF2QDk8uy+gAIMoW4HYYv4A55lkYrTtkXV
         PmOKeRTYsepmCpXtJgZZpqF8Yk8QD3m3Q0xZURpBd6rOMfC4FVj/mtrr5FtlHA8syOvu
         a5xEmQo+a6vRc7+gcNgXhUhZ7Y2ftV1f4OBHaorAuNOGyxHbjZ1C0J7GrWxiWojD1Wyy
         55vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3JIvP1fLoUDaPL2KDH7rBxoB2fmHYy4Oyai7s7FblzM=;
        b=cQX/aJXXUmjUms3kFxTlKYc1bwNd0DhKStHmqOovIxjOhNwF1Pv6RztOzDl74T2GK7
         04XHWUXJeOR7Gf7If2Qw9le7cXI73cUo1PUq6XAUc6HK+ezYBuQji+3iK4CdYLRrFBPv
         PWi+G/llsjMaGHR9sWvwHzZqg2CK5dUUzfk9Yb4M+ddZkTAVqWG1hG1EPDI2cPGfUK9X
         SqeP20uspSK4cQuDKxhpXOrtyTOmFaoYEYcXyJ7pxRgfBLxTfvNwq5h1yhtbuB1gVe64
         1LaY7jaqXwq962+JjQugqUp5oQAKLtrEYlKs/9RShVfcVqC8fvIsO8lGkRKyYP+Zl3xs
         suUg==
X-Gm-Message-State: AJIora/Sv2ccnYmsK5TqohR1QpeCiJ2T+KzM1LWmelSU/A1nddQI40M9
        TkEFlHBLyHpn0DHpRmAZ+/IXOA==
X-Google-Smtp-Source: AGRyM1u0vGXTJ6VoG+UpXo1yuYiOQ2/csLw8KHFNtxpsN2sGIuYba6SJoaBHEAs8+lbsIADjsYgTBg==
X-Received: by 2002:a05:6512:929:b0:485:5918:7a8f with SMTP id f9-20020a056512092900b0048559187a8fmr3617198lft.463.1657125478033;
        Wed, 06 Jul 2022 09:37:58 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id v12-20020a056512096c00b004831cc659ffsm1168063lft.125.2022.07.06.09.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 09:37:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/2] arm64: dts: cleanup for v5.20, second round
Date:   Wed,  6 Jul 2022 18:37:53 +0200
Message-Id: <20220706163754.33064-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

This should conclude my cleanup session for ARM/ARM64.

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit 87ccc38e2f8e55853ddfe633d9934bc7ca74b21c:

  arm64: dts: apm: Harmonize DWC USB3 DT nodes name (2022-06-27 10:15:20 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/dt64-cleanup-5.20-2

for you to fetch changes up to 2b090180dced85ccf27f276c1b6c9521d4c4120e:

  arm64: dts: marvell: armada-3720: align lednode names with dtschema (2022-06-27 10:44:03 +0200)

----------------------------------------------------------------
Cleanup of ARM64 DTS for v5.20, part two

Remaining cleanups for ARM64 DTS: gpio-keys and led node names on Marvel
platforms.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      arm64: dts: marvell: align gpio-key node names with dtschema
      arm64: dts: marvell: armada-3720: align lednode names with dtschema

 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts     | 4 ++--
 arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)
