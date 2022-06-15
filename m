Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F3754C576
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343974AbiFOKHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244130AbiFOKHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:07:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BE81573A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:07:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x5so15391825edi.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LNaRZAAN8AQp34o+sHE3iUIn/YiSWmS1n1lw97oIgFA=;
        b=A0X/bur5kYMMgmug+4K7M5IpnQh7ai6WzFGP4oGeu/nE9QPqxcIJXTNIdeiIDJKVZc
         fKgNik1or3ZzwzV3qCjmGpOYeDb5iGtin+1pszNMqlx8Mg46++M/lkahFPwiYM7udSVO
         aUedJxbOsVLjsBGIb4pHF7pWJZBEVYk/9IlPKlMxVvVpuET/2Fy/bCELSMaYTwq4bVdp
         02BgG1NaeRhoRYeGx1KMsb0LUQ6DM28BQWayLpg6g9PK0bgW+lhrNz/OY988BTcs5SKS
         KaW+9sMjKfLZPDRp1lmCbktDhgWdlduqaSoYdOLBUaRGI5xxjNERMIqT5tComS5WKP28
         LyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LNaRZAAN8AQp34o+sHE3iUIn/YiSWmS1n1lw97oIgFA=;
        b=eKRdyqkjmOWecLszTmSyganz2KIeIjUQKGqASq+DxmVd5GWsLlmGQPWw1hxbw+auvo
         vluJU56YHxr8xM2XCiHVOweV/7cSXtHSzkYeIH63Yt68iecSvK8kuC+MRgAuRgIDU2cj
         CfIBWCdnlXiNUGpfbyPE0RsU2AP/kbWFq18J5lejUrjHc90gqLwaJKnoAQe7qlJuKu+A
         MbdhCRtnzokzKHQ5+6wk+UAqrREPemGdPbp1gbpNspvAx/S64DstC4/lXKrNROZjLQXn
         r535QtRzsOPBN2J6gcIH1NX52+OM3FtP2yi0E57t6JAxdSFllRhP+S6rX6SatkE4LBoo
         GA1A==
X-Gm-Message-State: AOAM5318szOTUebxwiXmsTBcCQmVkIZ6ZkpOL4NO5UBLtWBROThEpwGk
        0Jz3606HgMUYBG0rDruxHuWaW4W3uA2MIZsH
X-Google-Smtp-Source: ABdhPJxcuuXNOG//lHLsVT8puGu/dXgDiLnOzHFWkvfJ4bfo01U7ywzMRT8kI9C780uGj0k+zExLTg==
X-Received: by 2002:a05:6402:51d4:b0:42f:b38d:dbb9 with SMTP id r20-20020a05640251d400b0042fb38ddbb9mr11701287edd.255.1655287666543;
        Wed, 15 Jun 2022 03:07:46 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id fd8-20020a1709072a0800b00718e4e64b7bsm1049801ejc.79.2022.06.15.03.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:07:46 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v3 0/3] regulator: userspace consumer DT support
Date:   Wed, 15 Jun 2022 12:07:40 +0200
Message-Id: <20220615100743.1706968-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
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

Add devicetree support of the userspace consumer driver.
The supply names for this driver is provided through DT regulator-names
& regulator handle can be acquired.
Driver events can be received from sysfs.

Optionally use sysfs notify to catch driver events into userspace application.
This enables userspace application to monitor events & handle them
appropriately.

Laxman Dewangan (1):
  regulator: userspace-consumer: Add devicetree support

Naresh Solanki (1):
  dt-bindings: regulator: add bindings for userspace-consumer

Patrick Rudolph (1):
  regulator: userspace consumer: Add Notification support

 .../regulator/userspace-consumer.yaml         |  66 ++++++++++++
 drivers/regulator/userspace-consumer.c        | 100 +++++++++++++++++-
 include/linux/regulator/userspace-consumer.h  |   1 +
 3 files changed, 165 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/userspace-consumer.yaml


base-commit: 018ab4fabddd94f1c96f3b59e180691b9e88d5d8
-- 
2.35.3

