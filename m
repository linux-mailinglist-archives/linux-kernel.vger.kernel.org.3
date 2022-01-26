Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910FA49D150
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiAZSAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiAZSAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:00:24 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FAFC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:00:23 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 13so256305qkd.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=howett-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P31D85rdtDB0qHadL+nmEne5kdwdptEf/d+s5l0GN1Y=;
        b=Fhb9L5QRXsWNpq6eFN9x0ZgLiR7qPDGoILRomACP3dXUZTBrdp7ZX/mZU/TyErD956
         xnV+DBaMzrRcqBUaM+nj85nkcf8RkwX92Z7wmg+ttgG29t1CQe2wCLyLHyC2jJ6QKCh5
         6LsFrUpmqcCBZO20G2OMtE65eU7VnrYXYxVCg1MsIh9BE0vasfbXEK4LorwH/DAVi2bF
         iJw/0vlrMdh3uCKNGHC282AdRbA9g+e5cYfB7wWhzjbvuv2FbPGCIXiXZVvs14CQYAl8
         vOqm4NMpEZ+hMDqGBqs+2Jvb7zYo3V5azELqOhqotmzEz+9Dz7Xql0YVFtbvkUlwSWL3
         e4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P31D85rdtDB0qHadL+nmEne5kdwdptEf/d+s5l0GN1Y=;
        b=MEACz01pHApNsVNu00BLOrrBkYCruOAH14IaTm94+L1kR8NFnkJu9HYNRYjY/4SQpv
         PViP1blH+2dHqKMfPOF23EmQ4idMjkBGxVvxcCkFKvJ8vyoxqGym03bXiYmR80LGmHI0
         A0WdD+n9vnRcHg92XjX5S8YBKEEuz3jDyIb6d131YpAXWwhJs1Pwz3HPJoelCzr8Kl7S
         PwXJEWoanMAmDgtnAC1npiSLhGOmF6FyWizTS5xoYDGG7WPd+bS+8p3RsLYHXiRVKrEt
         8rlKbik5L+/XEKkOruH3iqGrUzKfjAnGekhVrXAr+HYf8e6mO1CYmbfKCVSQ+ig0N0le
         N8Rg==
X-Gm-Message-State: AOAM531wgKNaPrkOkm2YAHMphN8F4ZAMHvV7WzfZqUXwU6crMtbnlDVm
        JshKXSaM30uk93A+8MV+3OPbHGs4kfWISidy
X-Google-Smtp-Source: ABdhPJxWXxweoCpXeRCqZP5tsHtKF6yap0wZoeDv9vRtclYLV5PZUmm5AyIWlbXM0A/yt/WjxhdANg==
X-Received: by 2002:a05:620a:2986:: with SMTP id r6mr11604955qkp.744.1643220022657;
        Wed, 26 Jan 2022 10:00:22 -0800 (PST)
Received: from rigel.delfino.n.howett.net ([2600:1700:df50:a7cf::725])
        by smtp.googlemail.com with ESMTPSA id 2sm5702342qtf.9.2022.01.26.10.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:00:21 -0800 (PST)
From:   "Dustin L. Howett" <dustin@howett.net>
To:     linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Michael Niksa <michael.niksa@live.com>,
        "Dustin L. Howett" <dustin@howett.net>
Subject: [PATCH v2 0/2] platform/chrome: add support for the Framework Laptop
Date:   Wed, 26 Jan 2022 12:00:18 -0600
Message-Id: <20220126180020.15873-1-dustin@howett.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the Framework Laptop to the cros_ec
LPC driver.

The Framework Laptop is a non-Chromebook laptop that uses the ChromeOS
Embedded Controller. Since the machine was designed to present a more
normal device profile, it does not report all 512 I/O ports that are
typically used by cros_ec_lpcs. Because of this, changes to the driver's
port reservation scheme were required.

Since this EC driver probes the MEC range first, and uses only the MEC
range if that probe succeeds[^1], we can get by without requesting the
entire port range required by non-MEC embedded controllers until
absolutely necessary.

[^1]: this includes "memory mapped" read - where the traditional LPC EC
requires I/O ports 0x900-0x9FF, the MEC EC multiplexes reads/writes
over the same eight ports, 0x800-0x807.

Changelog in v2:
  Cleaned up the commit subjects per request.

Dustin L. Howett (2):
  platform/chrome: cros_ec_lpcs: detect the Framework Laptop
  platform/chrome: cros_ec_lpcs: reserve the MEC LPC I/O ports first

 drivers/platform/chrome/cros_ec_lpc.c          |   47 ++++++++++-----
 include/linux/platform_data/cros_ec_commands.h |    4 +
 2 files changed, 38 insertions(+), 13 deletions(-)

-- 
2.34.1

