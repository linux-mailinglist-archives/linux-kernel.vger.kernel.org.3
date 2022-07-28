Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D546584397
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiG1PwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiG1PwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:52:01 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819766BC35;
        Thu, 28 Jul 2022 08:51:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659023494; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=Uoivu6Vw8N4PfBieS8/LwV2EQRNlD+AssZI3OJn5KE0QEVhIQfeIIvNXCVf0fWZSxTJGRTqElYNdVo5QCmsl9KKqY5H0BV6IqN3i+SIYyXbvD7fO9cKcizRRYSWAJfh2IczAHtdjCQ8d86DVa1zRPtSAZdCbFAsOubhDbPooMs4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659023494; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=eIVJdUXeEoFT0XsTWsjdI7cmvorFUz8L2j4z7229AqY=; 
        b=RVch7ePCikqtfxJqLaM+nv8llTUaXEANzYlKNrGZn09b2WiBWDcFingqQn1ztDMm+Qo/4Ta/LmqduVa1kCugIU+55e8oUlIeOq6W2omdIzZORaB7QLqUwWzXCBTcnWkZo+2KICsCACSJnhXZ1HPxvASKVtUYNNgJAa9F+B5wD+w=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659023494;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=eIVJdUXeEoFT0XsTWsjdI7cmvorFUz8L2j4z7229AqY=;
        b=N6d4JhE7ZNMe/aFMTTJJsjLy6QJLLpWLY/QbLPU1ywmqu6AXmKXNk3+CV0gNPZhg
        owpUBrPVFeu9XqnZZN9JKcEn06olrfFAotIDh7BukRhSC+KlhRwrD2Motes9YjZDKor
        H8bneZk037DCCPqx+T1QJD7cIV0hFpj3cQIQkAGU=
Received: from localhost.localdomain (43.250.165.51 [43.250.165.51]) by mx.zoho.in
        with SMTPS id 1659023493370468.4685004171713; Thu, 28 Jul 2022 21:21:33 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     David Howells <dhowells@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     linux-security-modules <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com
Message-ID: <20220728155121.12145-1-code@siddh.me>
Subject: [PATCH v3] kernel/watch_queue: Make pipe NULL while clearing watch_queue
Date:   Thu, 28 Jul 2022 21:21:21 +0530
X-Mailer: git-send-email 2.35.1
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

This causes a UAF when post_one_notification() tries to access the pipe
on a key update, which is reported by syzbot.

We also need to use READ_ONCE() in post_one_notification() to prevent the
compiler from optimising and loading a non-NULL value from wqueue->pipe.

Bug report: https://syzkaller.appspot.com/bug?id=3D1870dd7791ba05f2ea7f47f7=
cbdde701173973fc
Reported-and-tested-by: syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.c=
om

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
Changes in v3:
- Restore the original unlock order, and clear before unlock.
- Use READ_ONCE() in post path.

This was explained by David Howells <dhowells@redhat.com> in
reply to v1. Not added Suggested-by since he didn't reply yet.

Changes in v2:
- Removed the superfluous ifdef guard.

 kernel/watch_queue.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index bb9962b33f95..617425e34252 100644
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
@@ -637,6 +637,12 @@ void watch_queue_clear(struct watch_queue *wqueue)
 =09=09spin_lock_bh(&wqueue->lock);
 =09}
=20
+=09/* Clearing the watch queue, so we should clean the associated pipe. */
+=09if (wqueue->pipe) {
+=09=09wqueue->pipe->watch_queue =3D NULL;
+=09=09wqueue->pipe =3D NULL;
+=09}
+
 =09spin_unlock_bh(&wqueue->lock);
 =09rcu_read_unlock();
 }
--=20
2.35.1


