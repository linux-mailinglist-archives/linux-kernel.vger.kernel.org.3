Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B374B923D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiBPUZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:25:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiBPUZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:25:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C35028D3AF;
        Wed, 16 Feb 2022 12:25:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46E92B82018;
        Wed, 16 Feb 2022 20:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F279C004E1;
        Wed, 16 Feb 2022 20:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645043101;
        bh=ljCVHn74fcgttGErgpehixSVg2TK0HWPi3UMCx9+1mI=;
        h=Date:From:To:Cc:Subject:From;
        b=nxnwtDHibTM/pRzTTSpKpOt7G8C8wEwWU0zBFA9moQQyHfo3Jq3pK5VkrZ13T6Es5
         T0/7R/DxFRukMgRL0PFUZ2RneoRR9u5X5vF3dSZh3B2ieJQOEmWI3bmtzK7hgiJZlC
         bf83QXhNXopdGPPHa0bSbYHcwEHxsbFrVSq5Iz0pEVEKsSFiKhSJQcGWy8rDSqvDs8
         oN9qpOe5ObhY3wo64LUUKCPUXB2bqNtRgSyE6QBJY1DrjIO/nqJCJa4qFy32gaK1wi
         Dapb8Mo04nZ31ZwF0e3oDSzqhfXo4HdROEA/JxR+FGSDca6zk77UF/thGodEmMihjC
         e2pkxe7TIERxg==
Date:   Wed, 16 Feb 2022 14:32:40 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] ACPICA: iASL: Replace zero-length array with
 flexible-array member
Message-ID: <20220216203240.GA918517@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a regular need in the kernel to provide a way to declare
having a dynamically sized set of trailing elements in a structure.
Kernel code should always use “flexible array members”[1] for these
cases. The older style of one-element or zero-length arrays should
no longer be used[2].

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/78
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/acpi/actbl2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 16847c8d9d5f..9ee4d1b39125 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -2319,7 +2319,7 @@ struct acpi_table_rgrt {
 	u16 version;
 	u8 image_type;
 	u8 reserved;
-	u8 image[0];
+	u8 image[];
 };
 
 /* image_type values */
-- 
2.27.0

