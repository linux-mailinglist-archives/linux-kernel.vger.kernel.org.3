Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62B059264F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 22:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiHNU3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 16:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiHNU3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 16:29:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782391EED7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 13:29:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id k26so10540164ejx.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 13:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xfOGomlI+wNDkGCVf2j5gRZIqtfFV7kG9Gxf0h/VnxU=;
        b=D1Y6bxPBDIzqq1QHg8NrNOVPs/qLN7TnjpcqjIhu/3KiooSJamYyL11iJeBHUGuw4Z
         /zCFkyohXYQGDTrDFRt92yXE7xHfQMB2U2yeRZ5Y1qo3oqC+NdAsr9axuEid3/m+fXAW
         3BVEy3YoQhiAJCUpa+1DpLtLqINhPLQMU9Pug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xfOGomlI+wNDkGCVf2j5gRZIqtfFV7kG9Gxf0h/VnxU=;
        b=m6XpagPkmlw2xyk930ZN6em5feubDT/ZJpEqMjjvORudQr6we0lQbk15I6xZe18rku
         oDt4zg6k9jgOV9AwRrR8Tkr30hIebI6ENbhokDU8Ht93hzRiLAPrUzr741UXwCytoUjV
         Vw3uWhE2uxRnmWUZYUPNA5OOrL41DQkkoa3ovklhOkEhE+i1i0Kw8Fz75NQWRC9GQJxL
         PCfKLR+MkJHS2k1BHdZvDUBX2p/lal4bDDE0ZYJaf7IrsSpvrask4CM0yV5OVQJhLZtL
         fx7tJe16TdQCnA/0Z9sAMDXE1Yp6aKMxUznFlI2Q9DbUpJRc0mT39YRLujfiqjV+6QHD
         kvBg==
X-Gm-Message-State: ACgBeo24NHt7XKBMzbzVsUgEN36hSG382pbU1PzW4QD9cwIS3EdKbiBu
        1H55vcwMbZh89cG2MLpOPO7rfpKdCE53Qvui
X-Google-Smtp-Source: AA6agR4Qz2vRNvRlP7iYNhedj0rD4yLNNBKVRcBEMHkVo3gnIIZ3zFfswYSk/9y6OwjYjbIu/18PWg==
X-Received: by 2002:a17:907:2c68:b0:730:9272:8c7f with SMTP id ib8-20020a1709072c6800b0073092728c7fmr8714460ejc.528.1660508986813;
        Sun, 14 Aug 2022 13:29:46 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709060ec900b0072ed9efc9dfsm3322188eji.48.2022.08.14.13.29.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 13:29:45 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id p12-20020a7bcc8c000000b003a5360f218fso6963298wma.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 13:29:45 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed0:b0:3a3:3ef3:c8d1 with SMTP id
 g16-20020a05600c4ed000b003a33ef3c8d1mr14508149wmq.154.1660508985000; Sun, 14
 Aug 2022 13:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAOi1vP9BSi-65of-8D0BA1_DC0eVD_TQcWkhrGJwaXw_skhHFQ@mail.gmail.com>
 <5d0b0367a5e28ec5b1f3b995c7792ff9a5cbcbd4.camel@kernel.org>
 <YvVzHQ5DVaPAvw26@ZenIV> <72a93a2c8910c3615bba7c093c66c18b1a6a2696.camel@kernel.org>
 <YvV2zfT0XbgwHGe/@ZenIV> <CAHk-=wgYnAPiGsh7H4BS_E1aMM46PdSGg8YqFhi2SpGw+Ac_PQ@mail.gmail.com>
 <YvV86p5DjBLjjXHo@ZenIV> <CAHk-=wjCa=Xf=pA2Z844WnwEeYgy9OPoB2kWphvg7PVn3ohScw@mail.gmail.com>
 <CAHk-=wjLLw0xjL+TZs5DUGL8hOpmLMa4B92aDVFxw4HZthLraw@mail.gmail.com>
 <CAHk-=wjyOB66pofW0mfzDN7SO8zS1EMRZuR-_2aHeO+7kuSrAg@mail.gmail.com>
 <YvlILbn1ERLgZreh@ZenIV> <CAHk-=wjvKtkqF9AXx8GoA80h_RNUV=Ld8qhi8ZEPmDXC0VUDUA@mail.gmail.com>
In-Reply-To: <CAHk-=wjvKtkqF9AXx8GoA80h_RNUV=Ld8qhi8ZEPmDXC0VUDUA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Aug 2022 13:29:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVyGt0XCFom97ULZyG5Phf7+ifC03sW1i4HUz7xaazng@mail.gmail.com>
Message-ID: <CAHk-=wiVyGt0XCFom97ULZyG5Phf7+ifC03sW1i4HUz7xaazng@mail.gmail.com>
Subject: Re: [GIT PULL] Ceph updates for 5.20-rc1
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        clang-built-linux <llvm@lists.linux.dev>
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

On Sun, Aug 14, 2022 at 1:03 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Gcc does well regardless, and clang ends up really wanting to move so
> much out of the dentry_cmp() loop that it runs out of registers and
> always ends up doing a couple of spills.
>
> I think it reduced the spills by one, but not enough to generate the
> nice non-frame code that gcc does.

Note that that code was basically written to make gcc happy, so the
fact that clang then does worse is not hugely surprising.

I dug into it some more, and it is really "load_unaligned_zeropad()"
that makes clang really uncomfortable.

The problem ends up being that clang sees that it's inside that inner
loop, and tries very hard to optimize the shift-and-mask that happens
if the exception happens.

The fact that the exception *never* happens unless DEBUG_PAGEALLOC is
enabled - and very very seldom even then - is not something we can
really explain to clang.

So it thinks that code is really hot in the inner loop, and does all
kinds of silly things due to that.

Gcc, in contrast, generates the obvious straightforward code, and
that's what I wrote and optimized that code for.

             Linus
