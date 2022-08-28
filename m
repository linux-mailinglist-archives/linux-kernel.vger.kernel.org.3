Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FAA5A3FAB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 22:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiH1UpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 16:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1UpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 16:45:00 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255091580F;
        Sun, 28 Aug 2022 13:44:55 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f24so3413976plr.1;
        Sun, 28 Aug 2022 13:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=A9D0cuoBStYXDmYgb1aaGFX8/+VPPNtzu94Y2LcT1zA=;
        b=CsUREvxiapMGbqr180DHU8MRhrOi2ZQ4zNXtFB2Jta8htf/c/ylGUIkhuxr0lCkwF5
         gQ1rYVX2vaO2crfYL4jkb+e5rRjWuqeD8bFqYOKN7AkNNCKkbxHR0FiBvqw4mOocpMTm
         apKb+psh9eVrljDC1eWdIhujz5vVD8Rs+oqpeGXQYMzDPvBTHFIOuIZ/lE4dXsVnkzZ+
         adnpd2NAhaXCrkIHZ7ANCieLkoD5NOKWueZkaZrmQFLkLbsalA7ALMwun1FQBaupQgEt
         rJImEbb/pwBsyGY85R6SeDpsn4eR3w6JPqCAm/s4NzqdhIQsgKEOvkgaTiNfVru7zB+s
         9Saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=A9D0cuoBStYXDmYgb1aaGFX8/+VPPNtzu94Y2LcT1zA=;
        b=3VYPUY5kPcRBWFJSsOL/UHBrxovVgF2Z+3oPafwJ+8DkiOGvxGxzszcuIP8Q29eEjc
         I6kgPjxQOSCd0lpg68jD5Zcc03/IglpR10IP+s9O2Qxlf2kGQuUu2QROMiUZ5ErNJSvL
         mEQ/mFliFVQ+1Lcg/P9oNmSk0RUTIu7DYO2kxPPL0R22ktKQnRDdCO+RvqMnlmZNilnw
         JHwwHxWQLNNdagu+1yIjdyWspr0vhetV8gU25Pw4MtqIb8uCxmnRTz78EwGwYWhK5L9F
         vNqkMv7LScja09W3JIsPqy6sZ49Ryo9KRjJwFG2m+/mjjExPIio9eu6ycNfn8jGtJMoR
         1tPg==
X-Gm-Message-State: ACgBeo0ZrJvUpgAwbX8WqRdRWoFZyEER6xDbNT0jqSAx91d9sirsSyy3
        hkHjzi5lOxRZ+/8SFPlG0YSnkhvOMnZdxg==
X-Google-Smtp-Source: AA6agR7nho/Rb/wMJkJk14TxEHIWwSWyQ8Bzws/9ExjKo7eDw7Fr5TBsjm1Nvo1Fp5dwpa9iOhDl2g==
X-Received: by 2002:a17:90b:38c4:b0:1fd:7119:1302 with SMTP id nn4-20020a17090b38c400b001fd71191302mr12251507pjb.243.1661719494912;
        Sun, 28 Aug 2022 13:44:54 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id j17-20020a170903029100b00172ba718ed4sm5779667plr.138.2022.08.28.13.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 13:44:54 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc:     damien.lemoal@opensource.wdc.com,
        Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v1] drivers/ata/libata-core: check return value of sata_scr_read()
Date:   Sun, 28 Aug 2022 13:44:43 -0700
Message-Id: <20220828204443.1954661-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
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

sata_scr_read() could return 0 on failure. Check the return value.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 drivers/ata/libata-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 826d41f341e4..ae08c7d35cb0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3021,7 +3021,8 @@ static void sata_print_link_status(struct ata_link *link)
 
 	if (sata_scr_read(link, SCR_STATUS, &sstatus))
 		return;
-	sata_scr_read(link, SCR_CONTROL, &scontrol);
+	if (sata_scr_read(link, SCR_CONTROL, &scontrol))
+		return;
 
 	if (ata_phys_link_online(link)) {
 		tmp = (sstatus >> 4) & 0xf;
-- 
2.25.1

