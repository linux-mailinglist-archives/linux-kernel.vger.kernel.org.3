Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F18549082
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377459AbiFMN1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 09:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357425AbiFMNYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 09:24:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D4D6C0D8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 04:24:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 50D7C21CC7;
        Mon, 13 Jun 2022 11:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655119454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oVDyyQNRZdOpJs5Ykd60IDoqlaom7m+VsdjwLrey5C4=;
        b=l7TxDF/FRkFqe6u/FqVZiF7Ihqp5aGKfbXpdYa9J5gK2wPjMO7VFhYqh42d1WpkPlSFmlV
        mPRuubJBOa4M4vF19l1U3+6IU3ee+UOpbo5JyDQ9EMDrSDxvRmjpzsCekD2hspvQC7fwKg
        pdEsnXGZvSTphJrd1x52d/duHpuQ6iQ=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 29D2C2C141;
        Mon, 13 Jun 2022 11:24:14 +0000 (UTC)
Date:   Mon, 13 Jun 2022 13:24:10 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [BUG] Threaded printk breaks early debugging
Message-ID: <YqceWi1524yuVITi@alley>
References: <CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com>
 <87y1y48spg.fsf@jogness.linutronix.de>
 <CAMdYzYr-Wo713Y4qjboTpoK6GcrYfKCfRJAEizwXw6-=dymVzg@mail.gmail.com>
 <87zgihlbst.fsf@jogness.linutronix.de>
 <CAMdYzYosXiQc9=t7daPaWWS=rnTVT6nnZvVBXDycBQvfR-1FAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYosXiQc9=t7daPaWWS=rnTVT6nnZvVBXDycBQvfR-1FAA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2022-06-12 19:30:27, Peter Geis wrote:
> On Sun, Jun 12, 2022 at 7:08 PM John Ogness <john.ogness@linutronix.de> wrote:
> >
> > On 2022-06-10, Peter Geis <pgwipeout@gmail.com> wrote:
> > > This might be a side effect of the fact that this is on a low powered
> > > arm64 board. I noticed with threading enabled during large bursts the
> > > console drops an excessive amount of messages.

What do you mean that console drops an excessive amount of messages,
please?

Do you see "dropped XXX messages" in the console output?
Or something else?

> > > It's especially
> > > apparent during the handover from earlycon to the normal console.
> >
> > I guess you have a very small kernel buffer and are generating unusually
> > high amounts of messages? Is there a reason you cannot use a larger
> > buffer?
> 
> The buffer isn't an issue here, everything is available in dmesg when
> userspace becomes available. Instead some messages bound for the
> serial console are never output.

This is strage. The message "dropped XXX messages" is printed only
when the buffer was full and the oldest messages were overwritten
before they were pushed to the console. If "dmesg" shows all messages
it means that no messages were overwritten.

Best Regards,
Petr
