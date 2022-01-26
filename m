Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADAA49C0EF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbiAZByD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbiAZByD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:54:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BCFC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 17:54:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5598615FF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 01:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06723C340E0;
        Wed, 26 Jan 2022 01:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1643162041;
        bh=HmDtfxHw0TkZKeuMjg1E/+s3cS8wl9HTxKT4JJin/A4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n5W4MYLNrHSAzrkjeTunr7ROvRwu84tUqYlWmglWNH4T//dtLXIn3XAJsu5oOdaoH
         hhxJKASSMVAc5InifAJPSkFHODUBamnR4xjouMwwZkOj3UzrHg03LPUaphyCqFmig0
         4GWA/ydOhy/CdALNzAxvUlCuplk6C1kKEtRdi8hk=
Date:   Tue, 25 Jan 2022 17:53:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Whitcroft <apw@canonical.com>
Cc:     Joe Perches <joe@perches.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH] checkpatch: make sure fix-up patches have Fixes
 tag
Message-Id: <20220125175359.9571d0cb36844ebe69583298@linux-foundation.org>
In-Reply-To: <CAO=4fJPTiNKvru=+qAasMZYUmsGQe+OBH4A2Dd1v-NFdQ8f-Qw@mail.gmail.com>
References: <20220119074609.4162747-1-senozhatsky@chromium.org>
        <a70570a10026203b544e930eb6dbcf6ad0abb2ad.camel@perches.com>
        <CAO=4fJPTiNKvru=+qAasMZYUmsGQe+OBH4A2Dd1v-NFdQ8f-Qw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 09:48:32 +0000 Andy Whitcroft <apw@canonical.com> wrote:

> On Wed, Jan 19, 2022 at 9:42 AM Joe Perches <joe@perches.com> wrote:
> >
> > On Wed, 2022-01-19 at 16:46 +0900, Sergey Senozhatsky wrote:
> > > If a patch contains "commit hash (commit name)", in other words
> > > if the patch fixes some particular commit, then require "Fixes:"
> > > tag.
> >
> > I do not like this patch as many commits merely reference a
> > previous patch and do not actually fix anything.
> 
> Agree.  It would need to be a tighter form of language to be safe to
> automatically suggest a Fixes tag.  The point of a Fixes tag is to be
> a semantically safe indicator of this relationship not relying on the
> vagaries of English for that connection.
> 
> You might be ok with something which is a tighter match on like
> "fixes <hash> (<name>)" and only suggesting a Fixes.

Also.

stable tree maintainers appear to have the habit of taking anything
which has Fixes and cheerfully backporting it.  Sometimes undesirably. 
This patch will encourage people to worsen this problem.

I wish this would simply stop, kernel-wide.  Make developers and
tree-owners actually *think* about the backport desirability.

If that were the global approach then checkpatch could

a) ask developers if they should have added "Fixes:" (this patch) then

b) if it has "Fixes:", ask developers if they should have added cc:stable.


