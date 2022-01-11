Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D77D48B07C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244551AbiAKPK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:10:28 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52966 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiAKPK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:10:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D0B93212C2;
        Tue, 11 Jan 2022 15:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641913826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g1CGBr5UE+DhAcZQHYM7UXjap1LMIHgSoXa/s/sKCLw=;
        b=raLWmdAZfYFYlSeWrA4A33K6ahZ4TMHY2N6C1ThXedmFjwwjBb7w1k89HCd24cdNj3LSnF
        9CevhupPycvW593twI66gaAD7hNjyNBysB8avO7WzbvI77lZkLO7qZQXT2kHAI1w99O6Py
        4e8ut9ESJVxKjBinjUij53fDzNEm9FI=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AFB43A3B85;
        Tue, 11 Jan 2022 15:10:26 +0000 (UTC)
Date:   Tue, 11 Jan 2022 16:10:25 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 1/1] vsprintf: Move space out of string literals in
 fourcc_string()
Message-ID: <Yd2d4damgW2Xa8Sd@alley>
References: <20220110205558.11876-1-andriy.shevchenko@linux.intel.com>
 <308b7158-7c2a-cc98-6091-14dae2b2cbba@rasmusvillemoes.dk>
 <Yd1p1XckKtdPyKSr@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd1p1XckKtdPyKSr@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-01-11 13:28:21, Andy Shevchenko wrote:
> On Tue, Jan 11, 2022 at 11:26:21AM +0100, Rasmus Villemoes wrote:
> > On 10/01/2022 21.55, Andy Shevchenko wrote:
> > > The literals "big-endian" and "little-endian" may be potentially
> > > occurred in other places. Dropping space allows compiler to
> > > "compress" them by using only a single copy.
> > 
> > Nit: it's not the compiler which does that, but the linker.
> 
> Ah, I stand corrected, thanks!
> 
> > > -	strcpy(p, orig & BIT(31) ? " big-endian" : " little-endian");
> > > +	*p++ = ' ';
> > > +	strcpy(p, orig & BIT(31) ? "big-endian" : "little-endian");
> > >  	p += strlen(p);
> > 
> > Hm, ok, those two strings do occur a lot with of_property_read_bool()
> > and friends. But if you're micro-optimizing anyway, why not drop the
> > strlen() and say p = stpcpy(...) instead?
> 
> Why not? I'll do it for v2.

It is safe here. I just hope that it will not trigger reports from
some tools looking for potential security issues ;-)

> Any thoughts / comments on the
> https://lore.kernel.org/lkml/20220110205049.11696-1-andriy.shevchenko@linux.intel.com/T/#u?
> I'm asking since dependency and I would like to know if we still want that
> fix or not.

Just commented there. It looks fine to me.

Best Regards,
Petr
