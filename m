Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD8C534B01
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 09:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346418AbiEZHxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 03:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiEZHxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 03:53:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08269E03E
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:53:36 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ge11so1142736pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FKY1rhZkdMBMrUZfIZycOdY5avxDQ/iGSLMXJ6LNb9Y=;
        b=cOnZJZkCCOkLxMjqnILedHexQv4MnUbOCfd5g4h+kDF3L/Noq+vogXEzH2Qq8dsCHe
         FMsx5MJc5GUVWNVZv5ZxpforSlgXZ0RE3SLShVOWJomcSaSzExdB5rzk2u2vddlbpFG6
         PMBIXaPc+HXXJvFcEAjUQ8UG3JoJaUtzqC1Ks3Nh0dbLVT1YSqpK9cxf6LDRFfPHJOV0
         m0gkVelPUPm2YjYbDrQFQCRHYOVnARIGpwzbIMPmYbRbltnIxliimz36f3/YTcuTLGPX
         jcUGEM+njcXYJDAYRvGEH44cP8lOYBqnVEQ+64hJugvXNwp8OZaikuSAm3a4VAA5xjC+
         lewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FKY1rhZkdMBMrUZfIZycOdY5avxDQ/iGSLMXJ6LNb9Y=;
        b=DgjJVsx5ujiKaNRyGMTxNxH1qAk+eN8LzJ7FrIgjgPIhtxykhPyARXo9wfXvzDjE1Q
         hq4EzP/fDCaTIXL0/RpKH6mjIK1aW/eTR62xmAHmDO0RgCdDigAJhkXz8cjT3mRAiUyE
         CfFv987lqO6ctf8K5o4G3kBbE29g8/AY7zaWTeEYqbEQmCVBtmHrdhUKLL2P1WgHham5
         WG0Xm34f02E7MIx9FfyySiqE+Bb9U4cDCwk8d8Ccn6U9EWfj9+GKvJp7r/tpMJCUWgfI
         3dRAGD1S9/NX+p1saVfBF5B0PjLXVarywX7PUMtgTDz50vA6v2M8A8aEw9tvQNhtvNV2
         mhZw==
X-Gm-Message-State: AOAM530X5Tri0dWdaj1YTZssJAB6Hjuv2lysHYT7c5se/pekS/4DoEqQ
        Bhz9aHXW4c0eUInVNxLWx4lRIFwnt51daCMM
X-Google-Smtp-Source: ABdhPJxqBIu27yeZ8CeO+ejoJRAiquRkOF+CBgzynV7NDz/kiHon6lkshbFEPrrujS/uC6pdXy7keA==
X-Received: by 2002:a17:902:ce8f:b0:162:1aa9:f543 with SMTP id f15-20020a170902ce8f00b001621aa9f543mr21167302plg.123.1653551615494;
        Thu, 26 May 2022 00:53:35 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id q20-20020a170902789400b0015eaa9aee50sm747028pll.202.2022.05.26.00.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 00:53:35 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Kees Cook <keescook@chromium.org>,
        Helge Deller <deller@gmx.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Gareth Powell <gpowell@broadcom.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        Justin Chen <justinpopo6@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: bcm: brcmstb: pm: pm-arm: Fix refcount leak in brcmstb_pm_probe
Date:   Thu, 26 May 2022 11:53:22 +0400
Message-Id: <20220526075325.27356-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
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

of_find_matching_node() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

In brcmstb_init_sram, it pass dn to of_address_to_resource(),
of_address_to_resource() will call of_find_device_by_node() to take
reference, so we should release the reference returned by
of_find_matching_node().

Fixes: 0b741b8234c8 ("soc: bcm: brcmstb: Add support for S2/S3/S5 suspend states (ARM)")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/soc/bcm/brcmstb/pm/pm-arm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/bcm/brcmstb/pm/pm-arm.c b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
index 3cbb165d6e30..70ad0f3dce28 100644
--- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
+++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
@@ -783,6 +783,7 @@ static int brcmstb_pm_probe(struct platform_device *pdev)
 	}
 
 	ret = brcmstb_init_sram(dn);
+	of_node_put(dn);
 	if (ret) {
 		pr_err("error setting up SRAM for PM\n");
 		return ret;
-- 
2.25.1

