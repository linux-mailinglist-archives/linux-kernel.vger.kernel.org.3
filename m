Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD08049DCA2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbiA0IgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237855AbiA0IgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:36:16 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C4AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:36:11 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id r59so2218668pjg.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gpkZriOud+v4a8DauzKMOyJvpjep63Cy9yFCnpVXURc=;
        b=lKbyqYIE0ec4waUHEdSyOg+yhdh6s8BUT6nj9oQ+nJBV71lZm+q3TNSCNrGet0ICG4
         bV0BljUmLrV/F4Bqe03WqpoJnstWtTcSevW9fgU8Gz1KYGD1iLzQtOUAr/j2+R35aULH
         WbHpMa3f02h4e1aiGnsU665wJn6YgY9e1KfpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gpkZriOud+v4a8DauzKMOyJvpjep63Cy9yFCnpVXURc=;
        b=wkO2kk/RK/kQ/oM36ETwBrQ3u5oiGb9RdNjNEyhELicjEM4YTTaJKY6RyDkxDGaseD
         GeJ3sahxXLsqxvF5h0n5a5pdPZJUSoVhk+7mM9JQvTqGbUrK7qNB2XDsKNWo3+0kvo14
         iMwzv5YIEBbZkE/qql8HY9pjOSN0KQBFnlB0cFUEzoGP3fU62MIpuBXsqryRDRq9YLGD
         XdXehpMEJxpLAXOw7WIl3dJXFup+COSIvR3X2ITxmkPB1oF2TP2+Sw/I8tRQ1AsKe4q1
         1S9FGLs0P+HNA9QNzqczw/EDi5Wk6KR2UDsGKwybKmEYGxDR2utGn1MsUxmEj1lws09d
         n5cA==
X-Gm-Message-State: AOAM530qZhvdYnoQjb6gsnRVbyKoFufgaOWkpB0s085/ySBgUfjM/HLI
        Fgz2CNW2N8h4C0TX/p1sQriqkPrEILwnFs3r
X-Google-Smtp-Source: ABdhPJy9lVwYjFugt7MKgWvIbZGlK5FevsUK8GEOHu2cCfBNgl9OI3KBphWC77bYZkL1Jjg3TjCBdw==
X-Received: by 2002:a17:902:e546:: with SMTP id n6mr2909226plf.38.1643272570752;
        Thu, 27 Jan 2022 00:36:10 -0800 (PST)
Received: from localhost ([2401:fa00:9:14:f81:dff7:4d7c:382])
        by smtp.gmail.com with UTF8SMTPSA id s42sm5001595pfg.146.2022.01.27.00.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 00:36:10 -0800 (PST)
From:   =?UTF-8?q?Sami=20Ky=C3=B6stil=C3=A4?= <skyostil@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dtor@chromium.org, evanbenn@chromium.org, arnd@arndb.de,
        gregkh@linuxfoundation.org,
        =?UTF-8?q?Sami=20Ky=C3=B6stil=C3=A4?= <skyostil@chromium.org>
Subject: [PATCH 0/2] Add a driver for the ChromeOS snooping protection sensor (HPS)
Date:   Thu, 27 Jan 2022 19:35:43 +1100
Message-Id: <20220127083545.1020423-1-skyostil@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series adds a driver for the ChromeOS snooping protection sensor
(a.k.a. HPS) device, attached on the I2C bus. The sensor is a
hardware-isolated module which reports a high-level presence signal,
e.g., whether there is person in front of the computer or not.

The driver exposes the device to userspace as a character device, which
can be used to send and receive messages to the sensor. The driver
automatically turns power off to the sensor unless a process is

More information about HPS, its firmware and communication protocol can
be found at
https://chromium.googlesource.com/chromiumos/platform/hps-firmware.


Sami Kyöstilä (2):
  drivers/misc: add a driver for HPS
  drivers/misc: add transfer ioctl for HPS

 MAINTAINERS              |   7 +
 drivers/misc/Kconfig     |  10 ++
 drivers/misc/Makefile    |   1 +
 drivers/misc/hps-i2c.c   | 304 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/hps.h |  20 +++
 5 files changed, 342 insertions(+)
 create mode 100644 drivers/misc/hps-i2c.c
 create mode 100644 include/uapi/linux/hps.h

-- 
2.35.0.rc0.227.g00780c9af4-goog

