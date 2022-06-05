Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1CD53DA55
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 08:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349199AbiFEGAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 02:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244081AbiFEGAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 02:00:48 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF24C20F6D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 23:00:47 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o17so9813121pla.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 23:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ysE83jJ6Rj+KdZGwx/lN3TOtV5szciIQ5SeiJ9lm3xA=;
        b=joXN6VFa/zS212kRkOBaaslZIZEQNAfdrdmvPnu+pzGUBcrZpZuD06kbp6765/EtU9
         EoaVxbNVy4GA+ThTyiF4OryCeG8K9CFVSJrndLz+aG9hmXCxsaZGS/ZFQo8lN3Vvey5B
         jObFZluzuTcxUcNaoSIbJGLe3HAdzqjCzCqExCv6QghAeUxWCKhK8HxMGixvX3p6QWSY
         2gH56QB6cqxbjreb5BdAjGDsWaUfvh9wHHWK8/fIHTKLH7kIc1a9nAvp4j8vXuadrkKp
         ALwEe2roz4Lf9CdKjwVyGtPKuCVwjS6P1gw4QFWthyXHI2jS0TPT7BKAdzE9MtAFaWrK
         nUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ysE83jJ6Rj+KdZGwx/lN3TOtV5szciIQ5SeiJ9lm3xA=;
        b=4LrtieG8n1quRgzXby8vLVs9yct6RVMRlIP3jp+TXb9CjRQDgyT99Zxfe9NDEi7A6b
         UrUEqVSeLWvTGnPkpeK4kFgJgQ0rfSrmSyHk6z0M54zKNANAFDc58Y+DHuBE6LANuvq3
         D373uRoBqIGNGfDP18X8qOZc4JBKtlhlbvH0cNoUeewar5rUodlNF7ecLjEdspndsbee
         mGXLNk0OflkHehZYxfjVZua/oKfyz3gUacwKUfpH5Vldrv9TNWjribze0BTfzq70RvNb
         SYInHUdz+VngPgOVOJitK8RMFQ9oAco7yC1YyzjDEm3bWDQUKJFrr4J/9spe4KHQc68H
         Dl2w==
X-Gm-Message-State: AOAM532DHN3x/7Ra3Y0OoFaGTIBwrq7pSy8k4aktI60P7qkxnt9AEIOT
        APtJh5zPWfesPE2qkjfoUIQ=
X-Google-Smtp-Source: ABdhPJzSRKj0blBkRBlUSCMYcB5IWuG6qNWQy7Pw40C6ZLjK3F/KhvGCZsmWFO9s6iL2JV3BzxFJ6w==
X-Received: by 2002:a17:903:1205:b0:15e:8cbc:fd2b with SMTP id l5-20020a170903120500b0015e8cbcfd2bmr18105312plh.99.1654408847301;
        Sat, 04 Jun 2022 23:00:47 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id k189-20020a6384c6000000b003fcde69fea5sm6261014pgd.81.2022.06.04.23.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 23:00:46 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Lombard <clombard@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] cxl: Fix refcount leak in cxl_calc_capp_routing
Date:   Sun,  5 Jun 2022 10:00:38 +0400
Message-Id: <20220605060038.62217-1-linmq006@gmail.com>
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
This function only calls of_node_put() in normal path,
missing it in the error path.
Add missing of_node_put() to avoid refcount leak.

Fixes: f24be42aab37 ("cxl: Add psl9 specific code")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/misc/cxl/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 3de0aea62ade..62385a529d86 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -387,6 +387,7 @@ int cxl_calc_capp_routing(struct pci_dev *dev, u64 *chipid,
 	rc = get_phb_index(np, phb_index);
 	if (rc) {
 		pr_err("cxl: invalid phb index\n");
+		of_node_put(np);
 		return rc;
 	}
 
-- 
2.25.1

