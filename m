Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BB648582B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242909AbiAES0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242899AbiAES0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:26:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBA8C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 10:26:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A00D8618A3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 18:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CDFC36AE0;
        Wed,  5 Jan 2022 18:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641407198;
        bh=Rk4Q4vTNAXnUXvO3PJI+x6Hj9/feWGDO97+dSEI99Yk=;
        h=From:To:Cc:Subject:Date:From;
        b=rSgZvHKGS5lm+ssq70iYawwe2mGnEL5qxg4tHZRBB0y4GseF4lYVhdi5gF3g1sxCd
         kotUJeFn8F77Mi2uax43a/pG6ityS5sbKhnmrGHeaUDKUJRW438EIBD9ZM6tNRKHju
         GUsC9QtRgANlTYtGvS2wbcC3K4k7A/+BbrNNBtXg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] firmware: edd: remove empty default_attrs array
Date:   Wed,  5 Jan 2022 19:26:34 +0100
Message-Id: <20220105182634.2802684-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; h=from:subject; bh=Rk4Q4vTNAXnUXvO3PJI+x6Hj9/feWGDO97+dSEI99Yk=; b=owGbwMvMwCRo6H6F97bub03G02pJDIlXH93acKKMNYJhkXhwQted6rgPZ+1XpqsYdaiqfVpV/2ra xgc5HbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjARER2GBQd23FnEqlxWOrPpy1YW6S dPvs+piWSYH3QizfJJ38v1YkcnKL1yu8cpctaFDwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default_attrs array of attributes for the edd sysfs entries is
totally empty for some reason, and a list of attributes is added later
after the object is created (which should be fixed up later as it's
racy).  Because this pointer is never used, and is empty, and we are
trying to remove all default_attrs usages, just delete it.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/edd.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
index 14d0970a7198..69353dd0ea22 100644
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -574,14 +574,6 @@ static EDD_DEVICE_ATTR(interface, 0444, edd_show_interface, edd_has_edd30);
 static EDD_DEVICE_ATTR(host_bus, 0444, edd_show_host_bus, edd_has_edd30);
 static EDD_DEVICE_ATTR(mbr_signature, 0444, edd_show_mbr_signature, edd_has_mbr_signature);
 
-
-/* These are default attributes that are added for every edd
- * device discovered.  There are none.
- */
-static struct attribute * def_attrs[] = {
-	NULL,
-};
-
 /* These attributes are conditional and only added for some devices. */
 static struct edd_attribute * edd_attrs[] = {
 	&edd_attr_raw_data,
@@ -619,7 +611,6 @@ static void edd_release(struct kobject * kobj)
 static struct kobj_type edd_ktype = {
 	.release	= edd_release,
 	.sysfs_ops	= &edd_attr_ops,
-	.default_attrs	= def_attrs,
 };
 
 static struct kset *edd_kset;
-- 
2.34.1

