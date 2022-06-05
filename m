Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3480453DA9B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 08:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349564AbiFEGvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 02:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbiFEGvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 02:51:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9097654
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 23:51:39 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n10so10430703pjh.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 23:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WgLvepossqYxUVw9ClZad/mto5k7o8Anzm/y5Yj+fuA=;
        b=etC4GCeyd4d0cZcDWCELzE23ufOSBZ/Ogr0TO86ojbcgGscfaGC6SDrMeeSwcFjqGZ
         TpaKCFYcoR99z6vef37qqqJBvTX7jjM60fsMiO0tp/MRAvWIwix1gfChvOCq9/pWd+kN
         xvP/18vCCsPHDOhOjRiYZUIh0u0YbE9fwRcIPLswHhFO8nZIGAj/74XxtvUmieilR+4X
         foxckJGbCC+Gd+YHoTvZ3Ph402WEWV/Pr9ILFj7Xu74YUGyEHKeEeEayd4eFfX5eMlqV
         BkmH81FCAUEFVjUQRL7Ycsp6GWQbloIcCFqBZll3abLesa88xwhHeZj55EAIn4YScCl9
         NVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WgLvepossqYxUVw9ClZad/mto5k7o8Anzm/y5Yj+fuA=;
        b=mf4Sizujw2CBC/HhbmVLA7ETDvpi8ZRoOtZIuLHk+0wjM7/mKaPfRgQrIwoiRn4HRX
         uFiGbfWBV+8YX+Hqb45XeiJydwLsxnuCAmzGicrg5OH7j4Y+lF00uQpYb8K/bOPvZ7Lu
         K/mQI/x0rbsodteraB6X/r+0DS66jxBDZdUQ6q7kJJa+OKXcagcT/z9jFAK4tPiVNAk4
         t5P8/bcNFSDLI6X6QsHOcy7BfKVnuMNgjXiwAIanNe7P07SATOJ0UFzMK2lf97mb/EwQ
         R3HcS3yqyEzJpSGRbX7Mc51phSK5E8qib6I8eDqzzrPFqgR0Rd5bmTm4Hlnh7rALArDx
         VFug==
X-Gm-Message-State: AOAM532VNpkX81GUTfM5h1WlN0efXCWlqcx6go7wXgluTEKc7t3uRJIh
        ZJJUkrLErq4adyLs6RtTh94=
X-Google-Smtp-Source: ABdhPJzVgwC+hEi6kwStpzn4oICo4kcq38lduufTqJH4dyo3N8ef1ZJFOaUBSHXH0ob6imm9qSJoqA==
X-Received: by 2002:a17:90a:c202:b0:1e2:e772:5f0a with SMTP id e2-20020a17090ac20200b001e2e7725f0amr19758314pjt.109.1654411898813;
        Sat, 04 Jun 2022 23:51:38 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id r6-20020a170902be0600b00162037fbacdsm8194582pls.187.2022.06.04.23.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 23:51:38 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] powerpc/cell/axon_msi: Fix refcount leak in setup_msi_msg_address
Date:   Sun,  5 Jun 2022 10:51:29 +0400
Message-Id: <20220605065129.63906-1-linmq006@gmail.com>
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

of_get_next_parent() returns a node pointer with refcount incremented,
we should use of_node_put() on it when not need anymore.
Add missing of_node_put() in the error path to avoid refcount leak.

Fixes: ce21b3c9648a ("[CELL] add support for MSI on Axon-based Cell systems")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/powerpc/platforms/cell/axon_msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index f3291e957a19..5b012abca773 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -223,6 +223,7 @@ static int setup_msi_msg_address(struct pci_dev *dev, struct msi_msg *msg)
 	if (!prop) {
 		dev_dbg(&dev->dev,
 			"axon_msi: no msi-address-(32|64) properties found\n");
+		of_node_put(dn);
 		return -ENOENT;
 	}
 
-- 
2.25.1

