Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92545B24F5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiIHRle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiIHRlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:41:02 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47282A96B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:39:44 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id c24so17409036pgg.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 10:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yocom-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=GeBUNt6iKyKVMJSNccGv5u8JOw8oNIwF9ROYFrWs1lE=;
        b=lWs9gg2J19N5dbtQLQWBSb3sLJ3t1w4TFIYRGfoDqPXPEVoivSpbx5UQ9qgmujKzgu
         NnWTpLY80/UFs8SAUEBLLxMIiVczzQ+iU6QRk1ksLMsb99zF+ifqBbY+qryKRzXlnENO
         VAfmYtFIRRQDTW8Yrs6UENPQ6w9fQWlQ6dAOx2zgIxhLANluskFsVs67k3cP+3+BTvBA
         LgeAU1eZ3Q+ocKS62yYFpAhCLA70LyEZdRAZQx6nuvpPWPJpRxbgAjRJDqyiGtUylOPm
         ZCru2H9eydaN38FdeH0wBkFAFLvxXxxMQxKWsCorDdDhc6VBaCqNrjUB7k+u4e1sacM1
         LrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GeBUNt6iKyKVMJSNccGv5u8JOw8oNIwF9ROYFrWs1lE=;
        b=U+9kgQ9eIzs/z2BZmar8OSfetzG7dKdfh/ztogv1qSJR/WSTKYZOLywv2Md/fn3our
         zOSxleqxMZc4zcmvqdOpvTYmR2gbao5IeOv8t7ckKEcEj3ORzxGJgHLAGr435K04daMH
         d72wFGukvD/Wn2C98kM8t/58Ult2vpP6GttgTd9B2U8VSyoinc3LoONGXSEE2ar68iQW
         4WaZwVBOA8XKLx5d585LqVKytTd2qDBO7h+X7exG2RYarwoxOu37CcoZvDJZOuhl9Gtc
         f5wvPKJC6BIFhco4ymkwq0vN9AoannYYsTuJmxEfESopHmQkaxQqfs3hGCjXkIZPs4t8
         Q1tQ==
X-Gm-Message-State: ACgBeo1CDCaoku/csgenZkGvkKJaqfFjFin46IaSizMFCuVm9U8HoHAm
        ZWYcHD5eIii2ls/gb/MECzlES/jKBCcdQ+/+
X-Google-Smtp-Source: AA6agR6tiJC1rmPcCLUUwaBgsmPk3YCf2zQZ9QkGf5dpF1S5Zn7EcATRPlxTiKvKKhQoxj55DgpmYQ==
X-Received: by 2002:a63:f74c:0:b0:42b:77c2:ce7c with SMTP id f12-20020a63f74c000000b0042b77c2ce7cmr8962778pgk.473.1662658779211;
        Thu, 08 Sep 2022 10:39:39 -0700 (PDT)
Received: from ghaven-kernel.yocom.org.beta.tailscale.net ([2601:600:8f80:973::5f])
        by smtp.gmail.com with ESMTPSA id x76-20020a62864f000000b0052d4b0d0c74sm15166767pfd.70.2022.09.08.10.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 10:39:38 -0700 (PDT)
From:   Nate Yocom <nate@yocom.org>
To:     dmitry.torokhov@gmail.com
Cc:     nate@yocom.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, hadess@hadess.net,
        benjamin.tissoires@redhat.com
Subject: [PATCH v6 4/5] Input: joystick: xpad: Add ABS_PROFILE to Docs
Date:   Thu,  8 Sep 2022 10:39:29 -0700
Message-Id: <20220908173930.28940-5-nate@yocom.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220908173930.28940-1-nate@yocom.org>
References: <20220908173930.28940-1-nate@yocom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ABS_PROFILE description to Documentation/input/

Signed-off-by: Nate Yocom <nate@yocom.org>
---
 Documentation/input/event-codes.rst | 6 ++++++
 Documentation/input/gamepad.rst     | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
index 8741d390b184..b4557462edd7 100644
--- a/Documentation/input/event-codes.rst
+++ b/Documentation/input/event-codes.rst
@@ -235,6 +235,12 @@ A few EV_ABS codes have special meanings:
     BTN_TOOL_<name> signals the type of tool that is currently detected by the
     hardware and is otherwise independent of ABS_DISTANCE and/or BTN_TOUCH.
 
+* ABS_PROFILE:
+
+  - Used to describe the state of a multi-value profile switch.  An event is
+    emitted only when the selected profile changes, indicating the newly
+    selected profile value.
+
 * ABS_MT_<name>:
 
   - Used to describe multitouch input events. Please see
diff --git a/Documentation/input/gamepad.rst b/Documentation/input/gamepad.rst
index 4d5e7fb80a84..71019de46036 100644
--- a/Documentation/input/gamepad.rst
+++ b/Documentation/input/gamepad.rst
@@ -189,3 +189,9 @@ Gamepads report the following events:
 - Rumble:
 
   Rumble is advertised as FF_RUMBLE.
+
+- Profile:
+
+  Some pads provide a multi-value profile selection switch.  An example is the
+  XBox Adaptive and the XBox Elite 2 controllers.  When the active profile is
+  switched, its newly selected value is emitted as an ABS_PROFILE event.
-- 
2.30.2

