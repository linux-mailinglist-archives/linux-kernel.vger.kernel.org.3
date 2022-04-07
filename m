Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745AD4F80D2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343822AbiDGNlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343771AbiDGNlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:41:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704D0DA6C1;
        Thu,  7 Apr 2022 06:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649338659;
        bh=srSDucO9JCz+e/axzg63E52u8hZL05pvFM7DVOLvqgs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FaxvCXmKape8nj5YnKm7r4QqP7PBx5l+hofgAanXwTmu1b20GPyIvUAGZQZB7vd7f
         ENVyXRUtDkKx9XdorlsQlhqD/AfjL8WElJmF4JJ2x/tUh5+1l3ZbpvSe5Gay4oGa7t
         5l1l00Pm/LdD4POFyN2kj6L2scWjmpuDvMhWaqwk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.161.122]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzhnN-1nyXYY0CyP-00vjRi; Thu, 07
 Apr 2022 15:37:39 +0200
Message-ID: <b746d99e-729f-ca0d-5d30-6d803d1cd833@gmx.de>
Date:   Thu, 7 Apr 2022 15:35:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH printk v2 09/12] printk: add functions to prefer direct
 printing
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>
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
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <Yk61Q+w7tWTjh8xl@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JaEcsKumoa/42DP+KZnrk1e+TWkwx4ruVfxnnOtiQ7Au5u4Twhg
 +KhoSlOexUZPQduFumRmC3jpOv1bQYEx+uUt/NCfkb0Ij2HKGwVzbnBDt5PwrNjbdkpggrl
 ZGRFhiQmI1tJsjypMgxj6W57emRkCBCHK7gDMPN9vnOwAJeOf4voVnC/Bn4pfwXZ64IQ8nw
 BmvSq1+lxPp0b/T/Ds37w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GCFEJvGCtYM=:Ox6o93hANqENEMVYywv3Xv
 rr64vK0b8s9Kf6oqt7g2OjVpl6y4pCtmLtJUeIOv7MZq3eXKld89RuZwbo+qoB/lk9iSe5jzT
 ltopTXUE5HnpBF4ROTl2vFDUqZBbEJxbqXbU9MLwioBM07yypmr/2Uzlg07riy648LFDJrKLz
 Bfg35OBwyQPLSY2iEuccjUKQM7umbwYF7uIpcDrfRuRRMy46I9Oh96+NM3y7eEVNowwrP69VH
 hKvxckT3p/YPWbepYHDbHi60wfsggtTzadf8iYesnqMiTM/KtUMqk89q6J0pjJdjMs5MrZtf4
 HTVdRUL5M1NT9cD5dtz6pDTxMmNydYL7IxTLoXjKh9OVvG0HTzBHenJqTkN6VTPZyrf3r1AaN
 1L0HBNz2kfy8jzFeB8fWui9nVKLr3gsW0woNiz0dKF1C1HSlUR34ClVtlJOks7RpXPQLEjKyO
 jtdgmnQkgydS79KdowPX+K0jQZ238oboFsTj0Fwkp91ZKFSmcmZcFFKknw/TIxvrP2/X3KsQq
 cKAmh47yix2jhYjbhu9Uzo3UQr/+g68dcbtO0uUv7PyHB7lz/xxbOUNSu2sZ+plm1BKK5mlc+
 ytzj/G/VhTdDMBWdBNQjqqleyfD03pEXb+52z/3VTXPcmfCwhZc6RRJ9crI+JDb61jHLTop/Q
 MIeMzkS0GADy0ZhBv4N+I4FgDQeqtvLscZbKeQqg3Ot8MdMn/xfCt+HuCKh0HewAdm9UCklNk
 QPnosXrTe47+uhkagM1NrPOQxmbeY44buv5N1GfIiR6aFrQRI++ZC0fRtt/D8EkadM+W9W55M
 pJw4/TRMDboprt6tRAYrGrv7XvYkA3w+7CMp06dTjHr827oULLlGNttrqmjC+qS1LZ4rf+4FB
 r8jZeUMxv+C5Ka8GGxskPXV3AjYz0mcHQfeATo/SJ5MItfxg+M97pKdB/sUWDiiHLqDwuvubk
 F0r5q5B33L2bb2EHO0XhZjbqd/d9NmVyGId7xWK4+Qzv47hbgX7q8u4pwU4zGa7Ka4Z0Rnfs0
 zgXajA/zrSF6gLm9lzM5nWt/0aZuJy2YtOfi55mRXUS8GYZpbxpTBMHYM7ZINkE+2AeuBIkzr
 gwfZyu384KaErg=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 11:56, Petr Mladek wrote:
> On Tue 2022-04-05 15:31:32, John Ogness wrote:
>> Once kthread printing is available, console printing will no longer
>> occur in the context of the printk caller. However, there are some
>> special contexts where it is desirable for the printk caller to
>> directly print out kernel messages. Using pr_flush() to wait for
>> threaded printers is only possible if the caller is in a sleepable
>> context and the kthreads are active. That is not always the case.
>>
>> Introduce printk_prefer_direct_enter() and printk_prefer_direct_exit()
>> functions to explicitly (and globally) activate/deactivate preferred
>> direct console printing. The term "direct console printing" refers to
>> printing to all enabled consoles from the context of the printk
>> caller. The term "prefer" is used because this type of printing is
>> only best effort. If the console is currently locked or other
>> printers are already actively printing, the printk caller will need
>> to rely on the other contexts to handle the printing.
>>
>> This preferred direct printing is how all printing is currently
>> handled (unless explicitly deferred).
>>
>> When kthread printing is introduced, there may be some unanticipated
>> problems due to kthreads being unable to flush important messages.
>> In order to minimize such risks, preferred direct printing is
>> activated for the primary important messages when the system
>> experiences general types of major errors. These are:
>>
>>  - emergency reboot/shutdown
>>  - cpu and rcu stalls
>>  - hard and soft lockups
>>  - hung tasks
>>  - warn
>>  - sysrq

I agree that those needs direct printing.
Did you maybe checked how much (e.g. in percentage) of a normal log is then
still left to be printed threadened?  Just in case it's not much,
is there still a benefit to introduce threadened printing?

Or another example, e.g. when running on a slow console (the best
testcase I know of is a 9600 baud serial port), where some printks
are threadened. Then a warn printk() has to be shown, doesn't it mean
all threadened printks have to be flushed (waited for) until
the warning can be shown. Will there then still be a measureable time benefit?

Just wondering...

Helge
