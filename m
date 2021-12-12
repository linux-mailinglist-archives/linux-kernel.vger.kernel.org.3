Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2B3471D00
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 21:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhLLUo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 15:44:26 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:35559 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhLLUoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 15:44:25 -0500
Received: by mail-pf1-f178.google.com with SMTP id p13so13255756pfw.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 12:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eeyCzwRt/r/iQsMN2NoDyx5KqHfbE7u+BMFfXv83R9w=;
        b=Udp/fnV8rIvBRrOsf9mZYbmY7qteaNarNrfi52BzZc/t2SSMjyBpd22PxuY01uSnl1
         Lz9XcA0vH7tbZZ07O7war982He5rOg1l5ZiJD7kK8RmQqMUz07sV4YFU8VwDkOWZwbO1
         LEPmwCfl81VYnbe5i5t2kCYhAD6JWfAXIz0WHx8LLk68CY+lsxhCDGCn0bVPJ7mXLvhn
         CF5HwWdNDqvPfEZW5V8Cb7/ry9EK6gleu0V+5tzNGYz0l+WBPYUsDFZ2dAtbzryzPM7z
         8vSrJucH0VC+vGFrOLAVw6LDPf3/3i1dIlKDIbra4vhh75Y6MOMKYWgWz7CSEO1xNtvD
         UCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eeyCzwRt/r/iQsMN2NoDyx5KqHfbE7u+BMFfXv83R9w=;
        b=q4S532wzSx79OYoMPOzrTMzxikK3TCa4MdClDLjxDHyl+3c33QHyS8ZZVkCJh8EkIl
         Yt6n8XTLViILjVzRgS9/Qba4noI9FFAk3ak0kokvzB83Vs7HTFFCf4UP4yw5W0ZJ2/td
         SXfzzKRZRSQsXHBjoC1R2yOMPb0I7h0Q/rn1pEyN7CRz+zq4yyIZrXq1rE2p5sUnXRjr
         hZmbGDfjB7gYR/au/bFXao0xxdAoON/vMcvu9ABC8+XskUIuGlZsZs+nPwrIlIRvWePi
         ULbDLXqlmqVOS6c8t2VzlNB7/63HPvO8Lr2VRzw7z8qtBa5rhyAmMn4TRp0RisJ/Ivi6
         ZjcQ==
X-Gm-Message-State: AOAM531NP1hgk4YHksqj5VTuQaXVWgh944oxEKeUllxq8w1/P5kcbj4B
        40cdCbCjMNYlFauUkYEsxwE=
X-Google-Smtp-Source: ABdhPJzE+pTUQgdtlmcqTq761EgtiZODIzpfL7s1GI4iY2ckbnAi4pFrNpAdrwlXA8eQ6Broz59hCg==
X-Received: by 2002:a63:7e01:: with SMTP id z1mr49502409pgc.238.1639341805239;
        Sun, 12 Dec 2021 12:43:25 -0800 (PST)
Received: from gnu-cfl-2.localdomain ([172.58.35.133])
        by smtp.gmail.com with ESMTPSA id q2sm10110196pfj.62.2021.12.12.12.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 12:43:25 -0800 (PST)
Received: by gnu-cfl-2.localdomain (Postfix, from userid 1000)
        id 044B8420978; Sun, 12 Dec 2021 12:43:24 -0800 (PST)
Date:   Sun, 12 Dec 2021 12:43:23 -0800
From:   "H.J. Lu" <hjl.tools@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fs/binfmt_elf.c: disallow zero entry point address
Message-ID: <YbZe67Rj2QuxeADn@gmail.com>
References: <20211211173447.4155374-1-hjl.tools@gmail.com>
 <CACVxJT-k664=aYp4VkG1LH3PsGHEf50PqP5EA+JWiFVb_JVs2Q@mail.gmail.com>
 <CAMe9rOqM+S_uBO-t5jJ1TLVD0R-LOJEiR6htb+k05c+ak7gF-g@mail.gmail.com>
 <CAHk-=wiEgwj3DGZai2GF9+z-FCSS455kGZ9z2g1qtdPLPWpvxQ@mail.gmail.com>
 <CAMe9rOqYxiMabie_2LN2mTTP7QPa0_mfKwDY10OSzKFj5GYT7A@mail.gmail.com>
 <CAHk-=whPK-aB34T1YS4CVK0G1m6QU7FZg28+oEeVaGy-b4hZGA@mail.gmail.com>
 <CAMe9rOoqkH=FL3s331YKeyz_Qjf7pR9M_Cf117XHErrTU-2iRA@mail.gmail.com>
 <CAHk-=wiKzE-+X7uZHELP-udnULXf75jog=UfO7GQ_gPXycELjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiKzE-+X7uZHELP-udnULXf75jog=UfO7GQ_gPXycELjw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 11:35:56AM -0800, Linus Torvalds wrote:
> [ Crossed emails ]
> 
> On Sun, Dec 12, 2021 at 11:30 AM H.J. Lu <hjl.tools@gmail.com> wrote:
> >
> > On Linux, the start of the first PT_LOAD segment is the ELF
> > header and the address 0 points to the ELF magic bytes which
> > isn't a valid code sequence.
> 
> Yeah, then I think a much more valid argument (and patch) is _that_ argument.
> 
> So that kind of explanation, along with a patch more along the line of that
> 
>         if (elf_ex->e_entry < header_sizes)
>                 goto out;
> 
> I suggested, and not talking about paper standards that may or may not
> be relevant.
> 
> That would be much more palatable to me - it's a _technical_ argument,
> not a "some paper standard that we clearly have never followed"
> argument.
> 
>                 Linus

I sent out the v2 patch with

	if (elf_ex->e_entry < sizeof(*elf_ex))
		goto out;


H.J.
