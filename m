Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4DD4708FB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245466AbhLJSll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242061AbhLJSlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:41:40 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F983C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 10:38:05 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id m24so8758359pgn.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 10:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ykP11dG828/Ovx8hCrFHY1auii5uZTVhWgmhjxyUXaA=;
        b=p783Et1gwS90tGpkB5iL24yLEqnGBO5K8Fszs1jtZGkFO7Y0GmUW5aANnbQWrC1aQa
         I4E+5bA5ENC4OP0yuoQVRz2S+hgUFINNvIpJoGOcUyJfanC9J1T72i9OhQ3cWk4SnB7R
         EZlOu89/MnQ3mxOUAyTnx9qm5HXLMDpg72XDBpYhnuXaO3DwsVoyF3mp0PcmPr9wUnrf
         S8OgivmTqQAwqKLpiOxkO/dOiY0KM1yExAKb4FGz/gOPM6eyWhgkXK2FvqBN7m8Bj3dW
         kWkEc5hCzQygfLkSOYjM8vumG2rFKyBMvwWs16ixk3yyx5mzHtHCBUWKqydXh9Q3cxmB
         8Qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ykP11dG828/Ovx8hCrFHY1auii5uZTVhWgmhjxyUXaA=;
        b=pRnk/+Q5+CcaRTTXMgXCD9LQLSHRDxksHixneUnrCUznaTGKLY+wizURtxApwJeB62
         WhPzZpKUgUGLGDGsb9mIfb/ZoBgYwj7DAFdW8JbBD3utAk85bMsWY4YRLDe7qEXdus3f
         v/DGjso60k+cLE6s/csz9/JCfQVRmM9gjNXcLsfga/srlo4NzgT0KA1yf7gXV+dW/8J5
         9gHnG0bBklZtp7XSIJWTCu9UkwF2TtwMeLecxvQaSRb7HSZBX6C+HSG2As9fvdWcx1dF
         FOZBcclYkt2+sNP45aPOJQVVSOCXqhOZvBDTAwsGFgPEMhiARB9zvTmKcUOA0xhHPNBv
         GPpQ==
X-Gm-Message-State: AOAM531JSbpHWS9kNXIGbVVi88t22+i63xTAIMUu+Rg9IR43c2Zf220J
        P7CBJQld5bllmh57TPfNpwM=
X-Google-Smtp-Source: ABdhPJyHc62D24ikiuK+khW2/KWqKzEalLnhn752anXZOpAS3cl9uZqhi8XFOYkQm5sdkLwVqRyXWQ==
X-Received: by 2002:a05:6a00:88b:b0:4a2:9c62:8865 with SMTP id q11-20020a056a00088b00b004a29c628865mr19837582pfj.46.1639161484770;
        Fri, 10 Dec 2021 10:38:04 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id m13sm3268255pgt.22.2021.12.10.10.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 10:38:04 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 10 Dec 2021 08:38:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal Koutny <mkoutny@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Newsome <jnewsome@torproject.org>,
        Alexey Gladkov <legion@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH 2/6] cgroup: Allocate cgroup_file_ctx for
 kernfs_open_file->priv
Message-ID: <YbOeiu5+DZQsJbm8@slm.duckdns.org>
References: <20211209214707.805617-1-tj@kernel.org>
 <20211209214707.805617-3-tj@kernel.org>
 <CAHk-=wgiYkECT=hZRKj8ZwfBPw2Uz=gpOGBGd4ny0KYhSsjC0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgiYkECT=hZRKj8ZwfBPw2Uz=gpOGBGd4ny0KYhSsjC0w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Dec 10, 2021 at 09:53:41AM -0800, Linus Torvalds wrote:
> On Thu, Dec 9, 2021 at 1:47 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > of->priv is currently used by each interface file implementation to store
> > private information. This patch collects the current two private data usages
> > into struct cgroup_file_ctx which is allocated and freed by the common path.
> > This allows generic private data which applies to multiple files, which will
> > be used to in the following patch.
> 
> I'm not sure if it's worth it having that union just to make the
> struct be 8 bytes instead of 16 (and later 16 bytes instead of 24),
> when the real cost is that dynamic allocation overhead, and there's
> likely only one or two active actual allocations at a time.

Yeah, I was initially doing ctx->procs_it and ->psi_trigger which looked
kinda silly so then nested structs and then why not the union which is kinda
logical in semantic sense.

> Wouldn't that simplify things? And might there not be some cgroup
> pressure user that also wants to use the iterator interfaces? Maybe
> not, my point is more that once we have an explicit struct allocation
> for cgroup proc files, we might as well clarify and simplify the
> code..

It's a bit of bikeshedding but I wanna explicitly denote who at currently
uses the fields, so how about nested structs w/ embedded iterator? If other
files ever want to share fields, we can shift those fields to the common
area together with ->ns.

Thanks.

-- 
tejun
