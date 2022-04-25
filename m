Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEB250D7C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 05:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240813AbiDYDqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 23:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240909AbiDYDqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:46:03 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0956E29CAC;
        Sun, 24 Apr 2022 20:42:23 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n8so24208055plh.1;
        Sun, 24 Apr 2022 20:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ohE50qU4qaQMeCii+Z+po7lmX+itL/YGUd1v4oq6lSE=;
        b=QFRvN00dPEFFBl991bCGDjOG7DP6CFyFhqSf7G0NoTIUctzPGQu3fHWyT6m4pCMO3L
         HTeL8qM/nN7T5xBOdgqqcVhO2yCTe46B+EIw71grg/NQy+WgcTnDU6+aTUyXZnDHYQ4s
         qy3qbqqcRuAQV78uesb40eVtoe4Gzl3FFMfZFz0NxtMIup7YD34UQ039Fk/89G55jAuc
         U76yPK7DaHYZtOXSHULHVknFfsjNre++JetVxzoonixo9G9h1sZdJerrG9hA0HEAwddl
         tnX0M2Hqij0gau10lhQcxtGQh69ReFtyPi4GL34lIymcpj8YwPCjNZACPPE/l1Qky4ZW
         BVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ohE50qU4qaQMeCii+Z+po7lmX+itL/YGUd1v4oq6lSE=;
        b=Jcy4SkRWhNoca0HYJvOKM9DKzpPKLBYgA3Z8wI/X3cYA8wB3nFhVwdmF4WDmLuPaZT
         7mdZ1ZS9I/pcLd6eDEnXPL7LqTcb7YrAPT4mlMlbSUWLSafAztaTXg2ZAxCAY/IljwyO
         A9UL/ft33znRR3nURqplZHByZb7Y26FVTUe1gZynsUulkaAnIxZqOYs2XKV5sJPcFDsq
         sobqiye/0PBEBznOWvM/nDdJmTTzowefn4khTQqSnQwRj54HKmvWfuV5cqJilBDUGJju
         YLT1adGJKwnbvYZMZOGFFa5Yre8EwhVQdJ/0eSSmUEV39GoWW5ydwp1YLRQh1Ffat29t
         tXTQ==
X-Gm-Message-State: AOAM5308xT6sudPHqWpFXDVzceB+P8M6t68VQWKj8MMzxDc487LnL8jv
        Xyjg0aqumbe82JoVcIv9nAc=
X-Google-Smtp-Source: ABdhPJzUDhFmD+FGEc/XuB74nBKfc3m5WWIREDnnzzQrZQWELhYTpfSJ2Bji24Ge1HEhBreek/OB7g==
X-Received: by 2002:a17:90a:df0f:b0:1d9:2372:b55e with SMTP id gp15-20020a17090adf0f00b001d92372b55emr12678494pjb.104.1650858143030;
        Sun, 24 Apr 2022 20:42:23 -0700 (PDT)
Received: from ethan-Latitude-7280.localdomain (125-228-239-174.hinet-ip.hinet.net. [125.228.239.174])
        by smtp.googlemail.com with ESMTPSA id t21-20020a17090a951500b001d77f392280sm10450231pjo.30.2022.04.24.20.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 20:42:22 -0700 (PDT)
From:   Ethan Yang <ipis.yang@gmail.com>
X-Google-Original-From: Ethan Yang <etyang@sierrawireless.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gchiang@sierrawireless.com, Ethan Yang <etyang@sierrawireless.com>
Subject: [PATCH] add support for Sierra Wireless EM7590 0xc080 and 0xc081 compositions.
Date:   Mon, 25 Apr 2022 11:42:04 +0800
Message-Id: <20220425034204.4345-1-etyang@sierrawireless.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add support for Sierra Wireless EM7590 0xc080 and 0xc081 compositions.

Signed-off-by: Ethan Yang <etyang@sierrawireless.com>
---
 drivers/usb/serial/qcserial.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index c18bf8164bc2..38e70a573e2c 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -166,6 +166,8 @@ static const struct usb_device_id id_table[] = {
 	{DEVICE_SWI(0x1199, 0x9090)},	/* Sierra Wireless EM7565 QDL */
 	{DEVICE_SWI(0x1199, 0x9091)},	/* Sierra Wireless EM7565 */
 	{DEVICE_SWI(0x1199, 0x90d2)},	/* Sierra Wireless EM9191 QDL */
+	{DEVICE_SWI(0x1199, 0xc080)},	/* Sierra Wireless EM7590 */
+	{DEVICE_SWI(0x1199, 0xc081)},	/* Sierra Wireless EM7590 QDL */
 	{DEVICE_SWI(0x413c, 0x81a2)},	/* Dell Wireless 5806 Gobi(TM) 4G LTE Mobile Broadband Card */
 	{DEVICE_SWI(0x413c, 0x81a3)},	/* Dell Wireless 5570 HSPA+ (42Mbps) Mobile Broadband Card */
 	{DEVICE_SWI(0x413c, 0x81a4)},	/* Dell Wireless 5570e HSPA+ (42Mbps) Mobile Broadband Card */
-- 
2.17.1

