Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12415B2915
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 00:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiIHWNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 18:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIHWNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:13:37 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353AF1A83F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 15:13:36 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:58992)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oWPm8-002ssu-S0; Thu, 08 Sep 2022 16:13:32 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:46196 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oWPm7-001KLb-OV; Thu, 08 Sep 2022 16:13:32 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Alexey Izbyshev <izbyshev@ispras.ru>,
        Florian Weimer <fweimer@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>
References: <YxAq2jYvGG8QOypu@gmail.com>
        <87czcfhsme.fsf@email.froward.int.ebiederm.org>
        <bdff6cf478fc29c80997a623a57dae5f@ispras.ru>
        <874jxkcfoa.fsf@email.froward.int.ebiederm.org>
        <da95e333b4c508ddf8130f8f2d2cbb92@ispras.ru>
        <YxjRx3+MipdFOudw@gmail.com>
        <20220908081003.sjuerd5wiyge4jos@wittgenstein>
Date:   Thu, 08 Sep 2022 17:13:08 -0500
In-Reply-To: <20220908081003.sjuerd5wiyge4jos@wittgenstein> (Christian
        Brauner's message of "Thu, 8 Sep 2022 10:10:03 +0200")
Message-ID: <87v8pxa51n.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oWPm7-001KLb-OV;;;mid=<87v8pxa51n.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/Jv5/mtihLYgg6/yEe7fE8pTsvhTbkicE=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Christian Brauner <brauner@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 516 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (1.9%), b_tie_ro: 8 (1.6%), parse: 1.40 (0.3%),
         extract_message_metadata: 5 (1.0%), get_uri_detail_list: 2.4 (0.5%),
        tests_pri_-1000: 3.7 (0.7%), tests_pri_-950: 1.27 (0.2%),
        tests_pri_-900: 0.98 (0.2%), tests_pri_-90: 119 (23.0%), check_bayes:
        117 (22.7%), b_tokenize: 7 (1.4%), b_tok_get_all: 65 (12.6%),
        b_comp_prob: 2.8 (0.5%), b_tok_touch_all: 38 (7.4%), b_finish: 0.95
        (0.2%), tests_pri_0: 350 (67.7%), check_dkim_signature: 0.56 (0.1%),
        check_dkim_adsp: 3.0 (0.6%), poll_dns_idle: 0.86 (0.2%), tests_pri_10:
        3.3 (0.6%), tests_pri_500: 10 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Potentially undesirable interactions between vfork() and time
 namespaces
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <brauner@kernel.org> writes:

> On Wed, Sep 07, 2022 at 10:15:51AM -0700, Andrei Vagin wrote:
>> On Wed, Sep 07, 2022 at 08:33:20AM +0300, Alexey Izbyshev wrote:
>> > > 
>> > > That is something to be double checked.
>> > > 
>> > > I can't see where it would make sense to unshare a time namespace and
>> > > then call exec, instead of calling exit.  So I suspect we can just
>> > > change this behavior and no one will notice.
>> > > 
>> > One can imagine a helper binary that calls unshare, forks some children in
>> > new namespaces, and then calls exec to hand off actual work to another
>> > binary (which might not expect being in the new time namespace). I'm purely
>> > theorizing here, however. Keeping a special case for vfork() based only on
>> > FUD is likely a net negative, so it'd be nice to hear actual time namespace
>> > users speak up, and switch to the solution you suggested if they don't care.
>> 
>> I can speak for one tool that uses time namespaces for the right
>> reasons. It is CRIU.  When a process is restored, the monotonic and
>> boottime clocks have to be adjusted to match old values. It is for what
>> the timens was designed for. These changes doesn't affect CRIU.
>> 
>> Honestly, I haven't heard about other users of timens yet. I don't take
>> into account tools like unshare.
>
> LXC/LXD does
>
> unshare(CLONE_NEWTIME)
> // write offsets to /proc/self/timens_offsets
> timens_fd = open("/proc/self/ns/time_for_children", O_RDONLY | O_CLOEXEC)
> setns(timens_fd, CLONE_NEWTIME)
> exec(payload)
>
> so I agree don't change the uapi, please.
>
> But as you can see what we do is basically emulating changing time
> namespace during exec via the setns() prior to the exec call.

If I understand the description of lxc/lxd correctly the proposed change
will not effect lxc/lxd, as the time namespace is already installed
before exec.  If anything what is proposed would potentially allow
lxc/lxd to be simplified in the future by removing the setns.

Are you then requesting the behavior of the time namespace not change
when the proposed change will not effect lxc/lxd?

Eric

