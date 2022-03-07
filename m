Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848B84D0553
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239106AbiCGRhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiCGRhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:37:15 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453238F993
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:36:21 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DA7003F1AF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 17:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646674579;
        bh=3HG+K+k5QA/B8ff7N43iW1x5z1qS4k2KKhb2cegl518=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=vHTP3IIeNp0CCnFLLGeTicQpH3qwvQ59tlc47kKynVmO/+qI1/QuZQnDKr0xc3ikK
         wp2mCTD/r5EclH/77ZhrB7gQNroYCQG4GUNcv/N58aeoj9gL/3l20McXeEq/UJBCCl
         SKYcsGl80L/7vAmNs2KJ7JNc9PVZWPmxP3YIWgGfq5hg1HRmaSfSPQFWEaizlHucpQ
         tuXalP+EZuiVeotyWf1IoBvRzAOR4NLX9bMiKC/PxE3/+0IgbAFO+ouagnUOFgbSzC
         bd8xnir0EeSBfM3A4O7r6MVLu+6D8UzPLJi9I+Jr5p3r14xC2TrgUmR7QbEcrmbZw4
         q1P4t4bfGrqdw==
Received: by mail-ej1-f69.google.com with SMTP id i14-20020a17090639ce00b006dabe6a112fso3571866eje.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 09:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3HG+K+k5QA/B8ff7N43iW1x5z1qS4k2KKhb2cegl518=;
        b=sRQDithPgNpuMOXCyrkZ1xbqhiUKXrQK+i5kb1Et69Zm5SW+7cLedFw0z18EbMnwuz
         IIRxpbQRQuwV07i0igiFkfBHS+jgz6HXkIWsaXPT6sG2WJj4iyUoCk44GFAjK6bKLPky
         POHEBr+3l3UKIboNi4mh2jRpMexWJBy16Lai+cY0m0lmrnpM9gtpyBuaJzGJLu9mQgvx
         Opljv/6oGpRj88ZRfpByTapgR4mpJ13fMh3U1aguzukVPrkGK+zkgh2YjycJhQ0w+avA
         GYvAhCuSOsBQiS9OJRRPdImDro/aELXSEbm03caqJB7MY2mvHoK0L/Ge+wOXLkezrapK
         MhbA==
X-Gm-Message-State: AOAM5331lRF1G8R3f3lG+MYcxRriiTu9Q8db3bh8uux2SAShhdKJvwWv
        qNsHChXl/tKLSsdmriIwfJeoHkEI0jEH3lJdjr32EgEFlkaO+U0czBA0JoT3puFt9ZjDJMBQVOC
        rpnhgPng5ZxIJHPxf2+mUpTx1Yvhi+hEV6hY3X1QYkw==
X-Received: by 2002:a17:906:585b:b0:6b7:73bc:5395 with SMTP id h27-20020a170906585b00b006b773bc5395mr10109317ejs.519.1646674579334;
        Mon, 07 Mar 2022 09:36:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKjiixge1fWdZzZQpMZjyr+5Ie33xOV4IY4yStu5Ftd/B2YpKtjTs3nermPtLrgHBcoNxM1w==
X-Received: by 2002:a17:906:585b:b0:6b7:73bc:5395 with SMTP id h27-20020a170906585b00b006b773bc5395mr10109307ejs.519.1646674579149;
        Mon, 07 Mar 2022 09:36:19 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090685c600b006daecf0b350sm3284875ejy.75.2022.03.07.09.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 09:36:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanho Min <chanho.min@lge.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] arm64: dts: various cleanup for v5.18
Date:   Mon,  7 Mar 2022 18:36:14 +0100
Message-Id: <20220307173614.157884-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd and Olof,

These patches were for very long time on the mailing list, but they were not
picked up. LG maintainer acked the LG part, ARM Juno remains unanswered.

These are considered cleanups, not fixes, although they fix real
dt_bindings_check warnings.

Could you pick them up for v5.18?

Best regards,
Krzysztof


The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/dt64-cleanup-5.18

for you to fetch changes up to ad3c72b0c6b912a0e917ae8010c62cc98012ab1e:

  arm64: dts: lg: align pl330 node name with dtschema (2022-03-02 20:25:14 +0100)

----------------------------------------------------------------
Minor cleanup of ARM64 DTS for v5.18

The DT schema expects DMA controller nodes to follow certain node naming
and having dma-cells property.  Adjust the DTS files to pass DT schema
checks.

----------------------------------------------------------------
Krzysztof Kozlowski (3):
      arm64: dts: juno: align pl330 node name with dtschema
      arm64: dts: lg: add dma-cells to pl330 node
      arm64: dts: lg: align pl330 node name with dtschema

 arch/arm64/boot/dts/arm/juno-base.dtsi | 2 +-
 arch/arm64/boot/dts/lg/lg1312.dtsi     | 3 ++-
 arch/arm64/boot/dts/lg/lg1313.dtsi     | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)
