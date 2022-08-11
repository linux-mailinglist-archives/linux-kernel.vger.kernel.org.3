Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBC659085C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 23:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbiHKVwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 17:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbiHKVwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:52:47 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361296F570
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:52:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fy5so4974607ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=n7g4q0re2nBdkZsO0VeJ01BMNo+LYiU8Bvh11jMjf/c=;
        b=QRaKVLiumxczB4AoRVjiQPgVmOxyMyxrWzHEAgfawho9jffJn1dtwxv5L94nY0eOOI
         a1bHvaYBMVXaVxcIrVNgfEjIrglzAWyDj3apv+PqsEZtti8sg4LMGKiCXnM/mAiatZfe
         Nnq5ixvjPydGSuJHUehEg9IIl8cnD3EFODU5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=n7g4q0re2nBdkZsO0VeJ01BMNo+LYiU8Bvh11jMjf/c=;
        b=yRRjD3cZiS2Hq9LkvtTO+yQwt8PaqhskH63VRAJRj5F7Jd9S+xQAQoMLv+bk529N83
         VxnqLwhK3+1GS1RzSRIfGGHEYNgSUM4hmiW3oBYnWEJagGnytV0a94U/hsCpVC16gPdU
         5Z8pG5K92C4fTcWT5Ne1XlKKZrxPkEA/s+szVaUx1cYD6qRz4zTSpQWJiEgC77VpqfJ4
         xJCsW1vMcp3EShLw1qunt4gBHqpk7rkOzcdvegwZXTmXwP7b+k0i9XJncm8dk/5LAyBg
         gQa167PWJLRI6uReHU0M57RxsmJoSFZRN2Myl6l/SLXLPqZgYg+V+9Y8akFlZPc0dar3
         nJQg==
X-Gm-Message-State: ACgBeo1byhu1neIx+UheUh5RITwUbmAcBIJI4w70qPw5OxMz+790PhiD
        BO+zxv3xB/cIUfXCQwUdlFhfmQ1Gh/m6qto+
X-Google-Smtp-Source: AA6agR5V/dGAFUPTekR2g1iXEd8PL5UUoohXqAj5M+q575lYYrD2SQDSrfrzH/MgiMm5C2wurMit/g==
X-Received: by 2002:a17:907:1361:b0:730:8f59:6434 with SMTP id yo1-20020a170907136100b007308f596434mr676523ejb.745.1660254764556;
        Thu, 11 Aug 2022 14:52:44 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id n26-20020a170906379a00b007308fab3eb7sm90778ejc.195.2022.08.11.14.52.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 14:52:44 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id d24-20020a1c7318000000b003a5c1bf4f27so1251523wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:52:43 -0700 (PDT)
X-Received: by 2002:a1c:2582:0:b0:3a5:1453:ca55 with SMTP id
 l124-20020a1c2582000000b003a51453ca55mr6664785wml.68.1660254762906; Thu, 11
 Aug 2022 14:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220811152446.281723-1-idryomov@gmail.com> <CAHk-=wifgq59uru6xDB=nY-1p6aQ-1YB8nVhW7T-N2ctK3m1gw@mail.gmail.com>
 <CAOi1vP9BSi-65of-8D0BA1_DC0eVD_TQcWkhrGJwaXw_skhHFQ@mail.gmail.com>
 <5d0b0367a5e28ec5b1f3b995c7792ff9a5cbcbd4.camel@kernel.org>
 <YvVzHQ5DVaPAvw26@ZenIV> <72a93a2c8910c3615bba7c093c66c18b1a6a2696.camel@kernel.org>
 <YvV2zfT0XbgwHGe/@ZenIV>
In-Reply-To: <YvV2zfT0XbgwHGe/@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Aug 2022 14:52:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgYnAPiGsh7H4BS_E1aMM46PdSGg8YqFhi2SpGw+Ac_PQ@mail.gmail.com>
Message-ID: <CAHk-=wgYnAPiGsh7H4BS_E1aMM46PdSGg8YqFhi2SpGw+Ac_PQ@mail.gmail.com>
Subject: Re: [GIT PULL] Ceph updates for 5.20-rc1
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
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

On Thu, Aug 11, 2022 at 2:38 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Exporting the functionality?  Sure, no problem.  Uninlining that one...
> I suspect that it's OK, but I'd like to see profiling data; it's not
> as if it would be hard to return to having it inlined, obviously.

The only case where I think it might matter is in __d_lookup(), and
it's probably not measurable.

Yes, __d_lookup() does matter, but it only matters once you've fallen
out of RCU mode, and at that point the cost of the function call is
likely in the noise.

I don't particularly like how it's inside that dentry hash chain loop,
but realistically by then we've already done a function call for the
dentry lock spinlock, so that loop already has to deal with it.

Again, __d_lookup_rcu() is the place where adding a function call
would matter more, because that one really does show up on profiles
regularly.

And it so carefully tries to avoid function calls (but the
DCACHE_OP_COMPARE case causes problems: at one time a few years ago I
actually wanted to move the DCACHE_OP_COMPARE *out* of the loop
entirely, because it's loop invariant and having that unlikely cause
inside the loop still causes bad things for register allocation).

So I think the uninlining is fine. If I had been really unhappy about
it I would have undone the pull.

It was more the "I was told there would be cake, but there was no
cake" that annoyed me.

            Linus
