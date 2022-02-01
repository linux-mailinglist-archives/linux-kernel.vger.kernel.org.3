Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0364A6865
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242769AbiBAXNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiBAXNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:13:05 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17385C061714;
        Tue,  1 Feb 2022 15:13:05 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 71DFC6110;
        Tue,  1 Feb 2022 23:13:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 71DFC6110
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1643757184; bh=UYAYefe+zvDOAsHHZ3G5fCXex2xO7DIMn5C0bv2jW9A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=I9rhyHVsD1dKPF/ryDE/awYMpadTa8l/Jvq6DRSEI5hEwd1blur11tJuYVIiKYNSC
         Y6wRhfEgqxeRdY4l9iPO4Dm5QDjp3ihd08OJ0qya9f+2MGr0Sd7W2rBGAxmg4EF5SK
         xImRT0LI5Nhq+9lvkmFiJo69ULZax/HYisyj4MLknbuAsEEu0YSHAvXNELFQZs0F7u
         mwjt1E1EoVa0pjWd2n+XoM7BGqhSpoUyQOCIDf/jQDNoclu+t6wcgQFQlZ6ST7y95F
         8smIqbEJZCApckwTqd13JQKH0HWKTIImNWVOqOS+O63UPE7ktRcFDietBWSTL2X94U
         e8SgBFHsdQzDA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        regressions@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v4 1/3] docs: add two documents about regression handling
In-Reply-To: <b32d06dca7d228d61692acaff386928bd673754f.1643710947.git.linux@leemhuis.info>
References: <cover.1643710947.git.linux@leemhuis.info>
 <b32d06dca7d228d61692acaff386928bd673754f.1643710947.git.linux@leemhuis.info>
Date:   Tue, 01 Feb 2022 16:13:37 -0700
Message-ID: <87k0ee5gf2.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I'll try not to take so long to have a look at it this time.

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Create two documents explaining various aspects around regression
> handling and tracking; one is aimed at users, the other targets
> developers.
>
> The texts among others describe the first rule of Linux kernel
> development and what it means in practice. They also explain what a
> regression actually is and how to report one properly.
>
> Both texts additionally provide a brief introduction to the bot the
> kernel's regression tracker uses to facilitate the work, but mention the
> use is optional.
>
> To sum things up, provide a few quotes from Linus in the document for
> developers to show how serious he takes regressions.
>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/admin-guide/index.rst           |   1 +
>  .../admin-guide/regressions-users.rst         | 436 ++++++++++++
>  Documentation/process/index.rst               |   1 +
>  Documentation/process/regressions-devs.rst    | 672 ++++++++++++++++++

I'll start with some *serious* bikesheddery...it's best if the names of
the files tell readers what's inside.  This isn't something I feel
really strongly about, but we could consider

	admin-guide/reporting-regressions.txt (or just regressions.txt)
        process/regression-policy.txt

>  MAINTAINERS                                   |   2 +
>  5 files changed, 1112 insertions(+)
>  create mode 100644 Documentation/admin-guide/regressions-users.rst
>  create mode 100644 Documentation/process/regressions-devs.rst
>
[...]

> +Send a mail to the regressions mailing list (regressions@lists.linux.dev) while
> +CCing the Linux kernel's regression tracker (regressions@leemhuis.info); if the
> +issue might better be dealt with in private, feel free to omit the list.

Perhaps a separate concern, but might you want to set up an @kernel.org
alias for the regression tracker?  Trust me, you're not gonna want to
run it forever, and the ability to quickly redirect the mail may prove
to be a nice thing to have.  An email address with your domain sitting
in the docs will circulate for years after it gets changed.

> +
> +Additional details about regressions
> +------------------------------------
> +
> +
> +What is the goal of the "no regressions rule"?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Users should feel safe when updating kernel versions and not have to worry
> +something might break. This is in the interest of the kernel developers to make
> +updating attractive: they don't want users to stay on stable or longterm Linux
> +series that are either abandoned or more than one and a half years old. That's
> +in everybody's interest, as `those series might have known bugs, security
> +issues, or other problematic aspects already fixed in later versions
> +<http://www.kroah.com/log/blog/2018/08/24/what-stable-kernel-should-i-use/>`_.
> +Additionally, the kernel developers want to make it simple and appealing for
> +users to test the latest pre-release or regular release. That's also in
> +everybody's interest, as it's a lot easier to track down and fix problems, if
> +they are reported shortly after being introduced.
> +
> +Is the "no regressions" rule really adhered in practice?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +It's taken really serious, as can be seen by many mailing list posts from Linux

serious*ly*

Otherwise I can't find a lot to complain about at this point.  I'm not
really convinced that we need all those Quotations From Chairman Linus,
but I won't fight about it either :)

In general, though, unless objections show up, I don't see any real
reason to not apply this one.

Thanks,

jon
