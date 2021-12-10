Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320BE470ED9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345183AbhLJXmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 18:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243792AbhLJXmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:42:10 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23656C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:38:35 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id t19so15398751oij.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9BvpYczibr3fHvAclIbse6LgViarAvvHO4nOus9478w=;
        b=heFroTLFvaYod5i0Dvqetc7fryMKOGz3I4zZObwH9D+86y7ja1BzN4djpIpbChIY/p
         oGnuewtRqlqbN5I5CcXfqonJXCt7rI3Siv9YbSQyMvwkg9+rjauRs+FH8ARi8+ecQBgT
         1HBc+rJI9iWaa2iOvA1zKrnmSaz5x+5L4piB0dto6CMAFTM3JdlyPl+Qdu7gyihAafhc
         gQ1igf1ZCCAJdGMTIpmDQW5zTFkzOYqWCEM2RAfcHLTgR4kLw9CPZSih0bkCC0Dmejg5
         8iPPqfyvuhF6apmpWB4PyZfxULk3jn28VQBqWZkYQtAaWl7Dr99pfXiow5os8QAFjmQW
         UWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9BvpYczibr3fHvAclIbse6LgViarAvvHO4nOus9478w=;
        b=ae9yKxGAluf+2Mi/nZ2QlemGMBp/O/rG42gNATsyO0pIn6HoLw5/0R8wNMgoF3tpm+
         kAJ+TeaGjpXmzl3fDhckrGaQqbbRq8JK/vlmV4NoaoL8QyJo5uzNHVnjPwrQdZgN/6FR
         jrU6HzqSttColyE9+ZVaVdssxTh5fkLjFnGDeehhFZ/VZagiNO7qA0DAfjvvNbT+0kb3
         oFUhbvdGUlVbBkMiMv8HkovVGwyR9oAQa1ehKgsu291umI/Ci+YKuzHIAyJPjTr3lr+O
         SdkG8bqZ0KvDTsyvVmHt1vsxOmkBJI9ij339hPuIjMJB+MwobBH8no5pZs2M8XTCRjBD
         SRgw==
X-Gm-Message-State: AOAM531d/ubSrGQDZbcRltxUE2X/vPP0kVMkakE3uk67Hi1GwAZMzFYy
        pic8ob4Oz2oYLyS1fo0k2iEly380t5qZ/r5yGFYzQw==
X-Google-Smtp-Source: ABdhPJykSGuBB2Df/+3enelxI3cyS/CCWGdkWyb7VqpHYQmgUgKZqf01pTVbXZ1kDTYMBO3sJUHK9OIeAnAddAuNNQ4=
X-Received: by 2002:aca:af50:: with SMTP id y77mr15416460oie.134.1639179514326;
 Fri, 10 Dec 2021 15:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20211115085630.1756817-1-elver@google.com> <YZJw69RdPES7gHBM@smile.fi.intel.com>
 <CANpmjNMcxQ1YrvsbO-+=5vmW6rwhChjgB20FUMKvHQ9HXNwcAg@mail.gmail.com>
 <YZJ01V8fZBlWz4VW@smile.fi.intel.com> <20211210183520.5cb1c4d4@gandalf.local.home>
In-Reply-To: <20211210183520.5cb1c4d4@gandalf.local.home>
From:   Marco Elver <elver@google.com>
Date:   Sat, 11 Dec 2021 00:38:22 +0100
Message-ID: <CANpmjNMda2Gu48wOTQAb0pGHK7-EFPngbr-0r2RnJmM7J9mcMw@mail.gmail.com>
Subject: Re: [PATCH] panic: use error_report_end tracepoint on warnings
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Wei Liu <wei.liu@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Alexander Popov <alex.popov@linux.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2021 at 00:35, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 15 Nov 2021 16:55:17 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > > > >       ERROR_DETECTOR_KFENCE,
> > > > > -     ERROR_DETECTOR_KASAN
> > > > > +     ERROR_DETECTOR_KASAN,
> > > > > +     ERROR_DETECTOR_WARN
> > > >
> > > > ...which exactly shows my point (given many times somewhere else) why comma
> > > > is good to have when we are not sure the item is a terminator one in the enum
> > > > or array of elements.
> > >
> > > So you want me to add a comma?
> >
> > Yes. And you see exactly why I'm asking for that.
> >
> > > (I'm not participating in bikeshedding here, just tell me what to do.)
> >
> > Done!
>
> Is there going to be another patch set? Or did I miss it?

Andrew was kind enough to fix it up for me. :-)
It's already in -mm:
  https://www.spinics.net/lists/mm-commits/msg161488.html
  https://www.spinics.net/lists/mm-commits/msg161487.html

Thanks,
-- Marco
