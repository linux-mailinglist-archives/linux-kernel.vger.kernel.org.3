Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB49589DCB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239852AbiHDOn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiHDOnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:43:24 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32B8D7B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659624162; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=BmOBmTuIAJgk4riYixnbfjX8OT9SurLggW8ikfzidBlvyU/ANWZGEjNfzwE9JiY2UvdJtCP4+c2BX+V0ort9kAv8UrCRuelqqKVtf6SAuBMkbQHlP1Ty5VPL3Xri+oVUinRBFVC9P00HrUnRz7q8zSlm0xsoJ3xo7a7O02JxpYY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659624162; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=7EA0R5wGmwD/JzNhBZZkjUXDbI+/3vWFGSun7M1ZaaQ=; 
        b=T0pxtWOFtI4gMm1xJCZK1UzrVcXxtU6VqqDXFm0zl+0ChRPmvkuv6/+WbPm/BPG/105O9ljACWv0TaqZb64YZP/F2SjFE8F/9EJ4kVInq3uBDdz+qEuD75dzvvASctxgL4WxjBorEzLHAyfrwpdqTB76/7CNuDFBjAzmIRykmsk=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659624162;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=7EA0R5wGmwD/JzNhBZZkjUXDbI+/3vWFGSun7M1ZaaQ=;
        b=SY9bL7SPGonkZH9NQRkXL+diHhyqttP5YgR74Ln7gQ+hgkbICvBhIw5cjNBFkXUf
        FepInqobG6cG6ZudcybDY2oXfNkAmhEvLI8E3C9tthfI7BhmDfaK++mWbaI0meSRAOE
        qnGDbc6hEMYO2aKCIRoU83JKscx2smHrQXS+U2HI=
Received: from localhost.localdomain (103.250.137.206 [103.250.137.206]) by mx.zoho.in
        with SMTPS id 1659624159351729.7543272293905; Thu, 4 Aug 2022 20:12:39 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     code@siddh.me
Cc:     christophe.jaillet@wanadoo.fr, corbet@lwn.net, dhowells@redhat.com,
        ebiggers@kernel.org, edumazet@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        rdunlap@infradead.org
Message-ID: <20220804144152.468916-1-code@siddh.me>
Subject: [PATCH v2 3/3] kernel/watch_queue: Remove wqueue->defunct and use pipe for clear check
Date:   Thu,  4 Aug 2022 20:11:52 +0530
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cd2a10ffd8cb11c79754f43d0d20fd3cd4ba9b7e.1659618705.git.code@siddh.me>
References: <cd2a10ffd8cb11c79754f43d0d20fd3cd4ba9b7e.1659618705.git.code@siddh.me>
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
Changes in v2:
- The sent patch had accidentally missed removing the member
  from struct, fix that.
- Use !READ_ONCE() instead of =3D=3D NULL, as said by checkpatch.pl.

 include/linux/watch_queue.h |  4 +---
 kernel/watch_queue.c        | 14 +++++---------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
index c99c39ec6548..88360771c097 100644
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
@@ -76,7 +75,6 @@ struct watch_queue {
 =09spinlock_t=09=09lock;
 =09unsigned int=09=09nr_notes;
 =09unsigned int=09=09nr_pages;
-=09bool=09=09=09defunct;
 };
=20
 /**
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 8999c4e3076d..825943cf74b2 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -43,7 +43,7 @@ MODULE_LICENSE("GPL");
 static inline bool lock_wqueue(struct watch_queue *wqueue)
 {
 =09spin_lock_bh(&wqueue->lock);
-=09if (unlikely(wqueue->defunct)) {
+=09if (unlikely(!READ_ONCE(wqueue->pipe))) {
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


