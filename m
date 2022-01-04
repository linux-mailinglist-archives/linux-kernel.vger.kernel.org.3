Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB9E4845F7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbiADQ3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiADQ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:29:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA46C061761;
        Tue,  4 Jan 2022 08:29:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F3E461524;
        Tue,  4 Jan 2022 16:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490CBC36AE9;
        Tue,  4 Jan 2022 16:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641313791;
        bh=D7SL25ZoKNl3aSqzBkgk6IkgtYqSp/dzemHZP/AyLzM=;
        h=From:To:Cc:Subject:Date:From;
        b=yIxplB02qzDwIXE34iR71kgcbBJsc408sF2T23UpmYb4eq274cQXYom2IFVKqrtBR
         MO9fVyGlOL0t1WuC02jaMD6a+naaxH28boergc2NuX8vOum0H3Jc7rzc6/7FbEoZuj
         R6jzcsq3Nw75wTnMpbdIyQRvnO4cNWHnK4dYaqWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH] block/rnbd-clt-sysfs: use default_groups in kobj_type
Date:   Tue,  4 Jan 2022 17:29:47 +0100
Message-Id: <20220104162947.1320936-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1464; h=from:subject; bh=D7SL25ZoKNl3aSqzBkgk6IkgtYqSp/dzemHZP/AyLzM=; b=owGbwMvMwCRo6H6F97bub03G02pJDIlXSn+nt/WtXaa6pWCJPs+5oLPWCx0M/++20Pg3743UMc0N /Q32HbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRPfUMC2ZP/3ztSx5j5VL5yS8c6h VWXu/8lc8wvyjohYX2958n8pdvKJML0GRaoWP+CQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the rnbd controller sysfs code to use default_groups field
which has been the preferred way since aa30f47cf666 ("kobject: Add
support for default attribute groups to kobj_type") so that we can soon
get rid of the obsolete default_attrs field.

Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Cc: Jack Wang <jinpu.wang@ionos.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index 44e45af00e83..2be5d87a3ca6 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -452,6 +452,7 @@ static struct attribute *rnbd_dev_attrs[] = {
 	&rnbd_clt_nr_poll_queues.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(rnbd_dev);
 
 void rnbd_clt_remove_dev_symlink(struct rnbd_clt_dev *dev)
 {
@@ -474,7 +475,7 @@ void rnbd_clt_remove_dev_symlink(struct rnbd_clt_dev *dev)
 
 static struct kobj_type rnbd_dev_ktype = {
 	.sysfs_ops      = &kobj_sysfs_ops,
-	.default_attrs  = rnbd_dev_attrs,
+	.default_groups = rnbd_dev_groups,
 };
 
 static int rnbd_clt_add_dev_kobj(struct rnbd_clt_dev *dev)
-- 
2.34.1

