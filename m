Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9BA492035
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240171AbiARH0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiARH0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:26:33 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D867C061574;
        Mon, 17 Jan 2022 23:26:32 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 133so8815561pgb.0;
        Mon, 17 Jan 2022 23:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M1c/PR63+kUtnRbviXHywx9AARLo+3pFZM+tuYfBXLQ=;
        b=S96n4Ajs+YCVlV94aWTT0wJCv5Nxpv5Z0FMpD6yGNmtIxag5NyzoLdd5+l5YlkOYpg
         oLbvRBBeIeRmtJ1abshDDpPlezpeFHlrEYEHEnec7aIEVSLh5gw3R5AI6XqI8AJ9CYUv
         4YOAco92zO9ymz9IKRYGnq/Ge24DgaF/hvp9Fm3dgcS71Y/f0D7I6HdTvuUmqLCuqw5z
         WTDYL+0BSRFB+n/u05pYGjU2wwwOhFmr4tjPaJ2EMvykkrNfb7mKFC2Atk6K1gcIk/HN
         wWh+KCQNDNfwXJTgyFV1xaPexnR47jwhBZ+dpbBcNnA0Opr99P56VYkMkN9z3fB9cD2t
         GR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M1c/PR63+kUtnRbviXHywx9AARLo+3pFZM+tuYfBXLQ=;
        b=cBLttLNTsI69alundSoyE0qmeZb95/1XAzISVM9bYIBaIuEJgUP/w4ckUO3cYhGMY0
         637CIsCc0yFs6dr/Oif6NqcfSA+UG6YqOO3tcnCrnmXgap6YTeBNMsB7+tVrZtjOdZDg
         pvZd0ysJlnKXBeMyuxD2k6UCCXdXj11SwMyB/WPLr5G50i0PGcxsrpUrvUoqDR9L2EZP
         9gqZRTHryx6doBu+4WcX2DkWrrCl+LoRmtl243WTORSLZGJcwo7tmYu9xkN5SoU9DOCP
         nMlzI/jo4WWuEaabBOVikj7uCOlTceISxjsR2XLT9tqoM0E98qsp8dNpRgL9OjL88su+
         Cmtw==
X-Gm-Message-State: AOAM532AvWxozN5cl+fdpQHN5YRiwZFCl+t3xgMYqHpSAH2BZYM3S9AV
        BSXhscIX1A1Bkilho4DTQOU=
X-Google-Smtp-Source: ABdhPJxrs33KJA2p70wb07aCVvcw4TjIG8rbG5kGcgQxImqCImNYco4m54cN+1ozkNWOO0Kd7O3wAw==
X-Received: by 2002:a63:8f05:: with SMTP id n5mr22166010pgd.606.1642490791918;
        Mon, 17 Jan 2022 23:26:31 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:bf2e:59:5029:f4c5])
        by smtp.gmail.com with ESMTPSA id y18sm11079816pfl.156.2022.01.17.23.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 23:26:30 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Angela Czubak <acz@semihalf.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] i2c-hid: fixes for unnumbered reports and other improvements
Date:   Mon, 17 Jan 2022 23:26:16 -0800
Message-Id: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series came about after I reviewed Angela's patch that fixed issues
with incorrect handling of high-numbered reports (15 and above) in
i2c-hid driver:

- it appears to me that the driver did not handle unnumbered reports
  correctly as the kernel internally expects unnumbered reports to be
  still prepended with report number 0, but i2c_hid_get_raw_report() and
  i2c_hid_output_raw_report() only expected report ID to be present for
  numbered reports.

- the driver tried to consolidate both command handling and sending
  output reports in __i2c_hid_command() but the rules for different
  commands vary significantly and because of that the logic was hard to
  follow and it bled out from __i2c_hid_command() to callers. I decided
  to introduce a few simple helpers and have the data encoding for
  individual commands done at the call site. I believe this made it
  easier to validate the rules and the logic and allowed to remove
  special handling for the HID descriptor retrieval, among other things.

- the driver does too many copying of data; encoding the data for
  commands at the call site allowed to only copy data once into the
  transfer buffers.

I tested this on a couple of Chromebooks with i2c-hid touchscreens, but
it would be great if other folks tried it out as well.

Thanks.

Angela Czubak (1):
  HID: i2c-hid: fix handling numbered reports with IDs of 15 and above

Dmitry Torokhov (11):
  HID: i2c-hid: fix GET/SET_REPORT for unnumbered reports
  HID: i2c-hid: use "struct i2c_hid" as argument in most calls
  HID: i2c-hid: refactor reset command
  HID: i2c-hid: explicitly code setting and sending reports
  HID: i2c-hid: define i2c_hid_read_register() and use it
  HID: i2c-hid: create a helper for SET_POWER command
  HID: i2c-hid: convert i2c_hid_execute_reset() to use i2c_hid_xfer()
  HID: i2c-hid: rework i2c_hid_get_report() to use i2c_hid_xfer()
  HID: i2c-hid: use helpers to do endian conversion in i2c_hid_get_input()
  HID: i2c-hid: no longer need raw access to HID descriptor structure
  HID: i2c-hid: note that I2C xfer buffers are DMA-safe

 drivers/hid/i2c-hid/i2c-hid-core.c | 593 +++++++++++++++--------------
 1 file changed, 313 insertions(+), 280 deletions(-)

-- 
Dmitry

