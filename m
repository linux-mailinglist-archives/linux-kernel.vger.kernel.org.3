Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C87254AC00
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355716AbiFNIkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355547AbiFNIkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:40:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A179443389
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:38:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5457B1F460;
        Tue, 14 Jun 2022 08:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655195938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=01j4ea8PbgWlNi5v0zYZJxxY0Tiy59ZXmfVMBYkPEtU=;
        b=VUNe+c+TOepqw10rHOTKPJ7BdHf+m1yLky4f+vCaUmDWeIb4hsFIZPFbM2U99cHenO6fJO
        B+2cFUohog6oIR/xeuBjYdYbkFe6jZGjuKHueYqEM0agSTeXRh3yZ2I46DbeTbgP9KGoHG
        rFigcf8M0EJF4Q7Q4cGdjCZwuflvaoo=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 341182C141;
        Tue, 14 Jun 2022 08:38:58 +0000 (UTC)
Date:   Tue, 14 Jun 2022 10:38:57 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [BUG] Threaded printk breaks early debugging
Message-ID: <YqhJIac+EGMRIcAA@alley>
References: <CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com>
 <87y1y48spg.fsf@jogness.linutronix.de>
 <CAMdYzYr-Wo713Y4qjboTpoK6GcrYfKCfRJAEizwXw6-=dymVzg@mail.gmail.com>
 <87zgihlbst.fsf@jogness.linutronix.de>
 <CAMdYzYosXiQc9=t7daPaWWS=rnTVT6nnZvVBXDycBQvfR-1FAA@mail.gmail.com>
 <87sfo9l2rt.fsf@jogness.linutronix.de>
 <YqdTsjRQiJUilSg6@alley>
 <CAMdYzYr-oHp-EgNJxumsR+DrZS=U7dLpvHymkAHPYQO8FsrLrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYr-oHp-EgNJxumsR+DrZS=U7dLpvHymkAHPYQO8FsrLrQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-06-13 18:20:03, Peter Geis wrote:
> On Mon, Jun 13, 2022 at 11:11 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Mon 2022-06-13 04:29:50, John Ogness wrote:
> > > On 2022-06-12, Peter Geis <pgwipeout@gmail.com> wrote:
> > > > The buffer isn't an issue here, everything is available in dmesg when
> > > > userspace becomes available. Instead some messages bound for the
> > > > serial console are never output.
> > >
> > > OK. Good to know.
> > >
> > > > We run a serial console at 1.5m baud which is significantly higher
> > > > than most SoCs which default to 115200. I have noticed some timing
> > > > differences since the introduction of the threaded console. A
> > > > significant amount of information is dumped very early in the boot
> > > > process (between 0 and 4 seconds into boot), as most drivers are
> > > > probing during this time. It also happens to be when the earlycon
> > > > console hands over to the normal console. There is no abnormal
> > > > debugging enabled, the output is a standard (non-quiet) boot log. The
> > > > question is why is direct mode not triggering during a panic?
> > >
> > > Just to be clear, you are not losing any intermediate messages. Only the
> > > tail end of the kernel log was never printed. Is this correct?
> > >
> > > This may be the same issue being discussed here [0].
> > >
> > > John Ogness
> > >
> > > [0] https://lore.kernel.org/all/87v8t5l39z.fsf@jogness.linutronix.de
> >
> > If the last messages are missing then it is most likely the same
> > issue.
> >
> > Peter, could you please try if the patch at
> > https://lore.kernel.org/r/YqdSw/fJvnkRbjvc@alley
> > would make any difference?
> 
> This patch permits the panic to come through to the console port. Thank you!
> Tested-by: Peter Geis <pgwipeout@gmail.com>

Great news. Thanks a lot for feedback.

I guess that the patch is not final. But it seems to be a good
direction.

Best Regards,
Petr
