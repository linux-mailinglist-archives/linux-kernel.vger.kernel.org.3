Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143C44A6B0E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 05:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244591AbiBBEuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 23:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiBBEt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 23:49:59 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DDCC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 20:49:59 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id i17so17752629pfq.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 20:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ixNNQGKazC1XhNHVmKH30fyOLMnUwp6F81j9y0xqQu8=;
        b=dO5ingx4LG7kTArVsgKCUStV9X99Cdu3z53CSY/9cSwEqWpaBel7FqOLhonz+4JhjG
         0NbtoRYY95wGSnL3/rkHdko+0vS6/6z5gEfSS+Ly9lhyyzLApyWQvXhxQ4yzFG2sDYQ4
         HSrUSCumfvlZbcRVYdn7s7Bx2jozhj4gGEjMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ixNNQGKazC1XhNHVmKH30fyOLMnUwp6F81j9y0xqQu8=;
        b=JaMycx9aAKJ/9xpcgV22WK1hztx4tFeAuoCUYbkQlePNMYmjmLtF68pzllTcUkJ2WX
         Qr4pUzi3kTwwzibleWCX7g2JIhw5qfiYGM+GpDgfwRQvGx0QefwieAt94wCR3uUUqU2X
         ATKjvYOSWc3veLMQfx3BhHpzlV0ueDtB0p9WYY/9wJAUjPEKGjVOsFMDVIWUvaZF/HqX
         WU4qDETIBN1LumO8X+Tn3e/HFp2ufjYHyDq76/6LiAYYNh42NkXyu+1oggiqkHvx2Iqo
         rx4HzZrU4G6das+I17lQ6LKrkFO+VMDNZ4asGcu7iKCnwdlnUIYsX5iV9ov0GEU5reT5
         IIyA==
X-Gm-Message-State: AOAM533wWUfbAtdITMUv7hklCIP0v/EMKl/fNC+434crWTN7V0E3+MKm
        q1N/NEPu0E2Zohqnr4R7OnGM6rBqa//wmg==
X-Google-Smtp-Source: ABdhPJw+apY1kRwFqwuj3jt9QiToc1HZRkVWyXwgK7jFI/0DAm6qxwaiiLsQPMkcrqCMWrnBTYmQvg==
X-Received: by 2002:a63:1ca:: with SMTP id 193mr20916523pgb.20.1643777398918;
        Tue, 01 Feb 2022 20:49:58 -0800 (PST)
Received: from localhost ([2401:fa00:9:14:97af:7793:b97d:448e])
        by smtp.gmail.com with UTF8SMTPSA id lb7sm4736670pjb.56.2022.02.01.20.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 20:49:58 -0800 (PST)
From:   =?UTF-8?q?Sami=20Ky=C3=B6stil=C3=A4?= <skyostil@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dtor@chromium.org, gregkh@linuxfoundation.org, arnd@arndb.de,
        evanbenn@chromium.org,
        =?UTF-8?q?Sami=20Ky=C3=B6stil=C3=A4?= <skyostil@chromium.org>
Subject: [PATCH v2 0/1] Add a driver for the ChromeOS screen privacy sensor (HPS)
Date:   Wed,  2 Feb 2022 15:49:36 +1100
Message-Id: <20220202044937.3187603-1-skyostil@chromium.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Changes in v2:
- Removed custom ioctl interface.
- Reworked to use miscdev.

Sami Kyöstilä (1):
  drivers/misc: add a driver for HPS

 MAINTAINERS            |   6 ++
 drivers/misc/Kconfig   |  10 +++
 drivers/misc/Makefile  |   1 +
 drivers/misc/hps-i2c.c | 184 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 201 insertions(+)
 create mode 100644 drivers/misc/hps-i2c.c

-- 
2.35.0.rc2.247.g8bbb082509-goog

