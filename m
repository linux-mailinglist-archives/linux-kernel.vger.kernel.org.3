Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E22471EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 01:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhLMAJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 19:09:22 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57472 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhLMAJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 19:09:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 24782CE0DAF;
        Mon, 13 Dec 2021 00:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A794C341C5;
        Mon, 13 Dec 2021 00:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639354158;
        bh=TODu9tTjC7rYkWsSwBH93xbqGiN+rFDa2+y/n24P1x0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cj6ewdwX6bZMJCbRBd7LTZSts9OAv0DaBO9e+MXsUadmVr5B9QKzeuM1YUUddzH+s
         1JhCfdSxd5auljbX1/ztMjbrzjgF8/wCpppmOhKlmTtqSC8rCg976E020GsIpB1cFo
         kw88f4QBpoNZrcVQgqHBJZSpeYiqYy2+43p5/het5egVdgmcrNGFrGDmYvY0V+Zm1d
         mny1zSlO0XoQQFZgqi+hTrMe3/+aC8HT86Z/3M2WWi7VTsfQZsrqd9ZBCkI58/BYRM
         c5cv5gBtStYwnN3LWZS9Dmqp16jP1Vip9CGHTPuAMpC2H5uslfHPXFR3KhC6ipDwVr
         iklJhbr44ipWA==
Date:   Mon, 13 Dec 2021 09:09:15 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/13] user_events: Add minimal support for
 trace_event into ftrace
Message-Id: <20211213090915.58034cd6c74782a4f58aacc2@kernel.org>
In-Reply-To: <20211210124305.24acd61f@gandalf.local.home>
References: <20211209223210.1818-1-beaub@linux.microsoft.com>
        <20211209223210.1818-3-beaub@linux.microsoft.com>
        <20211210194358.e590d49a1620df7345f9f679@kernel.org>
        <20211210124305.24acd61f@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 12:43:05 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 10 Dec 2021 19:43:58 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > +/* Limit how long of an event name plus args within the subsystem. */
> > > +#define MAX_EVENT_DESC 512
> > > +#define EVENT_NAME(user_event) ((user_event)->tracepoint.name)
> > > +#define MAX_FIELD_ARRAY_SIZE (2 * PAGE_SIZE)  
> > 
> > I don't recommend to record the event which size is more than a page size...
> > Maybe 256 entries?
> > It is also better to limit the total size of the event and the number
> > of fields (arguments).
> > 
> > Steve, can we write such a big event data on the trace buffer?
> 
> In the future yes!
> 
>   https://lore.kernel.org/all/20211125175253.186422-1-tz.stoyanov@gmail.com/

Ah, nice!

> 
> But it will still require some configuration changes from user space. But
> that said, if the user wants to add a larger size, then they can do so (in
> the future).

Hmm, so, at this moment I recommend to pick the max size of the event
smaller than page size but enough large (e.g. 1024, that is finally Beau
has chosen).
And after that new ring buffer introduced, expand it.
What would you think?

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
