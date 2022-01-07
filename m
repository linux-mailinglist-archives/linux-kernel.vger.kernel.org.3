Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA6D487A0D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239818AbiAGQBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:01:14 -0500
Received: from foss.arm.com ([217.140.110.172]:41996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbiAGQBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:01:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF3DA13D5;
        Fri,  7 Jan 2022 08:01:09 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.196.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B74743F66F;
        Fri,  7 Jan 2022 08:01:08 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: booting.rst: Cover Armv8-R64
Date:   Fri,  7 Jan 2022 16:00:56 +0000
Message-Id: <20220107160056.322141-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107160056.322141-1-andre.przywara@arm.com>
References: <20220107160056.322141-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a new revision of the ARMv8-R architecture [1], which
optionally introduces kernel compatibility - by introducing an MMU
into EL1 and EL0.
Linux can run on such an implementation, if it is entered in EL1 and
VMSA is both implemented and enabled for that exception level.

Clarify our kernel boot protocol to make this an officially supported
mode of operation, but also limit the expectations about running in
secure state (which is the only security state in v8-R).

Also we heavily rely on the Virtual Memory System Architecture (VMSA),
make this explicit in the text, as this allows to cover v8-R64 as well.

[1] https://developer.arm.com/documentation/ddi0600/latest/

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 Documentation/arm64/booting.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
index 07cb34ed4200..99fab4d7e7ad 100644
--- a/Documentation/arm64/booting.rst
+++ b/Documentation/arm64/booting.rst
@@ -167,8 +167,13 @@ Before jumping into the kernel, the following conditions must be met:
 
   All forms of interrupts must be masked in PSTATE.DAIF (Debug, SError,
   IRQ and FIQ).
-  The CPU must be in non-secure state, either in EL2 (RECOMMENDED in order
-  to have access  to the virtualisation extensions), or in EL1.
+  If the CPU supports two security states, Linux must be entered in
+  non-secure state, either in EL2 (RECOMMENDED in order to have access
+  to the virtualisation extensions) or in EL1.
+  If the CPU only supports a single security state, Linux can be run even
+  when this single state is "secure".
+  The exception level the kernel is entered in must support the VMSA
+  memory model.
 
 - Caches, MMUs
 
-- 
2.25.1

