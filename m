Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3250C5356EC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 02:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349642AbiE0AAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 20:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345134AbiE0AAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 20:00:32 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5686D6F494
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 17:00:31 -0700 (PDT)
Received: from sequoia.corp.microsoft.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8D85C20B44CF;
        Thu, 26 May 2022 17:00:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8D85C20B44CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1653609631;
        bh=va52FY3CxVCP4CDaqya7zxaHqwkN4nQrlRwZnNMAbec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zr3h0vZVzjUnKnzcwb3bRT3m50dMDGbnXvq4t+KjgU8ZKb0L9PW3wNg71DoCtZjny
         rlAsS83qM8837mn79cM6xnxAiFJadS3UADG4sDuga74kS4IQ1/Lr1urFiKM3/kLY1b
         OCvI6YQ3xrPV0ZHJNHa2LfTmVTu01U3IPteZWL2E=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Jianyong Wu <jianyong.wu@arm.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] 9p: Make the path walk logic more clear about when cloning is required
Date:   Thu, 26 May 2022 19:00:01 -0500
Message-Id: <20220527000003.355812-4-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220527000003.355812-1-tyhicks@linux.microsoft.com>
References: <20220527000003.355812-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cloning during a path component walk is only needed when the old fid
used for the walk operation is the root fid. Make that clear by
comparing the two fids rather than using an additional variable.

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 fs/9p/fid.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index dae276ca7f7a..dfe98a308612 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -150,7 +150,7 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
 {
 	struct dentry *ds;
 	const unsigned char **wnames, *uname;
-	int i, n, l, clone, access;
+	int i, n, l, access;
 	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid, *root_fid, *old_fid;
 
@@ -214,7 +214,6 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
 	}
 	fid = root_fid;
 	old_fid = root_fid;
-	clone = 1;
 	i = 0;
 	while (i < n) {
 		l = min(n - i, P9_MAXWELEM);
@@ -222,7 +221,8 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
 		 * We need to hold rename lock when doing a multipath
 		 * walk to ensure none of the patch component change
 		 */
-		fid = p9_client_walk(old_fid, l, &wnames[i], clone);
+		fid = p9_client_walk(old_fid, l, &wnames[i],
+				     old_fid == root_fid);
 		p9_client_clunk(old_fid);
 		if (IS_ERR(fid)) {
 			kfree(wnames);
@@ -230,7 +230,6 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
 		}
 		old_fid = fid;
 		i += l;
-		clone = 0;
 	}
 	kfree(wnames);
 fid_out:
-- 
2.25.1

