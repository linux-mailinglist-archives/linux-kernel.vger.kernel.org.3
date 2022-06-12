Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EB6547957
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 10:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbiFLIyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 04:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbiFLIyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 04:54:21 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4593A517C8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 01:54:19 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id BF1A1C023; Sun, 12 Jun 2022 10:54:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1655024058; bh=iguW8VJn2xpk0juxhAsB0Ag6tYkQSGJW6piilwKSWbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+KTqWdVXotF/5fkqb1pV/VMI9c9zLiYEM6w6IDbaXlExQ05HCqB82C/Pdrf8Jyo/
         ZRra4lkx+4MzRSIuMy3jbImDhZUpwoskp0owNHeIlUm3ErMCgruf9kBpAEdaCv6uce
         PZCQN97OW5ybZ/VgxOLzBHU4isENHCeZa3d0PGlebg4cVUlHERbA2OeUhvmY2WcH1O
         URWPJPDy0epyKy0mw3r6MfHc5oWF+TE6AHRQPx26rQ/vvhMBYyvCUlKgjtHUwsB57G
         +JNv4hDUFSRR0dG3fwP4QQT+6rGyCTtEKp02lb94Ffmg9EpzhL2iOl3fclD8ttOzSc
         kn8iD4Ds9zYtA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 52F69C01F;
        Sun, 12 Jun 2022 10:54:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1655024058; bh=iguW8VJn2xpk0juxhAsB0Ag6tYkQSGJW6piilwKSWbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+KTqWdVXotF/5fkqb1pV/VMI9c9zLiYEM6w6IDbaXlExQ05HCqB82C/Pdrf8Jyo/
         ZRra4lkx+4MzRSIuMy3jbImDhZUpwoskp0owNHeIlUm3ErMCgruf9kBpAEdaCv6uce
         PZCQN97OW5ybZ/VgxOLzBHU4isENHCeZa3d0PGlebg4cVUlHERbA2OeUhvmY2WcH1O
         URWPJPDy0epyKy0mw3r6MfHc5oWF+TE6AHRQPx26rQ/vvhMBYyvCUlKgjtHUwsB57G
         +JNv4hDUFSRR0dG3fwP4QQT+6rGyCTtEKp02lb94Ffmg9EpzhL2iOl3fclD8ttOzSc
         kn8iD4Ds9zYtA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 62618ee2;
        Sun, 12 Jun 2022 08:54:10 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 03/06] 9p: v9fs_fid_lookup_with_uid fix's fix suggestion
Date:   Sun, 12 Jun 2022 17:53:26 +0900
Message-Id: <20220612085330.1451496-4-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220612085330.1451496-1-asmadeus@codewreck.org>
References: <20220612085330.1451496-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tyler, I can just squash this in your commit if you're ok with this,
as I've already rebased the other patches on top of it.

Cc: Tyler Hicks <tyhicks@linux.microsoft.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 fs/9p/fid.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index 5a469b79c1ee..baf2b152229e 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -221,12 +221,15 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
 		 * walk to ensure none of the patch component change
 		 */
 		fid = p9_client_walk(fid, l, &wnames[i], clone);
-		p9_client_clunk(old_fid);
+		/* non-cloning walk will return the same fid */
+		if (fid != old_fid) {
+			p9_client_clunk(old_fid);
+			old_fid = fid;
+		}
 		if (IS_ERR(fid)) {
 			kfree(wnames);
 			goto err_out;
 		}
-		old_fid = fid;
 		i += l;
 		clone = 0;
 	}
-- 
2.35.1

