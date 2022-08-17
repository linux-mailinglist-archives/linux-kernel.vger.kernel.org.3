Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F6759755F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 19:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240783AbiHQRvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 13:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238326AbiHQRvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:51:42 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A3596FED
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:51:41 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o14-20020a17090a0a0e00b001fabfd3369cso1297283pjo.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yocom-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Wm0tHJqofpxXwdDseHL/uJ/+OrgW8gnJ90ltIhdcZZ0=;
        b=RWQZoIk7J8VvXclA1u1mR1aNYk0pV40udcWTXfL+88lFOmAsZcVOO2nDhTc/1h7dIy
         M5gb7K+jQ80pdHhsaxS52T04c9wN5cOSWNu7J6BQqpsWJzav+Zeg4F9fzWL63p0Tv02D
         XCFJF4NBZnPgplNiBMQx19sDsa54kJUV2e3Xw8IWgq4RKPQOWLE6v4N6Qbqb5AFT2zje
         Se+vQMtcMPYT7Z5gqTnDPPMS7USyxh3XR4MzMvCSzzScHtAs7HUwEyhrSdIim8LQvRak
         9LliQnQ2tLI+tLZg39yFFNwsTmpcHpz6NfzztyVCRLZNtrL9L1S9rZV/z/TPrlkmlQJT
         SLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Wm0tHJqofpxXwdDseHL/uJ/+OrgW8gnJ90ltIhdcZZ0=;
        b=Of2L9B0sw/t2ekd58lb63kCqKKERHuanRB7zTs3pyu8tyc5GTi+MgCO83BeiGz9YQ8
         Yqjms6zLpVxoLmKhCQPmWrQqcq4rsPuTCHsW0iLHuWI0DNFYF3catzRoNWEGUdDpN+oL
         u9fwrf+ZPmV2osOXSqfOGv3cglkelvIN7wWS4T7qr9vmTwiEDEOA9clDYIqDSkhGW9UX
         jYOlTbVRHSph1mw6DSlRNhV4WRiogegmfVfHJO3zaPuiSX0NRsn1OyLFEPWyLvqFM0ei
         Y43K2tTWJemAhVAZgRjAD+4iiSMUFmCDf4OHIYMWf6X80L9KNKnIxxIT3U/3XKHmAG7p
         UFaQ==
X-Gm-Message-State: ACgBeo2LFxU63iPXgiqjWleZM/a60wyB8E23/QjtUktaVpQetJxAu01p
        IqMxVCHitxIEmgB0RAP93Twr7+PM/CdUFAU8
X-Google-Smtp-Source: AA6agR63v1wAt+8uIVJ71lOT9FWq5Tr4DTfCyM176tZv1KzizQ6Zb+GE2LCVdurejoOxm6ddtV/LKw==
X-Received: by 2002:a17:902:8d8a:b0:16f:21fb:b97a with SMTP id v10-20020a1709028d8a00b0016f21fbb97amr27396985plo.160.1660758700773;
        Wed, 17 Aug 2022 10:51:40 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:8f80:973::5f])
        by smtp.gmail.com with ESMTPSA id z29-20020aa7991d000000b0052f0a616a87sm10734127pff.168.2022.08.17.10.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 10:51:40 -0700 (PDT)
From:   Nate Yocom <nate@yocom.org>
To:     dmitry.torokhov@gmail.com
Cc:     nate@yocom.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, hadess@hadess.net
Subject: [PATCH v4 3/3] Input: joystick: xpad: Add X-Box Adaptive Controller XBox button
Date:   Wed, 17 Aug 2022 10:51:34 -0700
Message-Id: <20220817175134.15084-4-nate@yocom.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817175134.15084-1-nate@yocom.org>
References: <20220817175134.15084-1-nate@yocom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adaptive controller sets 0x02 bit for this button, all others set 0x01
so presence of either is used for BTN_MODE.

Signed-off-by: Nate Yocom <nate@yocom.org>
Tested-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/input/joystick/xpad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 561e097396fb..f65e8b1d46e2 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -859,7 +859,7 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 		if (data[1] == 0x30)
 			xpadone_ack_mode_report(xpad, data[2]);
 
-		input_report_key(dev, BTN_MODE, data[4] & 0x01);
+		input_report_key(dev, BTN_MODE, data[4] & 0x03);
 		input_sync(dev);
 		return;
 	}
-- 
2.30.2

