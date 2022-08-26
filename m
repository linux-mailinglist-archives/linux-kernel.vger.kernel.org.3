Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D095A30F3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 23:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344651AbiHZVXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 17:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbiHZVXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 17:23:44 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79435C2769
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 14:23:43 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:58148)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oRgnj-007gqt-4A; Fri, 26 Aug 2022 15:23:39 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:50386 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oRgnh-00969l-U2; Fri, 26 Aug 2022 15:23:38 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Ye Weihua <yeweihua4@huawei.com>
Cc:     <keescook@chromium.org>, <oleg@redhat.com>, <tglx@linutronix.de>,
        <chang.seok.bae@intel.com>, <linux-kernel@vger.kernel.org>
References: <20220826092258.147322-1-yeweihua4@huawei.com>
Date:   Fri, 26 Aug 2022 16:23:05 -0500
In-Reply-To: <20220826092258.147322-1-yeweihua4@huawei.com> (Ye Weihua's
        message of "Fri, 26 Aug 2022 17:22:58 +0800")
Message-ID: <87k06un1hi.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oRgnh-00969l-U2;;;mid=<87k06un1hi.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1922DM4VLhHt1xTrSuxIvOvx1SIQzKcQqo=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Ye Weihua <yeweihua4@huawei.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 600 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 14 (2.3%), b_tie_ro: 11 (1.9%), parse: 1.52
        (0.3%), extract_message_metadata: 16 (2.7%), get_uri_detail_list: 1.70
        (0.3%), tests_pri_-1000: 20 (3.4%), tests_pri_-950: 1.75 (0.3%),
        tests_pri_-900: 2.1 (0.4%), tests_pri_-90: 127 (21.3%), check_bayes:
        124 (20.8%), b_tokenize: 7 (1.2%), b_tok_get_all: 6 (1.1%),
        b_comp_prob: 2.7 (0.4%), b_tok_touch_all: 104 (17.3%), b_finish: 1.40
        (0.2%), tests_pri_0: 389 (64.9%), check_dkim_signature: 0.86 (0.1%),
        check_dkim_adsp: 3.2 (0.5%), poll_dns_idle: 0.57 (0.1%), tests_pri_10:
        3.3 (0.6%), tests_pri_500: 19 (3.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal: fix deadlock caused by calling printk() under
 sighand->siglock
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ye Weihua <yeweihua4@huawei.com> writes:

> __dend_signal_locked() invokes __sigqueue_alloc() which may invoke a
> normal printk() to print failure message. This can cause a deadlock in
> the scenario reported by syz-bot below (test in 5.10):
>
> 	CPU0				CPU1
> 	----				----
> 	lock(&sighand->siglock);
> 					lock(&tty->read_wait);
> 					lock(&sighand->siglock);
> 	lock(console_owner);
>
> This patch specities __GFP_NOWARN to __sigqueue_alloc(), so that printk
> will not be called, and this deadlock problem can be avoided.

While the patch below will in theory fix the reported deadlock, I don't
think it is a good choice of fix.  As a rule we want to allow printk to
be callable in as many places as possible, so that it can be used for
debugging.  There are enough places that take siglock that outlawing
printk under siglock will make the kernel unstable.

I tried to read the current kernel and verify this deadlock to see if I
could suggest a better location to change the code to fix the deadlock.
Say modifying task_work_add to not take siglock.  The current
task_work_add does not take siglock.  I encountered a few other
significant function differences as well.  One significant difference is
that io_poll_double_wake no longer exists.

I think the amb-pl011.c driver might even be more different yet.

Can you reproduce this on current kernels?

Reading the code I think this is already fixed.

Perhaps you want to read the code of the affected subsystems and pick
some appropriate changes to backport to 5.10?

Eric

