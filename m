Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2904A4AA659
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 05:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379057AbiBEECb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 23:02:31 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:42886 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239965AbiBEEC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 23:02:29 -0500
Received: by mail-pl1-f172.google.com with SMTP id l13so6772960plg.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 20:02:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1gSrOa55TE+xa5Ovu18B/xIJNxdc0rLEc+vfv3wsOPw=;
        b=gVrhMSy6ySQjBkDG6DNxEf8eOB4XVqZkMbghmcAM/8CT40RTIA1jgjnweUKa4Aawk7
         gzIO3xxFz/AtNxyiVOOJXYrG5hKVALNgjvftIbhkYPT3RUO8cfcQb5lmYn/jLK/MIMBA
         Cz4ZStxEe56g1Xk2rRIlO3okFnsoA6ogBlkge3nG1qtPWwvVPaq47UpCD5rIebFUDKXw
         kwnxi2s3EB6HCAadmqZ2HrzLABQ/twBBcsmpY2IJTPqt2lEaCbH5ywyEHjGaDqH0amQY
         0XEr7E1s07lAfRq74UYtPdIQH8/9K1sjVt5QXwiGa2ZpXiR8ub2j4ZyQGT0o0jWtHuTP
         +XLQ==
X-Gm-Message-State: AOAM531SiXU8xcaN4ySZYJkCCoGemB2OgGW0Eo/aoedYu7w0xF266Sci
        jAWv/LwbpgSYEDRltE2LjkE=
X-Google-Smtp-Source: ABdhPJxlNKtcmgTk80gaWnM+MZmDh9r7I/FI2AE/4qK1HVaPp/GEXFVirp4r83Ilq4i0c4TYgguNjQ==
X-Received: by 2002:a17:90b:3810:: with SMTP id mq16mr6759582pjb.95.1644033749360;
        Fri, 04 Feb 2022 20:02:29 -0800 (PST)
Received: from sultan-box.localdomain ([204.152.216.102])
        by smtp.gmail.com with ESMTPSA id l2sm4247707pfc.183.2022.02.04.20.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 20:02:28 -0800 (PST)
Date:   Fri, 4 Feb 2022 20:02:26 -0800
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH RFC v1] random: do not take spinlocks in irq handler
Message-ID: <Yf320i+tVl6MXnD7@sultan-box.localdomain>
References: <YfgPWatDzkn2ozhm@linutronix.de>
 <20220204153149.51428-1-Jason@zx2c4.com>
 <Yf2Q25T04cAxJY3H@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yf2Q25T04cAxJY3H@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 09:47:23PM +0100, Sebastian Andrzej Siewior wrote:
> No need for atomic. If this is truly per-CPU then there will be no
> cross-CPU access, right?
> Therefore I would suggest to use __this_cpu_inc_return() which would avoid
> the sync prefix for the inc operation. Same for __this_cpu_or(). And you
> could use unsigned int.

Hi,

The __this_cpu_{ATOMIC_OP}() functions are for atomically performing a single
per-CPU operation for the current CPU from contexts that permit CPU migration.
Since this code is safe from CPU migrations (add_interrupt_randomness() runs in
hardirq context), the atomic per-CPU helpers are unneeded. Instead of using
__this_cpu_inc_return() and __this_cpu_or(), we can operate on the per-CPU
pointer directly without any extra safety (e.g., `++fast_pool->count` can be
used in place of `__this_cpu_inc_return(irq_randomness.count)`).

Sultan
