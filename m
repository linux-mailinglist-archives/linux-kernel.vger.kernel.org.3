Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDB4579818
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbiGSLDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiGSLDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:03:51 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA824255BB;
        Tue, 19 Jul 2022 04:03:50 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPS id 9F00340D403D;
        Tue, 19 Jul 2022 11:03:48 +0000 (UTC)
From:   Andrey Strachuk <strochuk@ispras.ru>
To:     Mattia Dongili <malattia@linux.it>
Cc:     Andrey Strachuk <strochuk@ispras.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Len Brown <len.brown@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] platform/x86: remove useless comparisons in sony_pic_read_possible_resource()
Date:   Tue, 19 Jul 2022 14:03:41 +0300
Message-Id: <20220719110341.7239-1-strochuk@ispras.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local variable 'p' is initialized by an address
of field of acpi_resource structure, so it does
not make sense to compare 'p' with NULL.

Local variable 'io' is initialized by an address
of field of acpi_resource structure, so it does
not make sense to compare 'io' with NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
Fixes: 41b16dce3905 ("create drivers/platform/x86/ from drivers/misc/")
---
 drivers/platform/x86/sony-laptop.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index d8d0c0bed5e9..07ef05f727a2 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -4341,7 +4341,7 @@ sony_pic_read_possible_resource(struct acpi_resource *resource, void *context)
 		{
 			struct acpi_resource_irq *p = &resource->data.irq;
 			struct sony_pic_irq *interrupt = NULL;
-			if (!p || !p->interrupt_count) {
+			if (!p->interrupt_count) {
 				/*
 				 * IRQ descriptors may have no IRQ# bits set,
 				 * particularly those those w/ _STA disabled
@@ -4374,11 +4374,6 @@ sony_pic_read_possible_resource(struct acpi_resource *resource, void *context)
 			struct acpi_resource_io *io = &resource->data.io;
 			struct sony_pic_ioport *ioport =
 				list_first_entry(&dev->ioports, struct sony_pic_ioport, list);
-			if (!io) {
-				dprintk("Blank IO resource\n");
-				return AE_OK;
-			}
-
 			if (!ioport->io1.minimum) {
 				memcpy(&ioport->io1, io, sizeof(*io));
 				dprintk("IO1 at 0x%.4x (0x%.2x)\n", ioport->io1.minimum,
-- 
2.25.1

