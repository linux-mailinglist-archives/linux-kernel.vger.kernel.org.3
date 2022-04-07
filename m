Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF454F89F4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiDGUg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiDGUgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:36:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D22533DC8D;
        Thu,  7 Apr 2022 13:21:56 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649361860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BYGDkh4CW9jxYKa2CiygjphDRK87uC0bCFLxEBlauK0=;
        b=UCw39tqt9vy4XBuGCC6AIUO/pKx/xIVPxZsglv0mtw6BFKlTAvFXVFP+FYpST+1q1WgF6/
        SuAMC6Qi2aTL9fBNMeiUyqnYtRoZCfHmu2wZGwPvI8bUKAEIMsMq6UpJi97UuqZSixBneV
        zVI1wOdVdzR59bFdsa0gLL3R13ZukPK+G09ufexdA73XaP8NRLT8COfei+ZEju7xj18WA7
        +wl17tx+IyuVNpmag5PL/NO2B3vLTqgPSzrpuwwZXH7ZToLqPbuADAY//ShQZPTpHN0tH0
        kOczv9gXlFyNKSeYAE8ntr3DK/zJ6hw0hxvuWSJm1EzhPHvVugvwe0Esj1tH5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649361860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BYGDkh4CW9jxYKa2CiygjphDRK87uC0bCFLxEBlauK0=;
        b=fSf09ft2PuysFOOCA/YnECK+DcmkYXc0VrisVM/2dkaLtnHdnmWL05UK4w4gXIF9gLydpe
        g87cPo5h8D3aiSAg==
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
In-Reply-To: <7fc5853e-dbe6-c2d2-2130-003e3b9777bc@gmx.de>
References: <20220405132535.649171-1-john.ogness@linutronix.de>
 <20220405132535.649171-10-john.ogness@linutronix.de>
 <Yk61Q+w7tWTjh8xl@alley> <b746d99e-729f-ca0d-5d30-6d803d1cd833@gmx.de>
 <87zgkxnepg.fsf@jogness.linutronix.de>
 <7fc5853e-dbe6-c2d2-2130-003e3b9777bc@gmx.de>
Date:   Thu, 07 Apr 2022 22:10:19 +0206
Message-ID: <878rsgvews.fsf@jogness.linutronix.de>
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
> In my case - while I debug low-level kernel code - I then just need to
> use pr_warn() or pr_emerg() and get it printed non-threadened. That's
> sufficient for me.

Actually, no. The loglevel does not determine if a message is direct
printed or not. By "warn" I was referring to WARN_ON(condition).

If you are debugging low-level kernel code, you usually will _want_
threaded printing. The timestamps match the printk() call, so you will
get accurate logs. And the runtime performance of your low-level kernel
code will not be significantly affected by the printk() call.

If for some reason you really want non-threaded printing, the patch we
are discussing creates new functions to manually activate it:

printk_prefer_direct_enter();
pr_info("debugging\n");
printk_prefer_direct_exit();

But then your pr_info() will cause significant latencies. The timestamp
would be the same, with or without direct printing.

John
