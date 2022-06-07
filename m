Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C9653F497
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbiFGDeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbiFGDe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:34:27 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BD352B19;
        Mon,  6 Jun 2022 20:34:26 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f9so3272372plg.0;
        Mon, 06 Jun 2022 20:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9ZV/P7UMxj9WhigT41C+LW4SlFc5LyNEmugmcXHXNuo=;
        b=LGku3SHTemGyfP0jmSQvlGv2PAi9vLvFv3xxjvx1lE2eMYco6VuT8MUFBJkQfhH1SP
         R4DwTJZR3OtcMiR8W4pKan0d55JJtuT1MTixI1bhUXSSIFNPNbd6gV7DmjazVakL5LHO
         nXRts8UrmJ39I68uMWzDZCRemIiODcAkP2r7h5P11Vmf2mGMJq4zpUoGIT67K0ck7Xif
         gQGevZiLL0neQZzQ+FQhNaY/hGdTsRPgzUmaNMiHyjc7O3Zc+CKe4/Zywroh0QZNrOWL
         wBmvnXxo9ksd383O2nplndogeN/gf8hC3agwQsbI9Rk8Drktf90NVPK6BC+513osSILk
         XHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ZV/P7UMxj9WhigT41C+LW4SlFc5LyNEmugmcXHXNuo=;
        b=l8j082fsCZYK8cs9A8bSOmrX+stgcP/3m/0Sv5CVd1Mp+k5gBt2kY5EtHxPffTWpVK
         pEh/NoAkZIOtb2kpiul4BW60h0w9gqqqknnDbxXHCilf/3pHvz+hahncXUhc4NkMyw2r
         0BO9VUw8KAMIH+d6OT6ySmcgzaFd10Jfg6dKV78K02l5LEZ4GD7LlH+5ytMQNjCV0YPy
         mFx9e/QRVj5UiVLtd4NUar944zI2wkrX6ikgL4X/AFfC+oX44WNid/WS0f6Uyw4Svlt0
         wgkcdRS7NqwnvJXtWr4wpcv0ym8WIsRL4+JClf5s7aDG+p+APfyT+R9SE9MUK9XL3eCD
         fEAQ==
X-Gm-Message-State: AOAM531ZZv3ON5yjooLvuxQthR9acpyyJeR6OdJlkhuCr7j6pJCHSq+D
        DpnFHN2mjzMGrwTvTP5hRv8=
X-Google-Smtp-Source: ABdhPJyRN2q0c27lJyTiX4ocCPgVPJEE4nzungwfhbKzMlC+X75Li/iCaQWNZ0CmQJmqpoD6typSKA==
X-Received: by 2002:a17:90b:1c8f:b0:1b8:c6dc:ca61 with SMTP id oo15-20020a17090b1c8f00b001b8c6dcca61mr29795986pjb.13.1654572865957;
        Mon, 06 Jun 2022 20:34:25 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id l24-20020a17090ac59800b001e25e3ba05csm16700350pjt.2.2022.06.06.20.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 20:34:25 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Miaoqian Lin <linmq006@gmail.com>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] sparc: kernel: Fix reference leak in jbusmc_probe
Date:   Tue,  7 Jun 2022 07:33:00 +0400
Message-Id: <20220607033306.688-3-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607033306.688-1-linmq006@gmail.com>
References: <20220607033306.688-1-linmq006@gmail.com>
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

of_find_node_by_path() returns a node pointer with refcount incremented,
we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: 85269eb5542b ("sparc64: Add JBUS UltraSPARC-IIIi support to memory controller driver.")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/sparc/kernel/chmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/kernel/chmc.c b/arch/sparc/kernel/chmc.c
index 6ff43df740e0..9cc1b92ffff9 100644
--- a/arch/sparc/kernel/chmc.c
+++ b/arch/sparc/kernel/chmc.c
@@ -409,6 +409,7 @@ static int jbusmc_probe(struct platform_device *op)
 		goto out;
 	}
 	mem_regs = of_get_property(mem_node, "reg", &len);
+	of_node_put(mem_node);
 	if (!mem_regs) {
 		printk(KERN_ERR PFX "Cannot get reg property of /memory node.\n");
 		goto out;
-- 
2.25.1

