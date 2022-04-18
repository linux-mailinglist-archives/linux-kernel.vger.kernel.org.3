Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8934505B34
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244386AbiDRPiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345437AbiDRPh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:37:28 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F0543EEC;
        Mon, 18 Apr 2022 07:58:45 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x18so11007229wrc.0;
        Mon, 18 Apr 2022 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CX/IUq1aN3lYpmTZrmux2ZoNqle4gaskLWMK3nNShGw=;
        b=JdNM/niE5cXM0TtsJv+AiQG6UfTArLkryCgK8z4GIkdoaRaCxwAIIidvmgZ+mkVEt8
         /4jGxK4C9/KlzaR+i6YfxG/XjIY5r2P9vF282wKEN702SZOJiIU3ZrGMdpzVnrdW3caj
         Z71tHHaOsQ6+ELTgAjQa/y/4XCfZMxeIyWXd0dGoGNj+dzoLH/hQoP/8rNOvNPFoKbBQ
         /LT6wmL2EybaqGXORDRUZN1ep0jeDcqhAxazDCKHQbMT4bzOI+a3ANSvoV4eqQzMqIze
         YZat7aMSXjylpz2cBZMUzb4WPYOo1i9LKSmhmlPBY1hBJNZaTJ+WGiCRqDYST9xZcYL4
         HYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CX/IUq1aN3lYpmTZrmux2ZoNqle4gaskLWMK3nNShGw=;
        b=NsNcabalVN18tFWmKypk/4KceResJxFbOucmtqNsU/lLzx3+5MFhjeSCRDXL62NLZV
         yRS47Lpfck2ILR25dlK785iONMgY7QN+ounciUlQ+ggEGXzbwVt8GReh3SWNsDTA0HgN
         rVa7+2Ki1Jz/y7iBWFiq78cQWZ336GqNxbw355vtozsTXmqH2DkofpKbBAbITEeddz0L
         8Du58/9+5ecxU8fgvAZjQSCmZLRwv3GcfupaFZWSZMAUkPDIRaTDr0g/f2OVz/v5BKsM
         8+Z08OXHMnepQoUcWW/pKC/+zWlSuFcxPCGK+vQJ/8WJbva4Bg6wBdPSJuJQsDKbbwcY
         ALBQ==
X-Gm-Message-State: AOAM5327Xvjq3uLysjAGDr2NqyoQYFebNSTMh9qql5tss0YQD7aGKC/U
        tY63MD/pzF9iQrKFLvP+OQP8ZfMsWv4=
X-Google-Smtp-Source: ABdhPJzzsluWxj0VaudxL34jveGy6/JC2BIiCB0OvhXZF9RY9e4P8n4nrql3SI+RbCDjUd+6EDMyGA==
X-Received: by 2002:a5d:6c68:0:b0:20a:8d5f:681a with SMTP id r8-20020a5d6c68000000b0020a8d5f681amr6931611wrz.470.1650293923638;
        Mon, 18 Apr 2022 07:58:43 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h2-20020a05600c414200b0038ec7a4f07esm16740652wmm.33.2022.04.18.07.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 07:58:43 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] rapidio: Remove redundant variable tmp
Date:   Mon, 18 Apr 2022 15:58:42 +0100
Message-Id: <20220418145842.87154-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable tmp is being assigned a value that is never read, the variable
is redundant and can be removed.

Cleans up clang scan build warning:
drivers/rapidio/rio-scan.c:561:10: warning: Although the value stored
to 'tmp' is used in the enclosing expression, the value is never actually
read from 'tmp' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/rapidio/rio-scan.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index 19b0c33f4a62..5256e76ab29c 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -524,7 +524,6 @@ static int rio_enum_peer(struct rio_net *net, struct rio_mport *port,
 {
 	struct rio_dev *rdev;
 	u32 regval;
-	int tmp;
 
 	if (rio_mport_chk_dev_access(port,
 			RIO_ANY_DESTID(port->sys_size), hopcount)) {
@@ -558,8 +557,7 @@ static int rio_enum_peer(struct rio_net *net, struct rio_mport *port,
 	rio_mport_write_config_32(port, RIO_ANY_DESTID(port->sys_size),
 				  hopcount,
 				  RIO_HOST_DID_LOCK_CSR, port->host_deviceid);
-	while ((tmp = rio_get_host_deviceid_lock(port, hopcount))
-	       < port->host_deviceid) {
+	while (rio_get_host_deviceid_lock(port, hopcount) < port->host_deviceid) {
 		/* Delay a bit */
 		mdelay(1);
 		/* Attempt to acquire device lock again */
-- 
2.35.1

