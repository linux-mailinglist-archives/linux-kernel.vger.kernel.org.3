Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945BE4656F0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245502AbhLAUTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245388AbhLAURe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:17:34 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2F0C061757
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 12:14:03 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id m12so12336946ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 12:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cm/LOgLyBHKAfjqechOv4aUVLu/lBrZhgrgfeAG5yYo=;
        b=fwEyewYur5etSp2FpL23q166Zxo/52wGLeItiLpnYKKIEI858vqpTANucPYAH3vXMn
         F2EJNFiqfRkM/cBZpB73BNMWsNecOfeKKv6xpobMrWm03XeDZ/drZzf2cxE/xzXNT2v3
         2xjvFop0AVhHAF8nkpPjaB1M/HeMkVxdkzQguOtyqaTl0VL4AkDfyH5U/UMOINph9A2a
         +Z04PdnBMK2KObVwXh2lH0bgw8ttHbddrFTRhroCovx5ZaPuEdNnnLetAm0zjuJlRhUC
         EPh1PjcCJw1NBjU8coV44cNv39c/YMeYTihhuUDhfwGuF+Tsghs4DIltrdiuiuZOBZzd
         MzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cm/LOgLyBHKAfjqechOv4aUVLu/lBrZhgrgfeAG5yYo=;
        b=7AvQJQaVijN/pXqk8I+Cwr3flV7peBeciJf6YKkopnt3J5n2duuHgXWkV0hT/5VdWL
         zidC2Wc9530CtcDOTsy5nkSPhOSskVqQXApi0w1kcbRC+h5A1pF8QLu7vVYvDzZf3fJ6
         bV627hsFEDYHlxOKhTFNIoXpvDy/oiY2OQfqYEq7P9NFacoI1JBrFpHxHL0vqSqD0bvi
         gSdr3DYA5zvyIYbE22tr1L5e6Ga6FdZSz+CP7UzN5bGEjSGTcwE400U71sYrG7qpqxTz
         G88rCGj3AA/fP1nsNsNvtfrgM/DV9nC85t+wC5EGEQsNRIzV3IFDI0Tut75oTIyp6tnC
         asHA==
X-Gm-Message-State: AOAM532RJogdoLt/pH3hjoKWWeNAfhvQ2yvvtWIbDfFoRGxln9eD26A9
        MIhJrGaD0dyHw3Os87DcMQRH
X-Google-Smtp-Source: ABdhPJwh7kUWJI3j+dt7aVBYHbMLal6jtWKJqNYOZ4M5lBHwJFT3jmirtgmKTGx4fzYCylglSD3stA==
X-Received: by 2002:a2e:3e17:: with SMTP id l23mr7025336lja.380.1638389642146;
        Wed, 01 Dec 2021 12:14:02 -0800 (PST)
Received: from localhost.localdomain (public-gprs378549.centertel.pl. [37.47.109.246])
        by smtp.gmail.com with ESMTPSA id i3sm86821lfu.156.2021.12.01.12.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:14:01 -0800 (PST)
From:   Lukasz Bartosik <lb@semihalf.com>
X-Google-Original-From: Lukasz Bartosik <lukasz.bartosik@semihalf.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Subject: [PATCH v2] Bluetooth: btmtksdio: enable msft opcode
Date:   Wed,  1 Dec 2021 21:13:51 +0100
Message-Id: <20211201201351.2552-1-lukasz.bartosik@semihalf.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Łukasz Bartosik <lb@semihalf.com>

Enable msft opcode for mt7921 chip.

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 drivers/bluetooth/btmtksdio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 9bf5e70f47ad..6a7ba67a2dd1 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -787,6 +787,8 @@ static int mt79xx_setup(struct hci_dev *hdev, const char *fwname)
 		return err;
 	}
 
+	hci_set_msft_opcode(hdev, 0xFD30);
+
 	return err;
 }
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

