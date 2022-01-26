Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6BE49D066
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243562AbiAZRIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:08:17 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52870 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243359AbiAZRIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:08:14 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3813D210DE;
        Wed, 26 Jan 2022 17:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643216893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6sYarmNh1p4/t72vwgPp80AMUnDWVi+SvUEiAxm1d44=;
        b=W6HGoKo86Hdz8YEPVKC5pZDHNsfS9P6sRjBHFi06CwkRvNOW8ROCkmuIIGbn0nRX9OJq4M
        Cqta7uVuCpsvTC+GqURzefxUlgj9OZBq+CDNupbWyXduRStCxNAnzu7Pb83+fggEILG0PS
        ugbVr4WEL8Q7Rpfg4utq+/pZDAd3rQQ=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B6FABA3B81;
        Wed, 26 Jan 2022 17:08:12 +0000 (UTC)
Date:   Wed, 26 Jan 2022 18:08:12 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>, linux-kernel@vger.kernel.org,
        senozhatsky@chromium.org, rostedt@goodmis.org
Subject: Re: [PATCH v3] printk: ringbuffer: Improve prb_next_seq() performance
Message-ID: <YfF//E5hUNJKqg2g@alley>
References: <1642770388-17327-1-git-send-email-quic_mojha@quicinc.com>
 <87tudxfafq.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tudxfafq.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-01-21 15:14:41, John Ogness wrote:
> Hi Mukesh,
> 
> Thanks for pushing this. I think it got lost somewhere. I have a couple
> very minor non-functional change requests.

Yes, thanks for pushing this. I have somehow lost this patch on my radar.

> On 2022-01-21, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> > From: Petr Mladek <pmladek@suse.com>
> >
> > prb_next_seq() always iterates from the first known sequence number.
> > In the worst case, it might loop 8k times for 256kB buffer,
> > 15k times for 512kB buffer, and 64k times for 2MB buffer.
> >
> > It was reported that pooling and reading using syslog interface
> 
>                        ^^^^^^^ polling
> 
> > might occupy 50% of CPU.
> >
> > Speedup the search by storing @id of the last finalized descriptor.
> >
> > The loop is still needed because the @id is stored and read in the best
> > effort way. An atomic variable is used to keep the @id consistent.
> > But the stores and reads are not serialized against each other.
> > The descriptor could get reused in the meantime. The related sequence
> > number will be used only when it is still valid.
> >
> > An invalid value should be read _only_ when there is a flood of messages
> > and the ringbuffer is rapidly reused. The performance is the least
> > problem in this case.
> >
> > Link: https://lore.kernel.org/lkml/YXlddJxLh77DKfIO@alley/T/#m43062e8b2a17f8dbc8c6ccdb8851fb0dbaabbb14
> > Reported-by: Chunlei Wang <chunlei.wang@mediatek.com>
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > ---
> > Changes against v2:
> >   Added the hunk suggested by John
> >
> Petr can probably just make the changes when committing. I am not
> requesting a v4.
> 
> @Petr: Feel free to add:
> 
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

I made the changes suggested by John. Also I have reverted few more
formatting changes. The result is basically v2 + the hunk suggested
by John.

The patch is committed in printk/linux.git, branch
rework/fast-next-seq. I am going to queue it for 5.18.

Best Regards,
Petr
