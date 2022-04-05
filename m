Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EED44F479E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351004AbiDEVO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443712AbiDEPkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F0E18500D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:58:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 568556190C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C5BC385A4;
        Tue,  5 Apr 2022 13:58:16 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] drivers/usb: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
Date:   Tue,  5 Apr 2022 14:57:54 +0100
Message-Id: <20220405135758.774016-7-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220405135758.774016-1-catalin.marinas@arm.com>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
operations while ARCH_KMALLOC_MINALIGN is the minimum kmalloc() objects
alignment.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/buffer.c  | 8 ++++----
 drivers/usb/misc/usbtest.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index fbb087b728dc..e21d8d106977 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -34,13 +34,13 @@ void __init usb_init_pool_max(void)
 {
 	/*
 	 * The pool_max values must never be smaller than
-	 * ARCH_KMALLOC_MINALIGN.
+	 * ARCH_DMA_MINALIGN.
 	 */
-	if (ARCH_KMALLOC_MINALIGN <= 32)
+	if (ARCH_DMA_MINALIGN <= 32)
 		;			/* Original value is okay */
-	else if (ARCH_KMALLOC_MINALIGN <= 64)
+	else if (ARCH_DMA_MINALIGN <= 64)
 		pool_max[0] = 64;
-	else if (ARCH_KMALLOC_MINALIGN <= 128)
+	else if (ARCH_DMA_MINALIGN <= 128)
 		pool_max[0] = 0;	/* Don't use this pool */
 	else
 		BUILD_BUG();		/* We don't allow this */
diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
index 150090ee4ec1..e13f7f6904ff 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -378,7 +378,7 @@ static void simple_fill_buf(struct urb *urb)
 
 static inline unsigned long buffer_offset(void *buf)
 {
-	return (unsigned long)buf & (ARCH_KMALLOC_MINALIGN - 1);
+	return (unsigned long)buf & (ARCH_DMA_MINALIGN - 1);
 }
 
 static int check_guard_bytes(struct usbtest_dev *tdev, struct urb *urb)
