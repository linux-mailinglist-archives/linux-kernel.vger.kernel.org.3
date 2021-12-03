Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918D84679FA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381648AbhLCPLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:11:12 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:45638 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352665AbhLCPLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:11:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F1329CE2702
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 15:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7C1C53FAD;
        Fri,  3 Dec 2021 15:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638544062;
        bh=I2MS+tlGndebxgqyTpUlg+3v7DixxHPGjw2biyaKMnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jxyYIsm8BSG9FthUUMSX2WIsBH0Wp6eqNb+4+Uc9yzNt7Rr+gGv6qgEo6Etj1RKmY
         GDxThXHL/o3fdXjpmyPanMOo7wLCwP8h2Bh+tJwWycTa1717qpvqe5qeHf5NvZkG0V
         SsxlRzIcrpri/1iIp1gNy8RHD+P/x6GTjkaK+Slc=
Date:   Fri, 3 Dec 2021 16:07:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH V2 2/2] kobject: wait until kobject is cleaned up before
 freeing module
Message-ID: <YaoyuzPutBjLuVNt@kroah.com>
References: <20211129034509.2646872-1-ming.lei@redhat.com>
 <20211129034509.2646872-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129034509.2646872-3-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 11:45:09AM +0800, Ming Lei wrote:
> kobject_put() may become asynchronously because of
> CONFIG_DEBUG_KOBJECT_RELEASE, so once kobject_put() returns, the caller may
> expect the kobject is released after the last refcnt is dropped, however
> CONFIG_DEBUG_KOBJECT_RELEASE just schedules one delayed work function
> for cleaning up the kobject.

The caller should NOT expect the kobject to be released.  That's the
whole point of dynamic reference counted objects, you never "know" when
the last object is released.  This option just makes it obvious so that
you know when to fix up code that has this assumption.

> Inside the cleanup handler, kobj->ktype and kobj->ktype->release are
> required.

Yes. Is that a problem?

> It is supposed that no activity is on kobject itself any more since
> module_exit() is started, so it is reasonable for the kobject user or
> driver to expect that kobject can be really released in the last run of
> kobject_put() in module_exit() code path. Otherwise, it can be thought as
> one driver's bug since the module is going away.

Why is module_exit() somehow special here?  What is so odd about that?

> When the ->ktype and ->ktype->release are allocated as module static
> variable, it can cause trouble because the delayed cleanup handler may
> be run after the module is unloaded.

Why is ktype and release part of module code?

What module kobject is causing this problem?

> Fixes the issue by flushing scheduled kobject cleanup work before
> freeing module.

Why are modules special here?

And if you enable this option, and then start unloading kernel modules,
yes, things can go wrong, but that's not what this kernel option is for
at all.

This feels like a hack for not a real problem.

thanks,

greg k-h
