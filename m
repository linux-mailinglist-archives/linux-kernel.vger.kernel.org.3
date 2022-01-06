Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54223486265
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 10:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbiAFJvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 04:51:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55276 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbiAFJvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 04:51:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2384B81FFA;
        Thu,  6 Jan 2022 09:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A594C36AE5;
        Thu,  6 Jan 2022 09:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641462680;
        bh=PMPnhquV4QwPaJwJNCUlbGJ4KmAUZao9eZBzGe90ndw=;
        h=From:To:Cc:Subject:Date:From;
        b=ndfMl4cVMv17FSPS8mYxbLWa6t8eZtWn1pPf7YIHZ3Y8dGF5WR5O08OkHX73D2+D8
         m7+jpNJx+CkcR//fevYrq89437PhPmiVQ7sfTTogRPpEnqfKrJxvLS/bhXxGtiDTwP
         yhG+rvGAdjkDt3ADqJFLdK7sek6yRAKMDlYk0hpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: [PATCH] parisc: pdc_stable: use default_groups in kobj_type
Date:   Thu,  6 Jan 2022 10:51:17 +0100
Message-Id: <20220106095117.3273204-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; h=from:subject; bh=PMPnhquV4QwPaJwJNCUlbGJ4KmAUZao9eZBzGe90ndw=; b=owGbwMvMwCRo6H6F97bub03G02pJDInXdk/tEsxYZcX7UIC9aNe0pc+XnfyuvGt2SEp3zw828cWn Hs/i64hlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJcP9mmCsZ7fNSvPrQYavruv7f4z XumcZM38swP/zKD1Xd68n9zxL/i3//PqXge3iRGAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the parisc pdc_stable sysfs code to use default_groups
field which has been the preferred way since aa30f47cf666 ("kobject: Add
support for default attribute groups to kobj_type") so that we can soon
get rid of the obsolete default_attrs field.

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/parisc/pdc_stable.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/parisc/pdc_stable.c b/drivers/parisc/pdc_stable.c
index e090978518f1..9513c39719d1 100644
--- a/drivers/parisc/pdc_stable.c
+++ b/drivers/parisc/pdc_stable.c
@@ -482,11 +482,12 @@ static struct attribute *paths_subsys_attrs[] = {
 	&paths_attr_layer.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(paths_subsys);
 
 /* Specific kobject type for our PDC paths */
 static struct kobj_type ktype_pdcspath = {
 	.sysfs_ops = &pdcspath_attr_ops,
-	.default_attrs = paths_subsys_attrs,
+	.default_groups = paths_subsys_groups,
 };
 
 /* We hard define the 4 types of path we expect to find */
-- 
2.34.1

