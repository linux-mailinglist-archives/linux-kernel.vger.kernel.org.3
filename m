Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6AC58B401
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 08:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241531AbiHFGJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 02:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238582AbiHFGJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 02:09:49 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE20C201BE
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 23:09:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z22so5666228edd.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 23:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G8+xp6CTSirrV4c005hxKlVzfV8/Z9ZKPx/4fznm5Fs=;
        b=qm/O7bVoyDkHehE0iPMgiaTuAFSxuvL8uWOMPJnTJvkXUlfi59RTM9UjN7MZ4/z/Ok
         0Xizcy4D44lj2whvjpgcoAdRIU0u0pawZW6Klw4N4V7KBgbsfFCIPEbPPw4JnCSJCRRN
         9K4S12vDtXj2a0jAB6zsjy9ie178iPgtV0VCzon9zEAwJ2JPI4rjDN4T9rc/6sLCsgZH
         movlXm7q4BvZxLVAMVMwKMRwfZI+a0sMS6vBCDijnH/YxBzMJHKsx4seOqZWHmNFTOlu
         /z6NF/S/6X07uA378LIMjSHcmh5R8EetkVqyA+tOcwhjLEqJOzbXhT57s9GzHTa9mHss
         SG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G8+xp6CTSirrV4c005hxKlVzfV8/Z9ZKPx/4fznm5Fs=;
        b=SSF1hiCrtsC/1lYeVrtpw4scFsvZlWjITwcO8fSCsRquGCHHbOjwaW6AweK9AaQjvx
         2bVv9J6X03tk2C4GclEmqqDLK8dDYz7MgvmEaJUnNJrL2AqCzfbW+uRSY/75AvtazKiA
         GAbGuclZIOVnDhsBQ/I3u/NbqJrcWhizk5unn23YNEM2+aB/yNTi053q7d+mMalPXIJ4
         2Hwqei0rCRSJEFJZzi4Wqp5I1hAkk5oje4YnEvqguSqNh/agTb3REUJo+MRerxvecCS5
         cUGD85NPv9B5TsiadHAHkFyJlQs1eZsqESbuTC4GuXivjZvDCl1uvO54zp7TMmtfAD2+
         KrQw==
X-Gm-Message-State: ACgBeo3+eHtfc5RriYt1IZJ5WT+XmB2shhc/wXweR8ZrbRTFu1SEyMqL
        2KYfXZqwRzlggmDDDz8jYqE=
X-Google-Smtp-Source: AA6agR6kHVI5r9LkxD3Z/MhoIZc89eS6Hr3svWarqPsCS9gOi+bQEi0QxT8flVyhGJOjRuJNnAXU9A==
X-Received: by 2002:a05:6402:348f:b0:43d:e568:97bd with SMTP id v15-20020a056402348f00b0043de56897bdmr9278639edc.279.1659766186404;
        Fri, 05 Aug 2022 23:09:46 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id p10-20020a05640243ca00b0043a7293a03dsm1002357edc.7.2022.08.05.23.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 23:09:46 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: r8188eu: use ffs() in phy_CalculateBitShift()
Date:   Sat,  6 Aug 2022 08:09:27 +0200
Message-Id: <20220806060929.11022-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220806060929.11022-1-straube.linux@gmail.com>
References: <20220806060929.11022-1-straube.linux@gmail.com>
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

Use ffs() in phy_CalculateBitShift() to simplify the function and
improve readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index dea6d915a1f4..3d8fcc1f0b6a 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -25,13 +25,9 @@
 */
 static	u32 phy_CalculateBitShift(u32 BitMask)
 {
-	u32 i;
+	u32 i = ffs(BitMask);
 
-	for (i = 0; i <= 31; i++) {
-		if (((BitMask >> i) & 0x1) == 1)
-			break;
-	}
-	return i;
+	return i ? i - 1 : 32;
 }
 
 /**
-- 
2.37.1

