Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7951D52AB07
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352288AbiEQSkT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 May 2022 14:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbiEQSkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:40:17 -0400
Received: from sender4-of-o58.zoho.com (sender4-of-o58.zoho.com [136.143.188.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED9F3915C;
        Tue, 17 May 2022 11:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1652812811; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=c/QgVX0MF2YimVNef7KMN9cFsenAkl5MIqMhNQ8bYUp6lHgNyTn3Kd8TDuLGBdfoM4Qqh+LDl8AerhHbMuu+ykQFysMtxUEeqLBokS48SEYiMW3Fqmv3A2lfH5RcBIz6d80saWL44U+cphp/KWxb5k/wmHL6DZaY17rxMbxzcTQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1652812811; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ifEE5KWRWUfeHk88nuZ3bY6KRsfs2POeZbigRez0zFs=; 
        b=UUCqp9HCKfRVttc/nkdCFrXCKo5UCTnCrj3KXuVze1XfKylmsZUtnbIkRCKjo7Ce+sTGa9pgQ0w0AJ3vkSqkA/qDFD+Of4YZqwkX6g+QNFwcXMDIGRJrdldjSmjoMYUBM/fK8gWh3IUwNft0Gpzk3J5YqZe47aF0KUPzAMxilOE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de>
Received: from z3r0.lan (185.31.62.161 [185.31.62.161]) by mx.zohomail.com
        with SMTPS id 1652812808776471.9683795053037; Tue, 17 May 2022 11:40:08 -0700 (PDT)
Message-ID: <c766b4d9758b9fd1e15af89643093c595404a665.camel@mniewoehner.de>
Subject: [PATCH v2] ACPI: utils: include UUID in _DSM evaluation warning
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <CAJZ5v0hWxhn9WM3ciQgbZpa7x8JwpHK=Bz4kefB_3VnAM0gB9Q@mail.gmail.com>
References: <f80dfd57fdca87897f070a3ea4ee0a26b03e7831.camel@mniewoehner.de>
         <CAJZ5v0h+kKwdntGPC5PP6N0ZRbRzLxuwcwTGm-PNBH6Z3mnETg@mail.gmail.com>
         <28686e8d994c297a78fb816805cd3652a8f8c90a.camel@mniewoehner.de>
         <CAJZ5v0hWxhn9WM3ciQgbZpa7x8JwpHK=Bz4kefB_3VnAM0gB9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 17 May 2022 20:40:06 +0200
MIME-Version: 1.0
User-Agent: Evolution 3.42.2 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_ADSP_ALL,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _DSM evaluation warning in its current form is not very helpful, as 
it lacks any specific information:
  ACPI: \: failed to evaluate _DSM (0x1001)

Thus, include the UUID of the missing _DSM:
  ACPI: \: failed to evaluate _DSM bf0212f2-... (0x1001)

Signed-off-by: Michael Niewöhner <linux@mniewoehner.de>
---
Changes in v2:
 - fix arguments order
 - fix indentation
 - drop line break

 drivers/acpi/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index d5cedffeeff9..3a9773a09e19 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -681,7 +681,7 @@ acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 func,
 
 	if (ret != AE_NOT_FOUND)
 		acpi_handle_warn(handle,
-				"failed to evaluate _DSM (0x%x)\n", ret);
+				 "failed to evaluate _DSM %pUb (0x%x)\n", guid, ret);
 
 	return NULL;
 }
-- 
2.34.1

