Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13344C9B1A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbiCBCU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiCBCUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:20:52 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5E28BF1E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 18:20:10 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id u16so562251pfg.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 18:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ut4FhFD89bZcY3y3faZEM5qMZpWcFX7wY9dfdN67y2k=;
        b=PI7qjJXOIkxen0fTtw2BH8lTxYwLVGDy3+/w//euncW4ziEjf5OwJv1idGU8cGDSeL
         tP2kKQpmtXKR6W+J4VsGvZxegrPIAERmISBIUIhN2CnJGXcn7FybAA86FNzaMNf/Y8K8
         jl9Fcu4KLOOT1/wOisQEXKtuHVtfEZrSGy0NwT0u+DypPW+twKw4YqZ7yq+AY/kZCjGj
         JW2QfvlkSlB2oU4Wf/lOZvzH2KznI6z0LHrff+lMTYGoIymuyvACNq2Af/1buJLvqttL
         nVB6hMVdB6i49tOyxO8PSZLO4cvKnuXV0ptScQFJCRuEbCPBl6Nz/m54T9EBNAzaFVhU
         8k6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ut4FhFD89bZcY3y3faZEM5qMZpWcFX7wY9dfdN67y2k=;
        b=2Wgfi5Ma5kBOm+BlX4Ho8eoZWmGNhFxFjzIzqLv1zPPa2J4CLn/EmoJvQqZmLHBMyT
         DsXCpBHAyz7lkmAXMnRpYOUK3I+kfxxDU+tWxyqKwZFse40eWoW/16oApItvkccBigFZ
         +RYItYUhb353E0ER+9eRFwI5Hhe5/CJWh34vamMCOrn3+khfLSjeGYcQLkR09o/gaAq/
         2VRghy0K/MlDsB7Cpm+l54W4g5BAPJkeeQO/gcmDT6JMhCStNKuyzsPpi9QH6klXshEN
         84No7/UKQXsvVjyzZN2+kY4T4ECb3Cvtpx9DwFm/Pxf6xqwvaGH9vV7EctqRMt/AylI9
         bUgQ==
X-Gm-Message-State: AOAM532p2dQD+5kFDnh9ObUCio6BpqDpGkSqDsURscZbjqNx0AIDhCbH
        XfgaS/Pv6Hjt5Cwc8YnKrVU=
X-Google-Smtp-Source: ABdhPJxFYXTMuT381NlVCmxAj19K234v4+6N1ZkK8rDABRKo76PGDqBEAqHfgaO40eSWXuBYOofIQA==
X-Received: by 2002:a05:6a00:cc7:b0:4ec:c6f3:ad29 with SMTP id b7-20020a056a000cc700b004ecc6f3ad29mr30774100pfv.66.1646187610156;
        Tue, 01 Mar 2022 18:20:10 -0800 (PST)
Received: from slim.das-security.cn ([103.84.139.53])
        by smtp.gmail.com with ESMTPSA id h5-20020a056a001a4500b004e177b8cbfdsm18589444pfv.197.2022.03.01.18.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 18:20:09 -0800 (PST)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        tyreld@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2] powerpc: kernel: fix refcount leak in format_show()
Date:   Wed,  2 Mar 2022 10:19:59 +0800
Message-Id: <20220302021959.10959-1-hbh25y@gmail.com>
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

Refcount leak will happen when format_show returns failure in multiple
cases. Unified management of of_node_put can fix this problem.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---

v2: 
1. change the title and description information. 
2. fix all possible refcount leak.

 arch/powerpc/kernel/secvar-sysfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index a0a78aba2083..1ee4640a2641 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -26,15 +26,18 @@ static ssize_t format_show(struct kobject *kobj, struct kobj_attribute *attr,
 	const char *format;
 
 	node = of_find_compatible_node(NULL, NULL, "ibm,secvar-backend");
-	if (!of_device_is_available(node))
-		return -ENODEV;
+	if (!of_device_is_available(node)) {
+		rc = -ENODEV;
+		goto out;
+	}
 
 	rc = of_property_read_string(node, "format", &format);
 	if (rc)
-		return rc;
+		goto out;
 
 	rc = sprintf(buf, "%s\n", format);
 
+out:
 	of_node_put(node);
 
 	return rc;
-- 
2.25.1

