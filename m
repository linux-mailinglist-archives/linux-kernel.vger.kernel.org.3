Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4EE547950
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 10:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbiFLIxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 04:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbiFLIxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 04:53:45 -0400
X-Greylist: delayed 72380 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Jun 2022 01:53:44 PDT
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807754ECFF
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 01:53:43 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id A9E49C01B; Sun, 12 Jun 2022 10:53:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1655024021; bh=w5eLWBoj4FhuSPOzs8fxdj2BHxKVzjRtW80SblPcooM=;
        h=From:To:Cc:Subject:Date:From;
        b=RX/9a0xOoFK9fjS69756LwgM0eZOZawG05ik6Y07P2wHsFLitDpVwNm+YjjgDLZeH
         rcyC7jZ0JMMZn2tylSKqtssY9gN17aeWeg/st9Bcn9gHTzFFenk5NHlW9L8R5aIHYb
         1VC92zCxK9LRdudzeskco6dIrNaEL2m6UZ6Pb2zpwcvQ+8VZKU2Fao4iUO6JOe7Lfo
         VQGFqFX2qDPHyszPf0r1xZXmyofxZ3jpq8yQxO59rzHRaSefIBlZkiJIXJEg1GMaXU
         GbjImQ/tFCsFGZ1XxSDo16bfQ4ozJbYPaizRO8hyWFL2lCJS2hcId8h8bHyslxmJXX
         YS1DW+sU4DJGg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 41BF6C009;
        Sun, 12 Jun 2022 10:53:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1655024020; bh=w5eLWBoj4FhuSPOzs8fxdj2BHxKVzjRtW80SblPcooM=;
        h=From:To:Cc:Subject:Date:From;
        b=hDzoQ6kFl17DajXPdaD2NZ3MWOw9+kp63WWqwCgNfGkMkzKh9DqV5ONFjXkHvxIvi
         TaauEIFJRXYr/CywF6p6/dhspH2lYvYV/m/A2/jNSjmjeSWxcF+l+TPWWNibnUiIW7
         iNKKWt/Fu7kikha071zMPNYMT0txBjpDlGDZffWcts+utWmk+Vb2K7vvA6BUzisPdl
         cBdsJigDmfDpOqZ5Ba/yAEZiMXpvbA59JDpksB0uGNAMun1pNqYbn2ewtqMstvTYdr
         EKDFYIg8WKD3SM/MZ/Vf+xhkl0R+jO0fh6a+V3ki2TwxIGAytew1IZli7Dem8YRjE9
         FWykdLsIuUWRQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 48909a71;
        Sun, 12 Jun 2022 08:53:34 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 00/06] fid refcounting improvements and fixes
Date:   Sun, 12 Jun 2022 17:53:23 +0900
Message-Id: <20220612085330.1451496-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So:
 - I could reproduce Tyler's generic 531 leak, fixed it by the first
   commit in v9fs_vfs_atomic_open_dotl
 - Found another less likely leak while reworking code
 - Christian's comment that it's not obvious that clunk is just a
   refcount decrease was very true: I think it's worth the churn,
   so I've rename this all through a new helper...
 - ... with the not-so-hidden intent to improve debugging by adding
   a tracepoint for them, which I have also done.

I've also taken my comment in the other thread further and went ahead
and made it in its own commit. Tyler, if you're ok with this I'll just
squash it up. You can see rebased patches here:
https://github.com/martinetd/linux/

Note that I also took the permission to add back '/* clone */' as a
comment to your changing p9_client_walk's arguments: while I can agree
variables are hard to track, figuring out what the heck that boolean
argument means is much harder to me and I honestly preferred the
variable.
Having both through a comment is good enough for me if you'll accept
this:
----
@@ -222,7 +221,8 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
                 * We need to hold rename lock when doing a multipath
                 * walk to ensure none of the patch component change
                 */
-               fid = p9_client_walk(old_fid, l, &wnames[i], clone);
+               fid = p9_client_walk(old_fid, l, &wnames[i],
+                                    old_fid == root_fid /* clone */);
                /* non-cloning walk will return the same fid */
                if (fid != old_fid) {
                        p9_client_clunk(old_fid);
----


The last commit is just cleanups and should be no real change.

Dominique Martinet (6):
  9p: fix fid refcount leak in v9fs_vfs_atomic_open_dotl
  9p: fix fid refcount leak in v9fs_vfs_get_link
  9p: v9fs_fid_lookup_with_uid fix's fix suggestion
  9p fid refcount: add p9_fid_get/put wrappers
  9p fid refcount: add a 9p_fid_ref tracepoint
  9p fid refcount: cleanup p9_fid_put calls


(diff stats include Tyler's commits)

 fs/9p/fid.c               | 71 +++++++++++++++-------------
 fs/9p/fid.h               |  6 +--
 fs/9p/vfs_addr.c          |  4 +-
 fs/9p/vfs_dentry.c        |  4 +-
 fs/9p/vfs_dir.c           |  2 +-
 fs/9p/vfs_file.c          |  9 ++--
 fs/9p/vfs_inode.c         | 97 +++++++++++++++++----------------------
 fs/9p/vfs_inode_dotl.c    | 79 ++++++++++++-------------------
 fs/9p/vfs_super.c         |  8 ++--
 fs/9p/xattr.c             |  8 ++--
 include/net/9p/client.h   |  3 ++
 include/trace/events/9p.h | 48 +++++++++++++++++++
 net/9p/client.c           | 42 +++++++++++------
 13 files changed, 211 insertions(+), 170 deletions(-)

-- 
2.35.1

