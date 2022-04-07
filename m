Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9264F81E0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243633AbiDGOi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbiDGOiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:38:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B3213858C;
        Thu,  7 Apr 2022 07:36:53 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649342157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oPpZ0m/EoTYA7DrLIFgnk4y1wQaBSP5g0/ujxGiQvG4=;
        b=JFPSDWgcDH5/nzr9OLV61NtbaX5cpcuOs0hCg8p6nRk238Xbe0DHd2splLnhZ405VuJZu6
        xgEvmbSFbT/qtWM9R9GrfswIOAjgDSzfsfV2CB+7/DW5obz6l9CJwCl66hMhg4n6mZ+nsq
        aNtV9/xHjb0xq6rrikMXHYDKy2ZmNYHRuYTnNi4kjix/MIL0MchiXeuf3Hlmf+ZKuC9dwE
        ZmaxHiDtf0s1V6eIY211e/y9mKy4SCwts89QsH9DlYpczA64TfX9Tk+P8jw2fHQapThy1V
        oxxOqPfVyQnyApAm5w5/Lr4rQlnQpgnbvny6d+WM8SuwKit/G68ZhHRtEChmwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649342157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oPpZ0m/EoTYA7DrLIFgnk4y1wQaBSP5g0/ujxGiQvG4=;
        b=jbnaZA7raEVl7ThYX+0bKwEQFI//kGVTC1fXb4kYxTvQG3olAl4sxy4B0WZmtBbTd/SJsB
        2DGlpoopNMzpHwCw==
To:     Helge Deller <deller@gmx.de>, Petr Mladek <pmladek@suse.com>
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
Subject: Re: [PATCH printk v2 09/12] printk: add functions to prefer direct
 printing
In-Reply-To: <b746d99e-729f-ca0d-5d30-6d803d1cd833@gmx.de>
References: <20220405132535.649171-1-john.ogness@linutronix.de>
 <20220405132535.649171-10-john.ogness@linutronix.de>
 <Yk61Q+w7tWTjh8xl@alley> <b746d99e-729f-ca0d-5d30-6d803d1cd833@gmx.de>
Date:   Thu, 07 Apr 2022 16:41:55 +0206
Message-ID: <87zgkxnepg.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-07, Helge Deller <deller@gmx.de> wrote:
>>>  - emergency reboot/shutdown
>>>  - cpu and rcu stalls
>>>  - hard and soft lockups
>>>  - hung tasks
>>>  - warn
>>>  - sysrq
>
> I agree that those needs direct printing.
> Did you maybe checked how much (e.g. in percentage) of a normal log is
> then still left to be printed threadened?  Just in case it's not much,
> is there still a benefit to introduce threadened printing?

A "normal" log can still contain many many messages. There have been
reports [0] where the system died because _printk_ killed it. This was
not any of the scenarios that we want direct printing for. It was just a
lot of messages that some driver wanted to output.

Until now the response was always to reduce printk usage or avoid it
altogether. printk has a bad reputation because it is so unpredictable
and expensive. So we are fixing printk. With threaded printers, we make
a dramatic change. printk becomes 100% lockless and consistently quite
fast. You can use it to debug or log messages within any code in the
kernel and not need to worry about horrible latencies being introduced.

For drivers that start dumping tons of messages, there is no concern
that the system will die because of the messages.

> Or another example, e.g. when running on a slow console (the best
> testcase I know of is a 9600 baud serial port), where some printks are
> threadened. Then a warn printk() has to be shown, doesn't it mean all
> threadened printks have to be flushed (waited for) until the warning
> can be shown. Will there then still be a measureable time benefit?

Now you are talking about something else, unrelated to the threaded
printing. A warn is considered a serious non-normal event. In this case,
printk temporarily falls back to the direct, slow, unpredictable,
printk-caller-context behavior we know today.

If we see that direct printing is being used during normal operation
(i.e. developers are performing warns just for fun), then we should not
mark warns for direct printing. We will need to get some real-world
experience here, but the goal is that systems do not use direct printing
unless a real serious emergency is going on. Otherwise, the system risks
dying because of the messages rather than the problem being reported.

John

[0] https://lore.kernel.org/all/20190306171943.12345598@oasis.local.home
