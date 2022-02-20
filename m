Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581C04BCFAC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 17:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbiBTQBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 11:01:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiBTQBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 11:01:47 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893F9443C7;
        Sun, 20 Feb 2022 08:01:24 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id e5so14248462lfr.9;
        Sun, 20 Feb 2022 08:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kiCO7Y3o/yfvY4Cex2AEsXYa2jd9fcUopAAuMMIl7X8=;
        b=UYW3P4C6klhBelzEbt4knsukbmG/vQrDalHcSOV/oA0N9z7KGI32MOaQM9QMiZ0y0b
         0qeYVp/Jk640kEgKGDf+ig/zbygc7XKgV9roR+KLswYEb/5tsvPinZmZfipxppUr4WC5
         LR4nrrxzta8WA2/vlM6MEgD5QSFH7uEf7/B8tlAh1IrBxvHQ2UdJ8AxGFv4utxkmJUOH
         istYxxlm1f/h+v24iKa6hGkxxBteB1jMZTr8ZRRc28MitrNyMSza35qZ/XUDNMto4FvY
         NyB7ioIyHTBNIjMZj1qjBF+br9vOdBhSxmG9wXurDHoqJ8o+biWqifbgDGHok/dKvKjv
         wLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kiCO7Y3o/yfvY4Cex2AEsXYa2jd9fcUopAAuMMIl7X8=;
        b=PEcsgbxc1eEKSOgpOPpaNbbeHkAWh2fBpfpALlHOnM/cG4hGTQ7oZ3Gmv697cl2rfC
         n40hlpDHq15v7wnTlUnkAkuZX9a4K4ypayrQ2N+yfI6HXBxhP4apxwr+gQzbOG79SV4Y
         ADDcLbUVfVWbj3D7YXtNaxV5hydQoDRfgZIeuIxgBFsz0tpd2vPEQpeQzMK/GAhobpkx
         HTb71lwTR1GeloHmVZ7tCYqdh4VvhdHJEQWbmPmi0VbZzDGrL6xKHF2f4G66s8NF6xmI
         r06mFs5zYAKD/6RyotdjOB8x5/U9nda3HhiYaufPkIgZMuT8MVpbX+e8M4Bzholsepvr
         19Yw==
X-Gm-Message-State: AOAM531hV0wuZ4TB3C/aAKayxfi0+4/mNTM8CIZSxCm4O6Bh2OGsmM/d
        i4g3fWlBtA4CL1jWwZSdb4I=
X-Google-Smtp-Source: ABdhPJwv9apys1DY/TwkeoLaXGUaOOzCI3U7YhVsxCvO6NPyAfRSsL06C6Isxw3fVxrX6fos67Xeyw==
X-Received: by 2002:a05:6512:390a:b0:43f:62f8:efd5 with SMTP id a10-20020a056512390a00b0043f62f8efd5mr11391942lfu.0.1645372882809;
        Sun, 20 Feb 2022 08:01:22 -0800 (PST)
Received: from localhost.localdomain ([94.103.229.64])
        by smtp.gmail.com with ESMTPSA id y11sm1018835ljj.122.2022.02.20.08.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 08:01:22 -0800 (PST)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        kimi.h.kuparinen@gmail.com
Cc:     linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+35eebd505e97d315d01c@syzkaller.appspotmail.com
Subject: [PATCH] HID: hid-thrustmaster: fix OOB read in thrustmaster_interrupts
Date:   Sun, 20 Feb 2022 19:01:14 +0300
Message-Id: <20220220160114.26882-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reported an slab-out-of-bounds Read in thrustmaster_probe() bug.
The root case is in missing validation check of actual number of endpoints.

Code should not blindly access usb_host_interface::endpoint array, since
it may contain less endpoints than code expects.

Fix it by adding missing validaion check and print an error if
number of endpoints do not match expected number

Fixes: c49c33637802 ("HID: support for initialization of some Thrustmaster wheels")
Reported-and-tested-by: syzbot+35eebd505e97d315d01c@syzkaller.appspotmail.com
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/hid/hid-thrustmaster.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-thrustmaster.c b/drivers/hid/hid-thrustmaster.c
index 03b935ff02d5..9da4240530dd 100644
--- a/drivers/hid/hid-thrustmaster.c
+++ b/drivers/hid/hid-thrustmaster.c
@@ -158,6 +158,12 @@ static void thrustmaster_interrupts(struct hid_device *hdev)
 		return;
 	}
 
+	if (usbif->cur_altsetting->desc.bNumEndpoints < 2) {
+		kfree(send_buf);
+		hid_err(hdev, "Wrong number of endpoints?\n");
+		return;
+	}
+
 	ep = &usbif->cur_altsetting->endpoint[1];
 	b_ep = ep->desc.bEndpointAddress;
 
-- 
2.35.1

