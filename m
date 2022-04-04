Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3804F1142
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbiDDIt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239621AbiDDItf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:49:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8DB3B56B;
        Mon,  4 Apr 2022 01:47:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5E7761F4594A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649062058;
        bh=D6HHjVxkjaNSQYpDgvwEk+llZiTyrRHbdq/ZOoDG6rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QSIxsE45CjDX7/iYnmGN/pFbmRhviD905KjuKlVkffYcv5c58eojlKlvQIikbufDZ
         4Qq6xdGxg8yea3Tdv2pU1aQk2lB3P6XkXVSFkl/TDN4igCSP2qft3qx/ZMpO9KuXzB
         lQO9pH2wpl1my+sgvwuJ8O4fZyXPftI+QuLjQuFtU46bINczce3NXz2KdP9ATDYa5H
         i87nXRTjXMSMhpGQiPGn1ut9485i77Av5QOLn4miB8VYv/qPBR7dr1FBZGx4vtTdRV
         LGK2N4pPm6MnmLVV6wJtUL7voEUaIHnRZy+l/B71m7rG5fv37rJGziWDKLEzfHgfkY
         9UBspO3VLRh8g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, arnd@arndb.de,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nfraprado@collabora.com,
        kernel@collabora.com, krzysztof.kozlowski@linaro.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 1/2] mfd: syscon: Allow using spinlocks with regmap fast_io
Date:   Mon,  4 Apr 2022 10:47:31 +0200
Message-Id: <20220404084732.14096-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220404084732.14096-1-angelogioacchino.delregno@collabora.com>
References: <20220404084732.14096-1-angelogioacchino.delregno@collabora.com>
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

