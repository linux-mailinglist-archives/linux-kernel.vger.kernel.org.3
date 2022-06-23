Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE6055801F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbiFWQm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiFWQmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:42:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08DD4925B;
        Thu, 23 Jun 2022 09:42:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63436B82488;
        Thu, 23 Jun 2022 16:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24836C3411B;
        Thu, 23 Jun 2022 16:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656002529;
        bh=O1Z6UxVXZFs09xPqqQhhlSwoeIGwkaDbXBSQz7fNh1c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N9rMhkT0nvkRSev4tITmZo6OeLr5YTufc7RwR1ErdDA9NR/h+iLI+p7lJ3C7v8Qq9
         /MvupL506VpFUNr0nxk8AFs2Kn+yiklC3WMqHBfmLj9xQ3TPFn9GR6acd5AZfvqkSg
         G4pqrIRFEKFOm2wxniViy+2cy675GyP43iTjI8OXeqonsQ6oy5Od7ucLLRyHo/xAK4
         nzdphtKwlpvaKpj7yCO0/x3Z/yDNdFf4zsa8wbAAPcZchmuBh1goP11+6bbrZoQbnp
         GXIL62g+34lcvW6NXDUIAbCbKlB0NlCBPjkFm1aNPSUFsaocJOczDHeud0KImge5i2
         qlBu6D7s+/xkQ==
Message-ID: <850ef2bc-f70d-afb2-a12f-8cc4c795dac8@kernel.org>
Date:   Thu, 23 Jun 2022 11:41:56 -0500
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
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <CAPhsuW4eDhVs2iu0y40LiFyKweJ+3d82-748kavGg5KXWsRuZg@mail.gmail.com>
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

On 6/22/22 09:24, Song Liu wrote:
> This is interesting work!
> 
> I applied the series on top of commit 78ca55889a549a9a194c6ec666836329b774ab6d
> in upstream. Then, I got some compile/link error for CONFIG_RV_MON_WIP and
> CONFIG_RV_MON_SAFE_WTD. I was able to compile the kernel with these two
> configs disabled.

I rebased the code and... it compiled. Maybe it was missing some
config options that I forgot to set as "depends on" in the Kconfig.

Can you check if it was the same problem automatically reported?

Any further information here would help. I will revisit this.

However, I hit the some issue with monitors/wwnr/enabled :
> 
>     [root@eth50-1 ~]# cd /sys/kernel/debug/tracing/rv/
>     [root@eth50-1 rv]# cat available_monitors
>     wwnr
>     [root@eth50-1 rv]# echo wwnr > enabled_monitors
>     [root@eth50-1 rv]# cd monitors/
>     [root@eth50-1 monitors]# cd wwnr/
>     [root@eth50-1 wwnr]# ls
>     desc  enable  reactors
>     [root@eth50-1 wwnr]# cat enable
>     1
>     [root@eth50-1 wwnr]# echo 0 > enable   <<< hangs
> 
> The last echo command hangs forever on a qemu vm. I haven't figured out why
> this happens though.

I could reproduce it. It is an error in the return code of monitor_enable_write_data(),
I fixed it locally (return retval ? retval : count; // needs more test), and
will add it to the next version. Thanks!

> I also have a more general question: can we do RV with BPF and simplify the
> work? AFAICT, the idea of RV is to maintain a state machine based on events.
> If something unexpected happens, call the reactor.
> 
> IIUC, BPF has most of these building blocks ready for use. With BPF, we
> can ship many RV monitors without much kernel changes.

I am aware of bpftrace and bpf + libbpf, and I have a PoC tool doing most of the
work I do in C/kernel in C/bpf.

From the cover letter:

"Things kept for a second moment (after this patchset):
[...]
	- dot2bpf"

The point is that there are use-cases in which the users need the code in 
C. One of those is the work being done in the Linux Foundation Elisa group.
There will be more formalism, like timed automata... which will require
infra-structure that is easily accessible in C... including synchronization,
and reactors that are available only in C on "per use-cases" basis - for
example on embedded devices.

On the other hand, there is ongoing research on asynchronous RV in which
I am only using BPF on the instrumentation side, for more complex formalism
running the processing in user-space (but for a different use-case,
with different timing and logical properties).

I see C and BPF (and rust?...) as complementary tools that I can use, and
we will have them all :-).

In this first series, I am adding the DA monitor in the kernel (motivated
by Elisa), and the basic kernel interface. After that, I will add the dot2bpf
for the cases in which BPF is a viable option... other formalism... other
extensions from Elisa... and so on... collecting these methods in a single
place.

-- Daniel

> Thanks,
> Song

