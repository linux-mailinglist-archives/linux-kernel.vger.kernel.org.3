Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8A849F32E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 06:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346253AbiA1Fz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 00:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346225AbiA1Fzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 00:55:55 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937BDC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 21:55:55 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id om4-20020a17090b3a8400b001b633bebd2dso2156045pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 21:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F975QErmCld1Ry9Jimo+ayxozR8wtzOzvEEKrRrpHg8=;
        b=L2nrqU6OX1MI4KSXx7NJ/SkQBxlZBNIo7laKBrnx9b3waVP1kL6DCVyiGkt9CSLmxf
         xKRmcR15LcftGWX6psPkwD5R298inZVp9A0WeQc4emgywYRJg9W9/m4CG77JaMYW+3Do
         rQPfqpNq+YW+rwPv2uOTs0FX+iOVmCWplvaqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F975QErmCld1Ry9Jimo+ayxozR8wtzOzvEEKrRrpHg8=;
        b=yvMaxpQqTJp18YNxHjUI796EzYoQcwBIKFtYonn0FZLiaSE40fwbBu75SKYBO+pzM7
         tdBpsT3TSUGcax5enLNjy+FkyFW21o+Qj7qWar9m7iH9d1fSrd2yV0VmlSvAlQoEg5k5
         zEagAM+UU+UH7q/H1MneF/PXQU1hdS8NRKmH2iHcQnxU8GiQ8vzJ/qWThHdJPksFC9z+
         E9jkVTke1zjzqNggXwWOd2UVuTR4+QsRiz7uOqprDCtjHf6nA5j5TuC4lHVBh18T1VSI
         mR29vlHEsWzFmFhv04iOpb6Xm6pVqTVDST6MQ4DNPqyjnTQK1UGSc3VMhzu/GpTA8vZ3
         74XQ==
X-Gm-Message-State: AOAM531r4bIci1C1iskvjc8cXfpEIJmWoNUyyJsP3GGA4UHPCm9z7/NQ
        pjARSQ1UuErFUlSXPw0EayCOPA==
X-Google-Smtp-Source: ABdhPJxh2Vdwi60f3eQnzNYyLGToNkDAsatZ5aGmyd8d4hIdQ3Pu9BJSGUEdT9TbehrZS9IShmRmwQ==
X-Received: by 2002:a17:902:7c17:: with SMTP id x23mr7259148pll.123.1643349355127;
        Thu, 27 Jan 2022 21:55:55 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:434a:300b:6887:c7e6])
        by smtp.gmail.com with ESMTPSA id k3sm8248221pfu.180.2022.01.27.21.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 21:55:54 -0800 (PST)
Date:   Fri, 28 Jan 2022 14:55:49 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] printk: Drop console_sem during panic
Message-ID: <YfOFZfPKsKBJszq7@google.com>
References: <20220126230236.750229-1-stephen.s.brennan@oracle.com>
 <20220126230236.750229-5-stephen.s.brennan@oracle.com>
 <87fsp9pm6q.fsf@jogness.linutronix.de>
 <YfK0Ugt/i8nMVOmY@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfK0Ugt/i8nMVOmY@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/01/27 16:03), Petr Mladek wrote:
> On Thu 2022-01-27 10:28:53, John Ogness wrote:
> > On 2022-01-26, Stephen Brennan <stephen.s.brennan@oracle.com> wrote:
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -2759,7 +2782,7 @@ void console_unlock(void)
> > >  	 * flush, no worries.
> > >  	 */
> > >  	retry = prb_read_valid(prb, next_seq, NULL);
> > > -	if (retry && console_trylock())
> > > +	if (retry && !abandon_console_lock_in_panic() && console_trylock())
> > 
> > As Sergey suggested [0], I would like to see the call to
> > abandon_console_lock_in_panic() move inside console_trylock(). This will
> > help to avoid the race between NMI CPU halt and the internal sema.lock
> > spinlock.

Thanks John.

> I would prefer if it is done as a followup patch. The code in this
> patch is still needed. It helps when the non-panic CPU is busy
> with pushing many pending messages. Also it is a more conservative
> approach.

No objections. This series fixes issue at hand, so conservative approach
makes sense.

On the other hand, we are at -rc1 and it seems like a very good time to
discuss/look into/work on/etc. solution for the remaining cases/races/etc.
