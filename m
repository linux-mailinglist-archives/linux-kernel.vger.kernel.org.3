Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C154838F3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 00:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiACXBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 18:01:46 -0500
Received: from linux.microsoft.com ([13.77.154.182]:41814 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiACXBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 18:01:44 -0500
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id EEC1D20B7179;
        Mon,  3 Jan 2022 15:01:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EEC1D20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1641250904;
        bh=zhGZbRIjnQ9zoZM+UuGo+hN274Xz54V+/R2UHwkLgzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BTpu5M17g13mPQeTO4B4EY2hsveOO+ckUrdAqGw2o+mTSHBCUe0qDwFrvk5VTpVKS
         Tm6T9vJaa5TiqKxlpMhqLuY+GJJxeBMgQjkVEEo+g4Rq70cpk6l7bVQDujJ+NVmZMU
         Z/G1gohUv9XAocH2kit5/XFSZgaFR0WHflJLu3wk=
Date:   Mon, 3 Jan 2022 15:01:39 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 09/12] user_events: Add documentation file
Message-ID: <20220103230139.GA1522@kbox>
References: <20211216173511.10390-1-beaub@linux.microsoft.com>
 <20211216173511.10390-10-beaub@linux.microsoft.com>
 <20211222231834.875f662b37fe673dec0b3663@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222231834.875f662b37fe673dec0b3663@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 11:18:34PM +0900, Masami Hiramatsu wrote:
> Hi Beau,
> 
> On Thu, 16 Dec 2021 09:35:08 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > Add a documentation file about user_events with example code, etc.
> > explaining how it may be used.
> > 
> > Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> > ---
> >  Documentation/trace/index.rst       |   1 +
> >  Documentation/trace/user_events.rst | 195 ++++++++++++++++++++++++++++
> >  2 files changed, 196 insertions(+)
> >  create mode 100644 Documentation/trace/user_events.rst
> > 
> > diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
> > index 3769b9b7aed8..3a47aa8341c6 100644
> > --- a/Documentation/trace/index.rst
> > +++ b/Documentation/trace/index.rst
> > @@ -30,3 +30,4 @@ Linux Tracing Technologies
> >     stm
> >     sys-t
> >     coresight/index
> > +   user_events
> > diff --git a/Documentation/trace/user_events.rst b/Documentation/trace/user_events.rst
> > new file mode 100644
> > index 000000000000..36104b537476
> > --- /dev/null
> > +++ b/Documentation/trace/user_events.rst
> > @@ -0,0 +1,195 @@
> > +=========================================
> > +user_events: User-based Event Tracing
> > +=========================================

[..]

> > +Registering
> > +-----------
> > +Registering within a user process is done via ioctl() out to the
> > +/sys/kernel/debug/tracing/user_events_data file. The command to issue is
> > +DIAG_IOCSREG. This command takes a struct user_reg as an argument.
> > +
> 
> Could you add the user_reg data structure here?
> 

Sure thing.

> > +The struct user_reg requires two values, the first is the size of the structure
> > +to ensure forward and backward compatibility. The second is the command string
> > +to issue for registering.
> 
> This explanation may be a bit out of date? 
> user_reg has 4 fields. 2 for input, 2 for output.
> 

Yeah, it only requires 2 inputs to work. I'll try to make this clearer.

> And could you add a section for DIAG_IOCSDEL?
> 

Sure thing.

> > +
> > +User based events show up under tracefs like any other event under the
> > +subsystem named "user_events". This means tools that wish to attach to the
> > +events need to use /sys/kernel/debug/tracing/events/user_events/[name]/enable
> > +or perf record -e user_events:[name] when attaching/recording.
> > +
> > +**NOTE:** *The write_index returned is only valid for the FD that was used*
> > +

[..]

> > +Example Code
> > +------------
> > +See sample code in samples/user_events.
> 
> Maybe tools/testing/selftests/user_events ?
> 

Previously I was asked to put the sample code in samples/user_events, so
it lives there.

Thanks,
-Beau
