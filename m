Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5430479C92
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 21:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbhLRUaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 15:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhLRUaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 15:30:21 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160A8C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 12:30:21 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x15so21707161edv.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 12:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZUNrx9kbSPTQRQvxe26IZvVu40WIMjlDMxWcOQUeOik=;
        b=qSru67JuO9ntAk2o23RoIzyKPCjffhWevDxX9+aI6nwR6ByItmf8GLwydlOeHbxOva
         mKD1JqMG+dDnDAfNfBRQblmgf3Uabz0T78GCnUj3x/AqezfiyYNQrUhSIRH2ffxvj7uP
         boq73TPkHMK+QZClBJn6hj8D2xjaE0B3eztRADzGjKv1cKFIr5fR38z6nWMmMCU57Bie
         uABpSNFD1ATTGAYr3IGtN7d2WakNQj0fGTbrt7tIcPay3JWQ9HCYX5N/6tfr5SI75LQA
         hfbXadF4m0fjaewOi9PzqonTzPY76it0vQRP8ococIDqMzPcr3BFyEXRnGJmX6pIhTYH
         26Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZUNrx9kbSPTQRQvxe26IZvVu40WIMjlDMxWcOQUeOik=;
        b=wmmZd4p5H2hxnmx2S18NwKoiA4Tn0yKZ8+7S3NOn/CKnUaVZ3wW2Jf/k23Wfoldnye
         ZqV4DE/MXi+Uo0TrcW7VuE0EZdhqkx0hLw+mAx8D5+jcXh2EQpE7Q+sk6G8SW99aY5ps
         UNTiFa0DFFJDH9BH5QSsFjef0FiNkoJ+u2tLhjL9+W1KqsrzxiHXiVPTin0SuPJ+RjzK
         Q/NVuecuwkkM4eNUt9s5QdCc5g+j9//XGpnO/hk6VFPb2F+tqC6xG7AmwUy8woQzzTBo
         lkY6cacJQy3IHbutfPf08KF9wLkqnhoR9dtP9s2jzUjOCFMwIznZj63cHLRT0n33RImG
         gq+Q==
X-Gm-Message-State: AOAM532pBnDDZpZddRnDgKJUoj2PSSqPNoBnvf8ckoj7CWAXFlQRNQ2K
        KUisIUdZ9mzx041uh+SrlTY=
X-Google-Smtp-Source: ABdhPJxYODaISvA06/Ql9Wg54CI5/nOsy1sLBpyfQFlTelajEOeo33tx9RdLLks0QjOKVO2Nse2INQ==
X-Received: by 2002:a17:906:5501:: with SMTP id r1mr7246723ejp.212.1639859419617;
        Sat, 18 Dec 2021 12:30:19 -0800 (PST)
Received: from Snowflake.localdomain ([83.143.250.232])
        by smtp.gmail.com with ESMTPSA id i6sm1976582edx.46.2021.12.18.12.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 12:30:19 -0800 (PST)
From:   Ismayil Mirzali <ismayilmirzeli@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, simon.fodin@gmail.com,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] staging: rtl8712: Fix alignment checks with flipped condition
Date:   Sat, 18 Dec 2021 22:28:47 +0200
Message-Id: <20211218202847.23086-1-ismayilmirzeli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ngo Tak Fong <simon.fodin@gmail.com>

Fixed two CHECKs of Alignment should match open parenthesis and flipped
a condition to pull the code in one tab.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ngo Tak Fong <simon.fodin@gmail.com>
Link: https://lore.kernel.org/r/20211207212223.GA70594@simon-desktop
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtl8712/rtl8712_efuse.c | 28 ++++++++++++-------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_efuse.c b/drivers/staging/rtl8712/rtl8712_efuse.c
index 4f3b54a7c3be..c9400e40a1d6 100644
--- a/drivers/staging/rtl8712/rtl8712_efuse.c
+++ b/drivers/staging/rtl8712/rtl8712_efuse.c
@@ -298,25 +298,23 @@ static u8 fix_header(struct _adapter *adapter, u8 header, u16 header_addr)
 			continue;
 		}
 		for (i = 0; i < PGPKG_MAX_WORDS; i++) {
-			if (BIT(i) & word_en) {
-				if (BIT(i) & pkt.word_en) {
-					if (efuse_one_byte_read(
-							adapter, addr,
+			if (!(BIT(i) & word_en))
+				continue;
+			if (BIT(i) & pkt.word_en) {
+				if (efuse_one_byte_read(adapter,
+							addr,
 							&value))
-						pkt.data[i * 2] = value;
-					else
-						return false;
-					if (efuse_one_byte_read(
-							adapter,
+					pkt.data[i * 2] = value;
+				else
+					return false;
+				if (efuse_one_byte_read(adapter,
 							addr + 1,
 							&value))
-						pkt.data[i * 2 + 1] =
-							value;
-					else
-						return false;
-				}
-				addr += 2;
+					pkt.data[i * 2 + 1] = value;
+				else
+					return false;
 			}
+			addr += 2;
 		}
 	}
 	if (addr != header_addr)
-- 
2.25.1

