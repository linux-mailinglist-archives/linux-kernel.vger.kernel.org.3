Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28837550AC5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 15:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbiFSNMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 09:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiFSNMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 09:12:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671CEBD7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 06:12:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655644355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wMfP08PPc01kd5DBiF5bxAhTiTOtneM+rfOS3CpGvvk=;
        b=PwCvY1oISi8teaOEOOpeG3pgX/5Gmq8YTkrG52/RFVtvevWXXhjSkp9ngn51Uv9aJTP0BL
        AkqRJVU0Ncd86ARUk6/f5Z2g07YxbQN/bcp6CUIViusWbrgbuhqM4OeBDyRrqMV+0qGFq8
        O1hWoWhs2O0snbSTmZV6I+HZWIyxVLf6/SWnAGZU0s9rKuY9CyG7pMOY6VOuQt1eCFL2Aq
        3LxbU9BrrF+agI8/xKWs3janWqEJnxOt+IoiVIzlB9DuTaXWj4cMRHRruXZ9H3/a9dAntI
        tPcb7g6KVOtDXvRZWi1G2hHysn0ysCGB7HsXajznI5hJpI7SOS62P8FkeBMN1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655644355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wMfP08PPc01kd5DBiF5bxAhTiTOtneM+rfOS3CpGvvk=;
        b=M3wF90tU3rsO7CBtAkHVcaoBGIMZyc26xqLTqqkQhc3WgMDoMJUREWmcIG+1wfiPnyagU3
        4W/2iFyNZ1wRKLAQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/urgent for 5.19-rc3
References: <165564429738.1413209.17302088152547038708.tglx@xen13>
Message-ID: <165564429887.1413209.8729918730024457105.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 19 Jun 2022 15:12:35 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2=
022-06-19

up to:  4051a81774d6: locking/lockdep: Use sched_clock() for random numbers


A RT fix for lockdep. lockdep invokes prandom_u32() to create cookies. This
worked until prandom_u32() was switched to the real random generator, which
takes a spinlock for extraction, which does not work on RT when invoked
from atomic contexts. lockdep has no requirement for real random numbers
and it turns out sched_clock() is good enough to create the cookie. That
works everywhere and is faster.

Thanks,

	tglx

------------------>
Sebastian Andrzej Siewior (1):
      locking/lockdep: Use sched_clock() for random numbers


 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 81e87280513e..f06b91ca6482 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5432,7 +5432,7 @@ static struct pin_cookie __lock_pin_lock(struct lockdep=
_map *lock)
 			 * be guessable and still allows some pin nesting in
 			 * our u32 pin_count.
 			 */
-			cookie.val =3D 1 + (prandom_u32() >> 16);
+			cookie.val =3D 1 + (sched_clock() & 0xffff);
 			hlock->pin_count +=3D cookie.val;
 			return cookie;
 		}

