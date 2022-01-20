Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40BB495181
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376673AbiATPds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:33:48 -0500
Received: from mail-108-mta72.mxroute.com ([136.175.108.72]:37637 "EHLO
        mail-108-mta72.mxroute.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346385AbiATPdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:33:46 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Jan 2022 10:33:46 EST
Received: from filter004.mxroute.com ([149.28.56.236] filter004.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta72.mxroute.com (ZoneMTA) with ESMTPSA id 17e781aa05f000bdf2.004
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Thu, 20 Jan 2022 15:28:37 +0000
X-Zone-Loop: c327753b08390804ea7040d86b10ac987a6a94d25386
X-Originating-IP: [149.28.56.236]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ds0.me; s=x
        ; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JVQnv3AVsUWy3ZjxZJjNI7QObG4R6sq0+QS/JmmuFdE=; b=BHtxwMqbuCOrh5i+9PW87UjR3Z
        shdKUIWt8HVX/Q4R5RJ8L8tXXo5mt+zn8ZqWivYivdEdEDt9H17hFYjryZr3HEG+FBZmv3/x2ggoL
        Err2M46S5F0MdpUug5lgrHjIxkBl7rl5VJ/rqWM9CyKbqHIhRAkEkNhACM2gHnUKHO8bbM8HgI9Fj
        BPxWEfhvjzRCvjMvrOBtBtlkANGH/tTHcoaqHyLz2q/L/HftRq2MK5pytRjgPiXeJe1OCN4wkhl8L
        jVZyYhyqgGaTBxBFjUgid4GrGm92sxKaNclKxesBXV2Jg/GKdGeq5W4pkDYUS/EJd/JlSQPIvxyNG
        5BfcLToQ==;
From:   Myrtle Shah <gatecat@ds0.me>
To:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] riscv: Fix XIP_FIXUP_FLASH_OFFSET
Date:   Thu, 20 Jan 2022 15:28:27 +0000
Message-Id: <20220120152828.4089364-2-gatecat@ds0.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120152828.4089364-1-gatecat@ds0.me>
References: <20220120152828.4089364-1-gatecat@ds0.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: dave@ds0.me
X-Zone-Spam-Resolution: no action
X-Zone-Spam-Status: No, score=5, required=15, tests=[ARC_NA=0,
 MID_CONTAINS_FROM=1, FROM_HAS_DN=0, RCPT_COUNT_THREE=0,
 R_MISSING_CHARSET=2.5, RCVD_COUNT_ZERO=0, FROM_EQ_ENVFROM=0, MIME_TRACE=0,
 BROKEN_CONTENT_TYPE=1.5, TO_DN_NONE=0, NEURAL_SPAM=0]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were several problems with the calculation. Not only was an 'and'
being computed into t1 but thrown away; but the 'and' itself would
cause problems if the granularity of the XIP physical address was less
than XIP_OFFSET - in my case I had the kernel image at 2MB in SPI flash.

I believe this approach is more generic.

Fixes: f9ace4ede49b ("riscv: remove .text section size limitation for XIP")

Signed-off-by: Myrtle Shah <gatecat@ds0.me>
---
 arch/riscv/kernel/head.S | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 604d60292dd8..b1ca65abeb1e 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -21,14 +21,13 @@
 	add \reg, \reg, t0
 .endm
 .macro XIP_FIXUP_FLASH_OFFSET reg
-	la t1, __data_loc
-	li t0, XIP_OFFSET_MASK
-	and t1, t1, t0
-	li t1, XIP_OFFSET
-	sub t0, t0, t1
-	sub \reg, \reg, t0
+	la t0, __data_loc
+	REG_L t1, _xip_phys_offset
+	sub \reg, \reg, t1
+	add \reg, \reg, t0
 .endm
 _xip_fixup: .dword CONFIG_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFSET
+_xip_phys_offset: .dword CONFIG_XIP_PHYS_ADDR + XIP_OFFSET
 #else
 .macro XIP_FIXUP_OFFSET reg
 .endm
-- 
2.34.1

