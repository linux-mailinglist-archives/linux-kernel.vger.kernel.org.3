Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6DB486274
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 10:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbiAFJyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 04:54:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56116 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbiAFJyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 04:54:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A7A1B81FEA;
        Thu,  6 Jan 2022 09:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B739EC36AEB;
        Thu,  6 Jan 2022 09:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641462845;
        bh=NWaWhTkm2DfWR/QEVcmB4mj8lYkY2Fnm02M8eheZ2mU=;
        h=From:To:Cc:Subject:Date:From;
        b=oLULddqmS2MV2NewRLh9QI8Wq+pJXWNFz42Yo2vspQhsCPugPl7KU7bO1K0Bbr0oK
         4oLut7abHwpZJ5iJHS3wUSz87ax1p/0G5qMh8JSk8yAP7nvWnonjWCvxYhSE168H38
         vrxys8InQXE/aH0Od4cEJhmprH7B9gIUUbARwyEE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH] s390/dasd: use default_groups in kobj_type
Date:   Thu,  6 Jan 2022 10:54:01 +0100
Message-Id: <20220106095401.3274637-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415; h=from:subject; bh=NWaWhTkm2DfWR/QEVcmB4mj8lYkY2Fnm02M8eheZ2mU=; b=owGbwMvMwCRo6H6F97bub03G02pJDInX9ljuPXVs2hdrQ3YF46eMW57VZB8/pnVv3697b8OnaIW5 5n7Q6YhlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJxDxiWDD5uZDVrt8aB1cePZLKmN 00OadCP5Vhfo5G5sF3t2Y/E/DftmDaeh/LU5wfkwE=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the s390 dasd sysfs code to use default_groups field which
has been the preferred way since aa30f47cf666 ("kobject: Add support for
default attribute groups to kobj_type") so that we can soon get rid of
the obsolete default_attrs field.

Cc: Stefan Haberland <sth@linux.ibm.com>
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/block/dasd_devmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 6043c832d09e..811e79c9f59c 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -1824,10 +1824,11 @@ static struct attribute *paths_info_attrs[] = {
 	&path_fcs_attribute.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(paths_info);
 
 static struct kobj_type path_attr_type = {
 	.release	= dasd_path_release,
-	.default_attrs	= paths_info_attrs,
+	.default_groups	= paths_info_groups,
 	.sysfs_ops	= &kobj_sysfs_ops,
 };
 
-- 
2.34.1

