Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8961D558A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiFWUaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiFWUaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:30:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2088D54BD0;
        Thu, 23 Jun 2022 13:29:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B68A6B8253D;
        Thu, 23 Jun 2022 20:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA19C341C0;
        Thu, 23 Jun 2022 20:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656016196;
        bh=fGELbkXVk4dX3gteYd37PudvcPc6ygh2tmwdmhwb1iw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DneYpDb67lZhg3O5WmGTYZJCmy+MD9hHlbjkCWEM/pJyRPruUdufzjeaPE+2TJ4IU
         h9E9doU1YnZXamYEPnTVqSOZu5L8aE60TK6/a0nT7O1iQPZ3zXlRSvPobIubWXF5cp
         DFncGREJnm2Von4PyNkWlH+LuWW9Qvgi1hBspfr1ZegzTXp854N/6szCPxlSPPELRH
         hWteLsItn6InhcUufckEsGkFPRHMnUzCoWoRUT2tVfDFGq+M/BLE6gYLybJf0mef/k
         fQTj+Cg6b9H4XB/f6ZM+FBMcsYn0ZXnMtvQgUxtqzRDw7K4XnvnQnPMvt4Owxwx7uy
         enIpqIR2wKHeA==
Message-ID: <d0f37c76-9211-da12-20e8-a7dde9c220ef@kernel.org>
Date:   Thu, 23 Jun 2022 15:29:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V4 00/20] The Runtime Verification (RV) interface
Content-Language: en-US
To:     Song Liu <song@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-trace-devel <linux-trace-devel@vger.kernel.org>
References: <cover.1655368610.git.bristot@kernel.org>
 <CAPhsuW4eDhVs2iu0y40LiFyKweJ+3d82-748kavGg5KXWsRuZg@mail.gmail.com>
 <850ef2bc-f70d-afb2-a12f-8cc4c795dac8@kernel.org>
 <CAPhsuW67decxVH4n4YitkW40OmUqq2LRX7Ry4jqdjrgXSAgknA@mail.gmail.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <CAPhsuW67decxVH4n4YitkW40OmUqq2LRX7Ry4jqdjrgXSAgknA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/22 12:52, Song Liu wrote:
> On Thu, Jun 23, 2022 at 9:42 AM Daniel Bristot de Oliveira
> <bristot@kernel.org> wrote:
>>
>> On 6/22/22 09:24, Song Liu wrote:
>>> This is interesting work!
>>>
>>> I applied the series on top of commit 78ca55889a549a9a194c6ec666836329b774ab6d
>>> in upstream. Then, I got some compile/link error for CONFIG_RV_MON_WIP and
>>> CONFIG_RV_MON_SAFE_WTD. I was able to compile the kernel with these two
>>> configs disabled.
>>
>> I rebased the code and... it compiled. Maybe it was missing some
>> config options that I forgot to set as "depends on" in the Kconfig.
>>
>> Can you check if it was the same problem automatically reported?
>>
>> Any further information here would help. I will revisit this.
> 
> Here are the error messages I got: https://pastebin.com/zJxMA6RK , and
> attached is the config file I used.
> 
>>
>> However, I hit the some issue with monitors/wwnr/enabled :
>>>
>>>     [root@eth50-1 ~]# cd /sys/kernel/debug/tracing/rv/
>>>     [root@eth50-1 rv]# cat available_monitors
>>>     wwnr
>>>     [root@eth50-1 rv]# echo wwnr > enabled_monitors
>>>     [root@eth50-1 rv]# cd monitors/
>>>     [root@eth50-1 monitors]# cd wwnr/
>>>     [root@eth50-1 wwnr]# ls
>>>     desc  enable  reactors
>>>     [root@eth50-1 wwnr]# cat enable
>>>     1
>>>     [root@eth50-1 wwnr]# echo 0 > enable   <<< hangs
>>>
>>> The last echo command hangs forever on a qemu vm. I haven't figured out why
>>> this happens though.
>>
>> I could reproduce it. It is an error in the return code of monitor_enable_write_data(),
>> I fixed it locally (return retval ? retval : count; // needs more test), and
>> will add it to the next version. Thanks!
>>
>>> I also have a more general question: can we do RV with BPF and simplify the
>>> work? AFAICT, the idea of RV is to maintain a state machine based on events.
>>> If something unexpected happens, call the reactor.
>>>
>>> IIUC, BPF has most of these building blocks ready for use. With BPF, we
>>> can ship many RV monitors without much kernel changes.
>>
>> I am aware of bpftrace and bpf + libbpf, and I have a PoC tool doing most of the
>> work I do in C/kernel in C/bpf.
>>
>> From the cover letter:
>>
>> "Things kept for a second moment (after this patchset):
>> [...]
>>         - dot2bpf"
>>
>> The point is that there are use-cases in which the users need the code in
>> C. One of those is the work being done in the Linux Foundation Elisa group.
>> There will be more formalism, like timed automata... which will require
>> infra-structure that is easily accessible in C... including synchronization,
>> and reactors that are available only in C on "per use-cases" basis - for
>> example on embedded devices.
> 
> Where can I find more information about the constraints of these use cases?

Check the LF elisa workgroup.

> I am asking because there are multiple ways to load a BPF program to the
> system. If the constraint is that we cannot have bpftrace or bcc in the system,
> maybe it is ok to run a standalone binary (written in C, compiled on a different
> system).

as I said... *I am aware of that*. I do like BPF! I was already convinced I will having
things in BPF :-)

dot2bpf does stand alone application, C + libbpf (and I did it this way to
have the most of flexibility), it works (for the things that are possible in BPF).
It shares most of the work in C/kernel, I will add it in the second patch series.

Or maybe we can load BPF programs in a kernel module, or compile
> the BPF programs into the kernel? (Yes, we can do it now, check
> kernel/bpf/preload). If any of these works, we can benefit from the good
> properties of BPF.

RV will take all these benefits, it is in the todo list as I said in this thread.
But the in kernel version also has its facilities.

For example, we can update the RV models without
> rebooting the system; and we can reuse various BPF maps, so we don't
> need to add union rv_task_monitor to task_struct.
> 
> Of course, we are out of luck if these systems cannot enable CONFIG_BPF
> at all. But I guess this is not common for modern embedded systems?

I understand your motivations, and I agree with the benefits of BPF, but I also
see benefits of having it in kernel as well.

So, RV will go with both, they are not mutually exclusive.

Thanks!
-- Daniel
> Thanks,
> Song

