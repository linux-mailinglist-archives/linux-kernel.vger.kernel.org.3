Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4021D509E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388690AbiDULGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354649AbiDULGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:06:43 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230DE2CE3A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 04:03:54 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q12so4319520pgj.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 04:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=b5cKgnHy5yIWx7IkuUyQsnSmFcYWr+B7twcbgmrD1pA=;
        b=obvkjUMexbjkc1qj09DfdFfiI7G7jgdbCm5eqjNe5hceKeW3SJk5IVv5dMWanBegdI
         X6Vg9585ErIRwvA80R7dx/hV2W2UMBriM6ncwqmUfHM/cwrNi8lau2sDMurX0LlfkDH1
         HMPR7megoF95tf+lL7wMYRcCDXs5yagS3e5bFYfMuSnmbDUPKPm/gjEZ0GpAdTIE+KeN
         RBpu2CtLHxwAZMrnZLGlbvJRYeJCimD3dwtlPQ/kZZQet1Z1g9/9K3kxVBviX+0Qa//W
         dO460VGTqbiM9wkrWJybohcQMcPO6BPDXV7OfqVmzZXka+agjeIJvtBRN85YoudByZIc
         KDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=b5cKgnHy5yIWx7IkuUyQsnSmFcYWr+B7twcbgmrD1pA=;
        b=agdTHxma8A7L2fLCGhLo2tlQNIQB3wIdTDIzbVsG5ieZ1hrR+3p6KMHTzTzQezxh9R
         r+7qffMXpGCkkffkGu9p8+NSwhw1Cie7j75HDEqiljTiP2rrTK4FEflkAGpjYsrKDeJ9
         kRPHmTPx4wr6fu+HeTd7VcTws6khBimLvduTkhtmnhxi+NPvtYAdKZHHMmXftRFS4c4g
         ndZ+W3YBnI4slbMfTSRI4ESLXT6p/aU9YQyHyr7cGM3f/LXVnWeHVjO+EbQI/P2ry0zS
         +rlBQNQKwVnGeOHLb8gYR+A15YFSMTud/0XoCmn7xIUfOiidwqJKKzQzhqF79fZXu21J
         3BTg==
X-Gm-Message-State: AOAM533pzJhXbKouRe3s0V4W6JaoviaTtP75aFpHm/5pD8XGYNbBwJt6
        ShYu4cvoT3A9v40nsRcLpjc=
X-Google-Smtp-Source: ABdhPJyYZCtFhdhMOk0AYGm3maxZ92nO7efmlTmc2GCYMV8UNCv698p1A6ja1HAXBQTX5iSeqJz19A==
X-Received: by 2002:a62:170b:0:b0:50a:6901:b633 with SMTP id 11-20020a62170b000000b0050a6901b633mr23204994pfx.34.1650539033603;
        Thu, 21 Apr 2022 04:03:53 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id q5-20020a056a00084500b0050ace4a699dsm5657964pfk.95.2022.04.21.04.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 04:03:53 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx35: Fix refcount leak in mx35_read_cpu_rev
Date:   Thu, 21 Apr 2022 19:03:44 +0800
Message-Id: <20220421110347.4304-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_compatible_node() function returns a node pointer with
refcount incremented, We should use of_node_put() on it when done
Add the missing of_node_put() to release the refcount.

Fixes: f68ea682d1da ("ARM: imx35: Retrieve the IIM base address from devicetree")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-imx/cpu-imx35.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/cpu-imx35.c b/arch/arm/mach-imx/cpu-imx35.c
index 80e7d8ab9f1b..3ae4a3dc44fb 100644
--- a/arch/arm/mach-imx/cpu-imx35.c
+++ b/arch/arm/mach-imx/cpu-imx35.c
@@ -22,6 +22,7 @@ static int mx35_read_cpu_rev(void)
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx35-iim");
 	iim_base = of_iomap(np, 0);
 	BUG_ON(!iim_base);
+	of_node_put(np);
 
 	rev = imx_readl(iim_base + MXC_IIMSREV);
 	switch (rev) {
-- 
2.17.1

