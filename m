Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E1A530A66
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiEWHk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiEWHkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:40:19 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B933F1D30C
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:40:17 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2859B3F1A1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653288177;
        bh=ElcnKNUngg8XsyxDb1irNReBJTeKSXIKHCZV8bfpqcM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=IdN9ij9KhQXTvjru0ZoAxBjP95dggo2tqLm3ORh0ytDKKCzdiZoFFCwvy0DCjKPhL
         MgYPIu7nVc0n3F/TPTZZd2UozF3MZKXH+q1Pp1e1zAK0teWZCs986NpxhfhRt01WMR
         52EXXmcKJJ/jJ3enknqkCHUIRtNvDeGeX/kujL+YcZTmB9CSxUyzgC0STzvhIugf+n
         /aQFQG/HyL4ZLnTdfrL08VCzs/o/hHvqVh2nQcGf7m9q92Vkb7NOadDxKpOcX5NOzK
         QQDExWINMDCmSy6jblAByF3lePru7NfFRbO4KfZrjRepyI2gloS5Ht14sSMCVshP4o
         0b+Du3nhOl3TQ==
Received: by mail-ej1-f72.google.com with SMTP id gf24-20020a170906e21800b006fe8e7f8783so5100489ejb.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 23:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ElcnKNUngg8XsyxDb1irNReBJTeKSXIKHCZV8bfpqcM=;
        b=WJHMzwPmPBIqmQ4uHnPLX0aagT0w82A/bGQzmtKpdLyCjeV94xAkeJkI2WiRrivkae
         I2tkL7cnKAKLVLJ4XLNko5RJWpjRNvPMeCCcjEL8lQNe3WTHL31bAZJzSVd18FSdozh+
         2iPpjZeOjbaZbsyUbtcofedReKv2LPXDftjwCH7GRqEQTditElkBmfnU2B2EfD+vzVKM
         QhyNq74ROze3+OjfcmnRef0Ly+6nUcSRAJm1qttRj9IrQp/97eoSfGnJN0Wea23WS14H
         dHhoU97NGQgPOu62Pe47Dw8wUKgLm2KC1xXzGauM0ddknisN7A2IpY4ZmalWlsCcx8QK
         xhNA==
X-Gm-Message-State: AOAM532CGdouZx8uuWvuPOnSa2EQzCYIA96n0Qg/KbD2XT00WrNIs9/j
        3nwl6swHN9LPsjKGEGuSyhq6V8foBPakC+q8UsmAYwExUZREHNv7rKr6OAxHMfhLt+m0GN0KV8E
        J31EPC4yzd8zwYS7b7G4JnyIiM3Uu9eKLGHSIff8BOQ==
X-Received: by 2002:a17:907:3f1f:b0:6fe:b40a:21f0 with SMTP id hq31-20020a1709073f1f00b006feb40a21f0mr11298521ejc.744.1653288176922;
        Sun, 22 May 2022 23:42:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybibqjJfbfowQwaW7O5HhenR3cdlBBXdit+jG7WP/mL+1F6AIWKRTXROJ5W9mpz1+M1cLFTg==
X-Received: by 2002:a17:907:3f1f:b0:6fe:b40a:21f0 with SMTP id hq31-20020a1709073f1f00b006feb40a21f0mr11298514ejc.744.1653288176736;
        Sun, 22 May 2022 23:42:56 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id p3-20020a056402074300b0042617ba63a5sm7792416edy.47.2022.05.22.23.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 23:42:56 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 0/3] ARM: s3c: Kconfig: Style cleanups
Date:   Mon, 23 May 2022 08:42:49 +0200
Message-Id: <20220523064252.11938-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The majority of the Kconfig files use a single tab for basic indentation
and a single tab followed by two whitespaces for help text indentation.
Fix the lines that don't follow this convention.

While at it, add missing trailing comments to endif statements and replace
tabs before comments with whitespaces (which seems to be more common).

Juerg Haefliger (3):
  ARM: s3c: Kconfig: Fix indentation
  ARM: s3c: Kconfig.s3c24xx: Fix indentation and replace some tabs
  ARM: s3c: Kconfig.s3c64xx: Fix indentation

 arch/arm/mach-s3c/Kconfig         | 14 +++++++-------
 arch/arm/mach-s3c/Kconfig.s3c24xx | 26 ++++++++++++--------------
 arch/arm/mach-s3c/Kconfig.s3c64xx | 16 ++++++++--------
 3 files changed, 27 insertions(+), 29 deletions(-)

-- 
2.32.0

