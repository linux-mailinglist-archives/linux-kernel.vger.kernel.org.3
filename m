Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC5E4EEE82
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346503AbiDANxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346490AbiDANw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:52:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C0E1C6483;
        Fri,  1 Apr 2022 06:51:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id CB0561F41AD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648821064;
        bh=D6HHjVxkjaNSQYpDgvwEk+llZiTyrRHbdq/ZOoDG6rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LUZHUjcmCUE2VmJHiAhRDw4Ka4RbZfwKueOMM7/s3ULtLQcQX/xJYyVHGxvbjZxoc
         GjfgSb/VcGGFvAYqU0xE8qPjtETk3gd+t6urWg1MNR0IDZV7zpeSm05fjApS/Ljr1S
         NbDsWnGils9jKI2w5d0APf5IfNqo3g7Iz7RQyqFSL/GCaWXbmQvkjDBSjFuWvkqt3V
         BPdIYGCYaAT2sXPneYgQAjxQjG0mFCt1+cwbo+NGxIsSvuoSsxkw0vKX6CgPjxnUCK
         betaRPBNtOkhJOEh1U3j9lA1tuk1SJVbDIK2eWfP5oGl+YD+mLCfWKjrSOV4ImtPZ8
         YCywSboYVwICg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, arnd@arndb.de,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nfraprado@collabora.com,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/2] mfd: syscon: Allow using spinlocks with regmap fast_io
Date:   Fri,  1 Apr 2022 15:50:47 +0200
Message-Id: <20220401135048.23245-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220401135048.23245-1-angelogioacchino.delregno@collabora.com>
References: <20220401135048.23245-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On at least some SoCs accessing MMIO regions is very fast and in some
cases acquiring a mutex for every IO operation brings a significant
overhead: this is also the rationale of regmap's fast_io configuration
parameter, which makes it switch to using a spinlock instead.

Since the typical use-case for syscon is to give access to misc system
registers (not representing any specific type of device) to one or more
other drivers, and since this is done via regmap anyway, allow such
devices to let syscon configure regmap with fast_io enabled and to let
this happen, add a Devicetree property "fast-io": when this is found,
syscon will set '.fast_io = true' in the regmap config.

Of course, it makes little sense to do that if a syscon node declares
a phandle to a hardware spinlock provider node, so we check for this
property only if no hwlock is present.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/mfd/syscon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 191fdb87c424..3fcd9afdb9ef 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -101,6 +101,10 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 		}
 	}
 
+	/* Checking for fast-io makes sense only if not using hwspinlock */
+	if (!syscon_config.use_hwlock && of_property_read_bool(np, "fast-io"))
+		syscon_config.fast_io = true;
+
 	syscon_config.name = kasprintf(GFP_KERNEL, "%pOFn@%llx", np,
 				       (u64)res.start);
 	syscon_config.reg_stride = reg_io_width;
-- 
2.35.1

