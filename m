Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92455ADD75
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbiIFCkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiIFCkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:40:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19A0564ED
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 19:40:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o2-20020a17090a9f8200b0020025a22208so6329545pjp.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 19:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=qXvn56tGZUzIlE7SITQ9TIrXvT0PTCFLe3C9HzRtSDs=;
        b=xUgb7lyGyDiDKO+Cstj2WrH1RkGFMSIfbsr3cZJ9FYkOmCgyQqLD3eJWKDfbKP48gl
         PGwDvboFNGPadYMwd0el8lcnI6L6RVQInNUc+A/WHvE5kHuwYJ4rWzLZ44gUzSKstJQg
         /BjXJXyBvPbSaR/dmb9qFN8IRfoP2S/Fj4Et+7LywaFFRHe7zyk1pOm8XpzBFUKgWOeB
         6bQ66j8D7pttWNRA9svgk76b5SMXEgBrU1ByVo88l31qjwEWCZP5vn1ef3Pzj900WueD
         bD2JHWNk6VLPKV0Hc+DI6UBuRhKMzAo7nXvBDgfOh+szgFyxQ4nSSXzoAwtSTEhwVf1T
         tFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=qXvn56tGZUzIlE7SITQ9TIrXvT0PTCFLe3C9HzRtSDs=;
        b=YxxcWnF9EQellZ0h4XIdE2fSe2zVwx+30OWC54F7u59JWMgPgY5Qo8QtW5iPh2DRtW
         pSc8rdPflILZbGqMuNEo9mGLurUKdKR/XD24Y3/VuKDM3HjqwcEMp//I5bUsR1Z0Ef8s
         bDa1ht8ivdv5Z1CS+eaUV/03M/5WkPP+4dTeyrzrEBcLoxDZet/fPYNt2tRY3b5xj4wV
         c6SkM50DzYmXM3IEaIhbRoWW7obHkNoI+FUK305UTljgJmwy1h1qGIgFlPjjUD0Y04zB
         +JL9lOs6UEXlCj4zmdwe/3qIyd7UVEIdAmeudlXEIixHzMdKPoprey9+2IVtaQsb+AIg
         yf3Q==
X-Gm-Message-State: ACgBeo1h6w6nV13S0TLsFrqKvd5OiMAitdF7O+CQXF757LMd+ISLRor0
        GmIlps+pgGKNKymRsxFRONOxsQ==
X-Google-Smtp-Source: AA6agR6IB38yfxjiIr2V0xpEfs1sKu9sBaswjt+218cfW5YI0DZWhE6SAFabgXxKYDgobvmgx6cRlA==
X-Received: by 2002:a17:902:ce8f:b0:176:d5af:a175 with SMTP id f15-20020a170902ce8f00b00176d5afa175mr109997plg.123.1662432044184;
        Mon, 05 Sep 2022 19:40:44 -0700 (PDT)
Received: from localhost (n058152048222.netvigator.com. [58.152.48.222])
        by smtp.gmail.com with ESMTPSA id jn20-20020a170903051400b00172b5d1e054sm4951365plb.17.2022.09.05.19.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 19:40:43 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>, Ard Biesheuvel <ardb@kernel.org>,
        Bertrand Marquis <Bertrand.Marquis@arm.com>,
        Rahul Singh <Rahul.Singh@arm.com>,
        Julien Grall <jgrall@amazon.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH] irqchip/gic-v3: Don't reserve persistent memory for Xen domain
Date:   Tue,  6 Sep 2022 10:40:40 +0800
Message-Id: <20220906024040.503764-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For GICv3 with its redistributor, the driver needs to reserve the
persistent memory for LPI configuration and pending tables, so the
reserved pages will not be overwritten by secondary kernel launched by
kexec, the hardware can continue to use the pages for maintenance
LPI states.

When kernel runs in Xen domain, Xen uses FDT with encapsulating ACPI
table in device tree.  Therefore, the EFI stub is not invoked and
the memreserve table is not installed, this leads to the memory
cannot be reserved as persistent region and kernel reports oops:

