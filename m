Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CAA4C20AF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 01:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiBXAfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 19:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiBXAfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 19:35:13 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778B39E9CC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:34:38 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id w37so313946pga.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jPSW45xiD/lnL8l3MDRyfU8xx/s58cubiThQsI6XrX0=;
        b=F++swCaDvbA4mUrRyBn/jN5z/jb13PdEkgomsy8G3FS1BVM/llA1wdn80bdiZswOka
         42feQGELkhXuNXvI5Ek00XyUy0MpQsOEd/SHRu9MuJy5Ovtb2Y/YlKZkJVHUtsCwsoU5
         7HZtYzoxLzJbSO9CtcsQOB0S46A1U54LVHSPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jPSW45xiD/lnL8l3MDRyfU8xx/s58cubiThQsI6XrX0=;
        b=0S2qEJzhlSM4SNaOYZxQqhG2dyXfNpo3u1DZ5uDTXqTCMewV1ZVIYJpOm8smbVKiBy
         rhsPiP5cOEOLpq2z2+GC2XWschpaJIaMPTE6Qw/OSzGZFKHQLYFpYHE2uxTCuSt4QL5a
         eC2ufRT34wmBUyU8Ri8zU7rnzPCxfX3r8x2ahgGgp0tUUlCrcAWHu/5ci8SGeNbIHPyM
         WHlS+xjD9EWnKWzF6O7jP7f0vCo7blo+eph5NEXlAQ6YIJpGO4e+U6svgeaU1BnaX+lm
         yaB6N/t9SFVaX5JTFYtJwCoVOpAQDE1FwHS6nZR/PCCDuBiAFb1qMGBJ5A+JJaobRWSh
         /qxg==
X-Gm-Message-State: AOAM531dySO02EbPJPH47ROWKlVL9LaDlhjoiYEhZYMN8VbWmBs4KY/5
        xc1B8Yk5aY0VsqCQ4kd6+nqYMA==
X-Google-Smtp-Source: ABdhPJxsX8Zp7RwiVfm9EjxPXZ6nxL/VAzG6WanMwp9dHPRSqVUcYDx1iZ6Rm4NP5NAIZj97PK/Llw==
X-Received: by 2002:a63:f241:0:b0:365:948d:19bb with SMTP id d1-20020a63f241000000b00365948d19bbmr275254pgk.253.1645662878045;
        Wed, 23 Feb 2022 16:34:38 -0800 (PST)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:e321:1e1b:f71e:33c])
        by smtp.gmail.com with ESMTPSA id ms7-20020a17090b234700b001bc7e6fc01csm4100344pjb.40.2022.02.23.16.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 16:34:37 -0800 (PST)
From:   Julius Werner <jwerner@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH 0/3] Update lpddr2 revision-id binding to match lpddr3
Date:   Wed, 23 Feb 2022 16:34:18 -0800
Message-Id: <20220224003421.3440124-1-jwerner@chromium.org>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series updates the device tree binding for "jedec,lpddr2" to
encode the revision ID (mode registers 6 and 7) in the same way as they
were already done for the "jedec,lpddr3" binding, and deprecates the old
way.

Julius Werner (3):
  dt-bindings: memory: lpddr2: Adjust revision ID property to match
    lpddr3
  memory: Update of_memory lpddr2 revision-id binding
  ARM: dts: Update jedec,lpddr2 revision-id binding

 .../memory-controllers/ddr/jedec,lpddr2.yaml  | 17 ++++++++++++--
 arch/arm/boot/dts/tegra20-asus-tf101.dts      |  2 +-
 drivers/memory/of_memory.c                    | 23 ++++++++++++-------
 3 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.31.0

