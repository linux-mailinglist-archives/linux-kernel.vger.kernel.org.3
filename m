Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DF9465552
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352322AbhLAS1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:27:16 -0500
Received: from foss.arm.com ([217.140.110.172]:44186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237744AbhLAS1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:27:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EEE2150C;
        Wed,  1 Dec 2021 10:23:54 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.65.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AF9E3F766;
        Wed,  1 Dec 2021 10:23:52 -0800 (PST)
Date:   Wed, 1 Dec 2021 18:23:49 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        paulmck@kernel.org, mtosatti <mtosatti@redhat.com>,
        frederic <frederic@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: Fill the gaps about entry/noinstr
 constraints
Message-ID: <Yae9tbtZW5mjcBVt@FVFF77S0Q05N>
References: <8719ad46cc29a2c5d7baac3c35770e5460ab8d5c.camel@redhat.com>
 <875ys9dacq.ffs@tglx>
 <20211130091356.7336e277@gandalf.local.home>
 <878rx5b7i5.ffs@tglx>
 <YadU1aSE6/0yGWny@FVFF77S0Q05N>
 <87v9088a5q.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9088a5q.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 07:14:41PM +0100, Thomas Gleixner wrote:
> Mark,
> 
> On Wed, Dec 01 2021 at 10:56, Mark Rutland wrote:
> > On Tue, Nov 30, 2021 at 11:31:30PM +0100, Thomas Gleixner wrote:
> >> ---
> >>  Documentation/core-api/entry.rst |  268 +++++++++++++++++++++++++++++++++++++++
> >>  Documentation/core-api/index.rst |    8 +
> >>  kernel/entry/common.c            |    1 
> >
> > I think the change to kernel/entry/common.c got included by accident?
> 
> That's what I get from doing such things 30 minutes before midnight...

Ah, I had debugged it down to:

nobikeshed void do_rst(struct tglx *tglx);
{
	aargh_rst_enter(tglx);

	documentation_begin();
	invoke_editor(tglx);
 	documentation_end();
}

... where I think we forgot the:

	enter_from_sleep_mode(tglx);
	...
	exit_to_sleep_mode(tglx);

Mark.
