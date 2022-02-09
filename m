Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFFD4B00C0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbiBIWz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:55:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236572AbiBIWz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:55:56 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58D1E02DFE0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:55:58 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y7so250789plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 14:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BcFfUoNY4HHUcjlUWbU5C1496bb+P9NZHjZT7bpwHGA=;
        b=KbW+HY8DgRG+TmRh4TbrFbBzl6xujiJpO4TS2TIDcw6nC5fOgV8xtkphxGKW8ji5uR
         ymrecwpo87NB/R8gLI5XkSClErCV7KpbGTYTlbBkn1W4DW2nkdEeV7cBPxNi5xO8h4yF
         AE8kylRc0xWzElF8tpi1DdbV0uDPDT8GMEPWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BcFfUoNY4HHUcjlUWbU5C1496bb+P9NZHjZT7bpwHGA=;
        b=KpzrrD9+STSyigCaGk17uqWeGrcyp89+xKu2K/9MXPFVMh+oliH+W2CwhIYc8jvAE7
         S0hZ6T6XsWI1EMSPdgTn/mwoIqKU6wi8yqVirobrggZoi3y1Qjg0cWz8PeMYDLwynNyA
         mWVelmm/DFqii1as9JVbpcKf1IGaZDumdD9ZLj3O5IX0mvjhIOdTIucln+Z6CTvFC2SH
         X6jSCTFkCKnfpPv1T6xl6qamW0jaZKpycv48yYchlcxGyEibUD4celMp2w9U1IIezJz+
         5CJaD2pAkCd5FBtd7clDc7kK+J85c+zS+/SJ/hLazD87v7clZD79/Fxk6htIEL9hChxa
         b/2g==
X-Gm-Message-State: AOAM531MOUZFFEGbnBC/0pWu8+ZaLRV8nby+RYS+MEihcjMMOB/gAnJE
        WNLMw+ALwgKbC8U4aw1p0Rk7PWAnkR4pXg==
X-Google-Smtp-Source: ABdhPJxSeXwyF0F7CE9HSgCb9AbUyBVZ1UQl15I0IKlKbEw0VHVmTAmtk9Ug/V671NFSj/6DiXPr/A==
X-Received: by 2002:a17:90b:390f:: with SMTP id ob15mr6065545pjb.195.1644447358371;
        Wed, 09 Feb 2022 14:55:58 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:5193:6865:e38e:3a5b])
        by smtp.gmail.com with ESMTPSA id b1sm5982015pgb.66.2022.02.09.14.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:55:58 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     benjamin.tissoires@redhat.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        "Sean O'Brien" <seobrien@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH v2 0/5] Input/HID: Consolidate ChromeOS Vivaldi keyboard logic
Date:   Wed,  9 Feb 2022 14:55:51 -0800
Message-Id: <20220209225556.3992827-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-on to this thread[1] where we discussed the need to
support the vivaldi keyboard function row keys in the google hammer
driver. I've extracted the common code into a new vivaldi-keymap.c file
that can be used by the various keyboard drivers used on ChromeOS
devices to expose the function_row_physmap sysfs attribute. That's a
good place to keep the HID parsing logic for the vivaldi and hammer
keyboards too, so one function goes there for that as well. Finally, we
add support for the function row physmap attribute to the hammer driver.

Changes from v1 (https://lore.kernel.org/r/20220204202021.895426-1-swboyd@chromium.org):
 * Yet another new file for HID part to fix compilation problems

Cc: Jiri Kosina <jikos@kernel.org> 
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Sean O'Brien" <seobrien@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>

Stephen Boyd (4):
  Input: atkbd: Convert function_row_physmap to u16 array
  Input: Extract ChromeOS vivaldi physmap show function
  HID: Extract vivaldi hid feature mapping for use in hid-hammer
  HID: google: Add support for vivaldi to hid-hammer

Zhengqiao Xia (1):
  HID: google: modify HID device groups of eel

 drivers/hid/Kconfig                   | 11 +++
 drivers/hid/Makefile                  |  1 +
 drivers/hid/hid-google-hammer.c       | 97 +++++++++++++++++++++------
 drivers/hid/hid-vivaldi-common.c      | 97 +++++++++++++++++++++++++++
 drivers/hid/hid-vivaldi.c             | 88 ++----------------------
 drivers/input/Kconfig                 |  7 ++
 drivers/input/Makefile                |  1 +
 drivers/input/keyboard/Kconfig        |  2 +
 drivers/input/keyboard/atkbd.c        | 27 +++-----
 drivers/input/keyboard/cros_ec_keyb.c | 30 +++------
 drivers/input/vivaldi-keymap.c        | 39 +++++++++++
 include/linux/input/vivaldi-keymap.h  | 37 ++++++++++
 12 files changed, 295 insertions(+), 142 deletions(-)
 create mode 100644 drivers/hid/hid-vivaldi-common.c
 create mode 100644 drivers/input/vivaldi-keymap.c
 create mode 100644 include/linux/input/vivaldi-keymap.h

[1] https://lore.kernel.org/r/nycvar.YFH.7.76.2201140935460.28059@cbobk.fhfr.pm

base-commit: dfd42facf1e4ada021b939b4e19c935dcdd55566
-- 
https://chromeos.dev

