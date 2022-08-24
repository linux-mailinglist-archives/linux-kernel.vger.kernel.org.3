Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125FC59FC77
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbiHXOAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbiHXOAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:00:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9945D760D6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:00:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A399B824BD
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A3EC433D7;
        Wed, 24 Aug 2022 13:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661349598;
        bh=KWnwJ1zMa3C2CDw6Y/OMLmmwDWaJ+biZe3MkwUbZHYs=;
        h=From:To:Cc:Subject:Date:From;
        b=xYytor4RJ8GRoHDLUA3TaZ9L/xtJ0TSzUzd8eYZwFZUYTlZJoyJzIX6VPNQ4kWlvB
         /mEkcpnn+u4OEMEyOfh3v66v2TtHwlgpU7ErpY+5PPGzX5QJL9s2ECgzO8NG4T4p10
         ECDFw+dnybc0XE1nrvBqsyelkp3AwXbRJSEyI2sQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     alsa-devel@alsa-project.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] sysfs: do not create empty directories if no attributes are present
Date:   Wed, 24 Aug 2022 15:59:46 +0200
Message-Id: <20220824135951.3604059-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2703; i=gregkh@linuxfoundation.org; h=from:subject; bh=KWnwJ1zMa3C2CDw6Y/OMLmmwDWaJ+biZe3MkwUbZHYs=; b=owGbwMvMwCRo6H6F97bub03G02pJDMlseleWz0p77dt8m1tRzqymifO7SvSa+rS3M/3+ef91PVd/ 565YRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAExkvwDDPPUPRss8Dk0ItLX7e80gh0 32681eC4YFM9ZNVL4f/e7no65TiZp5vyfVvXaWAwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating an attribute group, if it is named a subdirectory is
created and the sysfs files are placed into that subdirectory.  If no
files are created, normally the directory would still be present, but it
would be empty.  Clean this up by removing the directory if no files
were successfully created in the group at all.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: new patch

Note, totally untested!  The following soundwire patches will need this,
if a soundwire developer could test this out, it would be most
apreciated.

fs/sysfs/group.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index eeb0e3099421..9fe0b47db47f 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -31,12 +31,14 @@ static void remove_files(struct kernfs_node *parent,
 			kernfs_remove_by_name(parent, (*bin_attr)->attr.name);
 }
 
+/* returns -ERROR if error, or >= 0 for number of files actually created */
 static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 			kuid_t uid, kgid_t gid,
 			const struct attribute_group *grp, int update)
 {
 	struct attribute *const *attr;
 	struct bin_attribute *const *bin_attr;
+	int files_created = 0;
 	int error = 0, i;
 
 	if (grp->attrs) {
@@ -65,6 +67,8 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 						       gid, NULL);
 			if (unlikely(error))
 				break;
+
+			files_created++;
 		}
 		if (error) {
 			remove_files(parent, grp);
@@ -95,12 +99,15 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 							   NULL);
 			if (error)
 				break;
+			files_created++;
 		}
 		if (error)
 			remove_files(parent, grp);
 	}
 exit:
-	return error;
+	if (error)
+		return error;
+	return files_created;
 }
 
 
@@ -146,10 +153,16 @@ static int internal_create_group(struct kobject *kobj, int update,
 		kn = kobj->sd;
 	kernfs_get(kn);
 	error = create_files(kn, kobj, uid, gid, grp, update);
-	if (error) {
+	if (error <= 0) {
+		/*
+		 * If an error happened _OR_ if no files were created in the
+		 * attribute group, and we have a name for this group, delete
+		 * the name so there's not an empty directory.
+		 */
 		if (grp->name)
 			kernfs_remove(kn);
-	}
+	} else
+		error = 0;
 	kernfs_put(kn);
 
 	if (grp->name && update)
-- 
2.37.2

