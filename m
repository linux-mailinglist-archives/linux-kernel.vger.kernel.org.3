Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18FF4B2109
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348381AbiBKJJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:09:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348378AbiBKJJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:09:13 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364A3C30
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:09:11 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id qe15so7525705pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ixrRB4BVZ5Ftz4yRLgTq5N+1jjPpkeSY9/Gftg2n7WM=;
        b=Und2qgfQKc7yDKChAKQaVZQypNiq5sM6vxM23wcp/C25LCit8z1ZtCq8ZYafmTStHZ
         sU9bRLrfE8LN2FCwC6M0fr7iaH5r6crxkIA8wI43ZVuIsdt8qWheJ/z6BG5Gc8K+UJ0W
         UjrsbJvhKbVtdeyvnWTXiyjBV6wmgcF4tKF0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ixrRB4BVZ5Ftz4yRLgTq5N+1jjPpkeSY9/Gftg2n7WM=;
        b=zFbweOJFGwjgmFggerBmVFy7sjg+8eN3QRS6pa9fYKNwkmDUqlJ51E/Cup505wGrWe
         RlkqW8gicyl5VJQDB+VKNjB5NnOYg3eQD65FFB/PYcc8HGvgyxS9zpL7HE9pozzdUC6G
         wadCKoVX0OJIyTt0I30nlL2OP7HnkXrDBfkfDteeJVryLFaCsvsyerbtmiDezigU91RI
         Y8q9qIMFAlfE7bLG9HesQILnTW/gwdisPt4Spz1pYFjP+KQZsRl1ZiXyqxiO5Js7PJFb
         zRdW1Vh7QRFmT7goZ9j1sYTR9OFORx4O1tAkuKfdoQ4SDs9BhE60xCKNTLlWe2E6umL1
         CKww==
X-Gm-Message-State: AOAM530GhnSQgmINMvQpup0Msub0LcXXxQJa9mVv2IDCFNKyWYSysSlt
        awFW8M2wo2bMfGqMksSaakvXXCzp82U4RQ==
X-Google-Smtp-Source: ABdhPJxw0GClKCjvSbtj8pHbiOblSIhN8iyhqs/Z9XL7/elOjOXhkvjS/2eRS8XxPRLpYNqRIZjPQA==
X-Received: by 2002:a17:902:d641:: with SMTP id y1mr704010plh.64.1644570550358;
        Fri, 11 Feb 2022 01:09:10 -0800 (PST)
Received: from localhost ([2401:fa00:9:14:72c7:7d52:feb:9958])
        by smtp.gmail.com with UTF8SMTPSA id z13sm26784512pfj.23.2022.02.11.01.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 01:09:09 -0800 (PST)
From:   =?UTF-8?q?Sami=20Ky=C3=B6stil=C3=A4?= <skyostil@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     bleung@chromium.org, evanbenn@chromium.org, tzungbi@google.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        =?UTF-8?q?Sami=20Ky=C3=B6stil=C3=A4?= <skyostil@chromium.org>
Subject: [PATCH v4 0/1] Add a driver for the ChromeOS human presence sensor (HPS)
Date:   Fri, 11 Feb 2022 20:08:56 +1100
Message-Id: <20220211090858.7970-1-skyostil@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
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


This series adds a driver for the ChromeOS human presence sensor
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

Changes in v4:
- Simplified open/release pm logic.
- Renamed device to "cros-hps".
- Stylistics cleanups.

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
 drivers/platform/chrome/cros_hps_i2c.c | 151 +++++++++++++++++++++++++
 4 files changed, 168 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_hps_i2c.c

-- 
2.35.1.265.g69c8d7142f-goog

