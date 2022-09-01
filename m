Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2575AA0A8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 22:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbiIAUIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 16:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiIAUHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 16:07:52 -0400
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B2199B75
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 13:07:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1662062828; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=ONerDPfdX90g0etv2BpUZv0RQ/NV4kBTE1n2pd+D7H6cAQiHlSQppu1w0bUfM41ENejrkdk1GX8wLnA3GwervYMppvJqjK5O4/DkHogTivPIW2Oad1oZpwRb7okY/JX1263COhN7Cs7IiSdDsIr4UldaudxZUFhkIpjTlsPkkg8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1662062828; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=CciC0JA+1Sl6P741HLOLO7oPE18KzPzTWUnJ9g4NcCY=; 
        b=KLd2FxNzp5QSijabx0YfKiK/nCxzgBBT08bLGJroT7MSBinsrSpD86tZjm+YnyuJ9k5B8uHrC6lg68Hw3V4RqlYBV7CdkaIeU8bYX5i0lbyfgkHo6v7OL2p9Zhueeal8kNzB5iUBOjoBU2OkmoIn3unY4lzl57FaPbFapC9g1DY=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1662062828;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=CciC0JA+1Sl6P741HLOLO7oPE18KzPzTWUnJ9g4NcCY=;
        b=hoDe65BsScmByWk2StwOsdECPhjE7FCJHqIBQbIlA7jZyet6KkAqAq3g8shZNgJx
        Nqh1hewTv79nBw+yAP43BnBLL71G+YgJeDhW/BupTrfRNKtVBqRLhdNNg7PBQiEv9Zf
        uktufTpEscH3cMdVxWMV8o9nfp6aBDto+97ZZ8KM=
Received: from localhost.localdomain (103.249.233.18 [103.249.233.18]) by mx.zoho.in
        with SMTPS id 1662062827191296.66769203214255; Fri, 2 Sep 2022 01:37:07 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Dumazet <edumazet@google.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <ef1791b7f1b5207d9ffae053d8641c9a634a25ea.1659771577.git.code@siddh.me>
Subject: [RESEND PATCH v2 2/2] kernel/watch_queue: NULL the dangling *pipe, and use it for clear check
Date:   Fri,  2 Sep 2022 01:36:56 +0530
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1659771577.git.code@siddh.me>
References: <cover.1659771577.git.code@siddh.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NULL the dangling pipe reference while clearing watch_queue.

If not done, a reference to a freed pipe remains in the watch_queue,
as this function is called before freeing a pipe in free_pipe_info()
(see line 834 of fs/pipe.c).

The sole use of wqueue->defunct is for checking if the watch queue has
been cleared, but wqueue->pipe is also NULLed while clearing.

Thus, wqueue->defunct is superfluous, as wqueue->pipe can be checked
for NULL. Hence, the former can be removed.

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 include/linux/watch_queue.h |  4 +---
 kernel/watch_queue.c        | 12 ++++++------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
index 7f8b1f15634b..d72ad82a4435 100644
--- a/include/linux/watch_queue.h
+++ b/include/linux/watch_queue.h
@@ -55,7 +55,7 @@ struct watch_filter {
  *
  * @rcu: RCU head
  * @filter: Filter to use on watches
- * @pipe: The pipe we're using as a buffer
+ * @pipe: The pipe we're using as a buffer, NULL when queue is cleared/clo=
sed
  * @watches: Contributory watches
  * @notes: Preallocated notifications
  * @notes_bitmap: Allocation bitmap for notes
@@ -63,7 +63,6 @@ struct watch_filter {
  * @lock: To serialize accesses and removes
  * @nr_notes: Number of notes
  * @nr_pages: Number of pages in notes[]
- * @defunct: True when queues closed
  */
 struct watch_queue {
 =09struct rcu_head=09=09rcu;
@@ -76,7 +75,6 @@ struct watch_queue {
 =09spinlock_t=09=09lock;
 =09unsigned int=09=09nr_notes;
 =09unsigned int=09=09nr_pages;
-=09bool=09=09=09defunct;
 };
=20
 /**
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index a6f9bdd956c3..a70ddfd622ee 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -43,7 +43,7 @@ MODULE_LICENSE("GPL");
 static inline bool lock_wqueue(struct watch_queue *wqueue)
 {
 =09spin_lock_bh(&wqueue->lock);
-=09if (unlikely(wqueue->defunct)) {
+=09if (unlikely(!wqueue->pipe)) {
 =09=09spin_unlock_bh(&wqueue->lock);
 =09=09return false;
 =09}
@@ -105,9 +105,6 @@ static bool post_one_notification(struct watch_queue *w=
queue,
 =09unsigned int head, tail, mask, note, offset, len;
 =09bool done =3D false;
=20
-=09if (!pipe)
-=09=09return false;
-
 =09spin_lock_irq(&pipe->rd_wait.lock);
=20
 =09mask =3D pipe->ring_size - 1;
@@ -603,8 +600,11 @@ void watch_queue_clear(struct watch_queue *wqueue)
 =09rcu_read_lock();
 =09spin_lock_bh(&wqueue->lock);
=20
-=09/* Prevent new notifications from being stored. */
-=09wqueue->defunct =3D true;
+=09/*
+=09 * This pipe will get freed by the caller free_pipe_info().
+=09 * Removing this reference also prevents new notifications.
+=09 */
+=09wqueue->pipe =3D NULL;
=20
 =09while (!hlist_empty(&wqueue->watches)) {
 =09=09watch =3D hlist_entry(wqueue->watches.first, struct watch, queue_nod=
e);
--=20
2.35.1


