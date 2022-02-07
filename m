Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DFB4AB322
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 02:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243666AbiBGBhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 20:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbiBGBhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 20:37:07 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8025C061348
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 17:37:03 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 192so10357445pfz.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 17:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R3tGsdctfkk5JbjRAHcsgcb8GPd56zPAXRY5uneUM9g=;
        b=Mit9yWZKEVxLr+hWZZtN7QKYLOoINgi/6sFdRx9h3LCYi3fhTg2qy5j5MD5skyO59k
         SesyQPGzucGNTgRLF8aZi8UqDh47v6jDSjJXUkAorHcPR2qVHOZxTyfkpYl40FEv19q6
         UnQAHb7qQ65CSJ0Dohw/P+ObyufJamCIiK/Qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R3tGsdctfkk5JbjRAHcsgcb8GPd56zPAXRY5uneUM9g=;
        b=skNY57wvqtgUtBk5Qo2WXrFD6c220p49M+oopbZSjSszUAD3v6DFouPuTbNdPcJw0z
         vTk5DNtDIVyhQF7VZwwGBXZUIsTiX/PT8mDO3SU4KWtFVaipE/dItF8if1HRe1i3DPeu
         u+VtfF8OSrUon931WhoZhCBhcLA6YYFaCD3/wen5G3cDNnDDqx+SubjYm4/Ozp38f7vi
         SIVx6mOrIdElu6E3iNUvA9nvTNQrjbaGm8gh39LrHgo/tJBtW26KaC9O/ZyHcN3zbe8w
         TXqwjM5yAKgkr9ui2sEf4Eeg2Ggif+dVi08laOadUL6UIVi59wbBcHQ3OOA8xrsehrBz
         Tfjg==
X-Gm-Message-State: AOAM530irklD7IrODLdUm57Znxq1qqmLhf/WMQ1wl3m+sxRglKrc3rDo
        5ZlaICfLpnfpPA1FZ+gPMVW54+LdAXNAAA==
X-Google-Smtp-Source: ABdhPJzmvjRmcW4cQephZC+O8UR47ld2tczhuzGNx0lhfB2qvD8qIYBMyc/imSXzRpg/RgPV7RCJXA==
X-Received: by 2002:a63:6882:: with SMTP id d124mr7563320pgc.305.1644197823173;
        Sun, 06 Feb 2022 17:37:03 -0800 (PST)
Received: from localhost ([2401:fa00:9:14:7544:a15c:37e1:f797])
        by smtp.gmail.com with UTF8SMTPSA id h27sm6613158pgb.20.2022.02.06.17.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 17:37:02 -0800 (PST)
From:   =?UTF-8?q?Sami=20Ky=C3=B6stil=C3=A4?= <skyostil@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     bleung@chromium.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        evanbenn@chromium.org,
        =?UTF-8?q?Sami=20Ky=C3=B6stil=C3=A4?= <skyostil@chromium.org>
Subject: [PATCH v3 0/1] Add a driver for the ChromeOS screen privacy sensor (HPS)
Date:   Mon,  7 Feb 2022 12:36:12 +1100
Message-Id: <20220207013613.1150783-1-skyostil@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


This series adds a driver for the ChromeOS screen privacy sensor
(a.k.a. HPS) device, attached on the I2C bus. The sensor is a
hardware-isolated module which reports a high-level presence signal,
e.g., whether there is person in front of the computer or not.

The driver exposes the device to userspace as a character device, which
can be used to control the power state of the device. The driver
automatically turns power off to the sensor unless a process is using
it.

More information about HPS, its firmware and communication protocol can
be found at
https://chromium.googlesource.com/chromiumos/platform/hps-firmware.

Changes in v3:
- Moved from drivers/misc to drivers/platform/chrome.

Changes in v2:
- Removed custom ioctl interface.
- Reworked to use miscdev.

Sami Kyöstilä (1):
  platform/chrome: add a driver for HPS

 MAINTAINERS                            |   6 +
 drivers/platform/chrome/Kconfig        |  10 ++
 drivers/platform/chrome/Makefile       |   1 +
 drivers/platform/chrome/cros_hps_i2c.c | 184 +++++++++++++++++++++++++
 4 files changed, 201 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_hps_i2c.c

-- 
2.35.0.263.gb82422642f-goog

