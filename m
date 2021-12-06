Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DA246A604
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348741AbhLFTzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348725AbhLFTzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:55:51 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6D1C061354
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 11:52:22 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b1so27955528lfs.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 11:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qCi545GbK80p7g1dOndZmxZ1t+GhgtzglTvcr5pYytw=;
        b=BeOKbti2cLjxynXRhm3uVU/EUMQvrRDofJNFCXD70PoFjKCjIkViJzExWINqSM41cT
         M3tsA3XXX728I+CF7b3WuTC0hZCo4DzYk8wCuxW+yfH1IbsWDO6KfXuxH856xk/DZp20
         M/2ExrQz6BX6H1dHggEaZL0QsDljVu9i6MJ7TyyNCkY1DmLrISnlMjca/mU3gdYAx8JE
         szTRQLeSZHqYxNJnAXaAufrUUJaMbKSAGtqmRgl/MhABVM+32IMpOkIoPswXlcRGDxTJ
         /Y3Qj26Hg4ihT90ZPGsVrFNHbEEs9VKWfvpu4BBLkMgCmwB5zY+fyhgq1R/3NqABjo2C
         bE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCi545GbK80p7g1dOndZmxZ1t+GhgtzglTvcr5pYytw=;
        b=IfdnVnHhtrbOns+bzu9vr67XrVcS1jysQMdlwzxHDv5dU3StWznDYAeqvvkbz7KpLm
         nYRLc/xQM8ETVNJGrVmWVWCdbTomnpdSmcM0tjqjXzspNeWiyZvrE2Ff70jHCqsOyV1C
         ODL4HTErqBh5yARTHxybKGvi+vNQj3xvYwNkWul4W4mgglTBt5QeaE8p7k1kqxIUE98M
         VIm4rhBy/DDb24ttPG4J8R/RJ17OG71A556F4Nb+xzvHbo372xFCnnlEc+hL0zP38ftk
         E5M4g29kkG7LzbUU74wr8fZ+USy56j1Xw0Tq2FRIWZt/aFLw8viff5vsQ8JIoQTP3XzK
         bTEg==
X-Gm-Message-State: AOAM533KBsh9cTxBXPWHx5sTpiaarbD87zI+QwfjMe+hqK5ymsD8yt3F
        D0wceGGIBTjH1BuvylWlJXdYMo+BSrQa1G0qsHHsyw==
X-Google-Smtp-Source: ABdhPJzxQx0rWjWRUrzzOUFgjYLY+vk8jRMLZ9DjSV/X+VNkcdE4K2MaupeR9XFTfer1Qnc8G4Woge338nytB1DpSxE=
X-Received: by 2002:a05:6512:1506:: with SMTP id bq6mr37711959lfb.444.1638820340271;
 Mon, 06 Dec 2021 11:52:20 -0800 (PST)
MIME-Version: 1.0
References: <20211206140313.5653-1-ojeda@kernel.org> <20211206140313.5653-12-ojeda@kernel.org>
 <Ya4mAqoOa8zIeZGZ@kroah.com> <CANiq72kCmLgrv++mFygR6dt0xOhfv04o9j6jYLQ1N+zLNvqohQ@mail.gmail.com>
 <Ya40Bcv+eFkqc9jv@kroah.com>
In-Reply-To: <Ya40Bcv+eFkqc9jv@kroah.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 6 Dec 2021 11:52:09 -0800
Message-ID: <CAKwvOdkLF_DPP1FF60720q3zxZG2qaSNTthxJPxLb4Bj=AFE=Q@mail.gmail.com>
Subject: Re: [PATCH 11/19] vsprintf: add new `%pA` format specifier
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 8:14 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 06, 2021 at 04:56:32PM +0100, Miguel Ojeda wrote:
> > On Mon, Dec 6, 2021 at 4:46 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > That should be in a .h file somewhere.  Remember, don't put #ifdef in .c
> > > files please.

Why not put #ifdef in .c files?

> > Will do, thanks for reviewing!
> >
> > > Same here, this should not be needed if you put it in a .h file
> > > correctly.

I guess IS_ENABLED could be used in the .c code, but I don't see how
they could move the dispatch to rust_fmt_argument to a header without
moving the definition of pointer() to a header, which they probably
_cant_ do because it's noinline_for_stack.

> >
> > This one is mimicking the `CONFIG_BLOCK` one (`case 'g'` a bit above)
> > -- but we can change it, of course.
>
> That should be changed as well :)

Isn't the point to minimize code that's unused for certain configurations?

-- 
Thanks,
~Nick Desaulniers
