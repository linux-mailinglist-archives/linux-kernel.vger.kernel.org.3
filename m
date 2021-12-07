Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFF646C28A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbhLGSVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhLGSVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:21:35 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B2CC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 10:18:04 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o20so60469682eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 10:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WE2EyhdaIKRgniT2lkFi3qndNcuUWHIlT44HhHt4xhI=;
        b=CNOUylDm39x63E41s5OZ8UaB156/vDwnH5BuYVCS8wlXEnQiVie4bOumiPwXCR+JOV
         XXGREV0opDGhSHyCgsI7srvQtyHyH/MwrczP4Bhi6Hm6XvnbnNlFfuze5pZC15/KqjEg
         QJiwXlXdECQ5sYq86gaZjnpO/UzJc/dNbZB2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WE2EyhdaIKRgniT2lkFi3qndNcuUWHIlT44HhHt4xhI=;
        b=mtE4vw3wELreH4bdIApxHzZU4S0dznqTj/wtrdB709WfVrfC0NQu/l8eSxttvjJlX5
         uQfNfwJRu1Sz/RNwu/XrTCxBsgUu/b8XOBrZvniqe8+tW8tEDCbE6tdEB+OUboUQWywK
         J/V3juw71RX0XyMG3jZRTcR2y2kusEFGOA9IoXRZq9kiMj9pG9+jhrTH8vuR4eDiZJdV
         mX5fvWc0nXEfVRoZN9mPML8fdajXe0lZNofALkG2nDSIhPKJohu4C0RPMlsCTHuQXR0m
         KEf4LMj5C+gq8TkYGqZr+g8mBRdzom5bQh0xYxoVds+k/233H8LIn0JVZVDnAS/e6BDs
         RTCQ==
X-Gm-Message-State: AOAM531M6KacIhn/Soex0+XgrvhLsP/Eoog7jXnfrP0YgVwtPbJArBeu
        fsmQFyi/2vTE2uNtJFB8vvOUeZuaKL+z2kYn
X-Google-Smtp-Source: ABdhPJwa0dovT2TtElonLlzLedgHPbzm6/TXLrC8vgN8Ww14VtRKZHJHUxJInoiZKIIBqVg+AzLmiA==
X-Received: by 2002:a17:906:4d4a:: with SMTP id b10mr1203544ejv.89.1638901082240;
        Tue, 07 Dec 2021 10:18:02 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id hv13sm181989ejc.75.2021.12.07.10.18.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 10:18:01 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id q3so31278897wru.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 10:18:01 -0800 (PST)
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr54060146wrn.318.1638901081204;
 Tue, 07 Dec 2021 10:18:01 -0800 (PST)
MIME-Version: 1.0
References: <20211207150927.3042197-1-arnd@kernel.org> <20211207150927.3042197-3-arnd@kernel.org>
In-Reply-To: <20211207150927.3042197-3-arnd@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Dec 2021 10:17:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgwQg=5gZZ6ewusLHEAw-DQm7wWm7aoQt6TYO_xb0cBog@mail.gmail.com>
Message-ID: <CAHk-=wgwQg=5gZZ6ewusLHEAw-DQm7wWm7aoQt6TYO_xb0cBog@mail.gmail.com>
Subject: Re: [RFC 2/3] headers: introduce linux/struct_types.h
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, kernelci@groups.io,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 7:10 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Working towards a cleaner header structure, start by moving the most
> commonly embedded structures into a single header file that itself
> has only a minimum set of indirect includes. At this moment, this
> include structures for

Ugh. I liked your 1/3 patch, but I absolutely detest this one.

It makes no sense to me, and just makes that header file a completely
random collection of some random structure types.

And I absolutely hate how it splits out the definition of the struct
from basic core infrastructure (initializers etc random inline
functions) for said structures.

So no. NAK on this one. I think it's a disaster.

              Linus
