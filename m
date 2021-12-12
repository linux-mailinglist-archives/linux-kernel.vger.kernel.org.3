Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DB24719E9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 12:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhLLLze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 06:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhLLLzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 06:55:33 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CDEC061714;
        Sun, 12 Dec 2021 03:55:33 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so12694600pja.1;
        Sun, 12 Dec 2021 03:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hX/ICKtr5gW8yVaOGnXk5ZnAIDwSq2paZmGCJ/xzR3o=;
        b=FAjhegj3SG+UvdjFvrXS28CX8qHvlvWkpKSnAo6rjTVKJAY1hjVPXZ8m70f95CvkOT
         2/zjV1M4KIciELPfm/ZJ8RivZ+R3bOHmcgzYuVtwQQNkEhvuHE6PXQ3vvN9QeuoJOZJu
         0T8clhzo8RfbmYie2hRraJr7Mp1eEGVkdz6ct/TI7CQxiATv2WKAZMUIpbDCujGcS4+M
         yP1s0xW/4ziupeNaiBlmRz87TOdRd2UGiSF+Gakf2esA4N+g3FWAUNpstJr4y653Xaib
         +PWHn6TuRuEMB29NyuoDpGqAczb8f3f/OrLjHDrcqE1/HYIavPSU/wkDbZYhwWA83+9a
         3MuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hX/ICKtr5gW8yVaOGnXk5ZnAIDwSq2paZmGCJ/xzR3o=;
        b=ervNcpCaF/hFYl/Lhvat6KXy6RC+ytJtyL5epWIrcMDtCqdt4bvsINBbAEDcGYyClF
         j3ILnMM+Fs5nIMsOQrtNKOdYCiYNIrF0UjgGHmx+xRoBzW8+OHmhunz+zapCEDqQo6uo
         qoHDgLEM7Wi6n3AikbXn4SPGalcKvKiBeRtbmGgvDcc5EmMtp86n4DY6Lm3t2qlmEzeG
         4XyI0z8j5/D6JqRfIW9BRb4A+jJOaaar0dtZx02hbV2qRT20DdJGMn8gyZ0gDGm1RB1y
         ee52iRRn2X9bMZMItNe3UwUc6Sa98DAoOGpENcUbmZM1UJs7hlj7Qv8O08yQUcyAy60O
         qtBw==
X-Gm-Message-State: AOAM531Z922jS32TFMKNEhYcGJdX90qrhDvPjYsa8cHfUiXoFdbjqnXK
        DGMeNY7REUrlZI3FbqJJ9t0=
X-Google-Smtp-Source: ABdhPJyX3oFAc+HQ//7S+51gGzVlfj9Q3l8O5LkRTdU480ioUaICXeQWuw4FTwGfw2PzHI6TOCaWoQ==
X-Received: by 2002:a17:90b:1e4f:: with SMTP id pi15mr37052454pjb.181.1639310132658;
        Sun, 12 Dec 2021 03:55:32 -0800 (PST)
Received: from localhost.localdomain ([240d:1a:8f0:6c00:89cb:88d1:b6b2:3345])
        by smtp.gmail.com with ESMTPSA id e14sm9909732pfv.18.2021.12.12.03.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 03:55:32 -0800 (PST)
From:   Alexandre Courbot <gnurou@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>
Subject: [PATCH] usb: storage: do not use UAS with Logitec LGB-4BNHUC
Date:   Sun, 12 Dec 2021 20:55:06 +0900
Message-Id: <20211212115506.180629-1-gnurou@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This 4-drives USB 3.1 bay gets unhappy when used with UAS:

	sd 10:0:0:0: [sdb] tag#18 uas_eh_abort_handler 0 uas-tag 5 inflight: CMD IN
	sd 10:0:0:0: [sdb] tag#18 CDB: Read(16) 88 00 00 00 00 00 00 9d 42 30 00 00 04 00 00 00

It works perfectly fine as a regular mass-storage device, so prevent UAS
from being used with it.

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
---
 drivers/usb/storage/unusual_uas.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index b34b858d82a6..9ef09cabef50 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -52,6 +52,12 @@ UNUSUAL_DEV(0x059f, 0x1061, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NO_REPORT_OPCODES | US_FL_NO_SAME),
 
+UNUSUAL_DEV(0x0789, 0x0296, 0x0000, 0x9999,
+		"Logitec",
+		"LGB-4BNHUC",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_IGNORE_UAS),
+
 /*
  * Apricorn USB3 dongle sometimes returns "USBSUSBSUSBS" in response to SCSI
  * commands in UAS mode.  Observed with the 1.28 firmware; are there others?
-- 
2.34.1

