Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BE4580E74
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbiGZIFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbiGZIFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:05:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357A06466;
        Tue, 26 Jul 2022 01:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658822718; x=1690358718;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EASm9B3SSa1L11yX9tNoIuowNnNMNvB6r5SRcH0bz/o=;
  b=B3c1GvvsZmNs2zQVX/lXSQJPouLmkGFP7HFobNvk6jkOnGBmvZAKv7ir
   pnX7Pzk0zRMUlFE3+ojfYoRZ9D0YafWrsbqDOq9SdejR5TcBhST5/FcTr
   o7owfrG+aVIOQvtYppiTE37FVmlHI3jQ/XiIhvlt9IETI7ukcxF1pdlUs
   ecXbx3NATuLVPVJ9jhD0o+xkuknAIRF8XVUJmyJmhGyEu0c0ISW1yZHGN
   CFCxlQpZ0H869S2LBwpHGDw/pySBxLR7I9NrRAKPFuillnz3PdRs2c92J
   Tn4VH7AfEjeRR50HwIs7aBHEeHWxJJwW7w+pBi7a0onNHQgiMIs38i5xl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="287902192"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="287902192"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 01:05:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="658568779"
Received: from icoprean-mobl1.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.252.56.129])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 01:05:07 -0700
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: [PATCH] HID: i2c-hid: fix the report-id passed in via set_or_send_report
Date:   Tue, 26 Jul 2022 11:05:04 +0300
Message-Id: <20220726080504.4185715-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The formatting of the data passed to the i2c HID data register was
changed with the re-work of the i2c-hid-core. Previously the report ID
passed in was encoded as 0xF if the report-id was greater than 0xF
(similar to what is done with the command portion.) Now with the rework,
a full report-id is passed in always, and this causes the messages to be
rejected by the i2c controller. Fix this by encoding the report-id
field in the same manner as previously was done.

Fixes: dbe0dd5fd2e0 ("HID: i2c-hid: explicitly code setting and sending
reports")
Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index c078f09a2318..156b12f840c4 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -296,6 +296,9 @@ static size_t i2c_hid_format_report(u8 *buf, int report_id,
 {
 	size_t length = sizeof(__le16); /* reserve space to store size */
 
+	if (report_id > 0xF)
+		report_id = 0xF;
+
 	if (report_id)
 		buf[length++] = report_id;
 
-- 
2.25.1

