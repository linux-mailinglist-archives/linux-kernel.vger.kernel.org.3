Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D8E4C44A3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbiBYMbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240654AbiBYMbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:31:44 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0482177CA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:31:12 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s13so4265830wrb.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=E9tlm0bYbuFCL4eTySYXlyyWt4det591cN1hShBwdzQ=;
        b=Btqx1lawzvIvfIgGLkqYleHyukZjyOU0UBH8Cp/zSYvsvo6YJh3Of6HJfSMjTpXyQn
         LHtpX3ShlMTBu/Xai4U7LdaDIuauBSZuWqmEqJ42s66PpIPzcvpMULdoO1SYn/L6NzId
         +nXVaGDRTBLAeJpydy/KribbaO86n3IA/tBb6cJGrV8aIEs8xN6K4WBqMOTLoV2vE3VQ
         ebtyoUTxkNmEQPH/0jZQLsCNNaj+GnE/+3D08ll9RRWQ3Amf10MOVkVLxY/rg65l0L4h
         s58z88vYSQIFAM4pVxJxjRnt+cPvC8DlTFLSCK63H6PohNLqYpGyiN9PDSCow6CqnK0r
         VyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E9tlm0bYbuFCL4eTySYXlyyWt4det591cN1hShBwdzQ=;
        b=qeuGJFysrGiVbZNswFwosDeD8VEJEOuQF3wcuP+8hlac0ERuYET9NWO7azJmRN7vyC
         p+uBnd1xaob5To/avSyNqfhjR2bTQrtRGzC61QwjXFFvPvemZvz8460TCHlTsYA7PVCa
         IDS/gD2RqKn9uMXA2+bowcIPOdtv6LzcMkgknYWUIGMnpyQHgHgd3pGE4C3Z8Gp8/jDu
         +ZZH0cMWptz1TYZH6J+v9/kFj/DKuMcMaaibQ+U0mzurEZn/P2NNSDBjXQpsW1Ji2+hv
         trWYiqndyhzwZKHxkDvCffSF24bBlFUXuuXj7sc72p2WgdmOBt/Za7ssHxJLSrKIr7WT
         4kIQ==
X-Gm-Message-State: AOAM532JaqYe+fArqG1OpPfMM2gQ7jOnazzQwx8yxuEVT1wQi0b+7Aqh
        sw6R0+Cd0VFiUllHcrmNtaKN4sskOcrvHA==
X-Google-Smtp-Source: ABdhPJxn4BvWmB8zLAmoljV/5vQKrLhWruP+jEr409SbtGF0iePtwZTfBdSsX9qC7ZZdnnkbLna2AQ==
X-Received: by 2002:adf:f1c1:0:b0:1e3:1381:7bd5 with SMTP id z1-20020adff1c1000000b001e313817bd5mr6091442wro.450.1645792271218;
        Fri, 25 Feb 2022 04:31:11 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.58])
        by smtp.gmail.com with ESMTPSA id r18-20020a056000015200b001edc12960fdsm2140916wrx.67.2022.02.25.04.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 04:31:10 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     airlied@linux.ie
Cc:     linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] char: agp: intel-agp: check the return value of pci_find_capability()
Date:   Fri, 25 Feb 2022 04:31:00 -0800
Message-Id: <20220225123100.25995-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function pci_find_capability() in agp_intel_probe() can fail, so its
return value should be checked.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/char/agp/intel-agp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
index 9e4f27a6cb5a..6a7e385bde8a 100644
--- a/drivers/char/agp/intel-agp.c
+++ b/drivers/char/agp/intel-agp.c
@@ -730,6 +730,8 @@ static int agp_intel_probe(struct pci_dev *pdev,
 	int i, err;
 
 	cap_ptr = pci_find_capability(pdev, PCI_CAP_ID_AGP);
+	if (!cap_ptr)
+		return -ENODEV;
 
 	bridge = agp_alloc_bridge();
 	if (!bridge)
-- 
2.17.1

