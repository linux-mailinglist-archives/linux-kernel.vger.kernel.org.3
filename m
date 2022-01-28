Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB5D49FF92
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240002AbiA1RaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343690AbiA1RaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:30:12 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B19C061747
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:30:11 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:3999:e79d:cb59:f2ec])
        by xavier.telenet-ops.be with bizsmtp
        id oHW92600704fKGS01HW9pQ; Fri, 28 Jan 2022 18:30:09 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nDV4a-00C0CU-Vh; Fri, 28 Jan 2022 18:30:08 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nDV4a-007BhB-EK; Fri, 28 Jan 2022 18:30:08 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: mm: Remove check for VM_IO to fix deferred I/O
Date:   Fri, 28 Jan 2022 18:30:06 +0100
Message-Id: <20220128173006.1713210-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an application accesses a mapped frame buffer backed by deferred
I/O, it receives a segmentation fault.  Fix this by removing the check
for VM_IO in do_page_fault().

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
This check was never present in a fault handler on any other
architecture than m68k.
Some digging revealed that it was added in v2.1.106, but I couldn't find
an email with a patch adding it.  That same kernel version extended the
use of the hwreg_present() helper to HP9000/300, so the check might have
been needed there, perhaps only during development?
The Atari kernel relies heavily on hwreg_present() (both the success and
failure cases), and these still work, at least on ARAnyM.
---
 arch/m68k/mm/fault.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index 1493cf5eac1e7a39..71aa9f6315dc8028 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -93,8 +93,6 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	vma = find_vma(mm, address);
 	if (!vma)
 		goto map_err;
-	if (vma->vm_flags & VM_IO)
-		goto acc_err;
 	if (vma->vm_start <= address)
 		goto good_area;
 	if (!(vma->vm_flags & VM_GROWSDOWN))
-- 
2.25.1

