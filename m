Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B72548368
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240743AbiFMJWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240718AbiFMJWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:22:37 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1CD13E16
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:22:33 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 25D9Kgx7000823;
        Mon, 13 Jun 2022 18:20:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 25D9Kgx7000823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655112043;
        bh=sUeQiGOXKyxAl0UcjFY0Rce/KrFiD5fobjE1eCXei3Y=;
        h=From:To:Cc:Subject:Date:From;
        b=tg5xx0WFjhtsWOYFCUHrzxlt1EIpxO7a0yE3L3du7kUgVp1E6TLXPi6gpOO04yr2e
         D7SWOpfowWBJbLp8NGBXeol+tTlojiNCRSaqVW0XzexYzV8LBN19Hu50s+wf82sz6t
         DGTw6LTVPBmGRZ7SLoQaN3EehFvjTU2fu7QS1L1diREfr7VD9gT9s/1wFAE7wcZ44a
         rbxJGz2RA2pn8neAKkszhzUo10+z27U6iRV+E9RB1AgKaTY2WA1N3nmS6wyL5scb1n
         ph9G/7oG8TJZyC1DTUI9mUtu1GVO9UY18PryP5+LxfwP2Lp/vp0Jc4B5vb3loDBmJc
         FmI3ACPNrSOLg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Keir Fraser <keirf@google.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] KVM: arm64: nvhe: rename confusing obj-y
Date:   Mon, 13 Jun 2022 18:20:25 +0900
Message-Id: <20220613092026.1705630-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Makefile appends several objects to obj-y from line 15, but none
of them is linked to vmlinux in an ordinary way.

obj-y is overwritten at line 30:

  obj-y := kvm_nvhe.o

So, kvm_nvhe.o is the only object directly linked to vmlinux.

Replace the abused obj-y with hyp-obj-y.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm64/kvm/hyp/nvhe/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index f9fe4dc21b1f..3c6d3a18171c 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -12,13 +12,13 @@ HOST_EXTRACFLAGS += -I$(objtree)/include
 lib-objs := clear_page.o copy_page.o memcpy.o memset.o
 lib-objs := $(addprefix ../../../lib/, $(lib-objs))
 
-obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
+hyp-obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
 	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o page_alloc.o \
 	 cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o
-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
+hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
-obj-$(CONFIG_DEBUG_LIST) += list_debug.o
-obj-y += $(lib-objs)
+hyp-obj-$(CONFIG_DEBUG_LIST) += list_debug.o
+hyp-obj-y += $(lib-objs)
 
 ##
 ## Build rules for compiling nVHE hyp code
@@ -26,7 +26,7 @@ obj-y += $(lib-objs)
 ## file containing all nVHE hyp code and data.
 ##
 
-hyp-obj := $(patsubst %.o,%.nvhe.o,$(obj-y))
+hyp-obj := $(patsubst %.o,%.nvhe.o,$(hyp-obj-y))
 obj-y := kvm_nvhe.o
 extra-y := $(hyp-obj) kvm_nvhe.tmp.o kvm_nvhe.rel.o hyp.lds hyp-reloc.S hyp-reloc.o
 
-- 
2.32.0

