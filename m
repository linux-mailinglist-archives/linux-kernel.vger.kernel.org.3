Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E6A596D01
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbiHQKul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238839AbiHQKuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:50:35 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F036C13A;
        Wed, 17 Aug 2022 03:50:34 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id c24so11652272pgg.11;
        Wed, 17 Aug 2022 03:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=5RiZpgZDUuO6MV3ALtXTmbuVcbhlGB6egOopFvdYj90=;
        b=fNzPi2WncFTKeH2XgHbHqO3yz1RWdVZcL/3a6wAebKjrIqoAkjVoPwk7v+t+NXa4Li
         NOKo6/ZYV6Cbrg31/a/m+Ntxb/ppYHnmzgOMsPxUzvBuuCt5y0a2CDYI6wuCLYLM5bF9
         Vkxksy10GEdcWIZZuPGUbpTiQdqy0wZDV8n+gGCKzIdldBWGmN994Pqih5/yevIoAuHk
         tBie1d7q5KZoKi4SddL6HNREi6cvEEHVeom7NkIJvSecw43K2pe81qJyyOBvxwV/qfMk
         gBDcjEqGJmrpmi+41Y6QYYPG0uuPXnVZ+n/TUHrjkUfZ0z6cLaWNIQ+wQJ+//AfJe/4b
         Y5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=5RiZpgZDUuO6MV3ALtXTmbuVcbhlGB6egOopFvdYj90=;
        b=kb0/QK3XKUIHoGWKHra2R2NVajdJbv+VLe89QaCluIv8ctZnlAyxfyluSSU5IQlGSH
         FeTxfnKVdOCwddRonGhtouWLiW7by9QdRCVSIUhlZxrUktERehf5yf2Nbeq7i3YKoY9E
         yoTNF5ey2VudZr1N96zjFsdy1hY6bVMi5FhUdh59P+6Ofpb45EkSy3zhS1IB0UfQ2wY1
         1jhKtVPGSA3sjodBpKb0DVRU8HB0afwkpziRLApcnGPhPxnDH3ZSPwK1sH4IsccyR15h
         6JGw3e8BoU5I6wQ0yzj++CooqNvRerfy0ituCLYxS5GoOTtFqormajvrpTmol8bitwCs
         VZsw==
X-Gm-Message-State: ACgBeo2NWtD5sEqseWbrEVRJA+gNKifn8VbkOBVTDzUrciOShmSExGox
        Q4A9HgoYUZyVwt7oaQPfhtZ7oGgxqYY=
X-Google-Smtp-Source: AA6agR6v/qaKXALKSRCgB2FvuUcNiNmRImMFtCzuegTfY64K6w8+f2ca/C2oUByGIo4KEIPNsYUC8Q==
X-Received: by 2002:a05:6a00:1a47:b0:52e:6a8c:5430 with SMTP id h7-20020a056a001a4700b0052e6a8c5430mr24537458pfv.48.1660733434041;
        Wed, 17 Aug 2022 03:50:34 -0700 (PDT)
Received: from fedora.. ([49.49.237.218])
        by smtp.googlemail.com with ESMTPSA id n8-20020a170902d2c800b00172897952a0sm1152033plc.283.2022.08.17.03.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 03:50:33 -0700 (PDT)
From:   Supasak Sutha <blur.3rd@gmail.com>
Cc:     blur.3rd@gmail.com, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: magicmouse: Add parameter to be able to adjust middle button position.
Date:   Wed, 17 Aug 2022 17:50:13 +0700
Message-Id: <20220817105013.28036-1-blur.3rd@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently the driver fixed the offset of middle button to [-350, +350].
Which separated the area to 3 equally space for 3 buttons.
Lead to a lot of mis-clicking as the magicmouse has no real button.
Users should be able to adjust the buttons to suite their fingers.

This patch add parameters to adjust theses offsets,
while keeping the default values to [-350, +350].

Signed-off-by: Supasak Sutha <blur.3rd@gmail.com>
---
 drivers/hid/hid-magicmouse.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 664a624a363d..9709085647fb 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -25,7 +25,12 @@ module_param(emulate_3button, bool, 0644);
 MODULE_PARM_DESC(emulate_3button, "Emulate a middle button");
 
 static int middle_button_start = -350;
+module_param(middle_button_start, int, 0644);
+MODULE_PARM_DESC(middle_button_start, "Middle button beginning offset");
+
 static int middle_button_stop = +350;
+module_param(middle_button_stop, int, 0644);
+MODULE_PARM_DESC(middle_button_stop, "Middle button end offset");
 
 static bool emulate_scroll_wheel = true;
 module_param(emulate_scroll_wheel, bool, 0644);
-- 
2.37.1

