Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28E050A398
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389832AbiDUPFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiDUPFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:05:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7816457B8;
        Thu, 21 Apr 2022 08:02:46 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650553364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SlFeoiiTAY6F1YgbT9Fkea5gk5jIaS/6AwlUauJpEpM=;
        b=GGJt0avUVw2F6use+61ZSkdT9PwiDiR4S7AL1HDJCb3Hy9cjATAzLUVnHOBgBFPkhUVUFb
        Clb0if52J/E/Guh7O5wHvWt96J6BP7mz4n+jdHMm3H1FpRibxIQyjYdiSD1MOEt2AdF7Ja
        6SVRTY0O/tVCIw6BaGQW+NG6WZtIVrnjw6f0EYCejRZDITPrrnsifoMRm3ooY9xzZXg7M0
        kIuFBBPiZzmlVN+SCfad3CaF5qW7bahFUXyY2bdmQGG/GLAjroKUbCUXtpIQHqNvs99cLo
        DJJaLW/TtjqXOzHXfwXAklkBqUHl97FyUjfRfJpuI5X/WlkOvTH3U6g+hSxaMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650553364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SlFeoiiTAY6F1YgbT9Fkea5gk5jIaS/6AwlUauJpEpM=;
        b=2NwaGsnWKw7FDPW9XKI+2/QUv7wPuJqR4fxhslzGs7ci87MHpwQX68EflthVOqDXGKNmx4
        PrwTu47nW10zyTDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Helge Deller <deller@gmx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Marco Elver <elver@google.com>, Wei Liu <wei.liu@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Wang Qing <wangqing@vivo.com>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v3 00/15] printk/for-next
In-Reply-To: <20220421144025.GE11747@pathway.suse.cz>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
 <20220421144025.GE11747@pathway.suse.cz>
Date:   Thu, 21 Apr 2022 17:08:43 +0206
Message-ID: <8735i6h430.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-21, Petr Mladek <pmladek@suse.com> wrote:
> This series looks almost ready for linux-next. The only real
> problems are:
>
>    + Use allow_direct_printing() instead of
>      atomic_read(&printk_prefer_direct) in defer_console_output()
>
>    + "temporary" remove
>      console_lock_single_hold()/console_lock_single_release() and
>      use the full console_lock()/console_unlock() instead.
>
> The rest are few cosmetic issues.
>
> I would like to push this into linux-next ASAP so that we get some
> wider testing of this approach. I do not expect that we could find
> much more issues just by staring into the code ;-)
>
> Now, the question is whether I should wait for v4. Or whether
> I should put v3 into linux-next with a follow up patch doing
> the two above suggested changes. They are quite trivial.
>
> Anyway, if I pushed v3+fixup then I would replace it with v4, v5, ...
> once they are available. I just do not want to block testing because
> of cosmetic problems.

Even though the fixup may be straight-forward, it would be touching a
lot of lines and could potentially introduce new problems. I prefer you
wait for a v4 so that there is no mess to clean up.

I can post a v4 tomorrow (using option #1 from [0] as the
synchronization alternative).

John

[0] https://lore.kernel.org/r/875yn2h5ku.fsf@jogness.linutronix.de
