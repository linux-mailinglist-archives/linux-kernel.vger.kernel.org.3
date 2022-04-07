Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FFD4F8880
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiDGUeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiDGUd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:33:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D798931E7AA;
        Thu,  7 Apr 2022 13:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649362790;
        bh=Clsw0azBwmGv5vn3jDer0ePY2DqZzo6JWD5bNEgFlHo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=TZ0ut+ah7scmN3K90tIZFBtomDyqygWdzSN96yUbZZ4R7dgj8zn6wvR3szBboZD+8
         84T1rbd17cf/t5rqhA4RzCp+v5+7+Tqq1Ha9Fn7OCrvMz3r8KjHy131uw/iK9yIKvH
         2/AqJY6TCJ8aoTHfYCuMRZXWdGem9hmLkToLFYqk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.161.122]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIdeR-1noJXE2wM9-00EeY8; Thu, 07
 Apr 2022 21:37:49 +0200
Message-ID: <7fc5853e-dbe6-c2d2-2130-003e3b9777bc@gmx.de>
Date:   Thu, 7 Apr 2022 21:36:04 +0200
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
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <87zgkxnepg.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KM0MoXUmeybSpeJsUO31eMZugL3Jyztha+nscPvfSeRyQ75lMwJ
 jdF50G7Dun6S1n9No6dcWJPl9KTw7q3ABK56owgE5UKbmM13Pm+0uBOuPyNPN74djSQ3b/1
 DT5vDBXp7CGAnQ+RQr2yFzU1+0fFR5sqfi62aVWnT4YRmJg5YHchyHrsirljLPjd223yPRl
 S2dC4CHIy8d6XnxO5l5zA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w/iol8Z6M84=:wwrJWOQZ5TP9VKmXrav8hi
 mhuCDg9PM4LOasXt2kj43ZtB3CTAA9oAX6t4zetDbHvE/M5JWAk6M9jB9Zc92ttymDTcDoEDD
 14A6OiNi5Pib8ooFsH94Ud+K2QUUYKh09vC4uwtlJj2NjdLc/SqJ9S5mtqhXw6CCbW2zY/286
 rBUl5nI77EOOzqtHJpzEUxjPvsHrC0Mpkv4D4m36UsKCakYCK5DwWt585BA9VA0mbR2B7tRsG
 E0evN3e4Q4MvvcGkDoteoUsER8xHx8DR3qQ1ZIDp97dS6sBlCG4dFjmYo3qx3GAAk7xPM2Xn5
 k1nDAgnZxKO2WoeR/Mc8dQDktkw4Qj6vQUgrT987PlRj8Qyp9PadWHuIG/fpymtPAkUUg5PYH
 tEprTFIUPwCzMfVZbGQAa8ZV3jUtl4tiqsLg2Cenqh2/BawXH8bGOmXHoMcCmGVQ0LW1lUkLj
 7cSdZ31h5hKqEoXla0vMPGtJAp34CgaRSPS12oiyB7R/6uMeT128mEcyz1Ckwm0IiVUdsGR/0
 rVtVjenpcyZdn8sVU6Ktr5ak18/wpxY6lhEbZk8b9DeUi2mxPevHJPaZHrLjlYI7FWlVF9tjH
 fLrtkux96ulwj8qXkbGNjEjnqiAtJnYGUqIuJ5TME1CKIcDCFxpjFtOonyS21Np63uzAFui8G
 hxkQC1ul/5lME3NSMbWctGkw0V7yMSTz0QmrgYk8jrmXVzTMt28V2D6EaFe9zgpiEEUfXf9ND
 4n3knr7vR5y10QYvmUX2M8+905n+NGytzk72e1grIiguJV8cvte5ccSC5RFVEVqFlezn/tUKa
 RiJ4hPu7OjB46eeofv9Mqamc9cjEZkEHol1uKG23LK4ZEywQ88zO41pOodKuZmC/K3q/sSioW
 RWLO7liIWlwVKrhU4WS07t4Isqr+GK1+ghHTeIpoOBxZ1YVYb2ArfESaSX1k9RIiIcj5EPaia
 TQ2YWEOn6jqmHePVyWrvxRT2L3sO0Zaz6rkx3ZRowtTwOtW5EMXMsmC0IycPvz74H7jA+tLea
 MxvY03dsq5kPD+yErItEO3zf7NQuSC4WTm1rpXfMZtOjYbfKAXaHpup9BybUd8iFzLUMA0n90
 8QmfWsDz5NyV10=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 4/7/22 16:35, John Ogness wrote:
> On 2022-04-07, Helge Deller <deller@gmx.de> wrote:
>>>>  - emergency reboot/shutdown
>>>>  - cpu and rcu stalls
>>>>  - hard and soft lockups
>>>>  - hung tasks
>>>>  - warn
>>>>  - sysrq
>>
>> I agree that those needs direct printing.
>> Did you maybe checked how much (e.g. in percentage) of a normal log is
>> then still left to be printed threadened?  Just in case it's not much,
>> is there still a benefit to introduce threadened printing?
>
> A "normal" log can still contain many many messages. There have been
> reports [0] where the system died because _printk_ killed it. This was
> not any of the scenarios that we want direct printing for. It was just a
> lot of messages that some driver wanted to output.
>
> Until now the response was always to reduce printk usage or avoid it
> altogether. printk has a bad reputation because it is so unpredictable
> and expensive. So we are fixing printk. With threaded printers, we make
> a dramatic change. printk becomes 100% lockless and consistently quite
> fast. You can use it to debug or log messages within any code in the
> kernel and not need to worry about horrible latencies being introduced.
>
> For drivers that start dumping tons of messages, there is no concern
> that the system will die because of the messages.

Thank you for this good explanation!

In my case - while I debug low-level kernel code - I then just need to use
pr_warn() or pr_emerg() and get it printed non-threadened. That's sufficie=
nt for me.

>> Or another example, e.g. when running on a slow console (the best
>> testcase I know of is a 9600 baud serial port), where some printks are
>> threadened. Then a warn printk() has to be shown, doesn't it mean all
>> threadened printks have to be flushed (waited for) until the warning
>> can be shown. Will there then still be a measureable time benefit?
>
> Now you are talking about something else, unrelated to the threaded
> printing. A warn is considered a serious non-normal event. In this case,
> printk temporarily falls back to the direct, slow, unpredictable,
> printk-caller-context behavior we know today.

Good.

> If we see that direct printing is being used during normal operation
> (i.e. developers are performing warns just for fun), then we should not
> mark warns for direct printing. We will need to get some real-world
> experience here, but the goal is that systems do not use direct printing
> unless a real serious emergency is going on. Otherwise, the system risks
> dying because of the messages rather than the problem being reported.

I agree, it's good if this gets fixed at some point.

Thanks!
Helge

> John
>
> [0] https://lore.kernel.org/all/20190306171943.12345598@oasis.local.home
