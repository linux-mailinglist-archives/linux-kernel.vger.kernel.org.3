Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9514A4A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377349AbiAaPSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:18:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57896 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358630AbiAaPSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:18:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA58260D29;
        Mon, 31 Jan 2022 15:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61356C340E8;
        Mon, 31 Jan 2022 15:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643642325;
        bh=HisdWC4AWe7kR+wvh8YBXu7Lk17Y96DfcnZsc4Sx24o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=plVL8abu/7kEL1MSYZpJR8V0QxmVt8fZGA3+4P8ij3EN/8BjmgtqAtpzCZORLg1Pa
         nmS3Uret/zOzrrsnBNF7gssxA62tFUJ7Abu3wxrl7vuDTqBntO45BY5E0j49drSMDT
         eq0ffDrISFjYCwmbBuw2alRUwHoBxA3FmUZFblALy+r07HEUHyELJxprOiUaRHjs1z
         28JDo4MVWxo1DYjscSeuF6iqhAbB5RY5bLL04KY7aGw1/83Wk4EIHOnvCHI1GR9nl7
         942jnmEFGmgg0hwdAEb9jZcc/z1FursyKcGEIvg42E3QttnsHSDDZouk9btyF0Q+cI
         OqBJy6dgBlG7w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nEYRq-0007mx-Ho; Mon, 31 Jan 2022 16:18:31 +0100
Date:   Mon, 31 Jan 2022 16:18:30 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>, kbuild-all@lists.01.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Eckert <fe@dev.tdt.de>
Subject: Re: [PATCH v1 1/1] docs: process: submitting-patches: Clarify the
 Reported-by usage
Message-ID: <Yff9xoh873aEikY4@hovoldconsulting.com>
References: <20220127155334.47154-1-andriy.shevchenko@linux.intel.com>
 <87o83xrwk9.fsf@meer.lwn.net>
 <YfPzNNvK8Sy8YmGW@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfPzNNvK8Sy8YmGW@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 01:44:20PM +0000, Matthew Wilcox wrote:
> On Thu, Jan 27, 2022 at 09:08:06AM -0700, Jonathan Corbet wrote:
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > 
> > > It's unclear from "Submitting Patches" documentation that Reported-by
> > > is not supposed to be used against new features. (It's more clear
> > > in the section 5.4 "Patch formatting and changelogs" of the "A guide
> > > to the Kernel Development Process", where it suggests that change
> > > should fix something existing in the kernel. Clarify the Reported-by
> > > usage in the "Submitting Patches".

> > How about instead something like "Reported-by is intended for bugs;
> > please do not use it to credit feature requests"?
> 
> I think this misunderstands the problem that Andy is trying to fix.
> 
> The situation: I write a patch.  I post it for review.  A bot does
> something and finds a bug (could be compile-error, could be boot
> problem).  That bot sends a bug report with a suggestion to add
> Reported-by:.  That suggestion is inappropriate because the bug never
> made it upstream, so it looks like the bot reported the "problem"
> that the patch "fixes".
> 
> It's not unique to "new feature" patches.  If I'm fixing a bug and
> my fix also contains a bug spotted by a bot, adding Reported-by
> makes it look like the bot spotted the original bug, rather than
> spotting a bug in the fix.
> 
> The best thing to do in this case is nothing.  Do not credit the bot.
> Maybe add a Checked-by:, but that would be a new trailer and I really
> don't think we need a new kind of trailer to get wrong.

It seems like the only way to fix this is to fix the bots. Adding more
documentation is unlikely to help in this case.

Can't we file a bug to whoever is running the bots (Intel?) and ask them
to remove the suggestion to add a Reported-by when the bot is testing a
patch (as opposed to mainline or even -next)?

Johan
