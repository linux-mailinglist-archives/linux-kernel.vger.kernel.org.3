Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADCD4935E8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346549AbiASHzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352349AbiASHxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:53:33 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA57C06173E;
        Tue, 18 Jan 2022 23:53:33 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so5232226pjj.4;
        Tue, 18 Jan 2022 23:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PSCDM8d3/49w8i9Xs5Framf9Ts8Oz7CfeiqrrYTy54w=;
        b=khMVw+QYJ8NTt4bpMMhLFhnE589FkWnFng18I/cjEueQq2gbAAF5IgQGPZZRXAdBGf
         uiWkw3OWhv1lzDqordEMZqRVrjApjn4Cl5eheELZLbxDAi7n7S3/vdeZqUn8nylqTQIX
         4chUfdwSPC4wGDU8xyXV07fy3xIK+iy+asEwbwGvEeiy8l9L/XrUMMITJSJ5MfYFEa9p
         Qyt7LkEDb1Ow1sbdzXGk3jgqZV2IXr3xdoKCmvZLG53z/0pg6GAPEfk3H8x0Rp2yxvKd
         PA2WOT6Vi94onI2e5tyQ982AYQVMdxtua9wD8Vam6VQ5L2Pxm2NrkU1MYZgh6KSOAdFH
         Qx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PSCDM8d3/49w8i9Xs5Framf9Ts8Oz7CfeiqrrYTy54w=;
        b=f+UT637KA9qZeWV5IRnO541FZhwiaW2BGeBdplTZqrrIMnnj1ZvtY+dTPqb6n9HKB6
         7ybvRe6ihw89PIFZdFTM8AKYZAJxnkjFNNyeOZ4Xfr6wQv5I1fyI6wLLospUCn0Ypk44
         eDMjBq3iVYAQ1V55sHJoxccYJVBr8NeZFRyusophcYxIZ385XgI7VqnJw3KJt+lSNubm
         43KdrFTATzFFftAI0GUHHk18vBGe4Td+ARDk1J4miPxLRMgmdVON99/RGtcRlOrfYSSp
         AJrDeZofGHR8QS2XRerIv2rmxw9gfL2MwijPazaKkLDf0Mw1zkgRTiUvv40VCKFCFYpn
         Gq9g==
X-Gm-Message-State: AOAM531wPHB4LFZJpi7QCStQcdud3Z5UwGNa1W72TvEfDVRMBR1nnz18
        rtvFrAHI4m3j0WoBFujYAyg=
X-Google-Smtp-Source: ABdhPJyxmFOYwwSSZuNBZh0uK6G9XpoYXiyCiVs/8l8Pw2RNqfzomeAuPUunRdv17lZiU4U3R2YWGA==
X-Received: by 2002:a17:903:41cf:b0:14a:f1af:15cc with SMTP id u15-20020a17090341cf00b0014af1af15ccmr1250446ple.122.1642578812420;
        Tue, 18 Jan 2022 23:53:32 -0800 (PST)
Received: from localhost.localdomain (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id x1sm16890561pgh.44.2022.01.18.23.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 23:53:32 -0800 (PST)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        SeanHY.Chen@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH 1/3] mmc: sdhci-pci-gli: Reduce the SSC value at 205MHz for GL9750 and GL9755
Date:   Wed, 19 Jan 2022 15:53:06 +0800
Message-Id: <20220119075306.36262-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

The SSC value is 0xFFE7 at 205MHz and may be saturated. Reduce the SSC
value to 0x5A1D at 205MHz to reduce this situation for GL9750 and GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 4fd99c1e82ba..9ead32d73447 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -390,7 +390,7 @@ static void gl9750_set_ssc(struct sdhci_host *host, u8 enable, u8 step, u16 ppm)
 static void gl9750_set_ssc_pll_205mhz(struct sdhci_host *host)
 {
 	/* set pll to 205MHz and enable ssc */
-	gl9750_set_ssc(host, 0x1, 0x1F, 0xFFE7);
+	gl9750_set_ssc(host, 0x1, 0xF, 0x5A1D);
 	gl9750_set_pll(host, 0x1, 0x246, 0x0);
 }
 
@@ -533,7 +533,7 @@ static void gl9755_set_ssc(struct pci_dev *pdev, u8 enable, u8 step, u16 ppm)
 static void gl9755_set_ssc_pll_205mhz(struct pci_dev *pdev)
 {
 	/* set pll to 205MHz and enable ssc */
-	gl9755_set_ssc(pdev, 0x1, 0x1F, 0xFFE7);
+	gl9755_set_ssc(pdev, 0x1, 0xF, 0x5A1D);
 	gl9755_set_pll(pdev, 0x1, 0x246, 0x0);
 }
 
-- 
2.34.1

