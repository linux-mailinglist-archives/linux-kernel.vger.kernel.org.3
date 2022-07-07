Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366CB56AE15
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbiGGWFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbiGGWFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:05:02 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7E72B1BA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 15:05:01 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so120789wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 15:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B5wkC6bSg20bpLD4uQZm3lcPPl+j3uqj6NVt2WW5Mcg=;
        b=JoYnHtdqAYiT+36KpL4vd68z4rhaJnSSsg1xfE6U/TWcp9nowym0LLc5feUvF6cUvt
         FBUAoeUMgHU+d8gc/nAa9KYVpHAA6oc64AfaDNZLuPUl+oOt6hoTTzlVpA6g244CjRAC
         0b7eCJwc2WiueTqO7ly4o/mFQwqCHi5xTKI0OY3HTbmapB9RyS7H0ypUMkLfcxwySOUe
         H+bi7Sss1x8a7j145shtX+T2pXLMx4rZ8NewuiYN+dGyOs7RUfZXeqIbqn3mW9bBWIJK
         HbNIlILXJ2QlL38ltMXCL5N/aO9naJdqKNA0TMzNgFvBYDziN+CR6FNoB0EVmWiS/LoY
         hNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B5wkC6bSg20bpLD4uQZm3lcPPl+j3uqj6NVt2WW5Mcg=;
        b=lBLXjx4UMjIccKH21/5vc0I7kzkIkmp4a1w/Qx0I+lVGxs7KPImXw7MWY7iLQ28luI
         OwcT9dGFIkTupB8FgCoGIK2+/rrTgQI8nWIX7L50mor2GtaW7kZudsLTMOWV7y31O+S4
         A8ksnWlst46aExS/BQCRIJZ4KJSbLzoGYNcYprQ2fWWP1HtzzmwtKus+QrKmRIoKRgGE
         1mxzX5eLSRyIKqUYKnWK+HbjPxCc8szS0tyRT3BgEkg9j/75r8vpDtDpXGgRGldtH8cd
         wfVKaOdHqLRmjgyVHB4RlqzdsOLrEl6xsjEM5rNLBocIbxRDdKZtLR3T0b6WMLvnb+Mp
         gDPQ==
X-Gm-Message-State: AJIora9hTbS4Hekvk2xEVxoA4ZqDBUrEwvpw2VJZ3YewAdf2IqBZPgum
        /b6LVMIt69cRPVO3IL/B1dyQ5A==
X-Google-Smtp-Source: AGRyM1tnnzsxvhPG5IKs+YBZgLkAEtXKFH5kbjSLNkMp91lah456WA9wRpXL5hKIPbb8QYLBQN/YLA==
X-Received: by 2002:a05:600c:22d8:b0:3a0:4092:caff with SMTP id 24-20020a05600c22d800b003a04092caffmr7025020wmg.59.1657231499789;
        Thu, 07 Jul 2022 15:04:59 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id bn24-20020a056000061800b0020fe35aec4bsm38625743wrb.70.2022.07.07.15.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:04:59 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Zong Li <zong.li@sifive.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jonas Hahnfeld <hahnjo@hahnjo.de>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Changbin Du <changbin.du@intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Brice Goglin <Brice.Goglin@inria.fr>
Subject: [RFC 2/4] arch-topology: add a default implementation of store_cpu_topology()
Date:   Thu,  7 Jul 2022 23:04:35 +0100
Message-Id: <20220707220436.4105443-3-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220707220436.4105443-1-mail@conchuod.ie>
References: <20220707220436.4105443-1-mail@conchuod.ie>
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

From: Conor Dooley <conor.dooley@microchip.com>

RISC-V & arm64 both use an almost identical method of filling in
default vales for arch topology. Create a weakly defined default
implementation with the intent of migrating both archs to use it.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/base/arch_topology.c  | 19 +++++++++++++++++++
 include/linux/arch_topology.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 441e14ac33a4..07e84c6ac5c2 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -765,6 +765,25 @@ void update_siblings_masks(unsigned int cpuid)
 	}
 }
 
+void __weak store_cpu_topology(unsigned int cpuid)
+{
+	struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
+
+	if (cpuid_topo->package_id != -1)
+		goto topology_populated;
+
+	cpuid_topo->thread_id = -1;
+	cpuid_topo->core_id = cpuid;
+	cpuid_topo->package_id = cpu_to_node(cpuid);
+
+	pr_debug("CPU%u: package %d core %d thread %d\n",
+		 cpuid, cpuid_topo->package_id, cpuid_topo->core_id,
+		 cpuid_topo->thread_id);
+
+topology_populated:
+	update_siblings_masks(cpuid);
+}
+
 static void clear_cpu_topology(int cpu)
 {
 	struct cpu_topology *cpu_topo = &cpu_topology[cpu];
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index a07b510e7dc5..fee306b8a541 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -92,6 +92,7 @@ void update_siblings_masks(unsigned int cpu);
 void remove_cpu_topology(unsigned int cpuid);
 void reset_cpu_topology(void);
 int parse_acpi_topology(void);
+
 #endif
 
 #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
-- 
2.37.0

