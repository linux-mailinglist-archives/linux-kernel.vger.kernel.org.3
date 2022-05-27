Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2F25356EA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 02:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbiE0AAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 20:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346078AbiE0AAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 20:00:33 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F64A3617A
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 17:00:32 -0700 (PDT)
Received: from sequoia.corp.microsoft.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id BF81420B5B4E;
        Thu, 26 May 2022 17:00:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF81420B5B4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1653609632;
        bh=WyWhT64EqXgi1j+9Im254CVOA49spwfGfom1V/BOPbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bIse+ow20K7BpanHXQ49cUZmR92pHLe3BfWwyAAZ4EsY5q37ymkoDSmdVFd0TvL/Q
         K7+e+3sGrdKft2U3/DDB9FKWl2dsfSbjIjli2TdTUUtdC4j6TKNc4R5zav4yirSfco
         AMuyahFc8Kx/YQEStqu6yesnJ0mDPPL8jhvkZp6c=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Jianyong Wu <jianyong.wu@arm.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] 9p: Remove unnecessary variable for old fids while walking from d_parent
Date:   Thu, 26 May 2022 19:00:02 -0500
Message-Id: <20220527000003.355812-5-tyhicks@linux.microsoft.com>
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

Remove the ofid variable that's local to the conditional block in favor
of the old_fid variable that's local to the entire function.

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 fs/9p/fid.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index dfe98a308612..d8c70c4cd3c2 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -169,10 +169,10 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
 	fid = v9fs_fid_find(ds, uid, any);
 	if (fid) {
 		/* Found the parent fid do a lookup with that */
-		struct p9_fid *ofid = fid;
+		old_fid = fid;
 
-		fid = p9_client_walk(ofid, 1, &dentry->d_name.name, 1);
-		p9_client_clunk(ofid);
+		fid = p9_client_walk(old_fid, 1, &dentry->d_name.name, 1);
+		p9_client_clunk(old_fid);
 		goto fid_out;
 	}
 	up_read(&v9ses->rename_sem);
-- 
2.25.1

