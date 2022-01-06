Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C0648626B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 10:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbiAFJw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 04:52:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33960 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbiAFJw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 04:52:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E566D61B0C;
        Thu,  6 Jan 2022 09:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD271C36AE5;
        Thu,  6 Jan 2022 09:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641462775;
        bh=efFKTT0Jx3OMrmu5gb5zc2cNDH9qON3cARz2+6+R698=;
        h=From:To:Cc:Subject:Date:From;
        b=JEIrtNtEzZC1c588ufBSgwPXV7mf/LZrdOCUXBCkEaL+Xfd5UfLdxjVXL0pIO1JAz
         Fg0I+vb95YVMLI7IvlTjpAApH2NWX1/+P74Xr4L3Z0iziwUmYGKHMYzRyVJBGRacPQ
         U6nZlY4LjQAN3omiMPC0O/+sRHo04FXr6vuVEPZc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH] s390/sclp_sd: use default_groups in kobj_type
Date:   Thu,  6 Jan 2022 10:52:52 +0100
Message-Id: <20220106095252.3273905-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1396; h=from:subject; bh=efFKTT0Jx3OMrmu5gb5zc2cNDH9qON3cARz2+6+R698=; b=owGbwMvMwCRo6H6F97bub03G02pJDInXdn+We35JyTMofeN+WZ/c4tLyhQcZDX8vvtAjlMXZ+svv zF/OjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjI7tMM80vuheeKJHiFuyT8yZvwff NPjrC47QwLrs7bzVh5kN+o3uFty+IOrhr5Mp+ZAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the sclp_sd sysfs code to use default_groups field which
has been the preferred way since aa30f47cf666 ("kobject: Add support for
default attribute groups to kobj_type") so that we can soon get rid of
the obsolete default_attrs field.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/char/sclp_sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/char/sclp_sd.c b/drivers/s390/char/sclp_sd.c
index 25c2d760f6e6..f9e164be7568 100644
--- a/drivers/s390/char/sclp_sd.c
+++ b/drivers/s390/char/sclp_sd.c
@@ -438,11 +438,12 @@ static struct attribute *sclp_sd_file_default_attrs[] = {
 	&reload_attr.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(sclp_sd_file_default);
 
 static struct kobj_type sclp_sd_file_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops,
 	.release = sclp_sd_file_release,
-	.default_attrs = sclp_sd_file_default_attrs,
+	.default_groups = sclp_sd_file_default_groups,
 };
 
 /**
-- 
2.34.1

