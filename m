Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9033C479A25
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 11:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhLRKF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 05:05:27 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:34602 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhLRKFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 05:05:24 -0500
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:e9c7:274f:a8f6:5f25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id C72FC282FBC;
        Sat, 18 Dec 2021 11:05:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1639821923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2SKZv6WDFCLBPFkqaOhYWcJOAHmG0CfGPXMaenmT9I=;
        b=t2oZ9oVSOkAO/ti0EEg6BCyib0jP8RMYivk8MpZ+RRLk1ZiL0JnewS2ND31Um/1SKooqSM
        ZXBE1EkHxzBwptJStCP2YjYiMX1JI1PeJi316NW9sn3hUsfwPqXExdHfFvmmW+rAS89rpe
        M4GDGVZnaIBqrwqCQiDV3s6G18Ria8dqFFqdBr66kziPjk5lSHtkHGuvBx/D7O3I8nKDnW
        z/VcQxrkSNC4mWivDxXQ7SMzLzFqit94bVSVuqm/1tJGqtJVkgAMvcz2Ca6HQ4WHJtaDjS
        Y6dw8S6DDlOQKO8xtulnYCtLNCKXvPTTMhKt1YjwGgvcUhGA2fwpDovylpS9sw==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-mips@vger.kernel.org
Cc:     INAGAKI Hiroshi <musashino.open@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v2 2/2] MIPS: generic: enable SMP on SMVP systems
Date:   Sat, 18 Dec 2021 11:05:11 +0100
Message-Id: <20211218100511.42508-3-sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211218100511.42508-1-sander@svanheule.net>
References: <20211218100511.42508-1-sander@svanheule.net>
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

