Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15F8466531
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358455AbhLBO1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347257AbhLBO07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:26:59 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2080CC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 06:23:37 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9E9C91EC0502;
        Thu,  2 Dec 2021 15:23:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638455011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ubQSWmQrw05Bz1s20/uKsey7AyjsugMRKr09G4WuY7k=;
        b=n3aYZyTmVhL0txil6syEg0em7XgTNNjiQAZB4okC9xGfgHJ0pseKDoL0pBvnNzAkzNgn90
        UQzAvsBUYS6gqoonaPAXPw5NVz106WBU3WI1U2WoofZl+B+osFUu2u3NNe9Ska5O0BOlfe
        PcErlIFfu06a6Dx9rtm7REKBB4mliJI=
Date:   Thu, 2 Dec 2021 15:23:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     X86 ML <x86@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] notifier: Return an error when a callback has already
 been registered
Message-ID: <YajW6LRVJi2IEHlU@zn.tnic>
References: <20211202133601.23527-1-bp@alien8.de>
 <20211202141630.rdkrtrltxhzdqtyb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211202141630.rdkrtrltxhzdqtyb@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 03:16:30PM +0100, Sebastian Andrzej Siewior wrote:
> >  	while ((*nl) != NULL) {
> > -		if (unlikely((*nl) == n)) {
> > -			WARN(1, "double register detected");
> > -			return 0;
> 
> This could be s/0/-EEXIST/ or do I miss something?

It is...

> I appreciate the updated warning with %ps!

Send peterz your thanks for that. :-)

> > -		}
> > +		if (unlikely((*nl) == n))
> > +			return -EEXIST;
			^^^^^^^^^^^^^^^

... right here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
