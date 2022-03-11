Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5304D5BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346924AbiCKHDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346899AbiCKHDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:03:15 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2950D1AC29A;
        Thu, 10 Mar 2022 23:02:13 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id r127so6322748qke.13;
        Thu, 10 Mar 2022 23:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hzY/sdOnpl2kFkpwmbZ9CQ4/TSPZAEZYFrxoYv943Ac=;
        b=MsJZ1iqpEYM+TEsgY6Yt+RK1RBGqctf446evavz80Fkb7/bq+kO6oh3Jv+StlJOmXz
         EZHfAXvhk7+EBPSyH7PxxdyWEl8C6yG5sg+8iTuoR3GZtOx6w2wQAOZ8bmXCe5Okcrxv
         KN7spjOIBwkTps3NiFfVLWBw2/qC2qxYyx+I3HhctJSPo19YHa4MFMDozANLm3awuBxH
         r2FTro+yZk/M/Cn930iR4b+mgtL+snih/X9/s6AoqM0krptgdYgYL6lFo0A2gyesPa5g
         GEOKgi0YFyOAKfObWUb+KEuxZcOkHxh73G7ueHM68oD4dsxuvYEPopcRjr9176bBG3WZ
         b6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hzY/sdOnpl2kFkpwmbZ9CQ4/TSPZAEZYFrxoYv943Ac=;
        b=t42WynToa+NYUzx1jDtNKcnKaDdcI+biMCehNfB5LtWdvwcv31gb0+ExJHwXeDKha4
         NQZjcrMhPxtiBcamZTirX40EshF18KPBQgy7aTe0YI3WYkf3gh9zdQ7aFMXoJK8giYXj
         Fpn1cmylX+KkynWYStlI5HlaWaBedCNixlTwZ4NWgn2KRqmTSNMRl4dk6fGw7Tz7aJDt
         dQQfmfZp7drSRf8uiJqJcbgMs7zYVimrR2vFBCoc8lDtVv10gOIFb3Ok5xOXz3M3Fqwr
         Vb/7ubmTFsS3GCVcVNTZOKnMiWOcgT92CMu6jAhZ2o6kgfCjU8nVK3FjbS2mcsV0qolU
         qJpg==
X-Gm-Message-State: AOAM530npOHvsDQ5+xQfyRLHA7JpDEqVe9gkFbSrfkexDjISNnWPlIGv
        v4lTApFnXUZVxHutfpOT24oo2oyoVZ0=
X-Google-Smtp-Source: ABdhPJyHC4DYI0VCACyg/IMe6etx4GTKaM/Wn8eeiXL8ffVAS71nbC1oi6XirNsn3ZnidHDCM7661A==
X-Received: by 2002:a05:620a:2904:b0:67b:3c00:2d81 with SMTP id m4-20020a05620a290400b0067b3c002d81mr5736124qkp.410.1646982132006;
        Thu, 10 Mar 2022 23:02:12 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id k8-20020a05620a138800b00679fc7566fcsm3352834qki.18.2022.03.10.23.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 23:02:11 -0800 (PST)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org
Subject: [PATCH 2/3] serial: 8250_fintek.c: Report chipID
Date:   Fri, 11 Mar 2022 02:02:01 -0500
Message-Id: <20220311070203.18159-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.34.1.75.gabe6bb3905
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

Provide some feedback to confirm this driver is enabled, and specify which
chip was detected.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index d9f0e546b1a1..03ad2354d808 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -155,11 +155,22 @@ static int fintek_8250_check_id(struct fintek_8250 *pdata)
 
 	switch (chip) {
 	case CHIP_ID_F81865:
+		pr_info("Fintek F81865\n");
+		break;
 	case CHIP_ID_F81866:
+		pr_info("Fintek F81866\n");
+		break;
 	case CHIP_ID_F81966:
+		pr_info("Fintek F81966\n");
+		break;
 	case CHIP_ID_F81216AD:
+		pr_info("Fintek F81216AD\n");
+		break;
 	case CHIP_ID_F81216H:
+		pr_info("Fintek F81216H\n");
+		break;
 	case CHIP_ID_F81216:
+		pr_info("Fintek F81216\n");
 		break;
 	default:
 		return -ENODEV;
-- 
2.34.1.75.gabe6bb3905

