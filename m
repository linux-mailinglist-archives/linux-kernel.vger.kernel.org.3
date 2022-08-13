Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD64591C5B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 20:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbiHMSyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 14:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239651AbiHMSx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 14:53:58 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A321113F0A
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 11:53:57 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id k14so3643088pfh.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 11:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yocom-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=mvPdMDyNKTfqz6k1c2rtPVKLvaBKcrbPWc8BVxjdedY=;
        b=4gkEsyZN39qjg2vrgm0H2K6qZ5jK623yHCU69SSOXOhHjIRl+xvIhLQVZSOoFNNSRx
         EopSx1pg28MtkHxwb0VAcDXN7kVBwsUdOgtrYuUhZoTy9Y4E6s5SeNrADtF/S7XOri/X
         Brn0zk+x4+1XbSEMX5cAj1U+/cpJHc+YR3FGB9N4rdOgD2ai6UnB3PgCq6RFNIP0nf+M
         lm1RiCTJTz+9D3xtg2lesy3yXMyZg8s7P4Fg1+oWGm5D9fQPjBuiEFKxpECJJhDIHlP3
         nU+uZ9Uk8yp/vUDdIWgfwDnFw3PEaxrTprN3B1gTSxd5Ua66SkC9RAgQOsmYHPNrbo7e
         LDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=mvPdMDyNKTfqz6k1c2rtPVKLvaBKcrbPWc8BVxjdedY=;
        b=tFMS8CPzADJPKcAgQd1/6rEtRg7c12ftK5RfSojZzVDtML1Pak0va6YCzrKurW4LHj
         jcg+snvXADQ4/7qDYT7TLF3XEX3pzdBs4wEvn7ysXtfeuS8rb34coyVJU+PnYRsg0SSM
         9RnbrkvXVABIJ8JRvQ/V5E8BC2L1yqCg2oXkq2Ee8PvQyjbYBhSaNHzpfOyZuXApIr8v
         aN6CBgn9VU7Xxga6z+102zjLa13IUri9qz1tizQeDY3a3lfyPOmB1MyYpxAdEQ9Hy30r
         eS1MOnH77h3N4Go7S2n5YIAaPGk6c34jxQrQ9TKdDQw0iVK6ZjWWR756vBIddNT2npUP
         Hgsw==
X-Gm-Message-State: ACgBeo02YuEp4q7IYdMv+FkF4KuZqnC9fUj2KFaf3ta+a2TM7ZRPvYH7
        kjI/Ox779wwDXle9+BKDxH9keMqLsBwzKg==
X-Google-Smtp-Source: AA6agR5FesUCLXoh+wZtTxjFXqThlCxwVdvfpdB8EAAIMN2BxaofqW0OwwQD2aRAvbgsQeN4kpV1IQ==
X-Received: by 2002:a05:6a00:2352:b0:52e:f0bd:981e with SMTP id j18-20020a056a00235200b0052ef0bd981emr8937778pfj.28.1660416837082;
        Sat, 13 Aug 2022 11:53:57 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:a07f:e6ac::1c])
        by smtp.gmail.com with ESMTPSA id fs1-20020a17090af28100b001f246f2a423sm1972183pjb.17.2022.08.13.11.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 11:53:56 -0700 (PDT)
From:   Nate Yocom <nate@yocom.org>
To:     dmitry.torokhov@gmail.com
Cc:     nate@yocom.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, hadess@hadess.net
Subject: [PATCH v3 3/3] Input: joystick: xpad: Add X-Box Adaptive Controller XBox button
Date:   Sat, 13 Aug 2022 11:53:43 -0700
Message-Id: <20220813185343.2306-4-nate@yocom.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220813185343.2306-1-nate@yocom.org>
References: <20220813185343.2306-1-nate@yocom.org>
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
---
 drivers/input/joystick/xpad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 83a4f4d07af5..bea71721b6cd 100644
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

