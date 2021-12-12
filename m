Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5020F471E32
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 23:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhLLWTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 17:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhLLWTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 17:19:33 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D63CC06173F;
        Sun, 12 Dec 2021 14:19:33 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id j9so12910908qvm.10;
        Sun, 12 Dec 2021 14:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5/2Wze8vZRG9YKWtB/AhqKPwIShZlYfqbSfgNVc2Zmw=;
        b=Y/vY1gwFL5MKOWON7KpUeBBaPUM0qdH0B18FP+J1/yQjsq3mc+DOOgJOkMcqnYDKgB
         Pj5xqHpQpAD5bGsZohVnOWSyzrGElxwN70wKcl1kT4o1IVkyy6DV9IPOoW8I16wggf9n
         5fxKoxYtflCYmBIV4z9dI5H0V1kl1fQiecwd4wy8mdA9AXXpBn+cfJQCvsgZ3fHkxpsB
         lSeu48slHXfxgHvtUPN3VtCtkAbE0HBRsVpKOtR5dqR4qaLMbAVh9cbayw5zUz0tf53n
         /TlwXqdDOg1P4rbNFOT3ZtFv9SK2FKnT0oxHALAJX/mBNHdIvyKCJzEm++9XduQMdOkQ
         mZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5/2Wze8vZRG9YKWtB/AhqKPwIShZlYfqbSfgNVc2Zmw=;
        b=u6ioi4EKovlKos3ndtF8gF1Re/yLEiVteAFLkLUWVQ1Gd14F4ZPws4/ljM8ahg2m8o
         7ljD2hSTB7Srx2gZEBwx6pnWi3JEo6IjvYyFTJApZ/Agf+DWpvBRIWYrTHlNZAcjyz2W
         PVXngvpb9MNOoSgPftcgAvHt1qBbzz55RV5hLbJiAqLuBlRhGq9R08YAqlBE+vTNRKPd
         c70gJU+0CyM080jb3++6NfNjpXfe/66V7MX/yKd9w9uD1RxbC1S06468LqruVO8b+aRB
         mpG1J/un1MojaTDP/0vYmGvlzr+Yp1RH9TqGUacCfX390AIaX+YoR5UeULQPMl07vqod
         lWKA==
X-Gm-Message-State: AOAM5337jvOaKuH71b3925b7kiKs0Ct0aDXIo+5zxiG0YiqcbnB7WUO5
        Xq50l6vLrkBa8LF6qidbLaU=
X-Google-Smtp-Source: ABdhPJzHVYmFFDaQ4KwaHk9hBdAawKnLmvKnYnuJQrjEkU0ha16zl8yUT4O+EEYq1SzNNO3kOvfMGA==
X-Received: by 2002:ad4:5cef:: with SMTP id iv15mr38245876qvb.86.1639347572362;
        Sun, 12 Dec 2021 14:19:32 -0800 (PST)
Received: from localhost.localdomain (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id x1sm2561065qtj.9.2021.12.12.14.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 14:19:31 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] of: unittest: 64 bit dma address test requires arch support
Date:   Sun, 12 Dec 2021 16:18:52 -0600
Message-Id: <20211212221852.233295-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

If an architecture does not support 64 bit dma addresses then testing
for an expected dma address >= 0x100000000 will fail.

Fixes: e0d072782c73 ("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset")
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 481ba8682ebf..126020e9838a 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -934,8 +934,9 @@ static void __init of_unittest_parse_dma_ranges(void)
 {
 	of_unittest_dma_ranges_one("/testcase-data/address-tests/device@70000000",
 		0x0, 0x20000000);
-	of_unittest_dma_ranges_one("/testcase-data/address-tests/bus@80000000/device@1000",
-		0x100000000, 0x20000000);
+	if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
+		of_unittest_dma_ranges_one("/testcase-data/address-tests/bus@80000000/device@1000",
+			0x100000000, 0x20000000);
 	of_unittest_dma_ranges_one("/testcase-data/address-tests/pci@90000000",
 		0x80000000, 0x20000000);
 }
-- 
Frank Rowand <frank.rowand@sony.com>

