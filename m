Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A9B483BE0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 07:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiADGWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 01:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiADGWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 01:22:18 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8C3C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 22:22:17 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so2117043pjp.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 22:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g0linz1nM494X8vzijMBtUZr5BhEAPp4y2s0Z9dySmY=;
        b=XBfamwb1MWPnu4S9c93hWxsB/f4mXVwHKKOTg6zVl0EmR24D98MAG4AdwN5eG2N+NX
         BJJ/7zv1H66jHPSiTQO20XYg5q31NdFbEeUPvOHk3monoE5r9w/7qd5WE4MdwRZe7pg8
         kHd+VX6K15CbO4oyTBxdsJ0wm8d7/iDjzcppA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g0linz1nM494X8vzijMBtUZr5BhEAPp4y2s0Z9dySmY=;
        b=n4Thh9UoL01T4vh+PnfUd5X2BPjWKpMKcGOUMBFqxq3zuAhJ8sfYhh/tg+HLZCfIXC
         qdvyAo7UEt4hZHRahO4DHGDAbG8/+Q5e9lPoRAmhPVnKPwX1w34DXCBNmpLoHqc/VcSp
         Owja8hqsg71JeeA42P85JDrlY9ylZXrla/J5IABPy6EyCl3Xkgu6OH3fgyIm6jat5A8S
         Ey6LjAbWvcKgZwM6khDhg2It1Xn0/T7gwcoBDpDDim48JiuH4PNb8mvONa5dhYsN0cf6
         l+Z50Am1iM06+665+QFymw5TuX5xS9M9u+DFjKV8JOv0iouwUgF956Ba7ECEhAANKLwh
         nnIw==
X-Gm-Message-State: AOAM532pvTmhkbkoNPrVArCRe7/1O7aFCTQ2CZAgvd1iRTPWGpTVF+74
        WsGkhVdY+U0vkNXscJFrysWCHQ==
X-Google-Smtp-Source: ABdhPJwwQfnH6p8Slf/P8cAeLej2Z56744YsmkGNqdwNgB6Ek/joSBwrAwH5++nT+r29ptw9k6vkKA==
X-Received: by 2002:a17:90a:f0cc:: with SMTP id fa12mr34784525pjb.134.1641277337377;
        Mon, 03 Jan 2022 22:22:17 -0800 (PST)
Received: from localhost ([2620:15c:202:201:6f47:183c:871a:2a1a])
        by smtp.gmail.com with UTF8SMTPSA id h4sm13350264pjk.2.2022.01.03.22.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 22:22:16 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 0/3] platform/chrome: Use new PM_OPS macros
Date:   Mon,  3 Jan 2022 22:22:10 -0800
Message-Id: <20220104062213.2365356-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 296282fca791 ("PM: core: Add new *_PM_OPS macros, deprecate old ones")
Add new macros to remove __maybe_unused and/or #ifdef CONFIG_PM_SLEEP.

Apply them to plaform/chrome, using .cocci script to ease the
refactoring.
Only one #ifdef remains, in cros_ec.c to expose core suspend/resume
routine.

Gwendal Grignou (3):
  plaform/chrome: remove SET_SYSTEM_SLEEP_PM_OPS
  plaform/chrome: Remove SIMPLE_DEV_PM_OPS
  plaform/chrome: Remove SET_LATE_SYSTEM_SLEEP_PM_OPS

 drivers/platform/chrome/chromeos_tbmc.c     |  6 +++---
 drivers/platform/chrome/cros_ec_debugfs.c   |  8 ++++----
 drivers/platform/chrome/cros_ec_i2c.c       |  6 ++----
 drivers/platform/chrome/cros_ec_ishtp.c     |  8 ++++----
 drivers/platform/chrome/cros_ec_lightbar.c  |  8 ++++----
 drivers/platform/chrome/cros_ec_lpc.c       |  6 ++----
 drivers/platform/chrome/cros_ec_rpmsg.c     |  6 ++----
 drivers/platform/chrome/cros_ec_sensorhub.c |  6 ++----
 drivers/platform/chrome/cros_ec_spi.c       |  6 ++----
 drivers/platform/chrome/cros_ec_typec.c     | 10 ++++------
 drivers/platform/chrome/cros_usbpd_logger.c |  8 ++++----
 11 files changed, 33 insertions(+), 45 deletions(-)

-- 
2.34.1.448.ga2b2bfdf31-goog

