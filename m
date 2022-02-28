Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A954C71E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238008AbiB1Qor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237303AbiB1Qod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:44:33 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B9466ADF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:43:54 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 418EA3FCA6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 16:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646066632;
        bh=PoF7elbTeQtgqDFeGhaJqHwYRICrtlMa3jaB+3i7AgQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Z4TYlNswxNMUHzoYBQIyaPxe0cT1AFXysV2Nbhnsp8bp1aeuvYjSDsH5edclN2YdL
         gpc3zW7zaUQz7MnOR8l5Pq3tUdD5lgDp4utg5Npiv+vqVUYKjw/aOaoO2ieZWWKXtQ
         wLCtnjdE0fKLkDqDvzZ3jt0ENC7wiBSO65ClOL/GAx9FHdJuFF0zVrt35F1F/ViEKT
         UCjggPejfpJQ4F55/n4H+ovpT5FTdkZRSbeGeRmDXnsuK9hkZcOwogqXrG1kAYHOux
         cRYuFbAyI64u5+jOg5q083c82ezpurglaQABtHTTq5lQnS+MLayHTPCz4X2XirslcM
         PlQ+87bC/6vqg==
Received: by mail-ej1-f72.google.com with SMTP id nb1-20020a1709071c8100b006d03c250b6fso5447274ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:43:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PoF7elbTeQtgqDFeGhaJqHwYRICrtlMa3jaB+3i7AgQ=;
        b=uEQUiSiBbgzJaFTwnSjc0RdGWp4aoX2RoVOZqBgsN2+tllfX4BOy6Lkq4NnK65X9Z5
         l65/II7yTU4wVqkleC8gbpdEmQATR3lVX2Dg2NtIhAsJn1ES49MxSykuYojPNCKTtkbW
         h5XB+lqkMac7aJ/fQhusK6Z/r03y5c8IOBPi2juvK8Q+ZLmxZ94k9KZ0GjX0kNKn4YR8
         6cJvkONSZuwYi80xGLh71EdoLaH9BTYwbqM4ypzGh03FqKo0PGEHJOfqMReHetfK0LoF
         usmxQF7YjsCUbZDlYOrO4s9PUZk0zyO3A2mE+Iqjf8Dz2EmKVewNugIl74o34seH5APY
         ZbZA==
X-Gm-Message-State: AOAM530EUFdp7s0BrSac3jaUdrgyIki2vePgFCm514mvQ2Hwfcf8w8I5
        U+LZY3QvMNaVyjA4762tXuk1OkgL18ybvWtHfueiN4dh6LlfFsBPzydYqXSZs+PJ+VrHDPuRWUK
        9SFEf4Bc4ro+Zuze58FF6/VIRfj8iHW631pcfoJKNuQ==
X-Received: by 2002:a17:906:c04d:b0:6b9:252:c51c with SMTP id bm13-20020a170906c04d00b006b90252c51cmr15364163ejb.470.1646066631922;
        Mon, 28 Feb 2022 08:43:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOi/bdof4uy0KEGbVp5rydze7BHQMHnskiHw6541xXjs05x74RpvOkmh39MSRPcmAqLBZlgA==
X-Received: by 2002:a17:906:c04d:b0:6b9:252:c51c with SMTP id bm13-20020a170906c04d00b006b90252c51cmr15364150ejb.470.1646066631726;
        Mon, 28 Feb 2022 08:43:51 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id p18-20020a17090635d200b006cdeef01456sm4498443ejb.163.2022.02.28.08.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 08:43:50 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 3/3] memory: tegra drivers for v5.18
Date:   Mon, 28 Feb 2022 17:43:13 +0100
Message-Id: <20220228164313.52931-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220228164313.52931-1-krzysztof.kozlowski@canonical.com>
References: <20220228164313.52931-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Tegra specific branch.

Best regards,
Krzysztof


The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-tegra-5.18

for you to fetch changes up to 0123af535b9c090cf05dcf500f9303bae5849691:

  memory: tegra: Constify struct thermal_cooling_device_ops (2022-01-27 10:41:54 +0100)

----------------------------------------------------------------
Memory controller drivers for v5.18 - Tegra SoC

1. Correct Tegra20 EMC memory device mask.
2. Minor improvements.

----------------------------------------------------------------
Dmitry Osipenko (2):
      memory: tegra30-emc: Print additional memory info
      memory: tegra20-emc: Correct memory device mask

Rikard Falkeborn (1):
      memory: tegra: Constify struct thermal_cooling_device_ops

 drivers/memory/tegra/Kconfig             |   1 +
 drivers/memory/tegra/tegra20-emc.c       |   2 +-
 drivers/memory/tegra/tegra210-emc-core.c |   2 +-
 drivers/memory/tegra/tegra30-emc.c       | 131 ++++++++++++++++++++++++++++---
 4 files changed, 124 insertions(+), 12 deletions(-)
