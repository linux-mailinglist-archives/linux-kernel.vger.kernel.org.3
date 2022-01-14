Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5895148E820
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbiANKQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:16:13 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:53910 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239765AbiANKQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:16:11 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-05 (Coremail) with SMTP id zQCowADnxxRTTeFh7l8zBg--.54455S2;
        Fri, 14 Jan 2022 18:15:47 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] ACPI/ACPICA: Check for NULL pointer after calling alloc
Date:   Fri, 14 Jan 2022 18:15:46 +0800
Message-Id: <20220114101546.1368163-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADnxxRTTeFh7l8zBg--.54455S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1UWw1fWw4DXw45KFW7Jwb_yoW8Xr43p3
        yaqFy7ArWxXF42ka1kXr4kWFW3GaykZry7KFWS9w1ava4rWFs8A3WqyryqvFy8Jrs7Ka18
        ZFsFkan8WFs093DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Gw1l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the possible failure of the allocation, object_info could be NULL
pointer.
Therefore, it should be better to check it in order to avoid the
dereference of the NULL pointer.
If fails, we should return 'AE_NON_MEMORY' and the caller
acpi_db_command_dispatch() will deal with the return status of
acpi_db_display_objects().
Also, the comment of the acpi_db_display_objects() is wrong.
So we need to correct it too.

Fixes: 995751025572 ("ACPICA: Linuxize: Export debugger files to Linux")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/acpi/acpica/dbnames.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
index 3615e1a6efd8..d8e5852fadb1 100644
--- a/drivers/acpi/acpica/dbnames.c
+++ b/drivers/acpi/acpica/dbnames.c
@@ -632,7 +632,7 @@ acpi_db_walk_for_specific_objects(acpi_handle obj_handle,
  * PARAMETERS:  obj_type_arg        - Type of object to display
  *              display_count_arg   - Max depth to display
  *
- * RETURN:      None
+ * RETURN:      Status
  *
  * DESCRIPTION: Display objects in the namespace of the requested type
  *
@@ -651,6 +651,8 @@ acpi_status acpi_db_display_objects(char *obj_type_arg, char *display_count_arg)
 	if (!obj_type_arg) {
 		object_info =
 		    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_object_info));
+		if (!object_info)
+			return (AE_NO_MEMORY);
 
 		/* Walk the namespace from the root */
 
-- 
2.25.1

