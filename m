Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CDF4BF3A2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiBVI3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiBVI3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:29:25 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F3C157226
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:29:00 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a23so40363487eju.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J4YfQybsK+XfBBKMof2I6wzbyQxle5AmeBoOukDBvsE=;
        b=PC9HeviVJ9bQZnx0cbe2TiMsc5Rrn4zqRnAIQngqMUsOaJ5r13jAxh6bmWwwk5/61T
         4qA9VlvySrUgbUttIEmpCJG3op/YHzagejyfu51VDgsZbEOq93q0gsu0M+NnYa0qvkaX
         53CnWroqu7cy9J6MyqgKkcrEHZdAL5KvXqE5QhP7hcJvshx+cMjfEa0FZt5nx8dScJ/Q
         2H5R0yLwL2abEMhsmyXMEgngaNtL3R2pUCy75Py6nksvUEQDcXedlHkXTd2sgv1/Tfsd
         RpWYmxpl1YXzYQZw+T7Fqm/p5lKyx1kbVgF65vos+xVZFv3Rr99aGYHTS7z3jc0iBQIT
         xqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4YfQybsK+XfBBKMof2I6wzbyQxle5AmeBoOukDBvsE=;
        b=dMsTq6ZsAOYxo0Kc8hAp2DQHLSRglKqVJOHj3uRyfLry+DO0SrHE5VqjTZ2N4PUEe+
         qjDN5hq6W0y1RjQ91RBH+M1nyrkh6pZZIOFIqVZ7sQCcGnuKahdVbrf+4D47L2TYusD4
         TR3NyfpVNc/xTrFs7fBFu0M4qYqaGqiRm8KiYt9yWMHyKMoc68UB9Z/Hfw3CFT8EXpR1
         LH03DIJBkC99tLbVjTUV+3iFLt5SjWtK6WTnxMKr2QVvCmeyP/XL2UtvMOiSRCcgSwLb
         kGEYf/uLVWl95Dq0UnjpWLXo6mw4pllv2+nlpuJnOvIe5oJSfkyTik0u97vcSUw0IxzU
         N/EQ==
X-Gm-Message-State: AOAM531LwuFztmn/QRXIVVnt+NOfegXgz3oIQEks4PK1oE8RusiwX14J
        lZyiYUUXck9eTbfQ4J+K8o8=
X-Google-Smtp-Source: ABdhPJxoHl1uKaghZMUCYpBJ/nzr1+Srdcw1R2PqegQppU8mvJhAqbR24+PJ+ni/HgCKkTanG66ILQ==
X-Received: by 2002:a17:907:366:b0:6ba:fff6:4fc7 with SMTP id rs6-20020a170907036600b006bafff64fc7mr18310266ejb.756.1645518539303;
        Tue, 22 Feb 2022 00:28:59 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id v12sm9831926edr.8.2022.02.22.00.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 00:28:58 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 3/3] staging: r8188eu: clean up rtw_rf.c
Date:   Tue, 22 Feb 2022 09:28:47 +0100
Message-Id: <20220222082847.6687-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222082847.6687-1-straube.linux@gmail.com>
References: <20220222082847.6687-1-straube.linux@gmail.com>
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

Remove unnecessary includes and the unused define _RTW_RF_C_ from
rtw_rf.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2:
No changes.

 drivers/staging/r8188eu/core/rtw_rf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_rf.c b/drivers/staging/r8188eu/core/rtw_rf.c
index 68178699a0c6..2d2f0fc4c942 100644
--- a/drivers/staging/r8188eu/core/rtw_rf.c
+++ b/drivers/staging/r8188eu/core/rtw_rf.c
@@ -1,12 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
-#define _RTW_RF_C_
-
-#include "../include/osdep_service.h"
 #include "../include/drv_types.h"
-#include "../include/recv_osdep.h"
-#include "../include/xmit_osdep.h"
 
 static const u32 ch_freq_map[] = {
 	2412,
-- 
2.35.1

