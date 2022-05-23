Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEC5530CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiEWJIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbiEWJIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:08:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAE245049;
        Mon, 23 May 2022 02:08:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 873D4B80FAC;
        Mon, 23 May 2022 09:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FE9C385A9;
        Mon, 23 May 2022 09:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653296929;
        bh=OJA2a/BahveGs2QkXmqOi3SskFo5ktHSCxteR1+YNTo=;
        h=From:To:Cc:Subject:Date:From;
        b=e/MszXwhVSAoFjxeusSXYi9yg8zVTMtd6puHR94MMWZWd3a5BWdYbWTcTuybR49uV
         JwjnZjA+cnnRHg7dlg3qhZ9XJdtWHuZ0M8Qwq+6353KA4KzSeLMO87htIUXS6ztsSC
         4lrcRdBQyjdhv0nsZ5AreCSqFD4Kx7ZjE5Kw7y4QAQUXsNvecC9CnZ5q4tQo9tTKBm
         HN1Hr17/pAy44fN301oBllHpOOZ/R3vYPVIQgOKW6pop+TWK1KhSLNlt/dlHwI4XLQ
         7jQjE+fvTibca3nL6W4+icznWEJ0+wPjJNQETr5Zg29DSocp7GNbu6agkUOFRHlkIc
         B1NR7gG8gGMog==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        mka@chromium.org, devicetree@vger.kernel.org, tzungbi@kernel.org
Subject: [PATCH v4 0/5] platform/chrome: cros_kbd_led_backlight: add EC PWM backend
Date:   Mon, 23 May 2022 17:08:17 +0800
Message-Id: <20220523090822.3035189-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds EC PWM as an backend option for ChromeOS keyboard LED
backlight.

The 1st patch reorder the headers alphabetically.

The 2nd patch separates the ACPI backend.

The 3rd patch is the DT binding document for the proposed compatible string.

The 4th patch supports OF match.

The 5th patch adds EC PWM as another backend.

Changes from v3:
(https://patchwork.kernel.org/project/chrome-platform/cover/20220321085547.1162312-1-tzungbi@kernel.org/)
- Fix review comments on 5th patch.

Changes from v2:
(https://patchwork.kernel.org/project/chrome-platform/cover/20220314090835.3822093-1-tzungbi@kernel.org/)
- Fix per review comments.

Changes from v1:
(https://patchwork.kernel.org/project/chrome-platform/cover/20220214053646.3088298-1-tzungbi@google.com/)
- Update email address accordingly.

Tzung-Bi Shih (5):
  platform/chrome: cros_kbd_led_backlight: sort headers alphabetically
  platform/chrome: cros_kbd_led_backlight: separate ACPI backend
  dt-bindings: add google,cros-kbd-led-backlight
  platform/chrome: cros_kbd_led_backlight: support OF match
  platform/chrome: cros_kbd_led_backlight: support EC PWM backend

 .../chrome/google,cros-kbd-led-backlight.yaml |  35 ++++
 .../bindings/mfd/google,cros-ec.yaml          |   3 +
 drivers/platform/chrome/Kconfig               |   2 +-
 .../platform/chrome/cros_kbd_led_backlight.c  | 196 ++++++++++++++++--
 4 files changed, 213 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-kbd-led-backlight.yaml

-- 
2.36.1.124.g0e6072fb45-goog

