Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CA2527653
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 09:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiEOHzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 03:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiEOHzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 03:55:08 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03938EE1D
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 00:55:06 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i17so11697067pla.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 00:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J10ZFOGMFSFgmFeZ9CiJXJ9EX3sHqK+vLfzm5M9SaHc=;
        b=Okz+AkpqEs0mD9VpVBxdoUMylSJBsGZmU51UP4T/lzwMr9hroGMVzqKD5AZUODA+8x
         n8DF7/xX6kYA2kSlUh4CSrB0QD2+xDpLnmRIOZmF2st37ELsRwk5uCkDvXJ76k1ZvDNt
         tfA9IxYhO5sZ1qOFXTH0b67kzB790dgFBtPLPv6bVSKlrOkylN6vEZWPyOhbUqtQBurI
         sqo8jKr2UhzSTtdGkHFAtk13TUH4HNvtyJCLy0+2MDN2eMGq+ku/eAYjTFn1DMGwCzuz
         9rDJB/HRqkb18Vaad0KB8ZTQ14mTswM5cb77zu4Br4VHHbVPNlfubvjg31npX2F+iLMB
         Nfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J10ZFOGMFSFgmFeZ9CiJXJ9EX3sHqK+vLfzm5M9SaHc=;
        b=GqgOSQUzfIqDupWeVac1AweALI5vYI4HY/qUM+kPBm/rUcVOXrM9gODzPAMUvv+Jw3
         a70aEoOMEjO9bf2p7BLub2d7kwF9Tg8YbrNA6tavXvk9D9umgAL/qN6lrMloL27ijFlK
         K6pm4v75CyOczSBMSHNxjDhgVB6h11AMXkvcZGnOHzE46A3lHAbQF2AJu+Siu1W3WRma
         dKvCMPRmT0/glXoSCmGtyDMzIAqi3gf73AFetCLkXLTFPc5VFkz43xTMRcI/JnE4IwaK
         2WcmzQI9nxZL6dQUsPGHnk5kw5XN/XbEik6GSqPGFupPcP0HgBkH6grq9p/iicTi4kU/
         OZxA==
X-Gm-Message-State: AOAM533NPgsXbEaqANuANMXYJb9s98oH/ontNjqf3PejomW4rBbJK5BE
        aTsO+VKXZa+t9AesVy389yM=
X-Google-Smtp-Source: ABdhPJyvehCpFMabiYes/DAarOYRUEt+uuHx8vDbmp8dbUi2+dV/mcaMW0mcPYFJx5Qk8S65WwU8fA==
X-Received: by 2002:a17:903:22ce:b0:15e:bd57:5bec with SMTP id y14-20020a17090322ce00b0015ebd575becmr12172409plg.114.1652601305573;
        Sun, 15 May 2022 00:55:05 -0700 (PDT)
Received: from f34-buildvm.eng.vmware.com ([66.170.99.2])
        by smtp.googlemail.com with ESMTPSA id k4-20020a628404000000b0050dc76281dcsm4624267pfd.182.2022.05.15.00.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 00:55:05 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, yesshedi@gmail.com,
        Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH 1/3] char: lp: ensure that index has not exceeded LP_NO
Date:   Sun, 15 May 2022 13:24:53 +0530
Message-Id: <20220515075455.306082-1-sshedi@vmware.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After finishing the loop, index value can be equal to LP_NO and lp_table
array is of size LP_NO, so this can end up in accessing an out of bound
address in lp_register function.

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
---
 drivers/char/lp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index bd95aba1f..e61060f3c 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -971,7 +971,7 @@ static void lp_attach(struct parport *port)
 			if (port_num[i] == -1)
 				break;
 
-		if (!lp_register(i, port))
+		if (i < LP_NO && !lp_register(i, port))
 			lp_count++;
 		break;
 
-- 
2.36.1

