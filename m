Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAC14B7C38
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245323AbiBPBIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:08:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245284AbiBPBHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:07:32 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C2AED941
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:21 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id q198-20020a1ca7cf000000b0037bb52545c6so2649590wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/tZwH09eYlURsU9ovNUrKKrqJAZOzfkUhLGHlZxAp8=;
        b=unwxR8WWm7ag8THNs5ELWKzhcrTV9g3QkZLSvlnQSBwpWf8FaRJ1P5vPfGhvb03Bxm
         qiV6dRd4sscYsoEZlK51aPyFdgEnI5TA3ryd9NVIOp6ELHa3Je8Wx/MgKapMxnX8+zFC
         tha9Z8j9kzhBLQx4kkhPeEhUy+to683FyHf4YhF1ZibderZdFs1w1Tcq/iG3Ap/F0CLs
         /6C9l7+d9Wf7X9iljmgol9N+ZQgf2sFqDMgFPGggs9N2riO1rBpHFrM8IXx9u+21GtnH
         8mkzdy4e/EGxdp3Q9XWUft2+8Cjt2X+M08ztZRy2yvvEPNMa1XuWnWeulULXYS7gOEmj
         PArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/tZwH09eYlURsU9ovNUrKKrqJAZOzfkUhLGHlZxAp8=;
        b=aDV02Iei029V/NEsoWQIrkANKSxnY+rMd819DupfSgWe25CVCiUxOjA5zbbEDtl2tK
         TTf7SkLhRwKpgCOzb7Xnkw4gteeaF4T7zbzIpYP43p6zBQux7PRGxE46IWPuBSoMtwZa
         BbDAD8tfxMV/C3s1+W071tiC4SyijMSQcmcbTAnnn4A5Og7cTtRtfAIpvZD+/OSP8r/O
         ECNnZyblOtoQoXTY4qM7+VFaIkFVoI45KH4QAqDF6c1y3tQuGmt+uyWA+hvCltmFT+Dr
         mjGDed1hRHTW+YjY17gbg8iMWEDXm3Pp/vERH/vsr/Ig0B+wwIizbH9dWp5gVckd73w5
         qlkA==
X-Gm-Message-State: AOAM533Lefa4m5kn/torz4aQ4koZsKyAlN57C8cjM9geGdLIS8rF3eH4
        IGB9g87qNaAt43InwvochBoqaQ==
X-Google-Smtp-Source: ABdhPJwmgkc8Pceapw6vfah49O7mao+Bg49sp3kmyHae27wH2ipTs30Lnt1yFrFLfJCN6TBCf9TrXw==
X-Received: by 2002:a05:600c:3588:b0:37c:306a:9eb7 with SMTP id p8-20020a05600c358800b0037c306a9eb7mr4872102wmq.107.1644973639777;
        Tue, 15 Feb 2022 17:07:19 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m8sm10551185wms.4.2022.02.15.17.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 17:07:19 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH v2 10/15] staging: r8188eu: remove DBG_88E macro definition
Date:   Wed, 16 Feb 2022 01:07:04 +0000
Message-Id: <20220216010709.791-11-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220216010709.791-1-phil@philpotter.co.uk>
References: <20220216010709.791-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove DBG_88E macro definition as it has no remaining callers within
the driver. This is part of the ongoing effort to cleanup the driver to
use standard debug mechanisms where appropriate.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/rtw_debug.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_debug.h b/drivers/staging/r8188eu/include/rtw_debug.h
index 311051757715..959fb6bd25ca 100644
--- a/drivers/staging/r8188eu/include/rtw_debug.h
+++ b/drivers/staging/r8188eu/include/rtw_debug.h
@@ -54,10 +54,4 @@
 
 extern u32 GlobalDebugLevel;
 
-#define DBG_88E(...)							\
-	do {								\
-		if (_drv_err_ <= GlobalDebugLevel)			\
-			pr_info(DRIVER_PREFIX __VA_ARGS__);		\
-	} while (0)
-
 #endif	/* __RTW_DEBUG_H__ */
-- 
2.34.1

