Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEFA461C44
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 17:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347232AbhK2RAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 12:00:09 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:60884 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347659AbhK2Q6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 11:58:09 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:46468)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mrjvV-001cTl-FO; Mon, 29 Nov 2021 09:54:49 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:58314 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mrjvS-001W3m-Tw; Mon, 29 Nov 2021 09:54:49 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        fam.zheng@bytedance.com, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>
References: <20211123150508.3397898-1-usama.arif@bytedance.com>
        <YZ0HkaOiKfmgN8zl@zn.tnic> <YaTd4ZID7O+bVRXT@redhat.com>
        <79517d3c-3674-cc21-fbdc-b26946809756@bytedance.com>
Date:   Mon, 29 Nov 2021 10:53:25 -0600
In-Reply-To: <79517d3c-3674-cc21-fbdc-b26946809756@bytedance.com> (Usama
        Arif's message of "Mon, 29 Nov 2021 15:32:18 +0000")
Message-ID: <87o862c396.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mrjvS-001W3m-Tw;;;mid=<87o862c396.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/24A4zXSRwo4RLM+YkwuBpjyHyvO6EKtU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.0906]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Usama Arif <usama.arif@bytedance.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1609 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 15 (0.9%), b_tie_ro: 12 (0.8%), parse: 1.25
        (0.1%), extract_message_metadata: 14 (0.9%), get_uri_detail_list: 2.6
        (0.2%), tests_pri_-1000: 24 (1.5%), tests_pri_-950: 1.42 (0.1%),
        tests_pri_-900: 1.24 (0.1%), tests_pri_-90: 155 (9.6%), check_bayes:
        149 (9.2%), b_tokenize: 7 (0.4%), b_tok_get_all: 11 (0.7%),
        b_comp_prob: 3.6 (0.2%), b_tok_touch_all: 122 (7.6%), b_finish: 1.55
        (0.1%), tests_pri_0: 1383 (85.9%), check_dkim_signature: 0.64 (0.0%),
        check_dkim_adsp: 3.3 (0.2%), poll_dns_idle: 1.43 (0.1%), tests_pri_10:
        2.3 (0.1%), tests_pri_500: 8 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [External] Re: [PATCH] x86/purgatory: provide config to disable purgatory
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usama Arif <usama.arif@bytedance.com> writes:

> Hi,
>
> Thanks for your replies. I have submitted a v2 of the patch with a
> much more detailed commit message including reason for the patch and timing values.
>
> The time taken from reboot to running init process was measured
> with both purgatory enabled and disabled over 20 runs and the
> averages are:
> Purgatory disabled:
> - TSC = 3908766161 cycles
> - ktime = 606.8 ms
> Purgatory enabled:
> - TSC = 5005811885 cycles (28.1% worse)
> - ktime = 843.1 ms (38.9% worse)
>
>
> Our reason for this patch is that it helps reduce the downtime of servers when
> the host kernel managing multiple VMs needs to be updated via kexec,
> but it makes reboot with kexec much faster so should be a general improvement in
> boot time if purgatory is not needed and could have other usecases as well.
> I believe only x86, powerpc and s390 have purgatory supported, other platforms
> like arm64 dont have it implemented yet, so with the reboot time improvement seen,
> it would be a good idea to have the option to disable purgatory completely but set default to y.
> We also have the CONFIG_KEXEC_BZIMAGE_VERIFY_SIG which can be enabled to verify the next
> kernel image to be booted and purgatory can be completely skipped if
> not required.

CONFIG_KEXEC_BZIMAGE_VERIFY_SIG is something totally and completely
different.  It's job is to verify that the kernel to be booted comes
from a trusted source.   The sha256 verification in purgatory's job
is to verify that memory the kernel cares about was not corrupted
during the kexec process.

I believe when you say purgatory you are really talking about that
sha256 checksum.  It really is not possible to disable all of
the code that runs between kernels, as the old and the new kernel may
run at the same addresses.  Anything that runs between the two kernels
is what is referred to as purgatory.  Even if it is just a small
assembly stub.

That sha256 verification is always needed for kexec on panic, there are
by the nature of a kernel panic too many unknowns to have any confidence
the new kernel will not be corrupted in the process of kexec before it
gets started.

For an ordinary kexec it might be possible to say that you have a
reliable kernel shutdown process and you know for a fact that something
won't come along and corrupt the kernel.  I find that a questionable
assertion.  I haven't seen anyone yet whose focus when getting an
ordinary kexec to work as anything other than making certain all of the
drivers are shutdown properly.

I have seen countless times when a network packet comes in a the wrong
time and the target kernel's memory is corrupted before it gets far
enough to initialize the network driver.

For a 0.2s speed up you are talking about disabling all of the safety
checks in a very dangerous situation.  How much can you can in
performance by optimizing the sha256 implementation instead of using
what is essentially a reference implementation in basic C that I copied
from somewhere long ago.

Optimize the sha256 implementation and the memory copy loop and then
show how the tiny bit of time that is left is on a mission critical path
and must be removed.  Then we can reasonably talk about a config option
for disabling the sha256 implementation in the kexec in not-panic case.

That sha256 implementation in part so that we can all sleep at night
because we don't have to deal with very very strange heizenbugs.

Eric

