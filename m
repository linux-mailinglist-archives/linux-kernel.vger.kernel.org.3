Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F754BCF90
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242388AbiBTPtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:49:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbiBTPt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:49:28 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D495C532D0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:49:06 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qx21so26875756ejb.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0LzislRsRPF3CyBdUmLIeLjcZ+WoLwAHUia8Yqa/r/Y=;
        b=ha2FxVA0CtY8C335/jYpTtab94I/NRB2Yqb/JJbP0d2h/g9iGmnwOCu++Tavz5zs2w
         JqQGVBD3pfViPN84daHU4fJZapDw3N0GAZNgHt7N88C1Dc5kAhTtGIpZbDM6dY3t87sH
         I29TcN8zqeLJM1Ia0lRZF1+q9qqBij5nwqL//tLuYqJU4BTl7VXxGd7twjUpjVbRczlr
         iPNrsJkHpR0AS2yTJO+nomj/brlQQrJmq2dLSh32tfVGBOuEOW4tEtVWUgJjaAmHk5Aq
         Fj7icxH8+2e7Yy+iIOzoUQkt+nIswofz916in6foReEN9J1pLe42dgIND8xaO7qrxtj4
         ZlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0LzislRsRPF3CyBdUmLIeLjcZ+WoLwAHUia8Yqa/r/Y=;
        b=YBzoEQnzWelmYIk3VzXWgc6lEp9lzhdn9MGEGtl5y4FNVEi4uHbm079pKlz6+LjyJd
         /u8EfKwGTBEPdP+9Mbe5rH3MXLnZvIFUW+YoZ+seShedbVoNLeYa17lqeFkrZ7reusxm
         p2ZQ0NismLOe/wW7NHdr/S/ceHiw2zSF4+KhiIpKWcLRI556LBRMJAoHhser3AYo1mPF
         lR94MtYBDPOkHpzDICqu3WMFHTAq+AFALrTXukx2K/N4YZoYi0euCgz2y2IKZb55p6ra
         YtOcPLSoQjlD19atJrc2ZiiLD+q+SWr2YvXCTzeDImWqvVPRETX164pEXDGLYhfQ8+PZ
         lZbw==
X-Gm-Message-State: AOAM530uso7rmpmqhpnApAwEy6QyN2rHbkD8jL3ZpJUihGkN6t0MAHwB
        c3EAsqyQvQJyEGi4G61gfKU=
X-Google-Smtp-Source: ABdhPJwZykj1EHixwqFV4XcWPVOX4bsIPTaOFEh54CJYyRq5L+ohYrYHChEMs7+jKAhm4XTIzhNA4Q==
X-Received: by 2002:a17:906:39c7:b0:6b5:1c00:f6a0 with SMTP id i7-20020a17090639c700b006b51c00f6a0mr12889792eje.631.1645372145481;
        Sun, 20 Feb 2022 07:49:05 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id ew6sm4178979ejc.217.2022.02.20.07.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 07:49:05 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: r8188eu: clean up rtw_rf.c
Date:   Sun, 20 Feb 2022 16:48:47 +0100
Message-Id: <20220220154847.7521-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220154847.7521-1-straube.linux@gmail.com>
References: <20220220154847.7521-1-straube.linux@gmail.com>
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
 drivers/staging/r8188eu/core/rtw_rf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_rf.c b/drivers/staging/r8188eu/core/rtw_rf.c
index 945a40e6511a..ac1c06a60735 100644
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

