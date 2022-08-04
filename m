Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724D7589CB7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239877AbiHDNcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239815AbiHDNcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:32:04 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B223D597
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659619869; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=BuDznUG+XJjgZb6WOz1pkcQ7d1CiQCJ/Rl0Fxs92y5cQAUjXUHkSsOgA4qUBlagjlEwSaJgvM1XrfFP0/bPx+4gZLW7LH3k04lf2UsJ5ehlksME/y+esyGGVnvzL96eCjCZIhERXY6wx/zceqHkH5jmdgtMxCMpPjozI2BcVuDQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659619869; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=y1Ovbial2FYc1BrqdnC91HLquYb0VtXHNQSWJNxyGjk=; 
        b=Vt65eUbIR6LC/lPVxeJx2K/5XfUprgeWduCXOQzfPRMSLHVOwoXQqGtThc/ZBwZkUIao4x/pMRrWYV0fueCEmTt9pkxcDfhneYni5CPYO846NCXyGOGyv2jyGBOrEpN+cSkwSXGRVPBYy5QppY/QJy8ozquJzJyWj/orNv4eiqw=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659619869;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=y1Ovbial2FYc1BrqdnC91HLquYb0VtXHNQSWJNxyGjk=;
        b=BmE3ziSSl6JohUDLEyLx9hkQtNrVtt4pVMlwGVL5T7lxvJM9+qulfAiFSYYw0yzI
        3fwxlkcUnIXTr/0ZKSxEOH6JZi3QBqN3ksPmBM9Liq7TadXR7ZpSQ7C+gLKYvTj5k/O
        QCewWX5y3RaccVFA598ES41lNj82qLKWXAv528ZQ=
Received: from localhost.localdomain (103.250.137.206 [103.250.137.206]) by mx.zoho.in
        with SMTPS id 1659619867360682.4482276982302; Thu, 4 Aug 2022 19:01:07 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Eric Biggers <ebiggers@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Dumazet <edumazet@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <cf470fb02971377e32564224f17897c55a374857.1659618705.git.code@siddh.me>
Subject: [PATCH 1/3 v4] kernel/watch_queue: Remove dangling pipe reference while clearing watch_queue
Date:   Thu,  4 Aug 2022 19:00:22 +0530
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1659618705.git.code@siddh.me>
References: <cover.1659618705.git.code@siddh.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If not done, a reference to a freed pipe remains in the watch_queue,
as this function is called before freeing a pipe in free_pipe_info()
(see line 834 of fs/pipe.c).

We also need to use READ_ONCE() in post_one_notification() to prevent the
compiler from optimising and loading a non-NULL value from wqueue->pipe.

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
Changes in v4:
- Brought the lines towards the start rather than the end.
- Removed incorrect NULLing of wqueue->pipe->watch_queue.
The latter was pointed out by Eric Biggers <ebiggers@kernel.org>
in reply to v3.

Changes in v3:
- Restored the original unlock order, and clear before unlock.
- Used READ_ONCE() in post path.
This was explained by David Howells <dhowells@redhat.com> in
reply to v1.

Changes in v2:
- Removed the superfluous ifdef guard.

 kernel/watch_queue.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index a6f9bdd956c3..8999c4e3076d 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -99,7 +99,7 @@ static bool post_one_notification(struct watch_queue *wqu=
eue,
 =09=09=09=09  struct watch_notification *n)
 {
 =09void *p;
-=09struct pipe_inode_info *pipe =3D wqueue->pipe;
+=09struct pipe_inode_info *pipe =3D READ_ONCE(wqueue->pipe);
 =09struct pipe_buffer *buf;
 =09struct page *page;
 =09unsigned int head, tail, mask, note, offset, len;
@@ -606,6 +606,9 @@ void watch_queue_clear(struct watch_queue *wqueue)
 =09/* Prevent new notifications from being stored. */
 =09wqueue->defunct =3D true;
=20
+=09/* This pipe will get freed by caller, and we are anyways clearing. */
+=09wqueue->pipe =3D NULL;
+
 =09while (!hlist_empty(&wqueue->watches)) {
 =09=09watch =3D hlist_entry(wqueue->watches.first, struct watch, queue_nod=
e);
 =09=09hlist_del_init_rcu(&watch->queue_node);
--=20
2.35.1


