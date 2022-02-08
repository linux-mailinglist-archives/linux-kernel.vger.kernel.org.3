Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CE54AE492
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388670AbiBHWdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386257AbiBHTym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:54:42 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D57C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:54:40 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id x52-20020a05683040b400b0059ea92202daso19072ott.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 11:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zuxBOxSXx7d4b4cX2jnWBhyNkXcf+aRokxgpIzaMMY4=;
        b=CKfBmmYn6zVLOBAXCzB4HbpOqT28Iz0wtkN2m8QBkqb4RPqsKjrXwnGt3ZJbnD3SDW
         GOmAqhYcOClgVzKKvHk1hfJBMMVBg5OLoWTgwW8gllUxdz4CQT3eJBo7x3Bnl0Micb6U
         Dn2z5sbZjVYesizs8uldTX3MtZaKwJDa0nKmPuUgMgK+Zpxuj6i/f4oGAXsJ+uZtOP4E
         sDhhE8pavmiaz33Bz3nPq+XmDYGcQ/gD5PJ/txpnzxIUNNJG2ujd3C3uY0o5FX4T3Tiq
         LC/tnfSJdgO4AawFjRZ3ZWCZat/elQt0le+nAd5DL9JdPsOcvHHnwhpEBURkGThuL/Zs
         yexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zuxBOxSXx7d4b4cX2jnWBhyNkXcf+aRokxgpIzaMMY4=;
        b=tUwsH/eioCN0qLKc3yPw3C9Sm5H54WrHf0eTiWGykyYxkyhNDrByEIskCeysyXpGZc
         9fBFSAEINnKSlP9fsTc4t+IcD3t3zZc3++uMmAyFDdC8MsKbImHagwrfywxf8HpmqMoA
         rOpMQHtxs7Cai/ln8pdZWFlvdzYK8VZ+LFGpaMtXMvcdSSceg8jrIN/I3ermoVHSFar5
         OUgKq7fb0JMg3EZtFVIC6HITN1uMpbb7S40ZpkzFxNsVeQ8kUqcjYopkIkq2sYBWcMmu
         7JqddWA61JKmICDC+hVcUDz9R5QPs4jfh9y0J2lDWxMAaJQsLcOPcJZPGLpknMOsU7uO
         Epbw==
X-Gm-Message-State: AOAM530U5emdjwesC65cfxbvo8vtDXrfjWqBwBlhkYpsaCY2iOqNPXD/
        u9zdVP6tBkixfQl5udxmWsnCLuBqUldPQx7v
X-Google-Smtp-Source: ABdhPJzDFsOkiI+GltX2s6MP2uANOLhlNipg9bTK+D1nKUInvxZkn6mZe1NF/PqswBq8Hlj7Jz0IZg==
X-Received: by 2002:a9d:609a:: with SMTP id m26mr2493399otj.223.1644350079668;
        Tue, 08 Feb 2022 11:54:39 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4cd8:12bf:fde8:3cda:d976:7f4e])
        by smtp.gmail.com with ESMTPSA id 8sm3468204oav.28.2022.02.08.11.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:54:39 -0800 (PST)
From:   Leonardo Araujo <leonardo.aa88@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Leonardo Araujo <leonardo.aa88@gmail.com>
Subject: [PATCH] Staging: r8188eu: core: do not use assignment in if condition
Date:   Tue,  8 Feb 2022 16:54:25 -0300
Message-Id: <20220208195425.32286-1-leonardo.aa88@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl warning:

ERROR: do not use assignment in if condition

Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index c7e8602d2097..d02632dc16c3 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1329,7 +1329,8 @@ static void c2h_wk_callback(struct work_struct *work)
 	evtpriv->c2h_wk_alive = true;
 
 	while (!rtw_cbuf_empty(evtpriv->c2h_queue)) {
-		if ((c2h_evt = (struct c2h_evt_hdr *)rtw_cbuf_pop(evtpriv->c2h_queue)) != NULL) {
+		c2h_evt = (struct c2h_evt_hdr *)rtw_cbuf_pop(evtpriv->c2h_queue);
+		if (c2h_evt) {
 			/* This C2H event is read, clear it */
 			rtw_write8(adapter, REG_C2HEVT_CLEAR, C2H_EVT_HOST_CLOSE);
 		} else {
-- 
2.29.0

