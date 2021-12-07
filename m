Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B0146C6A1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241807AbhLGVZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbhLGVZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:25:57 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A5CC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 13:22:26 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id np3so419534pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 13:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ju5q/8LdtV/d6IPSSjw+nF8L2cah7GfwEe7IizH6nS4=;
        b=O/caTuT/x4AJZXSEVDeoxnH+Zkkd8t5p1pMhH3V1MxoQrbSTXpVz//hXL6nKExvwyN
         HxhqTCpEtUZ/pA/rCNt2cErq7+5mDf6OUNJgrH7ka60/MXDu588FjRQ/I5ZIdqyJqgK/
         +Rc0sAxigHplMeiPhHG0fOe3Dl1/3VYn/aqKDnsZydu07AxikewwFwJs+06hYhsgCGA8
         8ONKLhJViZkNJGx//Y+wVhsq4aq9nep9LXvqBQZbE/OVyMnGhpWp9ear/9byEyqfduUt
         inMTECmsNO0H4vv66KXHjMEl3FPZERX6PYk9FhHVusUWWgEgUFO9j8K58qKb9R8Zc1LM
         OqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ju5q/8LdtV/d6IPSSjw+nF8L2cah7GfwEe7IizH6nS4=;
        b=v0QWnn1kuGwKEtbJUhitli9Kmojh0xx/Nntk5pkVCl2RdmlH9FUTK1wV9npOqPXXW4
         QzdJnCRCvuN3ks9oBmz/pui7kCjYv+N1wHXXz/4dKBh279AKTxZCq/eGcaY2+L/u8mv4
         cGoQCeC0brNCfTCnaNpcoxrNqObEetddeq/8zTN0m6xIft6uRuHbUO2aObU51UOWYiwV
         KgNKVfTw5Sy5ijinK7MpXyfbh8fGNxFrkuTvNVJUk056MGpyAg5lnyO2L5r6lQUSHR1t
         ptk6y+TWyrPtfxc7Syq1J6grCTv59ncDDuS3WQIJ9vNnL76UKEJ1Q6iEkKZaT3YWVZXn
         px+g==
X-Gm-Message-State: AOAM532+4KHjvPmeTlp//Cbnk61TuEyNCrOsps5YsqJrMf4LhZ3s7t+H
        YGKl4c9doHdMlpVqYTTv/fI=
X-Google-Smtp-Source: ABdhPJwLkQCaWF8wwFDCO+7EEp9cQjbVj8dWmjPzDL1UCjffJYDVTNzdB1rirFX0hfnZHtWBKVcWZg==
X-Received: by 2002:a17:90a:c58f:: with SMTP id l15mr2088266pjt.75.1638912146573;
        Tue, 07 Dec 2021 13:22:26 -0800 (PST)
Received: from simon-desktop (n112119139022.netvigator.com. [112.119.139.22])
        by smtp.gmail.com with ESMTPSA id p16sm698712pfh.97.2021.12.07.13.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 13:22:26 -0800 (PST)
Date:   Wed, 8 Dec 2021 05:22:23 +0800
From:   Ngo Tak Fong <simon.fodin@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8712: Fix alignment checks with flipped
 condition
Message-ID: <20211207212223.GA70594@simon-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed two CHECKs of Alignment should match open parenthesis and flipped
a condition to pull the code in one tab.

Signed-off-by: Ngo Tak Fong <simon.fodin@gmail.com>
---
Changes in v2:
  - flipped a condition to pull the code in one tab.
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
2.32.0

