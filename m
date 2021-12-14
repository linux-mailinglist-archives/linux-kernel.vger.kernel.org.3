Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFE8473CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 06:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhLNFkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 00:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhLNFkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 00:40:31 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7743C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 21:40:30 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso15242954pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 21:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8JDQ3MQqde4N4IH+n3XX9fcwBopiKKaWQdwS/tyqbmg=;
        b=JMRGQ3yC8cFgwlByku5wmFn/Vn6qivpe/xVabCxqWaQk8+ADkoKdCr5IrnsvBR6jXK
         CxcwgvZOiTIQ/Mo/F+XtLqhGBWAt13JeE/CQeV3mB6TMEu4nGumkqwM8ZxaWZcrLBeyM
         XJJJrbzNLAsV4PGgQ01bUe7Dc9V3yLbhge7X5kN9oMxFOgoUvUtIQEqRQe/hr0DvAsig
         hki8AiK8lsqNj2xDXoDFwO5DZfzDdoFpgDNot88819bDo87fEm7stEsTTWYq8pAjYVqz
         1JwvIK/lSk/lZGCPKkvhgm6hHh9vBTBnSpJ03p8DiDY3PAiZ1FLpr07IzP/bUnsQim7C
         FUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8JDQ3MQqde4N4IH+n3XX9fcwBopiKKaWQdwS/tyqbmg=;
        b=4yHTTI1+0F9lK3I95KvVDxQKAaOgrdFKuapZEZdxnFtLpQPmLEkUC3X9rJNLq5ISmO
         26rUGBGIrnSURfP3QDhsGoZ7O4FE9Nq/nW0QvliGptQYhr+EG+cU+Zl7qs+o+FCUXlri
         Ar+ezeY8XNjYpjA8gYxnad2jjmaRVoJycbAhkru4z9TD59DQFj8B215gIwOLe6vdBkpX
         t+mlhnDaRcktT8Crj4Ir6X8RgKQT3VrbSjGuHPVKGe4CqSlOhJXUc2KkEKfebKYjVub3
         7FTzkUbDX5BS6m1ImqEbsW0LIyaEBzozghR2pLWrzKT1oAsUU9D8vYZ3dkRNdKZg92ls
         RHFA==
X-Gm-Message-State: AOAM532Mg7pavVgOdHM4iZwj05B5VyFVpo1WlKkJ6QKqRCEFXvBHPlgw
        L/JTNe0VRcvTEL0wxnph3ic=
X-Google-Smtp-Source: ABdhPJzuI5t1dM1LqRoGpWfjl6OfM6sIxTLiYd+vBRqoxfGSqb07+2RIXhG3hL3fBYBznZJiqj5zpQ==
X-Received: by 2002:a17:90b:4c8b:: with SMTP id my11mr3433862pjb.96.1639460430094;
        Mon, 13 Dec 2021 21:40:30 -0800 (PST)
Received: from google.com ([2620:15c:202:201:6d07:5ea2:4ced:3b3d])
        by smtp.gmail.com with ESMTPSA id m6sm12613305pfh.87.2021.12.13.21.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 21:40:28 -0800 (PST)
Date:   Mon, 13 Dec 2021 21:40:25 -0800
From:   "dmitry.torokhov" <dmitry.torokhov@gmail.com>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        jirislaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        282827961 <282827961@qq.com>, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v20] tty: Fix the keyboard led light display problem
Message-ID: <YbguSZFyWGUt+Nwh@google.com>
References: <20211213061244.13732-1-changlianzhi@uniontech.com>
 <YbdMTCVybK34HBSz@kroah.com>
 <Ybehbz1LqRqcK+Hh@google.com>
 <tencent_404C1E8253D7D34255D5026C@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_404C1E8253D7D34255D5026C@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 10:06:38AM +0800, lianzhi chang wrote:
> > On Mon, Dec 13, 2021 at 02:12:44PM +0800, lianzhi chang wrote:
> > > > Use the "ctrl+alt+Fn" key combination to switch the system from tty to
> > > > +#define KDGKBLEDCTL  0x4B73  /* set whether to allow control of keyboard lights */
> > > > +#define KDSKBLEDCTL  0x4B74  /* get whether the keyboard light is currently allowed to be set */
> > >
> > > What userspace code is going to use these new ioctls?
> > >
> > > I still don't understand the problem that this is supposed to be
> > > solving.  How can we have never had a problem until now with regards to
> > > LED settings on keyboards?  What commit caused this to change?  Has it
> > > always been broken for 30 years and no one noticed?
> > 
> > Yes, it's been going on since forever (I guess at least 2.6 where input
> > core was introduced) and nobody really cared as very few people bounce
> > between graphical environment and VTs _and_ use CapsLock or NumLock
> > _and_ have keyboards with these LEDs).
> > 
> > Now, there is a couple-line solution that was in v19, lianzhi chang just
> > needed to drop condition that was being introduced in
> > vt_set_leds_compute_shiftstate(). That would ensure that proper state of
> > LEDs is restored on every VT switch. It also might have resulted in
> > LEDs switching momentarily off before turning on according to the
> > graphical desktop preferences, but I do not thing this is a big issue.
> 
> As you said, in the V19 version, there is a judgment condition in
>  vt_set_leds_compute_shiftstate(). If you delete it, there will be 
> some minor flaws. I always want to solve it perfectly. This may 
> be my selfish intention, but my ability is lacking, which has led 
> to iterating 21 versions.
> 
> > 
> > Now we are building this new infra with new ioctls, etc, for miniscule
> > gain of avoiding this blink. I do not believe this is worth it.
> If the current solution is not worth it, or the solution optimized for v19
> is easier to accept, I will go back to the v19 code to submit.

My recommendation would be to land the adjusted v19 (the one without the
conditional) that fixes original issue of LED state not being restored
on VT switch, and then as a followup, and if you so inclined, offer the
patch that introduces special ioctls to notify keyboard driver that
it should avoid touching LED state completely for a given VT, so that we
can discuss it separately and decide if such functionality is
needed/wanted.

Thanks.

-- 
Dmitry
