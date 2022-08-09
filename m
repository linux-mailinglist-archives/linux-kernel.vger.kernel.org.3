Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E6958DFEF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345898AbiHITMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346481AbiHITLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:11:10 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBB0330
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 12:00:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i14so23843398ejg.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 12:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VVV8GGpoeLc6+MwlCT0V9dvKeeRB3XD+JQNEfU5zFB4=;
        b=XS74q4C+R/RkerpK/v956xeICTISjlZPR7ZGmhz92t1i3i7F2m/3inQg+aj3m+m6dr
         M77s0vBeprURuoen9lVmJrVsTNMEMY6A9xIYseaKhApwnfZEJpAmNH7oRlfDEbFcQVug
         aYGLct1cvKUeJSKUfVfOlQcwDiMP9ep2ky3lI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VVV8GGpoeLc6+MwlCT0V9dvKeeRB3XD+JQNEfU5zFB4=;
        b=dFnsXv3UhqqbSU0BPEZ4a4rjPLK+EqOITgYjDcKipXqX/LtHQlxhMyd1vWyESq84Bn
         0wopLIFKmJT0OLlX8I03XtAPBIP/N46AoB8gdh6E4DpSp2n/Y8YqOVmbOfZZr6TBsMXv
         MuCNiQ9cJlhJrDs+lKCJsswfbKBQICaKX9leiCmNs1suhs0jC+Sj69wWT+NsPB0S4i6V
         q8eWMAifiZ+gz1c7GJikCOeWHOee+6rvs5+DBi4bqIhAH1/+CfLgj8xnEJfJNjIEo/lP
         feubxZ0ffsXTkGXWGKrhH8oJb2NBXddykWauniTo+eE7svcRKcQFBvv7oPg+fM56Sovk
         ALhw==
X-Gm-Message-State: ACgBeo1i+XODS2WZw/Jd9WW3aMN07lwxf6BgfAanUZ5uiAgj2xwfgF/y
        B0yMIGNC/eeX5pRnMq4WLP41hZvLUvto32d2oW8=
X-Google-Smtp-Source: AA6agR5awR3sJWfQV+/xRbf58sg/vcLgkKyuwHX5pX+BT01YAaLUZqE5C/RuNBeB8OtyfTPh1CNwVA==
X-Received: by 2002:a17:907:2722:b0:731:2aeb:7942 with SMTP id d2-20020a170907272200b007312aeb7942mr10941951ejl.734.1660071603637;
        Tue, 09 Aug 2022 12:00:03 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id f26-20020a170906139a00b0072b55713daesm1433477ejc.56.2022.08.09.12.00.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 12:00:02 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id z12so15301491wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 12:00:02 -0700 (PDT)
X-Received: by 2002:a5d:56cf:0:b0:21e:ce64:afe7 with SMTP id
 m15-20020a5d56cf000000b0021ece64afe7mr14879214wrw.281.1660071601819; Tue, 09
 Aug 2022 12:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220808073232.8808-1-david@redhat.com> <CAHk-=wiEAH+ojSpAgx_Ep=NKPWHU8AdO3V56BXcCsU97oYJ1EA@mail.gmail.com>
 <1a48d71d-41ee-bf39-80d2-0102f4fe9ccb@redhat.com>
In-Reply-To: <1a48d71d-41ee-bf39-80d2-0102f4fe9ccb@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Aug 2022 11:59:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg40EAZofO16Eviaj7mfqDhZ2gVEbvfsMf6gYzspRjYvw@mail.gmail.com>
Message-ID: <CAHk-=wg40EAZofO16Eviaj7mfqDhZ2gVEbvfsMf6gYzspRjYvw@mail.gmail.com>
Subject: Re: [PATCH v1] mm/gup: fix FOLL_FORCE COW security issue and remove FOLL_COW
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
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

On Tue, Aug 9, 2022 at 11:45 AM David Hildenbrand <david@redhat.com> wrote:
>
> I totally agree with BUG_ON ... but if I get talked to in all-caps on a
> Thursday evening and feel like I just touched the forbidden fruit, I
> have to ask for details about VM_BUG_ON nowadays.
>
> VM_BUG_ON is only active with CONFIG_DEBUG_VM. ... which indicated some
> kind of debugging at least to me. I *know* that Fedora enables it and I
> *know* that this will make Fedora crash.

No.

VM_BUG_ON() has the exact same semantics as BUG_ON. It is literally no
different, the only difference is "we can make the code smaller
because these are less important".

The only possible case where BUG_ON can validly be used is "I have
some fundamental data corruption and cannot possibly return an error".

This kind of "I don't think this can happen" is _never_ an excuse for it.

Honestly, 99% of our existing BUG_ON() ones are completely bogus, and
left-over debug code that wasn't removed because they never triggered.
I've several times considered just using a coccinelle script to remove
every single BUG_ON() (and VM_BUG_ON()) as simply bogus. Because they
are pure noise.

I just tried to find a valid BUG_ON() that would make me go "yeah,
that's actually worth it", and couldn't really find one. Yeah, there
are several ones in the scheduler that make me go "ok, if that
triggers, the machine is dead anyway", so in that sense there are
certainly BUG_ON()s that don't _hurt_.

But as a very good approximation, the rule is "absolutely no new
BUG_ON() calls _ever_". Because I really cannot see a single case
where "proper error handling and WARN_ON_ONCE()" isn't the right
thing.

Now, that said, there is one very valid sub-form of BUG_ON():
BUILD_BUG_ON() is absolutely 100% fine.

                Linus
