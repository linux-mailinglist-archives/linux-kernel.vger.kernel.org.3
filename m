Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F74471CE9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 21:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhLLUTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 15:19:53 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:36596 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhLLUTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 15:19:52 -0500
Received: by mail-wr1-f43.google.com with SMTP id u17so23891405wrt.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 12:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kai+38ffN8h6EE4lcs4yXb6aSJaYI4aKa/cyVHvav4Q=;
        b=OHrb0CxnEGkk+A0FoXgxBbPagJ81j5Ten47px24G2jb+maDurlEHjgEge7FYXYmyGS
         vAZjK6eqwOwXQMgL4HOkX32LXFko7oObZuntxT04IBYvncbvETDvrgut/2Ck0ya/qF5b
         wEJCszgJcjnQvC1g+BQuqVnx+nPuVsEOdGqsSWWuw+mlcGF5i75ggl2ZCoVQrB0WwKXB
         sg9JEQPLFXfczqomsq+vSYYrjjt1BwBjN07DpHhMHuhZDECdbbcG2yGsefN8EGvWK51T
         XYPfKlzbfFetMpwTdBnHOAtBLIT8kS0hX0IK7nttm0VjmtB9wZBt8V9TKKADBbjnEqCv
         ASRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kai+38ffN8h6EE4lcs4yXb6aSJaYI4aKa/cyVHvav4Q=;
        b=R3NtcZxn2bFpnV0K73Izw4FgjOPng/S+RrvlG4wMEAEJdN88tJHqgqp6nnxIMM4Dsw
         rithjtfTcUa0ol5ZkXVhpgU2L7VwHl/AHjGEWOULQrVGJAgMdzFY/mYvRYDUgfQxnTvM
         wDv39q6mL62wevwpS3DejpZ2VNOO5QC6A3fT8/F4bPLmQjlJJvZ8HdEcFpenvQSxnG+s
         akWcQxJDE+smgrOXTUWe7qApyobTLFl9Q4vDP7i8Ld/Tk0TL4xvqwHKPLQZ+sS92mORe
         Prov+K6F8MSbt5aDdF5MhNED7R55GahZszbYBCCRJs1QsuSB0e3QDjcMiw+94MoYXHWt
         mS5A==
X-Gm-Message-State: AOAM533GysSKCErAw4GFwSDN0RkR/sZ3PlLToI+5VS65zVic15xAdJ44
        oFCmAdeM5wK4zMuPbQLZF+NJxw==
X-Google-Smtp-Source: ABdhPJwRch+y3kMPJINftWfz71kXXxhOT6aJCL97WR9M4GQ2LHsTtE1wLvBDA8lqYqO4uUdxL+zKZw==
X-Received: by 2002:adf:e84d:: with SMTP id d13mr27337627wrn.72.1639340331606;
        Sun, 12 Dec 2021 12:18:51 -0800 (PST)
Received: from localhost.localdomain (203.247.120.78.rev.sfr.net. [78.120.247.203])
        by smtp.googlemail.com with ESMTPSA id p5sm9092710wrd.13.2021.12.12.12.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 12:18:51 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     khilman@baylibre.com
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        p.zabel@pengutronix.de, balbi@kernel.org, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v5 0/3] usb: meson: fix shared reset control use
Date:   Sun, 12 Dec 2021 21:18:41 +0100
Message-Id: <20211212201844.114949-1-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes a usb suspend warning seen on the libretech-cc by
using reset_control_rearm() call of the reset framework API. 
This call allows a reset consummer to release the reset line even when 
just triggered so that it may be triggered again by other reset
consummers.

reset_control_(de)assert() calls are called, in some meson usb drivers, 
on a shared reset line when reset_control_reset has been used. This is not
allowed by the reset framework.

Finally the meson usb drivers are updated to use this new call, which
solves the suspend issue addressed by the previous reverted 
commit 7a410953d1fb ("usb: dwc3: meson-g12a: fix shared reset control
use").

changes since v4:
- call reset_control_rearm() after clk_prepare_enable() fails

Amjad Ouled-Ameur (3):
  phy: amlogic: phy-meson-gxl-usb2: fix shared reset controller use
  phy: amlogic: meson8b-usb2: Use dev_err_probe()
  phy: amlogic: meson8b-usb2: fix shared reset control use

 drivers/phy/amlogic/phy-meson-gxl-usb2.c | 5 ++++-
 drivers/phy/amlogic/phy-meson8b-usb2.c   | 9 +++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.25.1

