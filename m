Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D059159B95B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiHVGYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbiHVGYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:24:45 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8829527B31;
        Sun, 21 Aug 2022 23:24:31 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 817361E80CD1;
        Mon, 22 Aug 2022 14:20:46 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gnCIdN0Cp1uH; Mon, 22 Aug 2022 14:20:43 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: chuanjian@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id C442B1E80D2C;
        Mon, 22 Aug 2022 14:20:43 +0800 (CST)
From:   Dong Chuanjian <chuanjian@nfschina.com>
To:     rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org,
        Dong Chuanjian <chuanjian@nfschina.com>
Subject: [PATCH] tools/power/acpi/os_specific/service_layers/osunixxf.c:remove unnecessary (void*) conversions
Date:   Mon, 22 Aug 2022 14:24:20 +0800
Message-Id: <20220822062420.4815-1-chuanjian@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary void* type casting

Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>

diff --git a/tools/power/acpi/os_specific/service_layers/osunixxf.c b/tools/power/acpi/os_specific/service_layers/osunixxf.c
index b3651a04d68c..a7e65fb95caf 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixxf.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixxf.c
@@ -679,7 +679,7 @@ acpi_os_create_semaphore(u32 max_units,
 
 acpi_status acpi_os_delete_semaphore(acpi_handle handle)
 {
-	sem_t *sem = (sem_t *) handle;
+	sem_t *sem = handle;
 
 	if (!sem) {
 		return (AE_BAD_PARAMETER);
@@ -715,7 +715,7 @@ acpi_status
 acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 msec_timeout)
 {
 	acpi_status status = AE_OK;
-	sem_t *sem = (sem_t *) handle;
+	sem_t *sem = handle;
 	int ret_val;
 #ifndef ACPI_USE_ALTERNATE_TIMEOUT
 	struct timespec time;
@@ -832,7 +832,7 @@ acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 msec_timeout)
 
 acpi_status acpi_os_signal_semaphore(acpi_handle handle, u32 units)
 {
-	sem_t *sem = (sem_t *) handle;
+	sem_t *sem = handle;
 
 	if (!sem) {
 		return (AE_BAD_PARAMETER);
-- 
2.18.2

