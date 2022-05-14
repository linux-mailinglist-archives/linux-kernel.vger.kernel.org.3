Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCC6526F91
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiENHPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 03:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiENHPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 03:15:10 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83042706
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 00:14:50 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p8so9547289pfh.8
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 00:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6syGbb+RTBmS7v1zUyaOnOEeBAD9d5yTeGK7n7VmHJU=;
        b=Bz+SSgUA4xke81OwFvcuBEHDdqT4m+wFwlDinRm9LdWBxjg09ZlpbSPVbwr96LIoPm
         q2ImB7EG2g+Ra+Q4l7bjK1R0gfStNJjV07tocvdKMxH8O7gKBsoUQJmN3h149D0odBSJ
         poqRkZiPNh/qjBr95LKZM3tAP01k3wPs0rSeRCpbFybF+95JMVKPNJUfSNec06+DCpJe
         BoqWzyd5SfsIu31NrHn3Zi4SeXdcPlYQgcRMqFWSDiqBFiiIGOTlhpVQRxrQtkBdnqzG
         qXdbvBqvBcLzJAHNmFzez61bm3u0HQ8Tg68zpZ/NQmm/dyAaB36ow7wPL1wMPQMdasL0
         2pxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6syGbb+RTBmS7v1zUyaOnOEeBAD9d5yTeGK7n7VmHJU=;
        b=CV9MooSZJ4rweCKinJdLNF/tn3ocmfa/g8nD3yq9wmuLgGi3A/1Ir5yy1gwoCR4x9S
         CaHbL8QhF9S+L0Jw8y7MM2ix4DnDV+/bWGJ6hjJbs6eEc9GmYaxTap7bVYgOAyD9JYT1
         OXbyFXk/bxT3YfcCDWsVudW3iGR/AUUryq16H5pAxE7SsVnCC8JLlQtI077l37JKWe96
         mQZnV8AoZEwEbsqx1KmgousMCZsFgx97XOLWkKLksJrV+12GNgHOmwv+HlzDBu5FPHq3
         asLugtHTsKq/cZE8ibiSOeCBoF4yHYYZFZ69aIwvGzvfCEY2A2tSFQPkgEK4+7/7JiAv
         dz2A==
X-Gm-Message-State: AOAM532eV/oFJJxsuvGqJ2j9tCTWiBJMKMwf7/G+i6hVSUr4TxBsFj9s
        Y9ImkFeDyVnqpYSsX/97/YR/SJmTdZEhP7s=
X-Google-Smtp-Source: ABdhPJxxDWM+pQb3fgHMZD9oXSMwNwTZtr6N2dJahGpwz8O1FPOyoVdGAkWnGNWPUoNKT+TX67QVAg==
X-Received: by 2002:a65:6846:0:b0:3db:32b7:fdb3 with SMTP id q6-20020a656846000000b003db32b7fdb3mr7005634pgt.430.1652512490167;
        Sat, 14 May 2022 00:14:50 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id d21-20020a63d655000000b003c14af50620sm2793114pgj.56.2022.05.14.00.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 00:14:49 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     eli.billauer@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] char: xillybus: Check endpoint type properly
Date:   Sat, 14 May 2022 15:14:35 +0800
Message-Id: <20220514071436.2517776-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver submits bulk urb without checking the endpoint type is
actually bulk.

[    3.108411] ------------[ cut here ]------------
[    3.108690] usb 1-1: BOGUS urb xfer, pipe 3 != type 1
[    3.108983] WARNING: CPU: 0 PID: 211 at drivers/usb/core/urb.c:503 usb_submit_urb+0xcd9/0x18b0
[    3.110976] RIP: 0010:usb_submit_urb+0xcd9/0x18b0
[    3.115318] Call Trace:
[    3.115452]  <TASK>
[    3.115570]  try_queue_bulk_in+0x43c/0x6e0 [xillyusb]
[    3.115838]  xillyusb_probe+0x488/0x1230 [xillyusb]

Add a check to fix it.

Fixes: a53d1202aef1 ("char: xillybus: Add driver for XillyUSB (Xillybus variant for USB)")
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/char/xillybus/xillyusb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
index 39bcbfd908b4..2ec2e087b2e7 100644
--- a/drivers/char/xillybus/xillyusb.c
+++ b/drivers/char/xillybus/xillyusb.c
@@ -730,6 +730,11 @@ static void try_queue_bulk_in(struct xillyusb_endpoint *ep)
 
 		usb_anchor_urb(urb, &ep->anchor);
 
+		if (usb_urb_ep_type_check(urb)) {
+			report_io_error(xdev, -EINVAL);
+			goto unanchor;
+		}
+
 		rc = usb_submit_urb(urb, GFP_KERNEL);
 
 		if (rc) {
@@ -834,6 +839,11 @@ static void try_queue_bulk_out(struct xillyusb_endpoint *ep)
 
 		usb_anchor_urb(urb, &ep->anchor);
 
+		if (usb_urb_ep_type_check(urb)) {
+			report_io_error(xdev, -EINVAL);
+			goto unanchor;
+		}
+
 		rc = usb_submit_urb(urb, GFP_KERNEL);
 
 		if (rc) {
-- 
2.25.1

