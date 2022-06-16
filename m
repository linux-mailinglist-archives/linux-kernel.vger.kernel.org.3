Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B9954E92D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377354AbiFPSJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiFPSJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:09:40 -0400
X-Greylist: delayed 2527 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Jun 2022 11:09:37 PDT
Received: from lizzy.crudebyte.com (lizzy.crudebyte.com [91.194.90.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905574EDFE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Message-Id:Cc:To:Subject:Date:From:Content-Type:
        Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
        Content-Description; bh=xm94cFRpLBeZoS4MkJUmpD9ccv8vD46ilbV91YuAu+4=; b=gTOEs
        aiOGh59u3PyvQFNqRbDXK5rbrTl2/02z3Yf6YAwDFqMRHfBdGjmFBUeekgmLJpcOMtVj+qA44ha/V
        7PY/1Dz0A9TFKsFgk7h7k79/VnE4JUHQ3nk9olcwnmy6b+AJwBT83U7v9mUC79w4h3SakvKiFbQ3y
        NfOKHHu55Clmzy9yEkoHJ/zRowQJLaeZcKRuJjQUxZfS15tI0w2bT6IqMtTpkuMg8H55//Gh8Mkdj
        rjdwgolVWqIsDBpTQeSdUfloljJkEdjMTuTEAnrVdPLOCBmEuIwzQ+a4jCIjzHjpzC6yrxSDUiCyC
        Zszg3Nxd9UpyhBTNY3dT1XFAn3dUA==;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
Date:   Thu, 16 Jun 2022 19:09:42 +0200
Subject: [PATCH] net/9p: show warning on Tread/Twrite if wrong file mode
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        David Howells <dhowells@redhat.com>
Message-Id: <E1o1tHC-00039k-04@lizzy.crudebyte.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The netfs changes (eb497943fa21) introduced cases where 'Tread' was sent
to 9p server on a fid that was opened in write-only file mode. It took
some time to find the cause of the symptoms observed (EBADF errors in
user space apps). Add warnings to detect such issues easier in future.

Signed-off-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Link: https://lore.kernel.org/netdev/3645230.Tf70N6zClz@silver/
---
As requested by Dominique, here a clean version of my previous
EBADF trap code to be merged. Dominique, if you already have an
equivalent patch queued, then just go ahead. I don't mind.

I'm currently testing your EBADF fix patch and the discussed,
slightly adjusted versions. Looking good so far, but I'll report
back later on.


 net/9p/client.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/9p/client.c b/net/9p/client.c
index 8bba0d9cf975..05dead12702d 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1555,6 +1555,8 @@ p9_client_read(struct p9_fid *fid, u64 offset, struct iov_iter *to, int *err)
 	int total = 0;
 	*err = 0;
 
+	WARN_ON((fid->mode & O_ACCMODE) == O_WRONLY);
+
 	while (iov_iter_count(to)) {
 		int count;
 
@@ -1648,6 +1650,8 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 	p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %zd\n",
 		 fid->fid, offset, iov_iter_count(from));
 
+	WARN_ON((fid->mode & O_ACCMODE) == O_RDONLY);
+
 	while (iov_iter_count(from)) {
 		int count = iov_iter_count(from);
 		int rsize = fid->iounit;
-- 
2.30.2

