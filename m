Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A4855ADC3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 02:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbiFZATi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 20:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiFZATh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 20:19:37 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E7013E8F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 17:19:36 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:41856)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5Fzz-009E2B-H2; Sat, 25 Jun 2022 18:19:35 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57626 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5Fzy-00AYHt-KI; Sat, 25 Jun 2022 18:19:35 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <20220622140853.31383-1-pmladek@suse.com>
        <YraWWl+Go17uPOgR@mtj.duckdns.org>
        <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
        <874k0863x8.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
        <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
        <87pmiw1fy6.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
        <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
Date:   Sat, 25 Jun 2022 19:19:27 -0500
In-Reply-To: <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 25 Jun 2022 16:48:38 -0700")
Message-ID: <87y1xkwa28.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o5Fzy-00AYHt-KI;;;mid=<87y1xkwa28.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/D80Oi4qTinv1YmPEUUSX8Os0cPZfAqnk=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 352 ms - load_scoreonly_sql: 0.12 (0.0%),
        signal_user_changed: 14 (4.1%), b_tie_ro: 12 (3.4%), parse: 1.68
        (0.5%), extract_message_metadata: 19 (5.4%), get_uri_detail_list: 1.13
        (0.3%), tests_pri_-1000: 23 (6.5%), tests_pri_-950: 1.93 (0.5%),
        tests_pri_-900: 1.39 (0.4%), tests_pri_-90: 80 (22.7%), check_bayes:
        77 (22.0%), b_tokenize: 7 (2.0%), b_tok_get_all: 6 (1.8%),
        b_comp_prob: 2.3 (0.7%), b_tok_touch_all: 58 (16.4%), b_finish: 1.26
        (0.4%), tests_pri_0: 178 (50.5%), check_dkim_signature: 0.85 (0.2%),
        check_dkim_adsp: 3.6 (1.0%), poll_dns_idle: 0.99 (0.3%), tests_pri_10:
        4.7 (1.3%), tests_pri_500: 23 (6.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: re. Spurious wakeup on a newly created kthread
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds <torvalds@linux-foundation.org> writes:

> Anyway, the whole "don't wake up thread until it's all done" is a
> separate and independent issue from the "odd use of kthreadd" issue.

Yes.  "don't wake up a kthread until it's all done" is a much easier
change that will simplify things tremendously.

Further it is necessary for Peter Zijlstra's rewrite of the kernel
freezer.   As anything that isn't a special stop state (which
TASK_UNINTERRUPTIBLE is not) will receive a spurious wake up on when
thawed out.

Eric
