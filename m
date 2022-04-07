Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01784F7C37
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244050AbiDGJ6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244051AbiDGJ6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:58:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6E6FEF;
        Thu,  7 Apr 2022 02:56:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8F167212B7;
        Thu,  7 Apr 2022 09:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649325381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IlRD7m/alIJncAcf5ZsFIg2sRj4ry7LBP76Q3+m8Fv0=;
        b=UKcH9KkS3V5pJFKjQTrgHntE36GmrRlMKttleodgavjTOO4sIry5rjlFnvmWUk+RlhxYpD
        UULtSZJpg0Ou1egwUxOTGJfzoz2l0kn9b21jZF6g7Ixb97QLzQkRiSBe3koCPaQLd63jYl
        kZKL4+gZ1GU9ZkRrER5szKvrJZF+QoM=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BAFEFA3B83;
        Thu,  7 Apr 2022 09:56:19 +0000 (UTC)
Date:   Thu, 7 Apr 2022 11:56:19 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
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
        Helge Deller <deller@gmx.de>, Marco Elver <elver@google.com>,
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
Message-ID: <Yk61Q+w7tWTjh8xl@alley>
References: <20220405132535.649171-1-john.ogness@linutronix.de>
 <20220405132535.649171-10-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405132535.649171-10-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-04-05 15:31:32, John Ogness wrote:
> Once kthread printing is available, console printing will no longer
> occur in the context of the printk caller. However, there are some
> special contexts where it is desirable for the printk caller to
> directly print out kernel messages. Using pr_flush() to wait for
> threaded printers is only possible if the caller is in a sleepable
> context and the kthreads are active. That is not always the case.
> 
> Introduce printk_prefer_direct_enter() and printk_prefer_direct_exit()
> functions to explicitly (and globally) activate/deactivate preferred
> direct console printing. The term "direct console printing" refers to
> printing to all enabled consoles from the context of the printk
> caller. The term "prefer" is used because this type of printing is
> only best effort. If the console is currently locked or other
> printers are already actively printing, the printk caller will need
> to rely on the other contexts to handle the printing.
> 
> This preferred direct printing is how all printing is currently
> handled (unless explicitly deferred).
> 
> When kthread printing is introduced, there may be some unanticipated
> problems due to kthreads being unable to flush important messages.
> In order to minimize such risks, preferred direct printing is
> activated for the primary important messages when the system
> experiences general types of major errors. These are:
> 
>  - emergency reboot/shutdown
>  - cpu and rcu stalls
>  - hard and soft lockups
>  - hung tasks
>  - warn
>  - sysrq
> 
> Note that since kthread printing does not yet exist, no behavior
> changes result from this commit. This is only implementing the
> counter and marking the various places where preferred direct
> printing is active.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Looks good to me. Let's see how it works in practice.
It is possible that we will need to add it on more
locations. But it is also possible that we will be
able to remove it somewhere.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
