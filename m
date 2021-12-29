Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76E6481157
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 10:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbhL2JlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 04:41:13 -0500
Received: from mailgw.kylinos.cn ([123.150.8.42]:48075 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235116AbhL2JlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 04:41:12 -0500
X-UUID: 89a522aa61814586b5a8a5a2cfb8b7dd-20211229
X-CPASD-INFO: 1cea0e763c304cf6a9061f90561160c4@erOfgV2XZWZfg3V8g6axcIFqYGZhkll
        _d3BRYmRgj1SVhH5xTWJsXVKBfG5QZWNdYVN_eGpQYl9gZFB5i3-XblBhXoZgUZB3gKWfgWGTZw==
X-CPASD-FEATURE: 0.0
X-CLOUD-ID: 1cea0e763c304cf6a9061f90561160c4
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,EXT:0.0,OB:1.0,URL:-5,T
        VAL:198.0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:113.0,IP:-2.0,MAL:0.0,ATTNUM:0
        .0,PHF:-5.0,PHC:-5.0,SPF:4.0,EDMS:-3,IPLABEL:-2.0,FROMTO:0,AD:0,FFOB:1.0,CFOB
        :1.0,SPC:0.0,SIG:-5,AUF:70,DUF:28551,ACD:148,DCD:250,SL:0,AG:0,CFC:0.765,CFSR
        :0.057,UAT:0,RAF:0,VERSION:2.3.4
X-CPASD-ID: 89a522aa61814586b5a8a5a2cfb8b7dd-20211229
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1, 1
X-UUID: 89a522aa61814586b5a8a5a2cfb8b7dd-20211229
X-User: shenzijun@kylinos.cn
Received: from localhost.localdomain.localdomain [(172.17.127.14)] by nksmu.kylinos.cn
        (envelope-from <shenzijun@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1016694055; Wed, 29 Dec 2021 17:53:36 +0800
From:   shenzijun <shenzijun@kylinos.cn>
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, jinzi120021@sina.com
Subject: [PATCH] ACPICA: DEBUGGER: Add return value check to acpi_db_walk_for_fields()
Date:   Thu, 30 Dec 2021 01:40:58 +0800
Message-Id: <20211229174058.11350-1-shenzijun@kylinos.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zijun Shen <shenzijun@kylinos.cn>

The function acpi_db_walk_for_fields frees buffer.pointer by the
first ACPI_FREE. And then uses the second ACPI_FREE to free
buffer.pointer which may assigns again in acpi_evaluate_object.
It's necessary to make sure that buffer.pointer get a block of
memory in acpi_evaluate_object and acpi_evaluate_object return 0.

Signed-off-by: Zijun Shen <shenzijun@kylinos.cn>
---
 drivers/acpi/acpica/dbnames.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
index 3615e1a6efd8..7a2d980cb2b8 100644
--- a/drivers/acpi/acpica/dbnames.c
+++ b/drivers/acpi/acpica/dbnames.c
@@ -550,7 +550,10 @@ acpi_db_walk_for_fields(acpi_handle obj_handle,
 	ACPI_FREE(buffer.pointer);
 
 	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
-	acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
+	status = acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		return (AE_OK);
+	}
 
 	/*
 	 * Since this is a field unit, surround the output in braces
-- 
2.31.1

