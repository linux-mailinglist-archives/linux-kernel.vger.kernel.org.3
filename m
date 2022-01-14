Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC99648E167
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 01:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238391AbiANALQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 19:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238356AbiANALO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 19:11:14 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806ACC061574;
        Thu, 13 Jan 2022 16:11:14 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 78so1299427pfu.10;
        Thu, 13 Jan 2022 16:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q8c93w5bjbPbNHYcCj6vw9R7FFzBe3yubr2S2ys7jow=;
        b=biOjEtzRfto97MwOkEz/PpXG0fvyBTQ0N+cxP//GcbhQp28LT/Y5ql7bskgwNS1jgX
         OnbLf/DPW7EkZlMTm0WDWBsu3V83gQEpScN70+042gbIfW093n5ECTDtYh4TqRf6CTAg
         XsoZpdmvEX6/SKma12syQ8SdH9uTVqJvqq4j/EEZPS7c/S57zFICXVIc4RpcNpYJLo50
         mWIfdEsTVSkfhukP0Egbi9kTGqqb6QGSpjMMYfknqA57Lpku/ocUPBsF1K4EYbGB7UHY
         NmqpHEainnEhPY7m4GybLc6fR8ObbrfVq9QTMNIKeZW81P2NGkYd6QRKqERj1gi8hXYo
         g/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q8c93w5bjbPbNHYcCj6vw9R7FFzBe3yubr2S2ys7jow=;
        b=UKaigiMva/+vVoO2bYZyU1d4sQMfNuBbxdbOieHUOsMozO/6wzy4yuZ+cZWRCybQCp
         5a3qkKWORyOAiFfniD8HJluNGfl9JzeUkDSJ6aVb/1v4jRA9fuRQg303z9RRCJuz/nVM
         SlnzW3EuIK4CJ6rVs5UMiE8xbJ/9Jz6KiANsrW5p+TFvBC1VuF3cqcfC/48xlgzBXPf6
         bnv7CFxApplkYa25gFbItEg/aOrIBEQf0TtHKiZuqBXz/kE9tE5n5z5/E5mHSrJe2aNJ
         GzBJKKnJ0mBppMsMaJwuhxmLNfoC2VLkCzHtNhsx+KxQZC+dakh16bkNf+Vgfl1TGlK1
         qFog==
X-Gm-Message-State: AOAM532R2u0ppEQTG8JlvxwnhxOvBjbCnzUivqfRLovI3G40YNqT2Ixf
        sxZrkOYE0H/q/5+njRz+U2E=
X-Google-Smtp-Source: ABdhPJyPFMAh7V/OnW+Qtp4Ph8kQS2Au6c/+rRfbAH7HWNJim8E3B5vjaCiwPvdkfW2YW66czpZjWQ==
X-Received: by 2002:a63:370b:: with SMTP id e11mr6057693pga.558.1642119073845;
        Thu, 13 Jan 2022 16:11:13 -0800 (PST)
Received: from localhost.localdomain (192.243.120.57.16clouds.com. [192.243.120.57])
        by smtp.gmail.com with ESMTPSA id s21sm3966429pfg.75.2022.01.13.16.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 16:11:13 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     m@bues.ch
Cc:     davidcomponentone@gmail.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ssb: fix boolreturn.cocci warning
Date:   Fri, 14 Jan 2022 08:11:02 +0800
Message-Id: <fa4f1fa737e715eb62a85229ac5f12bae21145cf.1642065490.git.davidcomponentone@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

The coccinelle report
./include/linux/ssb/ssb_driver_gige.h:98:8-9:
WARNING: return of 0/1 in function
'ssb_gige_must_flush_posted_writes' with return type bool

Return statements in functions returning bool should use true/false
instead of 1/0.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 include/linux/ssb/ssb_driver_gige.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ssb/ssb_driver_gige.h b/include/linux/ssb/ssb_driver_gige.h
index 15ba0df1ee0d..28c145a51e57 100644
--- a/include/linux/ssb/ssb_driver_gige.h
+++ b/include/linux/ssb/ssb_driver_gige.h
@@ -95,7 +95,7 @@ static inline bool ssb_gige_must_flush_posted_writes(struct pci_dev *pdev)
 	struct ssb_gige *dev = pdev_to_ssb_gige(pdev);
 	if (dev)
 		return (dev->dev->bus->chip_id == 0x4785);
-	return 0;
+	return false;
 }
 
 /* Get the device MAC address */
-- 
2.30.2

