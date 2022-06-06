Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E884753E83A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239366AbiFFOBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbiFFOBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:01:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A86771D5A9A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:01:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82B0315DB;
        Mon,  6 Jun 2022 07:01:17 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D26B3F73B;
        Mon,  6 Jun 2022 07:01:16 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     vincenzo.frascino@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH] arm64: Enable docker support in defconfig
Date:   Mon,  6 Jun 2022 15:01:03 +0100
Message-Id: <20220606140103.32779-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 defconfig does not support the docker usecase.

Enable the missing configuration options.

The resulting .config was validated with [1].

...

Generally Necessary:
- cgroup hierarchy: properly mounted [/sys/fs/cgroup]
- apparmor: enabled and tools installed
- CONFIG_NAMESPACES: enabled
- CONFIG_NET_NS: enabled
- CONFIG_PID_NS: enabled
- CONFIG_IPC_NS: enabled
- CONFIG_UTS_NS: enabled
- CONFIG_CGROUPS: enabled
- CONFIG_CGROUP_CPUACCT: enabled
- CONFIG_CGROUP_DEVICE: enabled
- CONFIG_CGROUP_FREEZER: enabled
- CONFIG_CGROUP_SCHED: enabled
- CONFIG_CPUSETS: enabled
- CONFIG_MEMCG: enabled
- CONFIG_KEYS: enabled
- CONFIG_VETH: enabled (as module)
- CONFIG_BRIDGE: enabled (as module)
- CONFIG_BRIDGE_NETFILTER: enabled (as module)
- CONFIG_IP_NF_FILTER: enabled (as module)
- CONFIG_IP_NF_TARGET_MASQUERADE: enabled (as module)
- CONFIG_NETFILTER_XT_MATCH_ADDRTYPE: enabled (as module)
- CONFIG_NETFILTER_XT_MATCH_CONNTRACK: enabled (as module)
- CONFIG_NETFILTER_XT_MATCH_IPVS: enabled (as module)
- CONFIG_NETFILTER_XT_MARK: enabled (as module)
- CONFIG_IP_NF_NAT: enabled (as module)
- CONFIG_NF_NAT: enabled (as module)
- CONFIG_POSIX_MQUEUE: enabled
- CONFIG_CGROUP_BPF: enabled

...

[1] https://github.com/moby/moby/blob/master/contrib/check-config.sh

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7d1105343bc2..f6b8eda18498 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -18,6 +18,7 @@ CONFIG_NUMA_BALANCING=y
 CONFIG_MEMCG=y
 CONFIG_BLK_CGROUP=y
 CONFIG_CGROUP_PIDS=y
+CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_HUGETLB=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_DEVICE=y
@@ -138,12 +139,16 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IPV6=m
 CONFIG_NETFILTER=y
+CONFIG_BRIDGE_NETFILTER=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_EVENTS=y
+CONFIG_NETFILTER_XT_MARK=m
 CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
 CONFIG_NETFILTER_XT_TARGET_LOG=m
 CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
 CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
+CONFIG_NETFILTER_XT_MATCH_IPVS=m
+CONFIG_IP_VS=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-- 
2.36.1

