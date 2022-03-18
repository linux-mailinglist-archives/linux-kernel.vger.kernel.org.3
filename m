Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5343C4DDBE4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbiCROrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbiCROrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:47:04 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3192B105A9B;
        Fri, 18 Mar 2022 07:45:45 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:55336)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nVDqJ-00HBmm-SI; Fri, 18 Mar 2022 08:44:39 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38506 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nVDqI-006Fhl-W2; Fri, 18 Mar 2022 08:44:39 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <87bl1kunjj.fsf@email.froward.int.ebiederm.org>
        <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
        <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
        <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org>
        <87bky67qfv.fsf_-_@email.froward.int.ebiederm.org>
        <202203171209.FC87C7B08@keescook>
Date:   Fri, 18 Mar 2022 09:44:30 -0500
In-Reply-To: <202203171209.FC87C7B08@keescook> (Kees Cook's message of "Thu,
        17 Mar 2022 12:10:16 -0700")
Message-ID: <87fsnf2ucx.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nVDqI-006Fhl-W2;;;mid=<87fsnf2ucx.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18c/C30UgmTCpKstYbDp2Va3pJS8t12OoI=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 314 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (3.7%), b_tie_ro: 10 (3.3%), parse: 1.10
        (0.4%), extract_message_metadata: 17 (5.3%), get_uri_detail_list: 1.21
        (0.4%), tests_pri_-1000: 23 (7.3%), tests_pri_-950: 1.46 (0.5%),
        tests_pri_-900: 1.30 (0.4%), tests_pri_-90: 56 (17.8%), check_bayes:
        54 (17.3%), b_tokenize: 7 (2.2%), b_tok_get_all: 6 (2.0%),
        b_comp_prob: 2.3 (0.7%), b_tok_touch_all: 35 (11.2%), b_finish: 0.87
        (0.3%), tests_pri_0: 189 (60.2%), check_dkim_signature: 0.46 (0.1%),
        check_dkim_adsp: 2.2 (0.7%), poll_dns_idle: 0.39 (0.1%), tests_pri_10:
        2.2 (0.7%), tests_pri_500: 9 (2.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/2] ptrace: Move setting/clearing ptrace_message into
 ptrace_stop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Tue, Mar 15, 2022 at 06:21:08PM -0500, Eric W. Biederman wrote:
>> 
>> Today ptrace_message is easy to overlook as it not a core part of
>> ptrace_stop.  It has been overlooked so much that there are places
>> that set ptrace_message and don't clear it, and places that never set
>> it.  So if you get an unlucky sequence of events the ptracer may be
>> able to read a ptrace_message that does not apply to the current
>> ptrace stop.
>> 
>> Move setting of ptrace_message into ptrace_stop so that it always gets
>> set before the stop, and always gets cleared after the stop.  This
>> prevents non-sense from being reported to userspace and makes
>> ptrace_message more visible in the ptrace helper functions so that
>> kernel developers can see it.
>> 
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> This looks good to me. Did you happen to run the seccomp selftests
> before/after these changes?

I did not.  This is a pure ptrace change.  Do you see a way that seccomp
could be involved?

Eric
