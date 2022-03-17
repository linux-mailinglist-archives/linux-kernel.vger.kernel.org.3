Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9484DCE6A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbiCQTEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237814AbiCQTE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:04:27 -0400
Received: from srv1.home.kabele.me (unknown [IPv6:2a02:768:2704:8c1a:3eec:efff:fe00:2ce4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CBC6BD7CA;
        Thu, 17 Mar 2022 12:03:05 -0700 (PDT)
Received: from srv1.home.kabele.me (localhost [IPv6:::1])
        by srv1.home.kabele.me (Postfix) with ESMTP id C6C421692B3;
        Thu, 17 Mar 2022 20:03:08 +0100 (CET)
Received: from localhost ([2a01:c22:8dfa:1400:beea:2810:7764:7afc])
        by srv1.home.kabele.me with ESMTPSA
        id CG36LOyFM2ITWTQAnmUwTQ
        (envelope-from <vit@kabele.me>); Thu, 17 Mar 2022 20:03:08 +0100
Date:   Thu, 17 Mar 2022 20:03:03 +0100
From:   Vit Kabele <vit@kabele.me>
To:     platform-driver-x86@vger.kernel.org
Cc:     r.marek@assembler.cz, devel@acpica.org, mingo@redhat.com,
        robert.moore@intel.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 3/3 RESEND] acpica: Do not touch VGA memory when EBDA < 1KiB
Message-ID: <YjOF5y0Edc0IdSOR@czspare1-lap.sysgo.cz>
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

The ACPICA code assumes that EBDA region must be at least 1KiB in size.
Because this is not guaranteed, it might happen that while scanning the
memory for RSDP pointer, the kernel touches memory above 640KiB.

This is unwanted as the VGA memory range may not be decoded or
even present when running under virtualization.

Signed-off-by: Vit Kabele <vit@kabele.me>
Reviewed-by: Rudolf Marek <r.marek@assembler.cz>
---
 drivers/acpi/acpica/tbxfroot.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index 67b7df1c0520..b1f4a91044d9 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -114,6 +114,7 @@ acpi_find_root_pointer(acpi_physical_address *table_address)
 	u8 *table_ptr;
 	u8 *mem_rover;
 	u32 physical_address;
+	u32 ebda_window_size;
 
 	ACPI_FUNCTION_TRACE(acpi_find_root_pointer);
 
@@ -143,25 +144,32 @@ acpi_find_root_pointer(acpi_physical_address *table_address)
 	 */
 	if (physical_address > 0x400 &&
 	    physical_address < 0xA0000) {
+		/* Calculate the scan window size
+		 * The EBDA is not guaranteed to be larger than a KiB
+		 * and in case that it is smaller the scanning function would
+		 * leave the low memory and continue to the VGA range.
+		 */
+		ebda_window_size = ACPI_MIN(ACPI_EBDA_WINDOW_SIZE,
+					    0xA0000 - physical_address);
+
 		/*
-		 * 1b) Search EBDA paragraphs (EBDA is required to be a
-		 *     minimum of 1K length)
+		 * 1b) Search EBDA paragraphs
 		 */
 		table_ptr = acpi_os_map_memory((acpi_physical_address)
 					       physical_address,
-					       ACPI_EBDA_WINDOW_SIZE);
+					       ebda_window_size);
 		if (!table_ptr) {
 			ACPI_ERROR((AE_INFO,
 				    "Could not map memory at 0x%8.8X for length %u",
-				    physical_address, ACPI_EBDA_WINDOW_SIZE));
+				    physical_address, ebda_window_size));
 
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
 
 		mem_rover =
 		    acpi_tb_scan_memory_for_rsdp(table_ptr,
-						 ACPI_EBDA_WINDOW_SIZE);
-		acpi_os_unmap_memory(table_ptr, ACPI_EBDA_WINDOW_SIZE);
+						 ebda_window_size);
+		acpi_os_unmap_memory(table_ptr, ebda_window_size);
 
 		if (mem_rover) {
 
-- 
2.30.2