[    0.403737] ------------[ cut here ]------------
[    0.403738] WARNING: CPU: 30 PID: 0 at drivers/irqchip/irq-gic-v3-its.c:3074 its_cpu_init+0x814/0xae0
[    0.403745] Modules linked in:
[    0.403748] CPU: 30 PID: 0 Comm: swapper/30 Tainted: G        W         5.15.23-ampere-lts-standard #1
[    0.403752] pstate: 600001c5 (nZCv dAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.403755] pc : its_cpu_init+0x814/0xae0
[    0.403758] lr : its_cpu_init+0x810/0xae0
[    0.403761] sp : ffff800009c03ce0
[    0.403762] x29: ffff800009c03ce0 x28: 000000000000001e x27: ffff880711f43000
[    0.403767] x26: ffff80000a3c0070 x25: fffffc1ffe0a4400 x24: ffff80000a3c0000
[    0.403770] x23: ffff8000095bc998 x22: ffff8000090a6000 x21: ffff800009850cb0
[    0.403774] x20: ffff800009701a10 x19: ffff800009701000 x18: ffffffffffffffff
[    0.403777] x17: 3030303035303031 x16: 3030313030303078 x15: 303a30206e6f6967
[    0.403780] x14: 6572206530312072 x13: 3030303030353030 x12: 3130303130303030
[    0.403784] x11: 78303a30206e6f69 x10: 6765722065303120 x9 : ffff80000870e710
[    0.403788] x8 : 6964657220646e75 x7 : 0000000000000003 x6 : 0000000000000000
[    0.403791] x5 : 0000000000000000 x4 : fffffc0000000000 x3 : 0000000000000010
[    0.403794] x2 : 000000000000ffff x1 : 0000000000010000 x0 : 00000000ffffffed
[    0.403798] Call trace:
[    0.403799]  its_cpu_init+0x814/0xae0
[    0.403802]  gic_starting_cpu+0x48/0x90
[    0.403805]  cpuhp_invoke_callback+0x16c/0x5b0
[    0.403808]  cpuhp_invoke_callback_range+0x78/0xf0
[    0.403811]  notify_cpu_starting+0xbc/0xdc
[    0.403814]  secondary_start_kernel+0xe0/0x170
[    0.403817]  __secondary_switched+0x94/0x98
[    0.403821] ---[ end trace f68728a0d3053b70 ]---

GICv3 interrupt controller is emulated by Xen hypervisor, this means the
LPI configuration table and pending table allocated by Linux kernel are
only emulated by software by not accessed by hardware, so it has no risk
to introduce race condition between the secondary kernel launched by
kexec and the physical interrupt controller.  And when the secondary
kernel is booting, it uses totally separate memory region from the
primary kernel, the secondary kernel can allocate its own LPI
configuration table and pending table and register them into Xen
hypervisor afterwards.

If look into the GIC implementation, LPI serves for message-based
interrupts (MSI), it comes from ITS or directly from MSI, and at the end
forward LPI to redistributor.  This means the physical LPIs are received
in Xen hypervisor (in EL2) and sets List Register for virtual CPU
interface (consumed in EL1).  Furthermore, to support the emulated LPIs,
the first question is how to connect virtual GICv3 with MSI, and then
it also requires Xen to emulate the ITS and redistributor; so far, Xen
hypervisor doesn't really emulate these hardware mechanism thus the
allocated LPI tables in Linux are not used by Xen hypervisor.

For above reasons, this patch simply skips to reserve persistent memory
for Xen domain so can mute the useless oops.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Bertrand Marquis <Bertrand.Marquis@arm.com>
Cc: Rahul Singh <Rahul.Singh@arm.com>
Cc: Julien Grall <jgrall@amazon.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5ff09de6c48f..9ba9984401de 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -34,6 +34,8 @@
 #include <linux/irqchip/arm-gic-v3.h>
 #include <linux/irqchip/arm-gic-v4.h>
 
+#include <xen/xen.h>
+
 #include <asm/cputype.h>
 #include <asm/exception.h>
 
@@ -2220,6 +2222,21 @@ static bool gic_check_reserved_range(phys_addr_t addr, unsigned long size)
 
 static int gic_reserve_range(phys_addr_t addr, unsigned long size)
 {
+	/*
+	 * When kernel runs in Xen domain, it misses to invoke the EFI stub,
+	 * thus the memreserve table is not installed; in this case, the
+	 * memory cannot be reserved as persistent region.
+	 *
+	 * On the other hand, the GICv3 controller is emulated by Xen
+	 * hypervisor, given a redistrubitor its LPI pending table and
+	 * configuration table are emulated by software but not manipulated
+	 * by hardware.  Therefore, it's not necessary to reserve them, for
+	 * kexec/kdump the secondary kernel can allocate new pages for these
+	 * two tables.
+	 */
+	if (xen_domain())
+		return 0;
+
 	if (efi_enabled(EFI_CONFIG_TABLES))
 		return efi_mem_reserve_persistent(addr, size);
 
-- 
2.34.1

