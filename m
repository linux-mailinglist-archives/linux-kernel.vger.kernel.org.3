Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324AC4F88FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiDGUiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiDGUhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:37:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23259364786;
        Thu,  7 Apr 2022 13:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649362938;
        bh=ImyuGelXfK/3By3p0LZU4LiBApMy/j1Ptb46Jf+Biz4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=TxSy/35dCJSdh0sNIk3fkYh/1dlFujjV9D56JtFQQ12mUp9apitJjLS3+XYD2mjda
         hnXY87qQIw3165Dc9upLAl+xAIrjazLtkLrCBKqMwQxeefR89hpEU0tTuv2rLtwcPP
         wGlK1KTU8a5Km0Ze1pEINc4FODSQGAPwukPD2gFE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.161.122]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mw9QC-1nt7Wf32ea-00s8YX; Thu, 07
 Apr 2022 22:22:17 +0200
Message-ID: <4bcfd2b3-66fd-c5df-a8df-c51a89a0bce4@gmx.de>
Date:   Thu, 7 Apr 2022 22:20:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH printk v2 09/12] printk: add functions to prefer direct
 printing
Content-Language: en-US
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Wei Liu <wei.liu@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Elver <elver@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Phil Auld <pauld@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Wang Qing <wangqing@vivo.com>, rcu@vger.kernel.org
References: <20220405132535.649171-1-john.ogness@linutronix.de>
 <20220405132535.649171-10-john.ogness@linutronix.de> <Yk61Q+w7tWTjh8xl@alley>
 <b746d99e-729f-ca0d-5d30-6d803d1cd833@gmx.de>
 <87zgkxnepg.fsf@jogness.linutronix.de>
 <7fc5853e-dbe6-c2d2-2130-003e3b9777bc@gmx.de>
 <878rsgvews.fsf@jogness.linutronix.de>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <878rsgvews.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MCP30BvgA48w2S6vbv0ww52S5IiHA5LgrkHY6aW/ilw2XmF20zj
 CyKNOA5UGd74GOaKDHhMTmRwVtC4l/zv7bG6nGoodZt2BMVqfZs8qs7iFD1g6j4HdHlFSYt
 M9qAQNgU+kmybrXaiBU+tw3h56jsi9KdJclSDdbiPtdLDIw55WXvoNyO6Sv+l4ecl8F0JeS
 Ux7LP2pLcpZrBw+3jhz3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vWjPjiUs2e8=:SQtDJq0Z8yB+0l9naVWmtO
 F61p2nma+jSN0aMMzp9zjTqH22d7/mHOFOJplbDT+DxS9WclQF/7bqe6aUbx6YBS2Ok/R5WqD
 l7HdE6leWz4eJkYBHqKS5K1eQw/pdA4mAGjFxEkNDHkGoAh/qrwOgs3jhjmPnFMr7omIkfT6G
 9cvi88qfUETke7/Rc/S9OnM27+SE4s9ZwEMSyTCpAqdzkHIwnK9I+hc2pIB5OD9EAEmIr8dyj
 tBgt4Sra5qo+Gcw2EoevPrWO3Qtrku2OK99ZGfrJ9a2btWiPtnqI/r/6HxiX/48oJZE2mWW0B
 lhRrYQAcvRdPsOhDuH7SzC0a7TP71bPZs/0MOQyfIQ7sZimmtbW3BZUBPcDg1LRfFYqWcVIJE
 GhYSLpLyGMv6ch+wpXSFVixYk29FTA3iO+obfQNjnk53kwF116msTVfaWOEVSdwrdJQ3+v5J9
 kj2HV+4Vk0IQeYZPDmF8ocDTHQx/AwwJNGvK6a+IOZZHN8kNvRPZPOQaFolTY7X3SWKH9fIN8
 qJSpiYJvoqMkeNfyczKH9lyBIZBhaB/z2gcIrUktOyEkh9yECSdWFhbsu9LKiNQ5AIXIu0rXw
 91MNnmeFX2nbfpF8TkkdQh6DQ5w7JIrdB04l0CmhVuds2vGkOgRo7jOKxNtplv59juDPMvm3y
 NhgQ3RAvrCULv+BvXzZEfWoyvs3qb2RqIQw0012Ms34C7+WE19NipEC7XENB6SyNVm0c4AztR
 3VLt2XkdAbtS+G8swtENY2wHUFHWPpwmGKexieQLvQQEhfnJiK3jYvvHlxMnqU2Kj0juJoWLb
 cJl6R2LN7/P2rw41ch1tSaauQsDUa12L4dnP+cngZ826OjpLQ4P2fKyIW9eJBdXvH4x7oQ3vh
 htkC0OvJ5BPUhBr+GWZF+H8bs5fKMTcmMW7/EkJzpXwLgEr/LJobYWzvgc1CpTKgLvXnxrmVl
 p8WUytMBZP3BmE7m7NPjHey8HRtE/jqB5XEYSAaeE+rF5+D7W5qWHQE6VoN5smCXNBkMqtcWN
 nax6p74t6lkWGu69Ft0Icl7Ck2kYpzN1g7E/qcfXMP1nSLg86AL+QDko/IqehI453JnRLD5OE
 NTB9BhlSaFV9oI=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 22:04, John Ogness wrote:
> On 2022-04-07, Helge Deller <deller@gmx.de> wrote:
>> In my case - while I debug low-level kernel code - I then just need to
>> use pr_warn() or pr_emerg() and get it printed non-threadened. That's
>> sufficient for me.
>
> Actually, no. The loglevel does not determine if a message is direct
> printed or not. By "warn" I was referring to WARN_ON(condition).

Oh, then there was a misunderstanding on my side.

> If you are debugging low-level kernel code, you usually will _want_
> threaded printing. The timestamps match the printk() call, so you will
> get accurate logs. And the runtime performance of your low-level kernel
> code will not be significantly affected by the printk() call.

That really much depends on what you debug.
Currently I'm debugging some CPU hotplug stuff, and I really want my
debug info printed immediately, otherwise it's too late to analyze what's
going wrong. I can imaginge other use cases like trying to find memory
leaks are similiar.

> If for some reason you really want non-threaded printing, the patch we
> are discussing creates new functions to manually activate it:
>
> printk_prefer_direct_enter();
> pr_info("debugging\n");
> printk_prefer_direct_exit();

That's quite unhandy. At least I would have thought that pr_emerg() would
do that call sequence.
Wouldn't it make sense to make pr_emerg() work unthreadened, as it's
used quite seldom and only in special situations...

> But then your pr_info() will cause significant latencies. The timestamp
> would be the same, with or without direct printing.

Yes, but that would be Ok in my case.

Helge
