Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCFB4B9B42
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237886AbiBQIih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:38:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbiBQIif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:38:35 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F541FEBC3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:38:21 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id b22so4039495qkk.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PzuXVPjFmcUUVHKwIXrte3HBX8BURJUEg5zzn+5s7Jo=;
        b=Ise/Swb+ARooHxbiRSox9+sw6KLNtydJTX0M6dQcI25siZd8JVYqvquyJI5t4UNADq
         yw8/lpuxmUnit/Wbs8z7BIXczRHusoe5qb2rLiQ60uIScDNNY0zOOy/NBPBYNcF2EDEj
         cwOs9Qmp7Ctyi1QSZfS5BLq06hrIIwhXtls51OUb708RhZGUvXGu/E5NVJnUxQ25iswA
         uyRy12qCzJX6oZtr5VlAnrEFbikoIe9im6FHw2q3U1xKf4Iqt0YVa/8Qowg5IsMLGili
         EbaoLbv+LSTiPK5n9EAMwXQx56Y5jBRoZu06PEt90eyLrYGrW3bnRBew/XPPoEukcgKq
         65Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PzuXVPjFmcUUVHKwIXrte3HBX8BURJUEg5zzn+5s7Jo=;
        b=6PJv0a0U8tCJtoI+Eq+aqOtERhJ/hNGiTJjgxang1sJt4nCLqYjjH1VRtPP+Z9Rnqo
         3K6BVVYKOIrsNXH16PKrHyQh6trv3wLUIysRyM8sO+rLo+fiXbcUn2sFwK8b732/YaG4
         TFTysXTtGGEXVlFR+pz3Wdew+/+oPiBSbl905w5huQamCmwTrroaUUYBIks4/lU3kCuB
         3bT8cTlUJiS/q6L90gKJ5dRHZrQdqgYtM1xZYtObcJvCkuhCSDm4edyfdFXsnj3ypHOD
         r0JOc+4uCKkz3EMfeD742fn/7asXzlnHz6WL/s+EKC5cfG4/9S6kQr9xQs08jwtkZaeG
         /mLA==
X-Gm-Message-State: AOAM531sUG0wXvAxChqy+snUz5IIyZFQgmNn5lA8bVh+T2JBFeUe3bt+
        NkH7x6kEOCPgdCGokunGElF0VCpDcEU=
X-Google-Smtp-Source: ABdhPJzMsVEHQOcswCAu08XNscGj5ji3sFyM2YXVu1Kmsvbqnei4CzbjdjbAYIznLrlUXM7d3nZBuw==
X-Received: by 2002:a37:9102:0:b0:5f1:8c87:1dda with SMTP id t2-20020a379102000000b005f18c871ddamr910945qkd.37.1645087100966;
        Thu, 17 Feb 2022 00:38:20 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x7sm1582146qto.42.2022.02.17.00.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 00:38:20 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: si.hao@zte.com.cn
To:     catalin.marinas@arm.com, will@kernel.org,
        pasha.tatashin@soleen.com, si.hao@zte.com.cn,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yang.yang29@zte.com.cn, zealci@zte.com.cn
Subject: [PATCH v2] arm64: kexec: Support the case of VA_BITS=39 in trans_pgd_idmap_page()
Date:   Thu, 17 Feb 2022 08:37:34 +0000
Message-Id: <20220217083734.1903109-1-si.hao@zte.com.cn>
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

From: sihao <si.hao@zte.com.cn>

fsl64() may get different values due to different physical addresses. Is
it possible to confirm the value of max_msb with CONFIG_ARM64_VA_BITS?

Reported-by: sihao <si.hao@zte.com.cn>
Signed-off-by: sihao <si.hao@zte.com.cn>
Reviewed-by: CatalinMarinas <catalin.marinas@arm.com>
---
Changes in V1:

Refer to: https://lore.kernel.org/lkml/20220121065216.1001021-1-si.hao@zte.com.cn/

When the values of CONFIG_ARM64_VA_BITS and CONFIG_ARM64_PA_BITS are not
equal, the following panic occurs when kexec is executed. 
This happens because trans_pgd_idmap_page() does not support VA_BITS=39.
So the patch supports the case of VA_BITS=39.

 arch/arm64/mm/trans_pgd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index d7da8ca40d2e..23c74f9c5790 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -232,7 +232,7 @@ int trans_pgd_idmap_page(struct trans_pgd_info *info, phys_addr_t *trans_ttbr0,
 {
 	phys_addr_t dst_addr = virt_to_phys(page);
 	unsigned long pfn = __phys_to_pfn(dst_addr);
-	int max_msb = (dst_addr & GENMASK(52, 48)) ? 51 : 47;
+	int max_msb = VA_BITS - 1;
 	int bits_mapped = PAGE_SHIFT - 4;
 	unsigned long level_mask, prev_level_entry, *levels[4];
 	int this_level, index, level_lsb, level_msb;
-- 
2.25.1

