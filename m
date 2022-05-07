Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A476B51E538
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 09:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380249AbiEGHdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 03:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238791AbiEGHdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 03:33:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3288464C5;
        Sat,  7 May 2022 00:29:49 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e24so12792471wrc.9;
        Sat, 07 May 2022 00:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gkqa+Dh4VElJCoRa1LM889KNNJniYHnTZNydz4wChHE=;
        b=TQUGZuWe7CS68jYCrPs7PT4WquNIn+uMO/HmZR1kJ+UDWtIJDVdbqTgXrdkYrPFAMS
         VyGEE/HdkxyuIin+4j/ceunxInzBDGUJMGvzPJC6AX46IeSmS2MEkTeB88TUzFKm2fdS
         VwrzBBUoOWTwulq+WzzI4ZgUy3DBMtuFVLGWzPah0J/9Q2AR3BGOFhMIFvNDPssiT4wW
         k2rnm4Ft4QWUbZtWejuT3cCRc/PVEPUuT4Cn4R58u3YkW/7OfKIbtecXWP/t+s51sSzS
         SHslOvYL43AOL/liNoMM5ucZY0+ItgFSjbu6j+BEJEMv8qFsQv5756boe/UdWJX+iiZN
         ek8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gkqa+Dh4VElJCoRa1LM889KNNJniYHnTZNydz4wChHE=;
        b=05MNfAZLfId5xWr86mkR3GtoMQtgg09X5SjVzWx1IQmGl+Iaci6PASm3Fh/sLlyKeJ
         MTDcRqh6kAAaV4UtFc3xndDI34cMNpF4dgSpQ8B9ofVIqKN9dqCggBJ3xdZOwimC340m
         xmhMYDbqYg+ZmnW7guvr8vQn8t3JTvwNU/4io2T2BydrRxfKCuUMI5TNPWKv+Y1Ht8X0
         DuaNEeD9+1tsJjcn+0NGFjopHd7zUW+R5mWuowBOtEYN359tCRWy40Md3epSri1f4Snj
         HfXsxrBBXlRTXexpAI5dE4jiW/PzH4ersRo/RkHVOq0uvOZMSVPyMauC1yOWY1lXHuvj
         1muA==
X-Gm-Message-State: AOAM530H4dGGQGjawEYHrC1gsk9o3oechADymWCJ05+xgM41MT5DeiL0
        3+0xyuMEfllF+V9MMgyU610=
X-Google-Smtp-Source: ABdhPJzclBf81AWFccMO1vtwEvrb7IynvUbbwvmVFnBdzAfrGK5FwwgDW4ehiLiZ6QuoOy77wuqVqA==
X-Received: by 2002:a5d:5221:0:b0:20c:9a6f:50be with SMTP id i1-20020a5d5221000000b0020c9a6f50bemr5645609wra.494.1651908587525;
        Sat, 07 May 2022 00:29:47 -0700 (PDT)
Received: from localhost.localdomain ([46.211.169.51])
        by smtp.googlemail.com with ESMTPSA id p6-20020a05600c358600b0039429bfebeasm9123616wmq.2.2022.05.07.00.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 00:29:46 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     linux@roeck-us.net, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, pauk.denis@gmail.com,
        renedis@hotmail.com, e_dimas@rambler.ru, hubert.banas@gmail.com
Subject: [PATCH] hwmon: (nct6775) add ASUS PRO H410T / PRIME H410M-R / ROG X570-E GAMING WIFI II
Date:   Sat,  7 May 2022 10:29:33 +0300
Message-Id: <20220507072933.3013-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boards such as
* PRO H410T
* PRIME H410M-R
* ROG STRIX X570-E GAMING WIFI II
have got a nct6775 chip, but by default there's no use of it
because of resource conflict with WMI method.

This commit adds such boards to the WMI monitoring list.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Reported-by: renedis <renedis@hotmail.com>
Reported-by: Dmitrii Levchenko <e_dimas@rambler.ru>
Reported-by: Hubert Banas <hubert.banas@gmail.com>
---
I have checked code by DSDT dumps from ASUS support site. 
Could someone please check that it works over current hwmon-next code? 
---
 drivers/hwmon/nct6775-platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index c2f76af735a2..6d46c9401898 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1042,6 +1042,7 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 static struct platform_device *pdev[2];
 
 static const char * const asus_wmi_boards[] = {
+	"PRO H410T",
 	"ProArt X570-CREATOR WIFI",
 	"Pro B550M-C",
 	"Pro WS X570-ACE",
@@ -1050,6 +1051,7 @@ static const char * const asus_wmi_boards[] = {
 	"PRIME B550-PLUS",
 	"PRIME B550M-A",
 	"PRIME B550M-A (WI-FI)",
+	"PRIME H410M-R",
 	"PRIME X570-P",
 	"PRIME X570-PRO",
 	"ROG CROSSHAIR VIII DARK HERO",
@@ -1064,6 +1066,7 @@ static const char * const asus_wmi_boards[] = {
 	"ROG STRIX B550-I GAMING",
 	"ROG STRIX B550-XE GAMING (WI-FI)",
 	"ROG STRIX X570-E GAMING",
+	"ROG STRIX X570-E GAMING WIFI II",
 	"ROG STRIX X570-F GAMING",
 	"ROG STRIX X570-I GAMING",
 	"ROG STRIX Z390-E GAMING",

base-commit: e21a58f67b9bb6dde09d6ef3c585573ceaa56a47
-- 
2.36.0

