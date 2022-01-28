Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844D649F31D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 06:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346213AbiA1FoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 00:44:20 -0500
Received: from foss.arm.com ([217.140.110.172]:49520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346194AbiA1FoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 00:44:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFA76113E;
        Thu, 27 Jan 2022 21:44:17 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.44.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 89D673F766;
        Thu, 27 Jan 2022 21:44:13 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh@kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/2] perf: Expand captured branch types
Date:   Fri, 28 Jan 2022 11:14:11 +0530
Message-Id: <1643348653-24367-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Branch Record Buffer Extension (BRBE) implementation on arm64 captures more
branch type classification which cannot be accommodated in the current perf
branch record format via perf_branch_entry.type element. To overcome this
limitation, perf_branch_entry.type needs to be expanded along with generic
branch classification.

This series achieves this expansion. But before that it adds more generic
branch classification types which can be accommodated without any changes,
while also updating the x86 implementation as required.

This series applies on v5.17-rc1

Please find BRBE captured branch type classification reference here.

https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers/
BRBINF-n--EL1--Branch-Record-Buffer-Information-Register--n-?lang=en

Proposed perf branch stack enablement on arm64 platform can be found here.

https://lore.kernel.org/all/1642998653-21377-1-git-send-email-anshuman.khandual@arm.com/

These patches are split from the above series (PATCH 9/11, PATCH 10/11) as
these perf changes are pre-requisite for BRBE enablement. Although there is
another proposal (PATCH 11/11), extending struct perf_branch_entry further
to capture branch record privilege level information (priv, 2 bits), it is
not included here. But please do let me know if that proposal should also
be discussed in this series. Thank you.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (2):
  perf: Add more generic branch types
  perf: Expand perf_branch_entry.type

 arch/x86/events/intel/lbr.c           |  4 ++--
 include/uapi/linux/perf_event.h       | 15 +++++++++++++--
 tools/include/uapi/linux/perf_event.h | 15 +++++++++++++--
 tools/perf/util/branch.c              | 13 ++++++++++++-
 tools/perf/util/branch.h              |  4 ++--
 5 files changed, 42 insertions(+), 9 deletions(-)

-- 
2.25.1

