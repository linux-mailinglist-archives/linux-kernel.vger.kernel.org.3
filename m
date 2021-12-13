Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A00473040
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239714AbhLMPQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:16:39 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57558 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhLMPQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:16:37 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6DE711F3B9;
        Mon, 13 Dec 2021 15:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639408596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xCCaxXJm8B7uTbUUdIN5mtZibEs0z6RoWTXwhkZrBG0=;
        b=UXhTmLBfkxU/+rQYsEaoBrklnIopW7t+wSivDM0j6f+7ejerEKa0QOXYyU1moDtxNw9vNe
        5XU62vkpY7H75f+gjYDkF3XcNZSsrrRzazB9ZynEJjfsD4CCDEe1u7ENCbuQArK4uRaeD9
        Q4cufKr98022wmRm1CumZgRRAVwHGmk=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 453B7A3B81;
        Mon, 13 Dec 2021 15:16:36 +0000 (UTC)
Date:   Mon, 13 Dec 2021 16:16:36 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: Re: [RFC PATCH] module: Introduce module unload taint tracking
Message-ID: <Ybdj1EDnMSl2NLab@alley>
References: <20211124173327.3878177-1-atomlin@redhat.com>
 <YbEZ4HgSYQEPuRmS@bombadil.infradead.org>
 <20211209153131.a54fdfbci4qnyy6h@ava.usersys.com>
 <YbKUUJUtjBk/n913@bombadil.infradead.org>
 <YbMlVFwBiRujKdEX@alley>
 <20211210160931.ftvxpulno73a2l7c@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210160931.ftvxpulno73a2l7c@ava.usersys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-12-10 16:09:31, Aaron Tomlin wrote:
> On Fri 2021-12-10 11:00 +0100, Petr Mladek wrote:
> > > If someone enables this feature I can't think of a reason why they
> > > would want to limit this to some arbitrary number. So my preference
> > > is to remove that limitation completely. I see no point to it.
> > 
> > I agree with Luis here. We could always add the limit later when
> > people report some real life problems with too long list. It is
> > always good to know that someone did some heavy lifting in
> > the system.
> 
> Fair enough.
> 
> > It might be even interesting to remember timestamp of the removal
> > to match it with another events reported in the system log.
> 
> I'm not so sure about this. We could gather such details already via Ftrace
> (e.g. see load_module()). Personally, I'd prefer to maintain a simple list.

Fair enough. It was just an idea. Simple list is a good start. We
could always add more details if people find it useful.


> > > If you just bump the count then its not duplication, it just adds
> > > more information that the same module name with the same taint flag
> > > has been unloaded now more than once.
> > 
> > Please, do not remove records that a module was removed. IMHO, it
> > might be useful to track all removed module, including the non-tainted
> > ones. Module removal is always tricky and not much tested. The tain
> > flags might be just shown as extra information in the output.
> 
> This is an interesting suggestion. Albeit, as per the subject, I prefer to
> just keep track of any module that tainted the kernel. That being said,
> Petr, if you'd prefer to track each module unload/or deletion event, then I
> would suggest for instance to remove a module once it has been reintroduced
> or maintain an unload count as suggested by Luis.

I just have fresh in mind the patchset
https://lore.kernel.org/r/20211129034509.2646872-1-ming.lei@redhat.com
It is about that removing sysfs interface is tricky and might lead to
use after free problems. I could imagine many other similar problems
that might happen with any module.

But I agree that the information about modules that tainted the kernel is
more important. I do not want to block the feature by requiring more
requirements.


Also we should keep in mind that the default panic() message should
be reasonably short. Only the last lines might be visible on screen.
Serial consoles might be really slow.

It is perfectly fine to add few lines, like the existing list of
loaded modules. Any potentially extensive output should be optional.
There already is support for optional info, see panic_print_sys_info().

Best Regards,
Petr
