Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF374D6401
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349642AbiCKOpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350348AbiCKOof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:44:35 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897C21451DD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:43:30 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id k24so13280058wrd.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dFJ+CZCDxyaZL6W/Y9PfyyEI45qJ81fWzaE92oPrWkQ=;
        b=qhC1b3AG7xUe4mER3/ocnTDCkgiTlqkNOkKb0PCrSErlu0F2OqV/WUuS2SG5oiq6+i
         9cyRxydqKrP/uE2mBg6f9QlBxrJcqIJlWh3d1zLOnTvG3AaQ1vKoSFg6/xE6pO79Xl7i
         tfi57QZEjX4ij17U5xISsBB44vKVYcR25KWyd/b6wA5Lo/cYq8RBWEqxJrZpHHPNSezf
         pT+09nuTl2/5+IBzdCwQIw+mWlMEmSITKA3kCeGlZwVtbb+adLgoeROWUV+P+ZGLANWb
         tb+MqG7L6eavEWmd0csKOzCOcXD3Odqv4qCQd2dd/jdHg3sT3FjEuR+bA9Kz1nESvNzO
         1skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dFJ+CZCDxyaZL6W/Y9PfyyEI45qJ81fWzaE92oPrWkQ=;
        b=WlU2nG5TdCYs2V14BAtwXsDntDMNwNLyNXssBaBTRlnk4OQug9xVkGMAmK+4CYJrSG
         Z1FLUmcjIHW4grjJKgr3unpqR6T5fc/qzQYl0ODLJNPg/hGKy/HcEoFR9gYpb4LjwLws
         DXkaucNoch4by49SFeZr3dASy4ix17sisM0mrgboT20Dj0a1fkkIt48lRPVUbCXSPcS8
         1bQZbkNSFrQ7AGxG+BxtoT7ZnfS66+V+WKulUgxG0A6naU52jpUEsMO+kdaVidufKCm0
         5cKBu+LGbxyekL50O0xgJ4tOaLIshRzJWekQrR6vG4efexiS3mKXAWErnZ+r248rqdZ0
         NmJw==
X-Gm-Message-State: AOAM530bZ0OZQXFlWGFmp1P2FZ/slyUSNr5wlsuXmLA3CpG7nTqnEGT8
        Hlld2azFjo9pIAaLzifIwA==
X-Google-Smtp-Source: ABdhPJyGpeO31IyjnE+UM1X4n1r8VX/rwlB/CwtgDaOd9hGMFvx/Q7uFxzu5ev+HymOdyqQHlXLmUg==
X-Received: by 2002:a05:6000:178c:b0:203:8449:20ea with SMTP id e12-20020a056000178c00b00203844920eamr7592920wrg.460.1647009809156;
        Fri, 11 Mar 2022 06:43:29 -0800 (PST)
Received: from localhost.localdomain ([46.53.250.95])
        by smtp.gmail.com with ESMTPSA id e20-20020adfa454000000b001f01a14dce8sm6877637wra.97.2022.03.11.06.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 06:43:28 -0800 (PST)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, adobriyan@gmail.com
Subject: [PATCH 5/5] x86/unwind/orc: delete dead write in __orc_find()
Date:   Fri, 11 Mar 2022 17:43:12 +0300
Message-Id: <20220311144312.88466-5-adobriyan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220311144312.88466-1-adobriyan@gmail.com>
References: <20220311144312.88466-1-adobriyan@gmail.com>
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

Also move "mid" variable to the innermost scope and delete useless
parenthesis while I'm at it.

Signed-off-by: Alexey Dobriyan (CloudLinux) <adobriyan@gmail.com>
---
 arch/x86/kernel/unwind_orc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 2de3c8c5eba9..d38125ea1bf6 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -35,7 +35,7 @@ static struct orc_entry *__orc_find(int *ip_table, struct orc_entry *u_table,
 {
 	int *first = ip_table;
 	int *last = ip_table + num_entries - 1;
-	int *mid = first, *found = first;
+	int *found = first;
 
 	if (!num_entries)
 		return NULL;
@@ -47,7 +47,7 @@ static struct orc_entry *__orc_find(int *ip_table, struct orc_entry *u_table,
 	 * ignored when they conflict with a real entry.
 	 */
 	while (first <= last) {
-		mid = first + ((last - first) / 2);
+		int *mid = first + (last - first) / 2;
 
 		if (orc_ip(mid) <= ip) {
 			found = mid;
-- 
2.34.1

