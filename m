Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6169D54AC1D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355684AbiFNIiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355548AbiFNIhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:37:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5055B427C7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:37:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EFEF71F894;
        Tue, 14 Jun 2022 08:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655195836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9VAXCbvSpeZ6BQdmzTuroDUERnJvufcYFBzvcgCeZIc=;
        b=dJBi3Ve8G9tUZpeQpfb4pVExJQ4QWW6xsgUbeN2qFwkEVdPxRDnhFu33OgfsShQGAQo79j
        WlROAXt3O4Xr0VmIfgi2O4OthbiAn6h1BkDFLfwDGK3pPwwb9FpzoSypd5V4jRVClVDcHp
        sYIqi7Jcy2pR6lomxZvMH9EXUUsY10c=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BF3282C141;
        Tue, 14 Jun 2022 08:37:16 +0000 (UTC)
Date:   Tue, 14 Jun 2022 10:37:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [BUG] Threaded printk breaks early debugging
Message-ID: <YqhIuTj+KAAA15J7@alley>
References: <CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com>
 <87y1y48spg.fsf@jogness.linutronix.de>
 <YqVZ4CyWTiDgngkA@google.com>
 <8735g9mqo0.fsf@jogness.linutronix.de>
 <Yqazr060OLp2Rpbk@google.com>
 <87wndlge43.fsf@jogness.linutronix.de>
 <Yqb9xOBiY/262lhk@google.com>
 <YqcN9mH/aVwBoIMQ@alley>
 <c81870cef50f4e1fac5083f0b780983d@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c81870cef50f4e1fac5083f0b780983d@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-06-13 16:11:19, David Laight wrote:
> From: Petr Mladek
> > Sent: 13 June 2022 11:14
> ...
> > Another interesting alternative is the Peter Zijlstra's mode
> > where all messages are printed to the console "immediately".
> > They are serialized only by the CPU-reentrant lock.
> > 
> > This mode is not good for production system. But it might
> > be good for debugging. The good thing is that the behavior
> > is well defined.
> 
> ISTM that all messages should be output (even if this means
> that cpu spin waiting for a serial console) until userspace
> has a chance to set an option to change the behaviour.

There are systems that do not boot because of softlockups
caused by slow consoles.

I am pretty sure that we will add the option to disable
printk kthreads sooner or later. But we prefer to improve
the code so that it works out of box. If we add the option
already know then people will disable kthreads and
do not report problematic scenarios.


> Oh, and can someone stop the distros hiding the console output.
> I want to see the 'oops' traceback when I break the kernel!

Different users have different needs. AFAIK, distros hide
the messages because they scare users and overload support.
It is probably more effective to enable them only for debugging
when users notice some malfunction.

I do not know the details. I guess that there were years of
evolution. The default in SUSE was probably set by some
project managers or people taking care of boot splash,
installation, ...

Best Regards,
Petr
