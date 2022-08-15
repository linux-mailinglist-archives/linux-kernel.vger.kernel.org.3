Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192C75930CB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243198AbiHOOam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243111AbiHOOaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:30:13 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4031D23BF1;
        Mon, 15 Aug 2022 07:30:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j1so9294677wrw.1;
        Mon, 15 Aug 2022 07:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xxHC06/Os8ziAl2SBnJlxSxiEi0i7a6+qXGKYnTl3x4=;
        b=AsBNtOtBuZg+ucZYXZPWvl+wLsJJeol+G+sKqa92iBhbiXAo8uWBpWtLMhgJEIqmyv
         3hP+g6k87IaPdrYezqweW4coMvYD/TxcI1fv6pt4JnShAu8Fs2iyo3wq+x5hiBQT2PE5
         4NT1llsmb6xy5taAdFSPFaJNkldVVHlv/QgMjXQHQ7/cS7S2U7kYdk+cXQCjGmOqSJF/
         TToE6wxfq5uapQGBYB/2/lkBhy5kqGvirYX9i7xZHS6MpCLXkB5y/O7VW9f/u1/6P/VB
         tRqFvraFzI1QXQ5HWMR+tQw9axISGQ2fDmrVyht2XRQ4losfQK11ukaznMU3+WNBPpFT
         am7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xxHC06/Os8ziAl2SBnJlxSxiEi0i7a6+qXGKYnTl3x4=;
        b=XMA6GZ8dGiJlsxX3hoBKsiAD8q2q63RZedKFLu9lx8flVhHhbYoJC24ALaHXgNHYBM
         pqeOK96pDvnwLg5KSF3f0oPgSeCor11kzChHr4UUTwIdkf+fIipw5lK35YUAOrZQoyGg
         KBpekkK86dAReFavwjAxg8ElRIFNUPydh3h4MIhrN5fQsEopath+0CGAWdsk4jt0EmEF
         JduudcCgd4TvBe2aB+MvbHmpNI3IU1MjEB6QaZZhpIOGvAFALUYXCI0CtAsoU1mAoA7Z
         zPyOUmJeVkjVLAizvMeqVDi2nE3sBIIdJZv9gvaGnFLrv+D2RKVj0H7vpHFefZWzo3zJ
         5pZw==
X-Gm-Message-State: ACgBeo2E7VL57esjJMu5rapbFFK3f34jJ1/dxqPELJhRh3aElX6wbbk5
        55Zkm3qEk/N+lDCD4zBZr5rWYCgakAUc4Q==
X-Google-Smtp-Source: AA6agR75zw4cdAZTd7ANv2PbiYz9wZE8aOZo7ES4acPI3bGepibaOMkkhMoX27dfOWFGVAUArhw5Jw==
X-Received: by 2002:a5d:59a4:0:b0:220:805a:bc65 with SMTP id p4-20020a5d59a4000000b00220805abc65mr8929397wrr.302.1660573810800;
        Mon, 15 Aug 2022 07:30:10 -0700 (PDT)
Received: from localhost.localdomain ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id m7-20020a056000008700b00224f895d620sm5456894wrx.48.2022.08.15.07.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 07:30:10 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, nathan@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v4 8/8] HID: uclogic: Add support for Parblo A610 PRO
Date:   Mon, 15 Aug 2022 16:29:56 +0200
Message-Id: <20220815142956.19180-9-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220815142956.19180-1-jose.exposito89@gmail.com>
References: <20220815142956.19180-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The Parblo A610 PRO is a UGEE v2 device with a frame with 9 buttons
and a bitmap dial. Its pen has 2 buttons, supports tilt and pressure.

Add its ID in order to support the device.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-ids.h            | 1 +
 drivers/hid/hid-uclogic-core.c   | 2 ++
 drivers/hid/hid-uclogic-params.c | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index ecf1468404b3..6b4068eecc6f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1276,6 +1276,7 @@
 #define USB_DEVICE_ID_YIYNOVA_TABLET		0x004d
 
 #define USB_VENDOR_ID_UGEE		0x28bd
+#define USB_DEVICE_ID_UGEE_PARBLO_A610_PRO	0x1903
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_G540	0x0075
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_G640	0x0094
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO01	0x0042
diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 6fcdb141acec..2efcf48f91ba 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -509,6 +509,8 @@ static const struct hid_device_id uclogic_devices[] = {
 				USB_DEVICE_ID_UGTIZER_TABLET_GP0610) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGTIZER,
 				USB_DEVICE_ID_UGTIZER_TABLET_GT5040) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
+				USB_DEVICE_ID_UGEE_PARBLO_A610_PRO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
 				USB_DEVICE_ID_UGEE_TABLET_G5) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 60ed94981a55..34fa991e6267 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1580,6 +1580,8 @@ int uclogic_params_init(struct uclogic_params *params,
 			uclogic_params_init_invalid(&p);
 		}
 		break;
+	case VID_PID(USB_VENDOR_ID_UGEE,
+		     USB_DEVICE_ID_UGEE_PARBLO_A610_PRO):
 	case VID_PID(USB_VENDOR_ID_UGEE,
 		     USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L):
 	case VID_PID(USB_VENDOR_ID_UGEE,
-- 
2.25.1

