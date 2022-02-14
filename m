Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AF34B5D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 23:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiBNWXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 17:23:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiBNWXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 17:23:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4E0119405
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ww1QGfXGug1kfVK0CvJIkvChcPj8/zHSHJWlG6R0u8k=; b=kzv8IBGTl7YYgCwNS9CjxVMCzg
        2qltXo2fQ2unlreJTjEeWnRDwYXGoVjXsDFL9rrqQLGk75cgpKrKGUR1c91NL/UQGdsuXEL7fdq04
        3S/wu76nJEuBM0BtJWWm15lmR9XCdkv1SCRaWXlJ70RIjsDnDVJ6BtU8/dcqy6SDPnCJ3zr8yC3ua
        v06MsrMSh6+zjpG7wLCmI+XUoBOvm+6ZeNpw0xZi7cEYVPHsb6/LbERszKJSVoEPnG2pPVpD/Lbzs
        98MppXlVHoHfc3LoOzIDY0HaPlpnB83oESJcAPmbWfPNVK7/HTovQg4nlxJR0hTfntn80Q6snRG5g
        BrVN9trQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJjkW-00HCFN-15; Mon, 14 Feb 2022 22:23:12 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] firmware_loader: EXTRA_FIRMWARE does not support compressed files
Date:   Mon, 14 Feb 2022 14:23:11 -0800
Message-Id: <20220214222311.9758-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document in the firmware loader Kconfig help text that firmware image
file compression is not supported for builtin EXTRA_FIRMWARE files so
that someone does not waste time trying that.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
Yeah, I wasted some time trying to use an xz compressed file
as builtin EXTRA_FIRMWARE, so try to prevent someone else from
doing that.

 drivers/base/firmware_loader/Kconfig |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-next-20220214.orig/drivers/base/firmware_loader/Kconfig
+++ linux-next-20220214/drivers/base/firmware_loader/Kconfig
@@ -60,6 +60,8 @@ config EXTRA_FIRMWARE
 	  image since it combines both GPL and non-GPL work. You should
 	  consult a lawyer of your own before distributing such an image.
 
+	  NOTE: Compressed files are not supported in EXTRA_FIRMWARE.
+
 config EXTRA_FIRMWARE_DIR
 	string "Firmware blobs root directory"
 	depends on EXTRA_FIRMWARE != ""
@@ -169,6 +171,9 @@ config FW_LOADER_COMPRESS
 	  be compressed with either none or crc32 integrity check type (pass
 	  "-C crc32" option to xz command).
 
+	  Compressed firmware support does not apply to firmware images
+	  that are built into the kernel image (CONFIG_EXTRA_FIRMWARE).
+
 config FW_CACHE
 	bool "Enable firmware caching during suspend"
 	depends on PM_SLEEP
