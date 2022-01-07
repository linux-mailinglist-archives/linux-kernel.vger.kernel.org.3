Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2414487A0B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239859AbiAGQBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:01:11 -0500
Received: from foss.arm.com ([217.140.110.172]:41986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233028AbiAGQBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:01:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 847561435;
        Fri,  7 Jan 2022 08:01:08 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.196.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F88D3F66F;
        Fri,  7 Jan 2022 08:01:07 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: booting.rst: Clarify on requiring non-secure EL2
Date:   Fri,  7 Jan 2022 16:00:55 +0000
Message-Id: <20220107160056.322141-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107160056.322141-1-andre.przywara@arm.com>
References: <20220107160056.322141-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARMv8.4 architecture revision introduced the EL2 exception level
to the secure world. Clarify the existing wording to make sure that
Linux relies on being executed in the non-secure state.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 Documentation/arm64/booting.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
index 52d060caf8bb..07cb34ed4200 100644
--- a/Documentation/arm64/booting.rst
+++ b/Documentation/arm64/booting.rst
@@ -10,9 +10,9 @@ This document is based on the ARM booting document by Russell King and
 is relevant to all public releases of the AArch64 Linux kernel.
 
 The AArch64 exception model is made up of a number of exception levels
-(EL0 - EL3), with EL0 and EL1 having a secure and a non-secure
-counterpart.  EL2 is the hypervisor level and exists only in non-secure
-mode. EL3 is the highest priority level and exists only in secure mode.
+(EL0 - EL3), with EL0, EL1 and EL2 having a secure and a non-secure
+counterpart.  EL2 is the hypervisor level, EL3 is the highest priority
+level and exists only in secure mode. Both are architecturally optional.
 
 For the purposes of this document, we will use the term `boot loader`
 simply to define all software that executes on the CPU(s) before control
@@ -167,8 +167,8 @@ Before jumping into the kernel, the following conditions must be met:
 
   All forms of interrupts must be masked in PSTATE.DAIF (Debug, SError,
   IRQ and FIQ).
-  The CPU must be in either EL2 (RECOMMENDED in order to have access to
-  the virtualisation extensions) or non-secure EL1.
+  The CPU must be in non-secure state, either in EL2 (RECOMMENDED in order
+  to have access  to the virtualisation extensions), or in EL1.
 
 - Caches, MMUs
 
-- 
2.25.1

