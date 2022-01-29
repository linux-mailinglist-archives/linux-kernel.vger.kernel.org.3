Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378F94A2E6A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 12:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbiA2Lyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 06:54:51 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60640
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239253AbiA2Lyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 06:54:49 -0500
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 225E83F1C2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 11:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643457286;
        bh=Ijka2jOdpqFz2YrK3+F7qMhZIXOz2gEU2sD1tESTLRA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=tJ8GVkNl+57fkdsI8qjnk58UKYoucIRIkQgzlH9ibur0EoB+XyzyCNHlKrSTEz/tP
         EVQ8hvJZEl4YPK0Bd8JI1AtiK8hflnxfEwBfCR+7c+v8jAKpcT6m5M1ezFQihynkxN
         JG3vZla6fXS4Kv/IzI9lusi6okqaOtBltsPvQP3xVZVHfhxVk4DG1C6mSSZM79em51
         rkE6X8IRycXZYNq9oNRwXzz9nWzNn2nd/OxQ4zNgPmxDhWmbN8574HkfoTdMe0VfHv
         fXxidM8YepdrTPYnlMrDijG2lR9rm+xCxMoP/hqYkv4rFeSc3bLmTMIoV3/6y7FPhr
         QJMrBX9Bm0RIw==
Received: by mail-ej1-f71.google.com with SMTP id q3-20020a17090676c300b006a9453c33b0so3663648ejn.13
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 03:54:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ijka2jOdpqFz2YrK3+F7qMhZIXOz2gEU2sD1tESTLRA=;
        b=NZ/MNogASkxvhRZv+gZl6XNUfX2O+caehWrYp18Ku335IG3Kt0HM01YBANv9ZLlhwn
         MdQCb4vhoBrFF3ukjsBCzW6TWlcMM+C/fPi8higewUaohGoQVogj9dYn2n4ktKKCYRSS
         dNfT/O9thSgLng7MI38KHgnWCKyn4lu4SrdczFpxhMUvmRr8XUXKcaXfLMRKS8iMvw5I
         uQGFxKT6OXpQOlm4Xnp3QK31R3QLjnTxCcRGbD71oGqcE854XE6r5iQ6oSo23aP2ZJVT
         w5H7ZhnrPyoyv6xlax13w76b9hfNxkblw+jSwQwfDfUn2y2bAmyHVMeKDNDy0QJwohSv
         OTKA==
X-Gm-Message-State: AOAM531aw+9NGmuNXHTB7jq0+xaLi6tM1nYsVmFoEQkFvhwiMYYgqbII
        z+W6o62VKdbexE3WKfD1gD/MgzZau/Vwao5YJs/eU38M4lkBCE+EZmmNckPsh+zTUVz9ORNEz7c
        HyVe3cg+1UYRuH74ineLueSzfaY6FUlHq4dALO2J37A==
X-Received: by 2002:a17:906:31d0:: with SMTP id f16mr10332123ejf.627.1643457285826;
        Sat, 29 Jan 2022 03:54:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwl4F8K9oN0osyeshGAGks4kNiiTjSReACDvep5GAMERd/Swk/uXL7hADTVqMn//NHDVdJ/cA==
X-Received: by 2002:a17:906:31d0:: with SMTP id f16mr10332112ejf.627.1643457285661;
        Sat, 29 Jan 2022 03:54:45 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id b30sm14571734edn.16.2022.01.29.03.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 03:54:45 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [GIT PULL] Samsung fixes for v5.17
Date:   Sat, 29 Jan 2022 12:54:42 +0100
Message-Id: <20220129115442.13474-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-fixes-5.17

for you to fetch changes up to 442b0c08db7e35980bed6af091877f4dda72ffca:

  soc: samsung: Fix typo in CONFIG_EXYNOS_USI description (2022-01-23 18:05:41 +0100)

----------------------------------------------------------------
Samsung fixes for v5.17

1. Typo in CONFIG_EXYNOS_USI description.
2. Add Alim Akhtar as a reviewer for Samsung Exynos platform.

----------------------------------------------------------------
Alim Akhtar (1):
      MAINTAINERS: add reviewer entry for Samsung/Exynos platform

Sam Protsenko (1):
      soc: samsung: Fix typo in CONFIG_EXYNOS_USI description

 MAINTAINERS                 | 3 +++
 drivers/soc/samsung/Kconfig | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)
