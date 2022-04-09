Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1204E4FA64F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 11:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbiDIJRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 05:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241226AbiDIJQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 05:16:15 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0879811D7A2
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 02:14:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id nt14-20020a17090b248e00b001ca601046a4so13966656pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 02:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2jZAJ+JA6yywC1V20DY87yMWwfDYQMlsgax/CHNuUKA=;
        b=gHRySIv4B/vBxWneeIYEr4hwAFt8BhQtlbEwvvhzsrjOA2EHXSVI+oX5jmtCEHMvr/
         7wmRXtEcEd4uxqBCJ4oniLy30jBvcGr4/jk5D0dpv4tA2h05qmryi4LHcnoVOh+Hm00e
         MMGCYU1llGTM/sL4l7Yf5zkAwC+XcjOrXYofrAtFPMTfSTbeedSQe9hsrTcbl934Vqdf
         CLlGbZGTMNtNedGh7jT6YTmW32RmWV24WdDGnK/Nkg7uV6EP+KxzE1zVByScZfcnR/mn
         eVRBBpsoBkHYH2AeqctzfkwGBiNhu7H3ryLTx+jG5tZ5uH2ZnovJZZ7JH3SX+btz9ZWj
         pQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2jZAJ+JA6yywC1V20DY87yMWwfDYQMlsgax/CHNuUKA=;
        b=dekYKKZhdOzvChP1omtJe/jRx5RQscEjUpFvO5tSD7A75jIfKlcv6w3xAqaEewsbXV
         7/XBq6JDH2vyeUFDQmEK6q4fWlDyu23ouTH7nGG7+o2HnYH/fwhPVnTnrF30xKSP6mUA
         okyDVYD2NIztwxs/aDeD1hrOahy3ftV6gnZ40FYl26uiWAAYtoyDi6DhlmfIczdRwS0X
         1+cEaurR3u458Hl5caDmWZA61Sh5J1/FsR1EzS4iRBOqQTrwc41bigQFIHAzt+CDO2xE
         THXDFEFYVrNBcgMkLjzKTwf16UrmAVilrt5RxZZgTSqa8MKjd0pqhuk+I06YlG7Gxp61
         5gww==
X-Gm-Message-State: AOAM533b1Jb7Tsel8Y6RRBziVMyq9scGxLeT7GQ3IJ9XVsAj3VFd5Pkr
        BnHdXnkdQtHUdLzafKfnw4OCFuEOLArcZ6tyIs8=
X-Google-Smtp-Source: ABdhPJwsbGx59samwR5vAj7S1DaqVuphUrywehVqnAhIN2MSzYcqKZuf12+M9uRcXBc+FRTGnuu73w==
X-Received: by 2002:a17:90a:c70f:b0:1bf:3e2d:6cfa with SMTP id o15-20020a17090ac70f00b001bf3e2d6cfamr26424465pjt.70.1649495645034;
        Sat, 09 Apr 2022 02:14:05 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id g6-20020a056a001a0600b004f7bd56cc08sm28351657pfv.123.2022.04.09.02.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 02:14:04 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm: mediatek: select arch timer for mt7629
Date:   Sat,  9 Apr 2022 17:13:47 +0800
Message-Id: <20220409091347.2473449-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
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

This chip has an armv7 arch timer according to the dts. Select it in
Kconfig to enforce the support for it.
Otherwise the system time is just completely wrong if user forget to
enable ARM_ARCH_TIMER in kernel config.

Fixes: a43379dddf1b ("arm: mediatek: add MT7629 smp bring up code")
Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 arch/arm/mach-mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 9e0f592d87d8..35a3430c7942 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -30,6 +30,7 @@ config MACH_MT7623
 config MACH_MT7629
 	bool "MediaTek MT7629 SoCs support"
 	default ARCH_MEDIATEK
+	select HAVE_ARM_ARCH_TIMER
 
 config MACH_MT8127
 	bool "MediaTek MT8127 SoCs support"
-- 
2.35.1

