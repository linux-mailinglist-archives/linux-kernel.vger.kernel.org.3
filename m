Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D28350BCBE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379973AbiDVQUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378340AbiDVQUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:20:23 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B8D5DE60;
        Fri, 22 Apr 2022 09:17:29 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 17-20020a05600c021100b00393a19f8f98so2631510wmi.4;
        Fri, 22 Apr 2022 09:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rIncxmhDUFubuTPIbfUUmhnyD3x3kFknV3aR1PwAHSU=;
        b=quLHBak67ilJ7XMk5cWh59WRxF7B6IHMYoaeosRq419Hmg1wM8lhRiwbfpOVrbNYn0
         WMiZVqrmL8JCp034/D4u5h7itqTpq0O4jXNIdvsTFMbyOtwHh4lYHysD866BVOkLQ5La
         17cwTCAS0a+ifbRTJrZnJi2TtYjBCXluT8noIq65EDNP302VMEHrYyaDNy7iPltS3C0h
         QYNRlQKMAtzMPfFSW+nSUN85N9Kw4j2ZxezhZyV11lMxgWoCm43IPGBT7ItE409Sj4vu
         aYhAWHrVL7/bzht5d/TY0KaOk4EPEtGuEBwfy6RafkhzBmxZxXLzCcSZMbhMAoTzf81O
         u6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rIncxmhDUFubuTPIbfUUmhnyD3x3kFknV3aR1PwAHSU=;
        b=GGzAwcTyLWQaN3PM6ThV9gYlgx0GlbgiBbl+pZDmoyZXY+6lXrs53KP7RrVjQEoyCM
         CAmwVTzSSQFgJcAHALCJSv8xqK17fGElW+duCHqZtWII0LQ2iqvznx+cLf+a+zJb4Non
         UoxY01iZYfU5X5kvDxd5EWBtpeYb/K1iU0jz4VY0dXEZci7STcDUcWL1PJLbhlSfxrj5
         yjUaUzDrSQfKx5u2gVjaqoq2a9qeNCpDuDqFEAuRXke9qHF017zUqClVsTgLKonhqkVh
         tFzZ3rwUxeRsYDsnqHfqlQr0YjtzOxNhCahOEb4Yv17SoqCURhCystGLsS4mWVSnod6o
         g5Iw==
X-Gm-Message-State: AOAM533PkkFsOJoHFRshNL3aEV43t/HTzlMOy8akspaUEreoByeMl5hH
        ZLq1PF2ztQo0rxJ7LTCZ3qdDNgwF7exqCA==
X-Google-Smtp-Source: ABdhPJy7KeEOprOPRKSsTs4cY5EYO9wXLB8zfkM0gOMvToggZOXNlBAOI4qobW464wC53PUnuMbrgA==
X-Received: by 2002:a05:600c:350f:b0:392:90d0:6b12 with SMTP id h15-20020a05600c350f00b0039290d06b12mr4851402wmq.180.1650644247720;
        Fri, 22 Apr 2022 09:17:27 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c22d400b0038c8dbdc1a3sm1927029wmg.38.2022.04.22.09.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:17:27 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     hadess@hadess.net
Cc:     hdegoede@redhat.com, dmitry.torokhov@gmail.com,
        rydberg@bitmath.org, lains@riseup.net, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 2/3] HID: logitech-hidpp: Fix double free on managed resource
Date:   Fri, 22 Apr 2022 18:17:08 +0200
Message-Id: <20220422161709.30198-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422161709.30198-1-jose.exposito89@gmail.com>
References: <20220422161709.30198-1-jose.exposito89@gmail.com>
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

However this driver was explicitly freeing the input device, allocated
using devm_input_allocate_device() through hidpp_allocate_input().

Remove the call to input_free_device() to avoid a possible double free
error.

Fixes: c39e3d5fc9dd3 ("HID: logitech-hidpp: late bind the input device on wireless connection")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 81de88ab2ecc..9c00a781ab57 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3957,11 +3957,7 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	}
 
 	hidpp_populate_input(hidpp, input);
-
-	ret = input_register_device(input);
-	if (ret)
-		input_free_device(input);
-
+	input_register_device(input);
 	hidpp->delayed_input = input;
 }
 
-- 
2.25.1

