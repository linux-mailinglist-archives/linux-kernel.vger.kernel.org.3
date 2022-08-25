Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215D05A1C41
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244416AbiHYWY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244356AbiHYWYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:24:40 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD6BC5795
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:24:39 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x19so38011plc.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yocom-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=AMvwQEDYyViZsL8j6NoVlVoUIIpz5J/YqO+FfmJYCms=;
        b=ToRlzjgTCDM5+dvAPgiCxfDNVf5k8nwWj4Dn7+hOfXzRlzCJyKd3pYcEuYXdQVMx18
         O/jwYLfAM4VximZtvVj5YWpB1p/R4Sp1ICF/sLljblO/ZupgFVu/F2KF5hDnrv+Q3E9a
         uvt2VojDxzwqS8ym/wHvaEnluwuVv9p5sfQWgJ11VXUfkEFNtni2ZTmW8VVwp/pQEYEb
         Bj6zzieMLhkEoE2JvHpFYWQouAPTcT776uL2ylVmNhuqXcw6a4fnjK24hb4LYFI4RyEz
         qcJEtq6cCKXxO6Sueus/Sh7gPA1GOr2Lx7WTEonZJcszUBpH15q3V8QWANNRe9eq5Qey
         lOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=AMvwQEDYyViZsL8j6NoVlVoUIIpz5J/YqO+FfmJYCms=;
        b=AXO//OBsL9GxRNOy6hfetTkZhylfuFf+pA8tHqqKRqRbokel8BMHKwmF0yac5Mo0xO
         j84Z0oAWSADxPqqRUS4/am2qgpz0F0maUt23afLhdBY2yY3SljV9KsrgloagRM99Ye4v
         +VvkvgiRybAAsTZWe+pQXD4nC1s3HPNlhtH8iJGNBuwg5I4adCFMmz9KT0DQCFkJgzj3
         xrCPKprTqS9HtACTfBm4IZNGz8U13ciBdTAixXATaVyHuJ+bu350gL6DpnyuUy0clIfl
         M55pj14GrNU4R2lK4HvZ/muVwdwTIQWKRi24FLL+KzmMz38Xjwp0tiW6zKVrZQI89Ckn
         QGNw==
X-Gm-Message-State: ACgBeo2L2i5k/KgDCfXdtGxDSMBHWWEBhPZd0/i9w6NLdmhdL2dnvfdZ
        GDCpVD0fpAyL1N2TJ6LmcZyZww==
X-Google-Smtp-Source: AA6agR6mEn+GnBN38cs7xJtLdYSoxtp7xXPbZgg/NqzoRDV+mtg8TO7vG0Gxsd9LMa39Jrs/8Z2PNA==
X-Received: by 2002:a17:902:da8f:b0:16f:e43:efda with SMTP id j15-20020a170902da8f00b0016f0e43efdamr1007466plx.164.1661466279510;
        Thu, 25 Aug 2022 15:24:39 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:8f80:973::5f])
        by smtp.gmail.com with ESMTPSA id e23-20020a63db17000000b00429b6e6c539sm81820pgg.61.2022.08.25.15.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 15:24:39 -0700 (PDT)
From:   Nate Yocom <nate@yocom.org>
To:     dmitry.torokhov@gmail.com
Cc:     nate@yocom.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, hadess@hadess.net,
        benjamin.tissoires@redhat.com
Subject: [PATCH v5 4/4] Input: joystick: xpad: Add X-Box Adaptive Controller XBox button
Date:   Thu, 25 Aug 2022 15:24:20 -0700
Message-Id: <20220825222420.6833-5-nate@yocom.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825222420.6833-1-nate@yocom.org>
References: <20220825222420.6833-1-nate@yocom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 9557e4768f14..ece38f00dfff 100644
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

