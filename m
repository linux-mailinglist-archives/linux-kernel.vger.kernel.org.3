Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD5E52B76C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiERJeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbiERJdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:33:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6023EAFAF4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:33:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 210931042;
        Wed, 18 May 2022 02:33:53 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9DD953F66F;
        Wed, 18 May 2022 02:33:51 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 0/8] arch_topology: Updates to add socket support and fix cluster ids
Date:   Wed, 18 May 2022 10:33:17 +0100
Message-Id: <20220518093325.2070336-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This series intends to fix some discrepancies we have in the CPU topology
parsing from the device tree /cpu-map node. Also this diverges from the
behaviour on a ACPI enabled platform. The expectation is that both DT
and ACPI enabled systems must present consistent view of the CPU topology.

Currently we assign generated cluster count as the physical package identifier
for each CPU which is wrong. The device tree bindings for CPU topology supports
sockets to infer the socket or physical package identifier for a given CPU.
Also we don't check if all the cores/threads belong to the same cluster before
updating their sibling masks which is fine as we don't set the cluster id yet.

These changes also assigns the cluster identifier as parsed from the device tree
cluster nodes within /cpu-map without support for nesting of the clusters.
Finally, it also add support for socket nodes in /cpu-map. With this the
parsing of exact same information from ACPI PPTT and /cpu-map DT node
aligns well.

The only exception is that the last level cache id information can be
inferred from the same ACPI PPTT while we need to parse CPU cache nodes
in the device tree.

P.S: I have not cc-ed Greg and Rafael so that all the users of arch_topology
agree with the changes first before we include them.

v1[1]->v2:
	- Updated ID validity check include all non-negative value
	- Added support to get the device node for the CPU's last level cache
	- Added support to build llc_sibling on DT platforms

[1] https://lore.kernel.org/lkml/20220513095559.1034633-1-sudeep.holla@arm.com

Sudeep Holla (8):
  arch_topology: Don't set cluster identifier as physical package identifier
  arch_topology: Set thread sibling cpumask only within the cluster
  arch_topology: Set cluster identifier in each core/thread from /cpu-map
  arch_topology: Add support for parsing sockets in /cpu-map
  arch_topology: Check for non-negative value rather than -1 for IDs validity
  arch_topology: Avoid parsing through all the CPUs once a outlier CPU is found
  of: base: add support to get the device node for the CPU's last level cache
  arch_topology: Add support to build llc_sibling on DT platforms

 drivers/base/arch_topology.c  | 75 +++++++++++++++++++++++++++--------
 drivers/of/base.c             | 33 +++++++++++----
 include/linux/arch_topology.h |  1 +
 include/linux/of.h            |  1 +
 4 files changed, 85 insertions(+), 25 deletions(-)

--
2.36.1

