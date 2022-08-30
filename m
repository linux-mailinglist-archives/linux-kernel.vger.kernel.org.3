Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7E45A6DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiH3Tty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiH3Ttw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:49:52 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65B4D9A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:49:48 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 7F9F340D403E;
        Tue, 30 Aug 2022 19:49:43 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 30 Aug 2022 22:49:43 +0300
From:   Alexey Izbyshev <izbyshev@ispras.ru>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fweimer@redhat.com>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Subject: Potentially undesirable interactions between vfork() and time
 namespaces
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <ed418e43ad28b8688cfea2b7c90fce1c@ispras.ru>
X-Sender: izbyshev@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've looked at Andrei's patch[1] that permitted vfork() after 
unshare(CLONE_NEWTIME) and noticed a couple of odd things that I'd like 
to point out.

  	/*
  	 * If the new process will be in a different time namespace
  	 * do not allow it to share VM or a thread group with the forking 
task.
+	 *
+	 * On vfork, the child process enters the target time namespace only
+	 * after exec.
  	 */
-	if (clone_flags & (CLONE_THREAD | CLONE_VM)) {
+	if ((clone_flags & (CLONE_VM | CLONE_VFORK)) == CLONE_VM) {
  		if (nsp->time_ns != nsp->time_ns_for_children)
  			return ERR_PTR(-EINVAL);
  	}

This change permits not only a normal vfork(), but also 
clone(CLONE_VM|CLONE_VFORK|CLONE_SIGHAND|CLONE_THREAD). I'm not sure 
whether it can cause real harm, but it's pretty inconsistent to forbid 
creation of normal threads after unshare(CLONE_NEWTIME), but permit such 
weird ones, so maybe the check should be strengthened.

Also, if such a thread execs, no time namespace switch will happen 
because it's vfork_done field will be cleared when its creator (a 
sibling thread) is killed by de_thread().

+       vfork = !!tsk->vfork_done;
         old_mm = current->mm;
         exec_mm_release(tsk, old_mm);
         if (old_mm)
@@ -1030,6 +1033,10 @@ static int exec_mmap(struct mm_struct *mm)
         tsk->mm->vmacache_seqnum = 0;
         vmacache_flush(tsk);
         task_unlock(tsk);
+
+       if (vfork)
+               timens_on_fork(tsk->nsproxy, tsk);
+

Similarly, even after a normal vfork(), time namespace switch could be 
silently skipped if the parent dies before "tsk->vfork_done" is read. 
Again, I don't know whether anybody cares, but this behavior seems 
non-obvious and probably unintended to me.

Thanks,
Alexey

[1] 
https://lore.kernel.org/all/20220613060723.197407-1-avagin@gmail.com/
