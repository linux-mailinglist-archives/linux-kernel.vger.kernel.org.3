Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B405047942B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhLQSkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:40:14 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:46084 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhLQSkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:40:12 -0500
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:ee0b:2663:4dc2:6747])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 0C311282A4F;
        Fri, 17 Dec 2021 19:40:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1639766411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=H2SKZv6WDFCLBPFkqaOhYWcJOAHmG0CfGPXMaenmT9I=;
        b=4fjx/eTmy5rFM6PibdCaLrRa9ZnGxxHVkTiqfercqe1MCdGEOS7BQw0/Va81YvDn7j1qVh
        4N0gKPutRwhP+VS1Fwnm7su68c5jXEFeO7T2bJzZUVCNVJSwQLOIRDQJHMQMA46mmGI/hv
        vZa7Np1VCvvFQofCY0//HU3uX+FcEy7U8cm3dglTrW9nx/OV9nEy0L0rJ4Cq/mru66e2ot
        HnThUgPI1FLs+q1VR8Ljp/mfzFU5aBGdzJoO/C94AkREOq3ltbBxWlwY9w71uZQElZx+jz
        E4LM3r9TK/LTf8Oru/dl6bNoV/NNKmDFwTzM5h3hRIPlslPq3EQLDvkG/acp8g==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-mips@vger.kernel.org
Cc:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>,
        INAGAKI Hiroshi <musashino.open@gmail.com>
Subject: [PATCH] MIPS: generic: enable SMP on SMVP systems
Date:   Fri, 17 Dec 2021 19:39:30 +0100
Message-Id: <20211217183930.16192-1-sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to CPS SMP setups, also try to initialise MT SMP setups with
multiple VPEs per CPU core. CMP SMP support is not provided as it is
considered deprecated.

Additionally, rework the code by dropping the err variable and make it
similar to how other platforms perform this initialisation.

Co-developed-by: INAGAKI Hiroshi <musashino.open@gmail.com>
Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 arch/mips/generic/init.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/mips/generic/init.c b/arch/mips/generic/init.c
index 1842cddd8356..1d712eac1617 100644
--- a/arch/mips/generic/init.c
+++ b/arch/mips/generic/init.c
@@ -110,14 +110,15 @@ void __init plat_mem_setup(void)
 
 void __init device_tree_init(void)
 {
-	int err;
-
 	unflatten_and_copy_device_tree();
 	mips_cpc_probe();
 
-	err = register_cps_smp_ops();
-	if (err)
-		err = register_up_smp_ops();
+	if (!register_cps_smp_ops())
+		return;
+	if (!register_vsmp_smp_ops())
+		return;
+
+	register_up_smp_ops();
 }
 
 int __init apply_mips_fdt_fixups(void *fdt_out, size_t fdt_out_size,
-- 
2.33.1

