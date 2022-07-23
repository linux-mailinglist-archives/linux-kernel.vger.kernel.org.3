Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58A657EF54
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 15:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbiGWN5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 09:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiGWN5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 09:57:39 -0400
X-Greylist: delayed 340 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Jul 2022 06:57:38 PDT
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B931A397;
        Sat, 23 Jul 2022 06:57:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658584631; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=R9dbIFc1ASVJ9R34cbOfYzXoARqki1ZPvuRVpM4LJ/uWcDrzYgRRfR2ygb+ykBXgnpVzSCyZGPkZLozYWups1guJmNmRdNbTFz/pnrr1ytekq14hpRefLCR06ibCUDFhMA8NuBK+cxL88yiDTqkcyg38hUaSB29jl4EXHXj9bS4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1658584631; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=8L4SM4wJh/annJul/rPP0P8kFy0c6pBphS7E4f99Zxw=; 
        b=FY2CfHGUEizRbQmYUjGiV5OVrPCX8GidwKBP8KBmhTY6Ol5Nnoi4aNQx7fMW4F1O8A6Uf10z+JVk1jDZfDWxnoUjB7nwUb0EQWu8heTAoZKYlKimbld0bNzgAi0Nulb9IrrGTeq9/R5bdz8Ni7vKdaAs3WQf6H8BGofoeL1oCqg=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658584631;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=8L4SM4wJh/annJul/rPP0P8kFy0c6pBphS7E4f99Zxw=;
        b=W2LzvKrxqDsIgR7clEFkfAgceQV7UP8aH2pplFvqPzBpQWdcyI+ebtJbamdvRuQH
        7BlUbSLLb/aYOLX7qjoRrmjvgrecUn6VxwBpFPc3dFJVceF2peCcKW32rsRjItX5OgT
        1UuMaEW2un8UgomefCzWk/ckyHj34V8sR+jTbKnc=
Received: from localhost.localdomain (43.250.158.127 [43.250.158.127]) by mx.zoho.in
        with SMTPS id 1658584630365731.3156260741329; Sat, 23 Jul 2022 19:27:10 +0530 (IST)
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
Message-ID: <20220723135447.199557-1-code@siddh.me>
Subject: [PATCH] kernel/watch_queue: Make pipe NULL while clearing watch_queue
Date:   Sat, 23 Jul 2022 19:24:47 +0530
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

This causes a UAF when post_one_notification tries to access the pipe on
a key update, which is reported by syzbot.

Bug report: https://syzkaller.appspot.com/bug?id=3D1870dd7791ba05f2ea7f47f7=
cbdde701173973fc
Reported-and-tested-by: syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.c=
om

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 kernel/watch_queue.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index bb9962b33f95..bab9e09c74cf 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -637,8 +637,17 @@ void watch_queue_clear(struct watch_queue *wqueue)
 =09=09spin_lock_bh(&wqueue->lock);
 =09}
=20
-=09spin_unlock_bh(&wqueue->lock);
 =09rcu_read_unlock();
+
+=09/* Clearing the watch queue, so we should clean the associated pipe. */
+#ifdef CONFIG_WATCH_QUEUE
+=09if (wqueue->pipe) {
+=09=09wqueue->pipe->watch_queue =3D NULL;
+=09=09wqueue->pipe =3D NULL;
+=09}
+#endif
+
+=09spin_unlock_bh(&wqueue->lock);
 }
=20
 /**
--=20
2.35.1


