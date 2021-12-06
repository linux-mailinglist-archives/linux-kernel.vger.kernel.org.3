Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE3F46A22D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbhLFRJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243090AbhLFRED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:04:03 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29A9C061746;
        Mon,  6 Dec 2021 09:00:34 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id b187so13683195iof.11;
        Mon, 06 Dec 2021 09:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IiBVDlO6dWRR3OPlC/Njn9svn98M0PKUk0hBIYNL69g=;
        b=dMC2L51nn+SVaQBS1/Q5PWUqV68wfSVp9mLVd8ohDtkLnB5Xudvvpyw3eBrT5yaPB7
         WHExjFifR6KaObB4mlnHeyDNhbY/YpDX9qsSikeG98L+kRlWzjWvxTC5GTdDaqhKoWQS
         cyCCFxuwQsRMkNdzxSYdhKZCa10DxmIC5dMQ04DJSSZ38AwPGVYEUyXZ8NehQzlFHH5d
         JAfTfNN1dMXm3fGIagmjD5222ajTYNgng/7iILsOqp40z7f8bcuTlpx93Rgq1QIU/JTI
         Xn+HumX4RshuJh8DPrvflLCkCs/ym1MJ+K+8cjzh2CjwIpL1fEbbCTDn7/aXjZ45vLyP
         3bIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IiBVDlO6dWRR3OPlC/Njn9svn98M0PKUk0hBIYNL69g=;
        b=mu4TOSeXZpU8ck+INaUh+NOTcBke5tsl+8tX/i+BnnZjmBM3qSMfA3ufDP4zDBoNvI
         YzCgCFlpJUMIXl3S+kladBN8Vweyh635RkAx17jLQxQQOSPXSU4DLtIoOUloWS98SQLQ
         THlMbYhCyG4+2td+OIEyd1NZvce2TtIFqCjvZxtDzX0+qD/SDrcbNAWdBdGZMO5Zq1M5
         700HUzOiY1vU/18hyPJbGfO8l4OjW05HEvbkOV8/nX8motfdC8R0dtRvh4CLm8BfYrdN
         SIt8p62O/NReFmDJq43iEAdLWi4qe+dj0J0+vMP56u+omw1xWmOA5vcaFf/3DTHjeZ1K
         DATw==
X-Gm-Message-State: AOAM532K7OWlM7BMNxyx1BaqCIXdbimoA3rNKdDVohp9GgFvXUsy0010
        U7yCinKTtJOispRSRpTCynBrKrUj2wLenMjFjpA=
X-Google-Smtp-Source: ABdhPJxVYSlwECz3v5OqKdRVMX7qpcZnFt9DtSD1xeG+SDlPVzH5kYzfPx9ZyFy1n9r7osTeyNOEXEB8N2L7KOePoCA=
X-Received: by 2002:a02:a91a:: with SMTP id n26mr42816802jam.46.1638810034009;
 Mon, 06 Dec 2021 09:00:34 -0800 (PST)
MIME-Version: 1.0
References: <20211206140313.5653-1-ojeda@kernel.org> <20211206140313.5653-2-ojeda@kernel.org>
 <Ya4bucmvLBJRWhvn@casper.infradead.org>
In-Reply-To: <Ya4bucmvLBJRWhvn@casper.infradead.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 6 Dec 2021 18:00:23 +0100
Message-ID: <CANiq72=nCrBXXGJYZNQPvyjixTbcpzGNCqAem78LspBrHcvP5w@mail.gmail.com>
Subject: Re: [PATCH 01/19] kallsyms: support "big" kernel symbols
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 3:18 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Who are all these people, who didn't actually do any of this
> implementation, and where am I who did?

In the list you said you were going to send the changes you had as a
patch, but I didn't see it, did you send it? I also sent you a private
email about it and never got a reply. Then Gary ended up sending the
ULEB128 later on, so I picked that one up.

But, yeah, the patch should have had a Suggested-by at least. I will
add you as a Co-developed-by -- no need to overreact! ;)

Cheers,
Miguel
