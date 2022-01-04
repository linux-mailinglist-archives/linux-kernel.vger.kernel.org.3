Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD61484805
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbiADSpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:45:31 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:34288 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbiADSpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:45:30 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:38356)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4ooJ-00AWSX-OT; Tue, 04 Jan 2022 11:45:27 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:34406 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4ooG-009lH8-NT; Tue, 04 Jan 2022 11:45:27 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Serge Hallyn <serge@hallyn.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        kernel test robot <lkp@intel.com>
References: <0f0408bb7fbf3187966a9bf19a98642a5d9669fe.1641225760.git.legion@kernel.org>
        <792dcae82bc228cd0bec1fa80ed4d2c9340b0f8f.1641296947.git.legion@kernel.org>
        <c8edba64-9b4b-1ef8-f0b3-1b4beacf1551@colorfullife.com>
Date:   Tue, 04 Jan 2022 12:42:26 -0600
In-Reply-To: <c8edba64-9b4b-1ef8-f0b3-1b4beacf1551@colorfullife.com> (Manfred
        Spraul's message of "Tue, 4 Jan 2022 19:13:40 +0100")
Message-ID: <87v8yzfilp.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n4ooG-009lH8-NT;;;mid=<87v8yzfilp.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/8QAMUU0CQxDO5ZSmCJ3j4bo1E1Zb8js0=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Manfred Spraul <manfred@colorfullife.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 399 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.9 (1.0%), b_tie_ro: 2.7 (0.7%), parse: 0.71
        (0.2%), extract_message_metadata: 8 (2.1%), get_uri_detail_list: 1.20
        (0.3%), tests_pri_-1000: 5 (1.3%), tests_pri_-950: 1.04 (0.3%),
        tests_pri_-900: 0.84 (0.2%), tests_pri_-90: 70 (17.7%), check_bayes:
        69 (17.3%), b_tokenize: 6 (1.5%), b_tok_get_all: 8 (2.0%),
        b_comp_prob: 1.80 (0.5%), b_tok_touch_all: 50 (12.6%), b_finish: 0.77
        (0.2%), tests_pri_0: 297 (74.4%), check_dkim_signature: 0.39 (0.1%),
        check_dkim_adsp: 3.4 (0.9%), poll_dns_idle: 0.17 (0.0%), tests_pri_10:
        2.5 (0.6%), tests_pri_500: 7 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2] ipc: Store mqueue sysctls in the ipc namespace
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Manfred Spraul <manfred@colorfullife.com> writes:
>
 Hi Alexey,
>
> On 1/4/22 12:51, Alexey Gladkov wrote:
>> Right now, the mqueue sysctls take ipc namespaces into account in a
>> rather hacky way. This works in most cases, but does not respect the
>> user namespace.
>>
>> Within the user namespace, the user cannot change the /proc/sys/fs/mqueue/*
>> parametres. This poses a problem in the rootless containers.
>>
>> To solve this I changed the implementation of the mqueue sysctls just
>> like some other sysctls.
>>
>> Before this change:
>>
>> $ echo 5 | unshare -r -U -i tee /proc/sys/fs/mqueue/msg_max
>> tee: /proc/sys/fs/mqueue/msg_max: Permission denied
>> 5
>
> Could you crosscheck that all (relevant) allocations in ipc/mqueue.c
> use GFP_KERNEL_ACCOUNT?

They are not.

> We should not allow normal users to use up all memory.
>
> Otherwise:
> The idea is good, the limits do not really prevent using up all
> memory, _ACCOUNT is the better approach.
> And with _ACCOUNT, it doesn't hurt that the namespace root is able to
> set limits.

Saying the cgroup kernel memory limit is the only thing that works, and
that is always better is silly.


First the cgroup kernel memory limits noted with ACCOUNT are not
acceptable on several kernel hot paths because they are so expensive.

Further the memory cgroup kernel memory limit is not always delegated to
non-root users, which precludes using the memory cgroup kernel memory
limit in many situations.


The RLIMIT_MQUEUE limit definitely works, and as I read the kernel
source correct it defaults to MQ_BYTES_MAX aka 819200.  A limit of
800KiB should prevent using up all of system memory, except on very low
memory machines.


So please let's not confuse apples and oranges, and let's use the tools
in the kernel where they work, and not set them up in contest with each
other.

Rlimits with generous but real limits in general are good at catching
when a program misbehaves.  The cgroups are better at setting a total
memory cap.  In this case the rlimit cap is low enough it simply should
not matter.

What has been fixed with the ucount rlimits is that (baring
implementation bugs) it is now not possible to create a user namespace
and escape your rlimits by using multiple users.

Eric
