Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9118748BDD4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 05:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350577AbiALENL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 23:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiALENK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 23:13:10 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A84C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:13:10 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso9351396pjm.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DbUxyMjpIOog9wvfYa8Q3QxFBHZVqdqm471d2skc/TM=;
        b=Sn3ZbZTXPZfNkTiNJMD2UkTzn2GvsdJbhulbJeiycHizNIxII/MgCzTeKZdWeoSaNm
         ribBHtwEFV+3p6rNFZDkF7tKn9PtU6TCMycdCpBxoZJdw5POb6cSBfxiPad/GCEqVboJ
         KsDK7acIaRwgWaj0uu2Go95+/KCjhVw4snhP33a/jStYyzM09pmh3w8TZrOflIYxHIHL
         DunxK3hjlWNj+5NtNxk9sy4TNr2OJUlAj56z8QpIKMHQlVWGRWkiSW/MeTAUUXo4Ye5k
         KxaLk0NDYDaFr6uM2pIds5uL6kMkRuHa8V3L3O43xsUIF/QMDPChi9kyV+aA+mKC6j61
         F1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DbUxyMjpIOog9wvfYa8Q3QxFBHZVqdqm471d2skc/TM=;
        b=hWxhkpk7Z2e/+9Ek8DLyY6clh9Gr6Rhwu6yorEw7MTZQ2TQil5d4LwVIZlSAoHQw9q
         wLbUnhaArnHRWtXlb7FPvmSBsYttXK4+DoNUjHKE3kHWv7yEnSIdA82kbqio10IDqQx1
         wRFHQIjS483ZNv+rPp9l5RUcVUH4oeqHJ+BByWpJJCf3jCgt57Vj2KCpxwqNTAYzvUd0
         T8hMSp1Vx+gIt9Hy9MXgjJQ3UHc9W7+B/pxPvnu6GH9RozJYK8qXFZr6dfbCobksJefy
         J6yIpHk9Cnch248igjYz6EnNnGQkNS0hCtR52bPFdydfpST1KnboMY/juv9fe4Msota8
         YlYA==
X-Gm-Message-State: AOAM533J4evkUA+jLYXpGmb3BOi1+hTIf0qdAjD2sSlUbXA/DArHst6s
        bmLSdtD1e/C7OVEs9jyKmw==
X-Google-Smtp-Source: ABdhPJxSSNkxwmCEPEdNlNPJ7QZ7UwepXMStTYc8FQ7Vl5dm6pY3aUNir0lDN6Q8ldY1w02w1P4WHw==
X-Received: by 2002:a17:902:7107:b0:14a:438f:f196 with SMTP id a7-20020a170902710700b0014a438ff196mr7736213pll.165.1641960790099;
        Tue, 11 Jan 2022 20:13:10 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t8sm11996244pfj.114.2022.01.11.20.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 20:13:09 -0800 (PST)
Date:   Wed, 12 Jan 2022 12:13:03 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Laight <David.Laight@aculab.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v2] tracing: Add test for user space strings when
 filtering on  string pointers
Message-ID: <Yd5VTy0UW1tOcjTD@piliu.users.ipa.redhat.com>
References: <20220110115532.536088fd@gandalf.local.home>
 <31c11a47a8bc4e34a1a64d54a54bb944@AcuMS.aculab.com>
 <20220110122436.5302128f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110122436.5302128f@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Sorry that I am out of office, and not reply in time.

On Mon, Jan 10, 2022 at 12:24:36PM -0500, Steven Rostedt wrote:
> On Mon, 10 Jan 2022 17:11:52 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > From: Steven Rostedt
> > > Sent: 10 January 2022 16:56
> > > 
> > > From: Steven Rostedt <rostedt@goodmis.org>
> > > 
> > > Pingfan reported that the following causes a fault:
> > > 
> > >   echo "filename ~ \"cpu\"" > events/syscalls/sys_enter_openat/filter
> > >   echo 1 > events/syscalls/sys_enter_at/enable
> > > 
> > > The reason is that trace event filter treats the user space pointer
> > > defined by "filename" as a normal pointer to compare against the "cpu"
> > > string. If the string is not loaded into memory yet, it will trigger a
> > > fault in kernel space:  

For accurate commit log, the swapped-out user page is not the root cause
of this bug is "supervisor read access in kernel mode". And it is trueth
that swapped-out user page can trigger a bug here, but it should be a
different a stack.

> > 
> > If a userspace pointer can end up the kernel structure then presumably
> > a 'dodgy' user program can supply an arbitrary kernel address instead?
> > This may give the user the ability to read arbitrary kernel addresses
> > (including ones that are mapped to PCIe IO addresses).
> > Doesn't sound good at all.
> 
> Only root has access to the information read here. All tracing requires
> root or those explicitly given access to the tracing data, which pretty
> much allows all access to kernel internals (including all memory). So
> nothing to worry about here ;-)
> 

I am not sure about the opposite way. Since kernel is not allowed to
access userspace most of the time, then is it an leakage, which looks
like:
    use tracepoint as trampoline to uaccess.
    read out user info from ustring_per_cpu

But any kernel code can call copy_from_user() function family freely, so
it is not a problem caused by this patch, right? Or ustring_per_cpu
should be zeroed out.

For V2, feel free to add "Tested-by"


Thanks,

	Pingfan
> > 
> > ...
> > > +	if (likely((unsigned long)str >= TASK_SIZE)) {
> > > +		/* For safety, do not trust the string pointer */
> > > +		if (!strncpy_from_kernel_nofault(kstr, str, USTRING_BUF_SIZE))
> > > +			return NULL;
> > > +	} else {
> > > +		/* user space address? */
> > > +		ustr = (char __user *)str;
> > > +		if (!strncpy_from_user_nofault(kstr, ustr, USTRING_BUF_SIZE))
> > > +			return NULL;  
> > 
> > Is that check against TASK_SIZE even correct for all architectures?
> > copy_to/from_user() uses access_ok() - which is architecture dependant.
> 
> The problem with access_ok() (which I tried first) is that it can't be used
> from interrupt context, and this check can happen in interrupt context.
> Either way, if we pick the wrong one for the arch, the only thing bad that
> can happen is that it returns "fault" and the filter fails, just like if
> the pointer was to bad memory.
> 
> > 
> > I think you need to remember where the pointer came from.
> > 
> 
> Why?
> 
> -- Steve
