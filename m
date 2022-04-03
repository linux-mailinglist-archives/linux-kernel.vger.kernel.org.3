Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A987D4F094F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 14:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357638AbiDCMVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 08:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbiDCMVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 08:21:21 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76E03467E
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 05:19:27 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j8so6041547pll.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 05:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=RShXJBNVQcxmpPDml0HJbk+LkoGJyZhOEELj1lVtbec=;
        b=ASJ/uTPqb3VVSeNcAbp/2MzxUbyvy50wiLrqZDmqGEYwccN7mrIFuq2OD45vQ6Cqd0
         5/SUkAf4QGZVRDwJhnFc6AR4Akd8JgP1Ri6SOd3GBHlqUzmn2nf0Wlm5E89DqxKOj7nn
         xKQdTmz/c/hKXtQ5BBsbm6DFU3CrpLDR9JfyWF4TOZonwBgKWNJUBVIFudEUScJgqto9
         1XFMuZhYlgHUvGg9TJne/FGV94UscJRufy3/bxlHDtcmRqnQ9vAPsdVlBR7aA694Ih57
         xqYbPEwz8xW0aoOWmbIF3In4VdnwmUsK03Tkj6Tk9AhUZny1MpIRAukpUqhxDp9kxkWO
         dw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RShXJBNVQcxmpPDml0HJbk+LkoGJyZhOEELj1lVtbec=;
        b=TizSPTQr9xfuJqNzvH0MbHHvyGVmzfLJTHeL5LAVcjHpq/pnoSmWBiuZf3cVXzdqOl
         ZsFGo7e24pfFL04XCKtjbRHda6d3li48m8mPHSCYCJrVK1UIWVQM3F5ShXMXXw/6AK8b
         VefC+g82TjsOYH2v/i7e8818OxJTYM8cC38NsVTnhiW5j5hnu2jw2PuRO+a5DF9UDMwh
         zIwhbdfJEUglPAB4Oa/fiTaB3CnzPMD7yf+K4E9/AM3QGnr5FCMWfnC1h35NfFRQeA7d
         XU3o8eaktYxeyi1GBdJSQimqdG66bqaq3OqJ0tjcV6K1eqAST21zuZYpd/UdP7qw0BtU
         tYuQ==
X-Gm-Message-State: AOAM5332k6A4z9WnIgR+MFNS5ajvdoPvtj+kteQipiunxyxg7wboR2BQ
        Py8Ajnfd1eNvKit9vBZKVc9JWlbu+83I1FENTnE=
X-Google-Smtp-Source: ABdhPJzJ180xuZCo6a/vyAI5wNXF0oUceznq7n1YZj4xX5GZFmrnqYFXuyvtiBLWAo0hSxO/XJ2jTg==
X-Received: by 2002:a17:90a:7403:b0:1ca:7de0:8cf9 with SMTP id a3-20020a17090a740300b001ca7de08cf9mr3869047pjg.74.1648988367280;
        Sun, 03 Apr 2022 05:19:27 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id o14-20020a056a0015ce00b004fab49cd65csm8604019pfu.205.2022.04.03.05.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 05:19:26 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Paul Mackerras <paulus@samba.org>,
        Shlomi Gridish <gridish@freescale.com>,
        Kim Phillips <kim.phillips@freescale.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] soc: fsl: qe: Fix refcount leak in par_io_of_config
Date:   Sun,  3 Apr 2022 12:19:20 +0000
Message-Id: <20220403121920.4788-1-linmq006@gmail.com>
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

The device_node pointer is returned by of_parse_phandle() with
refcount incremented. We should use of_node_put() on it when done.
This function only calls of_node_put() in the regular path.
And it will cause refcount leak in error path.

Fixes: 986585385131 ("[POWERPC] Add QUICC Engine (QE) infrastructure")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/soc/fsl/qe/qe_io.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_io.c b/drivers/soc/fsl/qe/qe_io.c
index a5e2d0e5ab51..9f5f746bea88 100644
--- a/drivers/soc/fsl/qe/qe_io.c
+++ b/drivers/soc/fsl/qe/qe_io.c
@@ -159,12 +159,12 @@ int par_io_of_config(struct device_node *np)
 	pio_map = of_get_property(pio, "pio-map", &pio_map_len);
 	if (pio_map == NULL) {
 		printk(KERN_ERR "pio-map is not set!\n");
-		return -1;
+		goto err_node_put;
 	}
 	pio_map_len /= sizeof(unsigned int);
 	if ((pio_map_len % 6) != 0) {
 		printk(KERN_ERR "pio-map format wrong!\n");
-		return -1;
+		goto err_node_put;
 	}
 
 	while (pio_map_len > 0) {
@@ -182,5 +182,9 @@ int par_io_of_config(struct device_node *np)
 	}
 	of_node_put(pio);
 	return 0;
+
+err_node_put:
+	of_node_put(pio);
+	return -1;
 }
 EXPORT_SYMBOL(par_io_of_config);
-- 
2.17.1

