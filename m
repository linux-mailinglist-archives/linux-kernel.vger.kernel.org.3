Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7500947078F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244518AbhLJRqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:46:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50000 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242020AbhLJRqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:46:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 273D9B8294A;
        Fri, 10 Dec 2021 17:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCACC00446;
        Fri, 10 Dec 2021 17:43:06 +0000 (UTC)
Date:   Fri, 10 Dec 2021 12:43:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/13] user_events: Add minimal support for
 trace_event into ftrace
Message-ID: <20211210124305.24acd61f@gandalf.local.home>
In-Reply-To: <20211210194358.e590d49a1620df7345f9f679@kernel.org>
References: <20211209223210.1818-1-beaub@linux.microsoft.com>
        <20211209223210.1818-3-beaub@linux.microsoft.com>
        <20211210194358.e590d49a1620df7345f9f679@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 19:43:58 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > +/* Limit how long of an event name plus args within the subsystem. */
> > +#define MAX_EVENT_DESC 512
> > +#define EVENT_NAME(user_event) ((user_event)->tracepoint.name)
> > +#define MAX_FIELD_ARRAY_SIZE (2 * PAGE_SIZE)  
> 
> I don't recommend to record the event which size is more than a page size...
> Maybe 256 entries?
> It is also better to limit the total size of the event and the number
> of fields (arguments).
> 
> Steve, can we write such a big event data on the trace buffer?

In the future yes!

  https://lore.kernel.org/all/20211125175253.186422-1-tz.stoyanov@gmail.com/

But it will still require some configuration changes from user space. But
that said, if the user wants to add a larger size, then they can do so (in
the future).

-- Steve
