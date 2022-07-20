Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8921557B6DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbiGTM4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbiGTM4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:56:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B281B252;
        Wed, 20 Jul 2022 05:56:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02BD915A1;
        Wed, 20 Jul 2022 05:56:03 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C81EA3F70D;
        Wed, 20 Jul 2022 05:56:00 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        Guenter Roeck <linux@roeck-us.net>, linux-acpi@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Subject: [PATCH v3 1/3] cacheinfo: Use atomic allocation for percpu cache attributes
Date:   Wed, 20 Jul 2022 13:55:38 +0100
Message-Id: <20220720-arch_topo_fixes-v3-1-43d696288e84@arm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220720-arch_topo_fixes-v3-0-43d696288e84@arm.com>
References: <20220720-arch_topo_fixes-v3-0-43d696288e84@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On couple of architectures like RISC-V and ARM64, we need to detect
cache attribues quite early during the boot when the secondary CPUs
start. So we will call detect_cache_attributes in the atomic context
and since use of normal allocation can sleep, we will end up getting
"sleeping in the atomic context" bug splat.

In order avoid that, move the allocation to use atomic version in
preparation to move the actual detection of cache attributes in the
CPU hotplug path which is atomic.

Cc: Ionela Voinescu <ionela.voinescu@arm.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 65d566ff24c4..4b5cd08c5a65 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -356,7 +356,7 @@ int detect_cache_attributes(unsigned int cpu)
 		return -ENOENT;
 
 	per_cpu_cacheinfo(cpu) = kcalloc(cache_leaves(cpu),
-					 sizeof(struct cacheinfo), GFP_KERNEL);
+					 sizeof(struct cacheinfo), GFP_ATOMIC);
 	if (per_cpu_cacheinfo(cpu) == NULL) {
 		cache_leaves(cpu) = 0;
 		return -ENOMEM;

-- 
b4 0.10.0-dev-54fef
