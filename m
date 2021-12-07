Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E7346C323
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240793AbhLGSy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240756AbhLGSyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:54:15 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D125C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 10:50:45 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y12so60442587eda.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 10:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gmb+Apudh+c3b4tBgmQNZgnlcpZS4tKe6ho/6WlprlI=;
        b=QDFc9P5aML7+YtJ4kv8ohPRs/NxD8Xl31/KC9meyRbjsUWaCD8+eUYuX6yVUlGqPHd
         KK5IUmkhYJUj3NsARjU1eko53272JkmdRrJUgX+l9Aw8osNMVvggDJ3o5a2SoDGLt8Xb
         QZuDre4bR/z4KskwYlkuCw9lTYA7xJJPi1fr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gmb+Apudh+c3b4tBgmQNZgnlcpZS4tKe6ho/6WlprlI=;
        b=jwRT9Vi6uIQAoTIfpeD5Ze8J0huGCLn9VTUQ3fHy0GA6FZ9HlGsCxj5sE27Fx1+ttc
         RoAGqmJkKS1hietgO+OCdhP5b8ooy2VlyJYJxWEr7qP9OzVQ5mRuK48AJd+pqC+er4gJ
         D902W3lC/S4muIBD+CX83WN8itpGmB1rFktvl8BEPeS9SjYjvsvNB153zRZRkVlymx6u
         npJh+V7s4IpTITEVocCkvdOH8wyhzs/hZJySO9NqC4n4OrgMzjqmGUjscX+ZTYJEEnPC
         DG2GKPKfQfEVKHfwCkWpWK8PPRtwas/V0pPCURguIn3Z3zDByTEDz5TETJ+9I7QtOzoE
         1Gpw==
X-Gm-Message-State: AOAM532oaV/77SgNiCeV9DAhI2osd2a5eMjnjsGFIwF2bA2cMCBey2Yo
        5f9Qkw3FVHwb+vu82Znygq1m39GOsmB/a18IJWI=
X-Google-Smtp-Source: ABdhPJxxk9BKMjApzP2802wIN2ROVjhRn4MTu6w9yrPnhHzUE1tpsb56K9P8Sz/oqlxd88zxN1gN3g==
X-Received: by 2002:a17:907:72cf:: with SMTP id du15mr1319707ejc.167.1638903043313;
        Tue, 07 Dec 2021 10:50:43 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id jx10sm205176ejc.102.2021.12.07.10.50.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 10:50:41 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id v11so31418018wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 10:50:41 -0800 (PST)
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr54258440wrn.318.1638903040805;
 Tue, 07 Dec 2021 10:50:40 -0800 (PST)
MIME-Version: 1.0
References: <20211207150927.3042197-1-arnd@kernel.org> <20211207150927.3042197-3-arnd@kernel.org>
 <CAHk-=wgwQg=5gZZ6ewusLHEAw-DQm7wWm7aoQt6TYO_xb0cBog@mail.gmail.com>
In-Reply-To: <CAHk-=wgwQg=5gZZ6ewusLHEAw-DQm7wWm7aoQt6TYO_xb0cBog@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Dec 2021 10:50:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjsdmyN3qYjA-Z4bqhin2ZFkssRaaTRm_LdJBqexTxWfQ@mail.gmail.com>
Message-ID: <CAHk-=wjsdmyN3qYjA-Z4bqhin2ZFkssRaaTRm_LdJBqexTxWfQ@mail.gmail.com>
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

On Tue, Dec 7, 2021 at 10:17 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ugh. I liked your 1/3 patch, but I absolutely detest this one.

Actually, it was 3/3 I liked and that made sense to me.

1/3 isn't pretty, but I can live with it.

          Linus
