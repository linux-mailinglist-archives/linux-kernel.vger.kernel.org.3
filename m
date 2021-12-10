Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DCE470A04
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242527AbhLJTSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242263AbhLJTSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:18:43 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0A5C061353
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 11:15:08 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w1so32783685edc.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 11:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n6TeiJB+wISGru+X+gXY0wZccZ3I10qT05tugQEQE+U=;
        b=HtnJINAuiWvu5j1uPXnuB+zPKeUGmqiiUzQ9mvKkAqr/6Swhi7qZDYDuyJOssPjt3F
         LfPjZf2juis6rU+Qb2gnAq+2jAqMBgve60w4VpNOTvqn1QIboty2RstxfNKGUC1DSBdg
         FtU5yNHMHZkjeeNepNsSwJmT6Smujk+6M1pLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6TeiJB+wISGru+X+gXY0wZccZ3I10qT05tugQEQE+U=;
        b=Eq89ayIfy7rtSm88S63F9+Ssb1fJb3kqMPLq8rWh4FokiAGRdzytjARnbtv8H7jtG3
         U0igb4xEOIGWoYT9lTp0OmjhWlGuh/7j+im70E4npvWeCKQn/QnJCU7FdAz1hlxAXDAA
         wqkX6Yd7ybtXP4i1cqvYPaFHcv9MHGo6E5jjOc3NX/EGz0uGq2tkOk7RJe/R3/YcTqkq
         oiAmmsjXdSoZBfZ8BVMQi/VND85PpOQe7dxR3UGeh7mbJMAYEM/4Wl41cYWLNjuSFp5P
         PLs5aii70uw293RhNCA3NcSUntMlR4yiDDPqOlA8EW79g3577r97/kgnzLtdTtInVCnn
         SZKw==
X-Gm-Message-State: AOAM5301mtwn+f6io2N/Iu1G6Adihre4rPljnYzGCu4Nj1eLNz99M35N
        BVLXFBC2bLdXwJgyRDoufB0UfTvlKtBPB0IdJCk=
X-Google-Smtp-Source: ABdhPJzAnxjNIfEYpeKz/Q5OQD5jixMl5FD+UKfqVj6cp4u3JgI7A6Ibd0xgEWf1CvwZEs17DgaOPA==
X-Received: by 2002:a05:6402:8d0:: with SMTP id d16mr41889667edz.403.1639163706648;
        Fri, 10 Dec 2021 11:15:06 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id g18sm1916490ejt.36.2021.12.10.11.15.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 11:15:04 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id t18so16513237wrg.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 11:15:03 -0800 (PST)
X-Received: by 2002:a5d:4575:: with SMTP id a21mr16616191wrc.193.1639163703510;
 Fri, 10 Dec 2021 11:15:03 -0800 (PST)
MIME-Version: 1.0
References: <20211209214707.805617-1-tj@kernel.org> <20211209214707.805617-3-tj@kernel.org>
 <CAHk-=wgiYkECT=hZRKj8ZwfBPw2Uz=gpOGBGd4ny0KYhSsjC0w@mail.gmail.com>
 <YbOeiu5+DZQsJbm8@slm.duckdns.org> <CAHk-=wgVUBc+9UVYp=uhyqTTw-QTHNrJow1Av+1jB4_Va93m1A@mail.gmail.com>
 <YbOlLawFDdS0hkpd@slm.duckdns.org>
In-Reply-To: <YbOlLawFDdS0hkpd@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Fri, 10 Dec 2021 11:14:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjpO7=Nk3JRHUWOvsR3v688S25MM+88q3=tP1d5iN1zfw@mail.gmail.com>
Message-ID: <CAHk-=wjpO7=Nk3JRHUWOvsR3v688S25MM+88q3=tP1d5iN1zfw@mail.gmail.com>
Subject: Re: [PATCH 2/6] cgroup: Allocate cgroup_file_ctx for kernfs_open_file->priv
To:     Tejun Heo <tj@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 11:06 AM Tejun Heo <tj@kernel.org> wrote:
>
> Just so that I'm understanding you correctly. The following is what I was
> suggesting. ie. just dropping the union and making the iterator embedded:

Oh, I thought that by keeping them separate you meant still keeping the union.

But you just meant separating them into their own "namespace" sub-structures.

That's fine by me, I don't think it matters, and if you find the
namespacing helpful go right ahead.

             Linus
