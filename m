Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72675482DE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbiFMJEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbiFMJEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:04:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07682E0A6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:04:20 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655111059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MfFNCvthw/m/3P9FIt3PvPJzUfynT8ekK4J8TiPctZE=;
        b=xwl29p9Lygw3bIK+LO9+Iz+9d3d9Iv7hFyiOxQrQhdb7yP8tN2k2kxQWGAkeocGkL6hPTs
        d3MV0u8I5D+yNR+MCfQf46uxgnOe8mPsLNASH81g2OYS599VRyB9jpqsolJZiKvTluy1R/
        5lLyDTr4ToOwOjWpZ5ywQ7WMm21JEAf/YioidzhaquSHILWuvQynliFEMHuLH9XxYFLAFV
        DmjSFRVWk/9R+3sDR6r/TDdC3zqqE+kj+x3Nxox0qAvNhHfBhcNwn7lEJ1AD6QWV4C56TS
        fLxybD8v1tUy3Gg/Ph89NEG9Ir9gvLi8VZOkmitKoPF0j4RNdg48dQDcEjcA2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655111059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MfFNCvthw/m/3P9FIt3PvPJzUfynT8ekK4J8TiPctZE=;
        b=n3u6RyWUvi+XzTXrgZZ6yIQbUUxfUGHx7WY4cQKjJoA1gsR4eTi/ld8w8l1gSLr4PoKmx9
        QO7ebf5y55fYL6CQ==
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org,
        pmladek@suse.com, Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [BUG] 8e274732115f ("printk: extend console_lock for
 per-console locking")
In-Reply-To: <20220613042937.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
References: <20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1>
 <87v8t5l39z.fsf@jogness.linutronix.de>
 <20220613042937.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
Date:   Mon, 13 Jun 2022 11:10:19 +0206
Message-ID: <87tu8pgcj0.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-12, "Paul E. McKenney" <paulmck@kernel.org> wrote:
>> As I suspected, the final printk's cannot direct print because the
>> kthread was printing. Using the below patch did seem to address your
>> problem. But this is probably not the way forward.
>
> When I apply it, I still lose output, perhaps due to different timing?
> Doing the pr_flush(1000, true) just before the call to kernel_power_off()
> has been working quite well thus far, though.

Your pr_flush() is appropriate for your RCU tests, but this is a problem
in general that needs to be addressed. I suppose we should start a new
thread for that. ;-)

During development we experimented with the idea of kthreads pausing
themselves whenever direct printing is activated. It was racey because
there are situations when direct printing is only temporarily active and
it was hard to coordinate who prints when direct printing becomes
inactive again. So we dropped that idea. However, in this situation the
system will not be disabling direct printing.

@Paul, can you try the below change instead? Until this has been
officially solved, you probably want to keep your pr_flush()
solution. (After all, that is exactly what pr_flush() is for.) But it
would be helpful if you could run this last test for us.

@Petr, I like the idea of the kthreads getting out of the way rather
than trying to direct print themselves (for this situation). It still
isn't optimal because that final pr_emerg("Power down\n") might come
before the kthread has finished its current line. But in that case the
kthread may not have much a chance to finish the printing anyway.

John Ogness

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ea3dd55709e7..45c6c2b0b104 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3729,7 +3729,9 @@ static bool printer_should_wake(struct console *con, u64 seq)
 		return true;
 
 	if (con->blocked ||
-	    console_kthreads_atomically_blocked()) {
+	    console_kthreads_atomically_blocked() ||
+	    system_state > SYSTEM_RUNNING ||
+	    oops_in_progress) {
 		return false;
 	}
 
