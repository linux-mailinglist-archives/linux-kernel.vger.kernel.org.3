Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD9E589CB5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239884AbiHDNcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239834AbiHDNcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:32:04 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DE939BB4
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659619870; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=TArb8JuB1u/dt9SGveolRdb/0G0ugu3aYa+l3KDB45spz+YjqqkVpocnYSOYpQ/2FtLJYxOr/fJskGu4g6puJVbRd3y7vCxPoNi+MTX/H4rRrGDD0VY0S3yE68zhxfbf4hJXZquHpNI2GNDXaMegU05QmRBRPD5JSYRMZysnRvk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659619870; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=e1Cbq8k6/3YzM7j1aQGJtFkkIjPn4LJXoM3g2nk5cLE=; 
        b=ECmeNiDjUWs71VbAz1usqwe1YmiZFKNj7AEja/3WyYIxyUN3RIy211CcdnAnRmpngfN7EnH8D+lp08NCdZqF6apcOgG9fD/YO0xFRBNEbVRutb1X6yQSDn42jQhMQayqxj4fa1la7zJfcA0d9JIXtMM05XtIxJ6DO4E4ico/2p0=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659619870;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=e1Cbq8k6/3YzM7j1aQGJtFkkIjPn4LJXoM3g2nk5cLE=;
        b=TerWYYE9ujbbNkLX1KP/NPA7FWH0FshItw90zSI9pMbk5uqbiFZ1MM1QQDmrKo4u
        rAMb/XAsXRWa62pQNLAz6zHlUwZR3MbC6jxurTeMX83dXLM9NfSw52G00wcN/CTwbCO
        PMQ2/Jg3nSuX7hYK6hUHIvctRhV44QXAwuqpEUwk=
Received: from localhost.localdomain (103.250.137.206 [103.250.137.206]) by mx.zoho.in
        with SMTPS id 1659619868551234.07828767217745; Thu, 4 Aug 2022 19:01:08 +0530 (IST)
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
Message-ID: <cd2a10ffd8cb11c79754f43d0d20fd3cd4ba9b7e.1659618705.git.code@siddh.me>
Subject: [PATCH 3/3] kernel/watch_queue: Remove wqueue->defunct and use pipe for clear check
Date:   Thu,  4 Aug 2022 19:00:24 +0530
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

The sole use of wqueue->defunct is for checking if the watch queue has
been cleared, but wqueue->pipe is also NULL'd while clearing.

Thus, wqueue->defunct is superfluous, as wqueue->pipe can be checked
for NULL.

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 include/linux/watch_queue.h |  3 +--
 kernel/watch_queue.c        | 14 +++++---------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
index c99c39ec6548..2a3b318db49d 100644
--- a/include/linux/watch_queue.h
+++ b/include/linux/watch_queue.h
@@ -55,7 +55,7 @@ struct watch_filter {
  *
  * @rcu: RCU head
  * @filter: Filter on watch_notification::info
- * @pipe: The pipe we're using as a buffer.
+ * @pipe: The pipe we're using as a buffer, NULL when queue is cleared/clo=
sed
  * @watches: Contributory watches
  * @notes: Preallocated notifications
  * @notes_bitmap: Allocation bitmap for notes
@@ -63,7 +63,6 @@ struct watch_filter {
  * @lock: Spinlock
  * @nr_notes: Number of notes
  * @nr_pages: Number of pages in notes[]
- * @defunct: True when queues closed
  */
 struct watch_queue {
 =09struct rcu_head=09=09rcu;
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 8999c4e3076d..c63b128818f4 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -43,7 +43,7 @@ MODULE_LICENSE("GPL");
 static inline bool lock_wqueue(struct watch_queue *wqueue)
 {
 =09spin_lock_bh(&wqueue->lock);
-=09if (unlikely(wqueue->defunct)) {
+=09if (unlikely(READ_ONCE(wqueue->pipe) =3D=3D NULL)) {
 =09=09spin_unlock_bh(&wqueue->lock);
 =09=09return false;
 =09}
@@ -99,15 +99,12 @@ static bool post_one_notification(struct watch_queue *w=
queue,
 =09=09=09=09  struct watch_notification *n)
 {
 =09void *p;
-=09struct pipe_inode_info *pipe =3D READ_ONCE(wqueue->pipe);
+=09struct pipe_inode_info *pipe =3D wqueue->pipe;
 =09struct pipe_buffer *buf;
 =09struct page *page;
 =09unsigned int head, tail, mask, note, offset, len;
 =09bool done =3D false;
=20
-=09if (!pipe)
-=09=09return false;
-
 =09spin_lock_irq(&pipe->rd_wait.lock);
=20
 =09mask =3D pipe->ring_size - 1;
@@ -603,10 +600,9 @@ void watch_queue_clear(struct watch_queue *wqueue)
 =09rcu_read_lock();
 =09spin_lock_bh(&wqueue->lock);
=20
-=09/* Prevent new notifications from being stored. */
-=09wqueue->defunct =3D true;
-
-=09/* This pipe will get freed by caller, and we are anyways clearing. */
+=09/* This pipe will get freed by the caller free_pipe_info().
+=09 * Removing this reference also prevents new notifications.
+=09 */
 =09wqueue->pipe =3D NULL;
=20
 =09while (!hlist_empty(&wqueue->watches)) {
--=20
2.35.1


