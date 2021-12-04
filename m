Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1346C468217
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 04:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384120AbhLDDJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 22:09:09 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:57438
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244657AbhLDDJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 22:09:08 -0500
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2657E4019B;
        Sat,  4 Dec 2021 03:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638587142;
        bh=jcDoHCvgsu6eXt/oRTi0+yecaX7b2PiElaljnlYmQFg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Iy8EHRtxB2XrLuXBFF7sb3ComEJZbWKGJeThIxJ+2LUfunDPBGnUAVgKr2a/FdWCq
         jnJ6NssIRJXXEI+XGW/T9Rxvp1NwJl/B/tNesPPtaj23Jv9j7ONcmJlHDImk5DnED3
         l76ZtgVL0DzQ5/ndUibvruqIw2VP/KBgMalsqc3ZjzDLQzjB73Htbm7XSTsYY0fK9w
         IviovFV9wyE7ztq7bKkZ+6uDP1DF1ty8LVrcqarTQir49+Z4z0dM4C2oRBacwW3t6w
         YItiVW3nDTaLhvu1SDQBHNi5xrHCmhiC4akyBmYduqMjfDrR1mySZiH7KoHupx7mQ9
         EsGiOem0RZp9w==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     mika.westerberg@linux.intel.com, andy@kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: intel: Assume 0 by default for PNP UID
Date:   Sat,  4 Dec 2021 11:04:52 +0800
Message-Id: <20211204030452.1482507-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's an EHL board that the DSDT doesn't have _UID for pinctrl device,
and that causes a NULL pointer dereference in strcmp().

So in the absence of _UID, assume it's 0 by default to avoid the issue
and get a pinmap.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 85750974d1825..fbbff6d1683c2 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1602,14 +1602,16 @@ const struct intel_pinctrl_soc_data *intel_pinctrl_get_soc_data(struct platform_
 	const struct intel_pinctrl_soc_data **table;
 	struct acpi_device *adev;
 	unsigned int i;
+	char *uid;
 
 	adev = ACPI_COMPANION(&pdev->dev);
 	if (adev) {
 		const void *match = device_get_match_data(&pdev->dev);
+		uid = adev->pnp.unique_id ?: "0";
 
 		table = (const struct intel_pinctrl_soc_data **)match;
 		for (i = 0; table[i]; i++) {
-			if (!strcmp(adev->pnp.unique_id, table[i]->uid)) {
+			if (!strcmp(uid, table[i]->uid)) {
 				data = table[i];
 				break;
 			}
-- 
2.32.0

