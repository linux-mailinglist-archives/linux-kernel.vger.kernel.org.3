Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB270471D3A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 22:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhLLVRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 16:17:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50882 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhLLVRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 16:17:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2C3FB80D48
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 21:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C275C341CB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 21:13:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="k+rFprH7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1639343623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JBHd5h73f8yYBplMFBvnP9mk3Sjoy3SanlAqRaTCpVE=;
        b=k+rFprH7f672V4p2b6zl9ZsE4Nf8VSuVXM8ZQ4B7aoTAe/SLDm9jBXyMZTSvZLycX4n7fA
        cr2k42yumFV5Fc/zpow8gG7CWJyT6HhbJ8+2Lg1jxAk0L7z4kaRabSUrHcPH7x9/uG9Ukh
        e91qHfD7PSXjbhhJ/+XGRExdnxf9K2I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0ddf73ea (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sun, 12 Dec 2021 21:13:43 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id f9so33927130ybq.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 13:13:42 -0800 (PST)
X-Gm-Message-State: AOAM530BVZUE8NFjbDv7AzB7/hJIrewbydZISbIOEcsGVO5FrIt9qa8d
        dD98zmG0MXGdYL20fzryr7l6WXLsLZG4fhw9IAU=
X-Google-Smtp-Source: ABdhPJwgBUdBrtYDjlPnZaL+2ZDpy1phRcCtuITT4bYVaxx7+43c/2o3UUwUmxQoHond4F8TLwjDZv9ZrKucv1FeCCY=
X-Received: by 2002:a25:a427:: with SMTP id f36mr28973901ybi.245.1639343621838;
 Sun, 12 Dec 2021 13:13:41 -0800 (PST)
MIME-Version: 1.0
References: <20211207121737.2347312-1-bigeasy@linutronix.de>
 <20211207121737.2347312-3-bigeasy@linutronix.de> <CAHmME9rYB7uii-HgorYmuEytoJ3bEyuD2FKkqP_oYqrAUf8cvg@mail.gmail.com>
 <87o85mvkag.ffs@tglx>
In-Reply-To: <87o85mvkag.ffs@tglx>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 12 Dec 2021 22:13:31 +0100
X-Gmail-Original-Message-ID: <CAHmME9rFMwhFr3C6uB9PMKOBsCFEpC7C-0zU44coCrYa6+be3w@mail.gmail.com>
Message-ID: <CAHmME9rFMwhFr3C6uB9PMKOBsCFEpC7C-0zU44coCrYa6+be3w@mail.gmail.com>
Subject: Re: [PATCH 2/5] irq: Remove unsued flags argument from __handle_irq_event_percpu().
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 11:39 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Jason,
>
> On Tue, Dec 07 2021 at 18:41, Jason A. Donenfeld wrote:
>
> > Applied to the crng/random.git tree, thanks.
>
> I have no objections vs. that patch, but it is good practice to solicit
> at least an ACK from the relevant maintainers before applying patches
> which touch other subsystems.

Sorry about that. Thanks for letting me know, and well noted for next time.

Jason
