Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA4847A3E4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 04:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbhLTDYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 22:24:18 -0500
Received: from smtpbg604.qq.com ([59.36.128.82]:54312 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234022AbhLTDYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 22:24:17 -0500
X-QQ-mid: bizesmtp48t1639970647t66ah7sm
Received: from localhost.localdomain (unknown [118.121.67.96])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 20 Dec 2021 11:24:05 +0800 (CST)
X-QQ-SSF: 01000000002000D0K000B00A0000000
X-QQ-FEAT: Z7q/N3OHGe84WMDAKKh1niE7bGmiiMVnpPotlMmuk40ljh59ew1pW8gG/ctug
        eHPFoO6mxxzlx1Jxxmva3EvDFYSUOs1I03gX8Jku454Ek7yqf7Sx6WHXnD9l/LizUXSmlYa
        DtDXxBYHx/236sMVk5Ux5hThSmm83p7ZG+1wDjhnW3tv3zpzobv3ypwxRlkhy6qI1T2CTld
        SawXK6jPtXMn+3eP3nnrrrRix5Kw8q7Clmlrp63Bv4WK1kRBBbZWZBPmBR2iwEU0aOA8Qt7
        RzqnU3NJuAR5CMpLZ5hwJHxoxwyGZfHOlMMRsd3K/85USlUvUB8teng1oAfyV6L4+gA6DFG
        R/P1070Gj5JCNPz6a3Afarn0T/xQw==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, wangborong@cdjrlc.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: use strscpy to copy strings
Date:   Mon, 20 Dec 2021 11:24:02 +0800
Message-Id: <20211220032402.630240-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strlcpy should not be used because it doesn't limit the source
length. So that it will lead some potential bugs.

But the strscpy doesn't require reading memory from the src string
beyond the specified "count" bytes, and since the return value is
easier to error-check than strlcpy()'s. In addition, the implementation
is robust to the string changing out from underneath it, unlike the
current strlcpy() implementation.

Thus, replace strlcpy with strscpy.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/powerpc/platforms/pasemi/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pasemi/misc.c b/arch/powerpc/platforms/pasemi/misc.c
index 1bf65d02d3ba..06a1ffd43bfe 100644
--- a/arch/powerpc/platforms/pasemi/misc.c
+++ b/arch/powerpc/platforms/pasemi/misc.c
@@ -35,7 +35,7 @@ static int __init find_i2c_driver(struct device_node *node,
 	for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
 		if (!of_device_is_compatible(node, i2c_devices[i].of_device))
 			continue;
-		if (strlcpy(info->type, i2c_devices[i].i2c_type,
+		if (strscpy(info->type, i2c_devices[i].i2c_type,
 			    I2C_NAME_SIZE) >= I2C_NAME_SIZE)
 			return -ENOMEM;
 		return 0;
-- 
2.34.1

