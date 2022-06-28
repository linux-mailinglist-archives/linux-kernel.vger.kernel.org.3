Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0291E55C3A4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245150AbiF1Fpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243496AbiF1Fpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:45:50 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4C31EAC9;
        Mon, 27 Jun 2022 22:45:49 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id v6so8929921qkh.2;
        Mon, 27 Jun 2022 22:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bDB1yQIYsmDWYDrdv3aqDf3xld4an2jBw75K40efpKQ=;
        b=AVlqRKA9fQpKhzMjJ/YjxARfBVbnVtbVvcoyN2TRyUdR+R0UJnLIyM1EvLINj00Iyn
         B19+WAZx1kN4XiJ7ar1vu1h7DM6ZIbx9YdeGbJnda1Y4dgvOb5bZqCr7ULg6c+uckzop
         2pVjy3AWDwVGyjoR5Uv0I4NKugIu+f3JuMzFHn4zFSYaL+m/gQAGiGbx8KuN2B4Aw5nl
         JZKp4HC82Uyqq7CT+b3gSeeXTYUH6f33VsDU8+Ikeu4Ec6/74ZxGZRxldS1mPBi0I7NE
         qseDenQecnLDBKPEOMh6QVK/e7MvdkW7Y8rHJbEjwip4vDa/Jf+rs0ZP/z/kRdWtdaao
         YodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bDB1yQIYsmDWYDrdv3aqDf3xld4an2jBw75K40efpKQ=;
        b=KE7eXWUrFZ8HkE5AYdqgEwsMZokuzKvf16X75kIL36Kk9WFl9VT3aL9mQ2rFi60W40
         M5ZNTbuztTbq1D7hqz7SKW6g0hqPM1ZjYsqzalhqx7RuIsgDN8zr9uCn7PNBXBwIF8lb
         NTQUbmwjEKzm7u8dNO8H3fd7WN+MuzQp4YtdAAQouS5CYD7m3FYBqQwi2crKjdvOhuEj
         k7y3IJ5WbeOUcxbzf7Jb15p1Z3H8rI1OzDlZH81Cf1QEioBxqII91+5Q3nl/3J3Uvgs5
         rJTe05ZLXv8uHYtXpAaQa7pGMImkppe/Q2SouDZm+bRbbEsOEfXGBmsZaa7R19tTveBM
         Bn1w==
X-Gm-Message-State: AJIora9S/Le76p5OiZm3bStE8QF6ysHgn0CcwvnpdtQ7baaCxCJ9jHak
        tAuVqmvwb3k9LlxYzNEKL1U=
X-Google-Smtp-Source: AGRyM1tf5mJP+t3vGwsUjLUnw/w1HOD6eqfpDPcHaSfcs5FbCMA26VN8obCrZ2yZ+lIi9v7qYfZByw==
X-Received: by 2002:a05:620a:4053:b0:6af:2d27:e791 with SMTP id i19-20020a05620a405300b006af2d27e791mr5244735qko.555.1656395148651;
        Mon, 27 Jun 2022 22:45:48 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id x26-20020ae9e91a000000b006a6edbbca84sm9850143qkf.94.2022.06.27.22.45.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2022 22:45:48 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhaohui.shi@horizon.ai, Schspa Shi <schspa@gmail.com>
Subject: [PATCH] watchdog: dw_wdt: Fix buffer overflow when get timeout
Date:   Tue, 28 Jun 2022 13:45:39 +0800
Message-Id: <20220628054539.33187-1-schspa@gmail.com>
X-Mailer: git-send-email 2.29.0
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

The top_val can be obtained from device-tree, if it is not configured
correctly, there will be buffer overflow.

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 drivers/watchdog/dw_wdt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index cd578843277e..1f8605c0d712 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -155,6 +155,9 @@ static unsigned int dw_wdt_get_min_timeout(struct dw_wdt *dw_wdt)
 			break;
 	}
 
+	if (WARN_ON_ONCE(idx == DW_WDT_NUM_TOPS))
+		idx = DW_WDT_NUM_TOPS - 1;
+
 	return dw_wdt->timeouts[idx].sec;
 }
 
@@ -178,6 +181,9 @@ static unsigned int dw_wdt_get_timeout(struct dw_wdt *dw_wdt)
 			break;
 	}
 
+	if (WARN_ON_ONCE(idx == DW_WDT_NUM_TOPS))
+		idx = DW_WDT_NUM_TOPS - 1;
+
 	/*
 	 * In IRQ mode due to the two stages counter, the actual timeout is
 	 * twice greater than the TOP setting.
-- 
2.29.0

