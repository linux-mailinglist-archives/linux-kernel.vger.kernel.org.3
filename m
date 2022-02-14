Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478834B416A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 06:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbiBNFhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 00:37:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiBNFhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 00:37:32 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59844EA11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:37:25 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b187-20020a251bc4000000b0061e15c5024fso31638504ybb.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+1SwCE06M0PNqBLEJTg15X5eH7+oSoSSFiekI+9wl9s=;
        b=VtTPVXxfex/1ySP2MQUCDrrLGS4bgo8o9gYa4yfPriMLozUesvzfOHPU9JNcSROXnZ
         3PTCEKlwxO3xEnbzXHfcKoos8ott/okgb3eO4UDDb5Hgq0fnhYoRMEpSqFV4Pk277fJ2
         +Nd5BHsBrYrOtYE1oe1F8NmnJOOYyYSzhBm7iowqdEfANVP0pk9K8G9JaIhlJe7ZekSu
         9kpEwoQssXCR1UvrZQT5zNlJ5DF4OJ8uwRFWNzYIWYAWuZKd0QjWbKpL/zmBkd6fQkMq
         a41bVuN0Wgd7EduqWuld4iSyG2TgCW8/AfcO5jxg3moU1H+YUcIzzZAWiUed0xbe9ykr
         0LPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+1SwCE06M0PNqBLEJTg15X5eH7+oSoSSFiekI+9wl9s=;
        b=3y4fHYkpk5BTJSX8xqLB8/t5lyXPa6k83RrtWNmQbY9wj/d6zS/YiGM/Jp05B/lC+r
         xNwTytQlo+KB/JbKe4P79/stfn3s/4AOT54ngSRy0BswXDyQldGGfWgderyl1Ca8Zan2
         vHIuOQmaxvgsRxkWEbtx54jRDyc1E50TdmWQYywoaul9qM3X4zYIY2FkH8MCGS/n/MTZ
         B6AlhyKU6y3kIvMmjJhWbI9+tE4H6RxO5+e2R7OsFm2//vzZq5lLDpzcMTR8J/UNMKdO
         sTJT+dFDCcIoglipsoYdsXMRLiU4BzCIkv+3qV/FuumPdeh7Qz+xrD+NqEdBcJDAjrUV
         TwYA==
X-Gm-Message-State: AOAM531S+xC4woVO6BsOYckqxhPHNCwJckxb6aRFJBtWPSzK0Xi8snR4
        6tVE8Eb0hDIBCmf5JBCCEdg0GBpEQCTw
X-Google-Smtp-Source: ABdhPJzLlnCyP8MR7Ka8mTntsMrSfWdMHHSSskLUEwG3JprtOu25ulTVq/KOFZQzyJJoH9evqR6maA8J1aHF
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:f315:f92d:e3d3:2539])
 (user=tzungbi job=sendgmr) by 2002:a25:900e:: with SMTP id
 s14mr10446908ybl.338.1644817044881; Sun, 13 Feb 2022 21:37:24 -0800 (PST)
Date:   Mon, 14 Feb 2022 13:36:41 +0800
Message-Id: <20220214053646.3088298-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 0/5] platform/chrome: cros_kbd_led_backlight: add EC PWM backend
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@google.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds EC PWM as an backend option for ChromeOS keyboard LED
backlight.

The 1st patch reorder the headers alphabetically.

The 2nd patch separates the ACPI backend as an independent option.

The 3rd patch is the DT binding document for the proposed compatible string.

The 4th patch supports OF match.

The 5th patch adds EC PWM as another backend option.

Tzung-Bi Shih (5):
  platform/chrome: cros_kbd_led_backlight: sort headers alphabetically
  platform/chrome: cros_kbd_led_backlight: separate ACPI backend
  dt-bindings: add google,cros-kbd-led-backlight
  platform/chrome: cros_kbd_led_backlight: support OF match
  platform/chrome: cros_kbd_led_backlight: support EC PWM backend

 .../chrome/google,cros-kbd-led-backlight.yaml |  35 +++
 .../bindings/mfd/google,cros-ec.yaml          |   3 +
 drivers/platform/chrome/Kconfig               |  14 +-
 .../platform/chrome/cros_kbd_led_backlight.c  | 218 ++++++++++++++++--
 4 files changed, 247 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-kbd-led-backlight.yaml

-- 
2.35.1.265.g69c8d7142f-goog

