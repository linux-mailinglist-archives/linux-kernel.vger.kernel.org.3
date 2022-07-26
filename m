Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BAA58102B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbiGZJn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiGZJn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:43:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A992831391
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658828606; x=1690364606;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3x9PTOTAkqDrjaH5m1MaerKhcFetdbG1N10LgQYm5Es=;
  b=fEKJDg9fuuMFFbqQcungl8pXvnjrUEuZgyN7T4YOCQaIdqtIYY68TK2F
   LFCI5UZnzw4IS6aBaiENR6+koBumfcr+CduGGSRiYRZjMEuK5WT2JS6PO
   vksJP8GjvSynZp7wb3ntsKQpEcZ0E51TEjDmLAaGLhSyg5kAPsQSYBF92
   zSsGAYvZDvpM409J+L5kAaetgSZ5aHv1noX6Z2N85Bq1GwGJXnPiQuzSY
   qvheLv02hHR7W37TdJVVbVbYyhP1YuzEd2fIJg/zmPSna4xeuaJaqloLg
   07vtVReqdkqEkHfwcRzyZq46Dx8iqGRwwW6BNxXhMt/DnKftLgP1L5ycH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="351902854"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="351902854"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 02:43:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="596964750"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 26 Jul 2022 02:43:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E715F9D3; Tue, 26 Jul 2022 12:43:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>
Subject: [PATCH v1 1/1] firmware: dmi: Don't take garbage into consideration in dmi_smbios3_present()
Date:   Tue, 26 Jul 2022 12:43:29 +0300
Message-Id: <20220726094329.1725-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The byte at offset 6 represent length. Don't take it and drop it immediately
by using proper accessor, i.e. get_unaligned_be24().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/firmware/dmi_scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index b2ea318a10a4..24537ce29bc4 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -630,7 +630,7 @@ static int __init dmi_smbios3_present(const u8 *buf)
 {
 	if (memcmp(buf, "_SM3_", 5) == 0 &&
 	    buf[6] < 32 && dmi_checksum(buf, buf[6])) {
-		dmi_ver = get_unaligned_be32(buf + 6) & 0xFFFFFF;
+		dmi_ver = get_unaligned_be24(buf + 7);
 		dmi_num = 0;			/* No longer specified */
 		dmi_len = get_unaligned_le32(buf + 12);
 		dmi_base = get_unaligned_le64(buf + 16);
-- 
2.35.1

