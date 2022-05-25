Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6D7533599
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 05:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbiEYDG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 23:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiEYDGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 23:06:52 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954382DA80
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 20:06:51 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i40so25369775eda.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 20:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sGmbJ9cE6oIUUPdop5yVhbY6e/fRjVkPPpoNpOlvd/4=;
        b=Zlgg7kmLf+pBY8CXQmH8HjY5q4isDao4TOz7cmEdYjOJ9wvIx1PvNZ1jJIrXTji2jD
         pZ9FBptuWsX3AoZYaWSkhkksuaxxLxPEbuIr3Vmcpqgk4MHQpQcnB1X9z75q+j8nbgqp
         oCAZg5Jqq+XSadOg6H55iivAliL6xDvuXPvxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sGmbJ9cE6oIUUPdop5yVhbY6e/fRjVkPPpoNpOlvd/4=;
        b=7YtRcC+qiKCrat5Vpr2X72q64exi4IvXEpd6wHp3awozatMpDxtvIkChra00sA6K8e
         wWbGUQlfMec4RPK3lHdaDNT6kVoyZsDrWKUoUP688Dso7Wo59567aDomH944+bKaHzWv
         nUI7BewwMWsC6ur/0XwwAe3dB1YBMFucoouuiptmyKIuLBkdw/ti3wi/D1FEV6z4nRuJ
         Orq0dGq80hZ7KV+2RLxso6NEBzew1lTU+sH/s/FQJ9pXlydIhvpAqMCVLNLEVArKi/4q
         0c3pksbRSO+6Wyd78k4ylLWD+sjLI/hS60BPtj0a8EG6FQFCZjzHmzUA5SzJNOvYKJ5U
         k9UQ==
X-Gm-Message-State: AOAM5333WsLjBhyYt4N+ye0HsSyRoYBKfCufRPzzAMxjv8NLwE2fFOGB
        S4E7HoCvFQ7HPVfqE+xFoZHv6qOkCuwM0Bfk
X-Google-Smtp-Source: ABdhPJzfdPwtAu2YI1QOGxTRHz3GMAxsdcKQdpGoLS/lRX46YysMdr9AKPnoyfUbBS7FTEmLqRoVHQ==
X-Received: by 2002:a05:6402:331d:b0:42a:d144:612c with SMTP id e29-20020a056402331d00b0042ad144612cmr31941633eda.325.1653448009924;
        Tue, 24 May 2022 20:06:49 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id x35-20020a50baa6000000b0042bcb9379b7sm43488ede.13.2022.05.24.20.06.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 20:06:49 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id c5-20020a1c3505000000b0038e37907b5bso343378wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 20:06:49 -0700 (PDT)
X-Received: by 2002:a1c:7207:0:b0:397:66ee:9d71 with SMTP id
 n7-20020a1c7207000000b0039766ee9d71mr2405731wmc.8.1653448008746; Tue, 24 May
 2022 20:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <Yo0zVZ7giRMWe+w5@casper.infradead.org>
In-Reply-To: <Yo0zVZ7giRMWe+w5@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 May 2022 20:06:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2kKMnxUu65zbJ28t0azRv3-EHpKaaecYTcLiNtw_eMQ@mail.gmail.com>
Message-ID: <CAHk-=wj2kKMnxUu65zbJ28t0azRv3-EHpKaaecYTcLiNtw_eMQ@mail.gmail.com>
Subject: Re: [GIT PULL] Page cache changes for 5.19
To:     Matthew Wilcox <willy@infradead.org>, "Ted Ts'o" <tytso@mit.edu>,
        Gao Xiang <xiang@kernel.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 12:34 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> These are the page cache changes for 5.19.  There are a few conflicts
> with other peoples work:

Hmm. Also the ext4 symlink change (which made your changes there go
away) and the erofs fscache code.

I think I sorted it all out correctly and it looked very
straightforward, but it would probably be a good idea for people to
double-check despite that.

                Linus
