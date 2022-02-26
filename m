Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B570E4C5868
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 23:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiBZWCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 17:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiBZWCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 17:02:01 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128B81AE662
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 14:01:27 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5CBF33FCA7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 22:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645912885;
        bh=FAnUY3DfJ5M1qZcbwfAjnLrPQZIrehzFU3WzcGW4NPY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=CPY8LzLDrC/HrjuEx8cmKTddpcMv7irPqA5I8Bp6hAFpRzRG8pGrB/XoKXHKSp72O
         KIABgInSvRinotthkVisWR3wiSXHBbhMFwePMiahoUOi3qoDmBZDvyqv/g5t4jxAor
         FHF0fCuVLoEJvHnacj4ARHvcfY9684yARApb59Ar0WjRrnzh40zk+BcDZ6TeqYU7Jn
         8d+71v/gZpjoaL0mdfJjeRTMEpx6rHZBYcIzmwd+uQC3Nr+uW+zfY3jX0a7z2C/SRB
         QPZMcEwnWb2OnlZ+wcBweSeAxmiQ3N7mDM9EkKHLh/mc6Oav/Yfzcr+IvsVWqDBb3R
         NLn4vZ9JOQP3A==
Received: by mail-ed1-f70.google.com with SMTP id eg48-20020a05640228b000b00413041cd917so3412678edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 14:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FAnUY3DfJ5M1qZcbwfAjnLrPQZIrehzFU3WzcGW4NPY=;
        b=6+mE1gKYOL3lsr+3S3f8YvwtAs7IvesAI5Vtajm/gWFudxLsBlvnlaA1GI1zjKODlJ
         ksGrIYhw9Sz0IYvIeuzQLOM6CJW5ZJ16tO8QC1dEA5vCOV/Kgc1AXDALF+sAO3k9isTb
         0IzpCMLzup03a+VhAJbd3b0qfSNu/fMZuKgwy0IjOlcrAWWq7KhHrf5NkeoSmBuM6Leh
         Ho2R9TFkyDkBPM1sq3bGWj0UWf9OQGg/Qm2NlTZXlI/rMQh5iiiKQmJU+mQr0q6CG8RA
         R2B11HcjqsohJBTxySQwpVxegpv0JikP1cQd4zHpBhy4RJTINDLq9vLOLrlM83wu0maY
         pyww==
X-Gm-Message-State: AOAM533Wbk5mWAMKAXsQpQ+pcfzxHgTnVOPKxUhQxAGEMraAcnugkJ7W
        3CYBoG9R3ty1bi+FrqOEJiuvc9yIMU0un044aazIoAHIE0ptuiIYuXSC5Lxo3D2zndLg2hFIXoo
        dV5CXfpMGBkTkMjC4oso5j8w6wzLevuoZuGP6bJJjqQ==
X-Received: by 2002:aa7:d415:0:b0:410:a0fa:dc40 with SMTP id z21-20020aa7d415000000b00410a0fadc40mr12768959edq.46.1645912885063;
        Sat, 26 Feb 2022 14:01:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJywqQ9pXRrzKzKSQQBjqQxtTf/L4gU2wppPf0iq4G4eucek0Gvb/L4v1UJzCEwf47xTWZi0Ig==
X-Received: by 2002:aa7:d415:0:b0:410:a0fa:dc40 with SMTP id z21-20020aa7d415000000b00410a0fadc40mr12768937edq.46.1645912884877;
        Sat, 26 Feb 2022 14:01:24 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id s2-20020a056402014200b0041285556b7csm3497424edu.72.2022.02.26.14.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 14:01:23 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 3/3] ARM: samsung: mach/soc for v5.18
Date:   Sat, 26 Feb 2022 23:01:16 +0100
Message-Id: <20220226220116.13452-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220226220116.13452-1-krzysztof.kozlowski@canonical.com>
References: <20220226220116.13452-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There was no mach/soc pull before, so on top of master.

Best regards,
Krzysztof


The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-5.18

for you to fetch changes up to e465ea5cc05d1d0b45c315fca0254bd2ee04b661:

  dt-bindings: soc: samsung: usi: refer to dtschema for children (2022-02-12 17:34:48 +0100)

----------------------------------------------------------------
Samsung mach/soc changes for v5.18

1. Fix hang of secondary CPU bring-up on some of Exynos5420-based
   devices (Secure Monitor Call SMC_CMD_CPU1BOOT should be skipped for
   all Exynos5 devices).
2. Extend Universal Serial Interface DT schema to precisely describe
   children nodes.

----------------------------------------------------------------
Henrik Grimler (1):
      ARM: exynos: only do SMC_CMD_CPU1BOOT call on Exynos4

Krzysztof Kozlowski (1):
      dt-bindings: soc: samsung: usi: refer to dtschema for children

 .../devicetree/bindings/soc/samsung/exynos-usi.yaml  | 20 ++++++++++----------
 arch/arm/mach-exynos/firmware.c                      |  4 +++-
 2 files changed, 13 insertions(+), 11 deletions(-)
