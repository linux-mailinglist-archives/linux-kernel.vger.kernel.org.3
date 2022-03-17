Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6934DCE60
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbiCQTD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237814AbiCQTDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:03:52 -0400
Received: from srv1.home.kabele.me (unknown [IPv6:2a02:768:2704:8c1a:3eec:efff:fe00:2ce4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 879081F6856;
        Thu, 17 Mar 2022 12:02:35 -0700 (PDT)
Received: from srv1.home.kabele.me (localhost [IPv6:::1])
        by srv1.home.kabele.me (Postfix) with ESMTP id A5CB41692B1;
        Thu, 17 Mar 2022 20:02:38 +0100 (CET)
Received: from localhost ([2a01:c22:8dfa:1400:beea:2810:7764:7afc])
        by srv1.home.kabele.me with ESMTPSA
        id hQBTJc6FM2L9WDQAnmUwTQ
        (envelope-from <vit@kabele.me>); Thu, 17 Mar 2022 20:02:38 +0100
Date:   Thu, 17 Mar 2022 20:02:33 +0100
From:   Vit Kabele <vit@kabele.me>
To:     platform-driver-x86@vger.kernel.org
Cc:     r.marek@assembler.cz, devel@acpica.org, mingo@redhat.com,
        robert.moore@intel.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 2/3 RESEND] acpica: Check that the EBDA pointer is in valid
 range
Message-ID: <YjOFyeR0OJfFsYjF@czspare1-lap.sysgo.cz>
Mail-Followup-To: platform-driver-x86@vger.kernel.org, r.marek@assembler.cz,
        devel@acpica.org, mingo@redhat.com, robert.moore@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <cover.1647526995.git.vit@kabele.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1647526995.git.vit@kabele.me>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the memory at 0x40e is uninitialized, the retrieved physical_memory
address of EBDA may be beyond the low memory (i.e. above 640K).

If so, the kernel may unintentionally access the VGA memory, that
might not be decoded or even present in case of virtualization.

Signed-off-by: Vit Kabele <vit@kabele.me>
Reviewed-by: Rudolf Marek <r.marek@assembler.cz>
---
 drivers/acpi/acpica/tbxfroot.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index 9fec3df6c3ba..67b7df1c0520 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -138,8 +138,11 @@ acpi_find_root_pointer(acpi_physical_address *table_address)
 	acpi_os_unmap_memory(table_ptr, ACPI_EBDA_PTR_LENGTH);
 
 	/* EBDA present? */
-
-	if (physical_address > 0x400) {
+	/* Check that the EBDA pointer from 0x40e is sane and does not point
+	 * above valid low memory
+	 */
+	if (physical_address > 0x400 &&
+	    physical_address < 0xA0000) {
 		/*
 		 * 1b) Search EBDA paragraphs (EBDA is required to be a
 		 *     minimum of 1K length)
-- 
2.30.2

