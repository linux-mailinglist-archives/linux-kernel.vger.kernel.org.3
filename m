Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A14550BCB9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378310AbiDVQUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351477AbiDVQUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:20:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59F35C861;
        Fri, 22 Apr 2022 09:17:23 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w4so11734283wrg.12;
        Fri, 22 Apr 2022 09:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tsTMShhOunXxsSfDe94cDR9nLWccacVm3HSfzZBOByg=;
        b=nKvgMY2IWH2PEHEZ+cl7OGmxw5xlhk3x5mrd/sdrjE03WJ0A4/iMINxWKaze7/4z1D
         EaZgcXfpsI07TuM7B7xC1eAjB4SiZR6YP8B5CaRzMStCvqaY2VNc7Otw68D+6PvDTYIb
         SW86CV3hpfJUOYU4waQJ4eOzLLoqdiz/BXlLtY9AstrlCmKu1LxEYJ4mkGe0ezZs+Wih
         AMRs6V6OMn0Jq8aCiE91ildQzfNoAbTBifdfnxJ3CYqmqb8ERjQ/JufqKQJpRCyOw2ih
         +1VAm6TrSldcATLGDX+RMHq5ZAoCbQlRcnvqppWUNLDjsyQtn3QYYfGo+fbx4dMXkLIf
         dWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tsTMShhOunXxsSfDe94cDR9nLWccacVm3HSfzZBOByg=;
        b=v/yMXmQRruIZPwpdLGCh0aeqxfPmVM1NHfeQazEoddEAgmI4rRRY+V/hTUvXsSucBg
         7CwviGNqa7RxBQUn5kLxFy69kWtPtyVUJxf5B9VoNCdEUUcK3/YosQJB0pEbYZyL427f
         kVR+AerdSue9VZal7mUPEzilVxP/20E4J+ar7TnGXsld75r27qA5PFUuB7hd7FXx+Ukl
         uDu0E+8f7DlHrqPGpae4yrqqVPXkKopN12Ds8x7+S1azeRoUcqEJ2V8DXVAm59C8JamE
         uPLPiqKKggYwbwS7ogvRuD729A+E3n/OZAgXrM+Efv/fdEtt2iTeapWnDduxYRkg9Zyc
         oMug==
X-Gm-Message-State: AOAM532fBGFWxXGIMWT88z4XomMjsQejEewnKMFBhwid52wnI/9kn6Bm
        J+FF/N71ok7GaXmT25+3r/I=
X-Google-Smtp-Source: ABdhPJx/muX49NvkIJ81aOJD11FvjLIeaod4BAQfzC8mIBwV/3b+XFa47AyKcGsqSoyl5DnvnisimQ==
X-Received: by 2002:a05:6000:16c1:b0:20a:b1c5:d7db with SMTP id h1-20020a05600016c100b0020ab1c5d7dbmr4457798wrf.64.1650644242311;
        Fri, 22 Apr 2022 09:17:22 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c22d400b0038c8dbdc1a3sm1927029wmg.38.2022.04.22.09.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:17:22 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     hadess@hadess.net
Cc:     hdegoede@redhat.com, dmitry.torokhov@gmail.com,
        rydberg@bitmath.org, lains@riseup.net, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 1/3] Input: goodix - Fix double free on managed resource
Date:   Fri, 22 Apr 2022 18:17:07 +0200
Message-Id: <20220422161709.30198-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the documentation for devm_input_allocate_device():

  Managed input devices do not need to be explicitly unregistered or
  freed as it will be done automatically when owner device unbinds from
  its driver (or binding fails).

However this driver was explicitly freeing the input device.

Remove the calls to input_free_device() to avoid a possible double free
error.

Fixes: 5ede7f0cfb93f ("Input: goodix - add pen support")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/input/touchscreen/goodix.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 752e8ba4fecb..61eb69f3a259 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -308,10 +308,8 @@ static struct input_dev *goodix_create_pen_input(struct goodix_ts_data *ts)
 		return NULL;
 
 	input_alloc_absinfo(input);
-	if (!input->absinfo) {
-		input_free_device(input);
+	if (!input->absinfo)
 		return NULL;
-	}
 
 	input->absinfo[ABS_X] = ts->input_dev->absinfo[ABS_MT_POSITION_X];
 	input->absinfo[ABS_Y] = ts->input_dev->absinfo[ABS_MT_POSITION_Y];
@@ -340,10 +338,8 @@ static struct input_dev *goodix_create_pen_input(struct goodix_ts_data *ts)
 		input->id.product = 0x1001;
 	input->id.version = ts->version;
 
-	if (input_register_device(input) != 0) {
-		input_free_device(input);
+	if (input_register_device(input) != 0)
 		return NULL;
-	}
 
 	return input;
 }
-- 
2.25.1

