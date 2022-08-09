Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2AB58E11D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbiHIUbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343850AbiHIUaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:30:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480BB22C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:30:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id k26so24240876ejx.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 13:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=SGeHWpS8KXCNe1fs123Ae1bZ4jHY7XPArBiSK195qHo=;
        b=diZ72ruOeFCCt/uKAyC4hFEGjST0bkVVYN2Yxf3d0zX/HotIMYgB0uLJgA4xp6aHl1
         b/YZNcRaInm3BeLB5q6B+tIq7+Cr7Jg7X2XQ5MJ95vhSXGcwq90tjIn+warmeDgCniS1
         CMV4iqB9gpLMcU5qcvguZuHFhANUGStypzYYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SGeHWpS8KXCNe1fs123Ae1bZ4jHY7XPArBiSK195qHo=;
        b=PyN9x6dRQYb7Uxkv8xd/pZcvNlGrYyvkSodKKgfAZAap3CprwuCkBEFwlbvJ7mF5cE
         EGhnkQu28HouZBbbG7D8zTo9LUDHkPz0TDcU5iDQjhIAcG+yQjlR/PW5xtqhiGZY8QOV
         Sn/8df/R6k22wD8LzgAWp+XskS1B1ndLrx778H9G9uv959LtyXgBH0F0CKl57Q5OHClp
         mW/2q+e3K3pQm2H7TJSlykm1YD8lhTo0fW6Md1TQtP6nZnV1YGb7l7rE6EoznVVnhgyS
         Zrv/ExQCvc6Zjp6RR9GvcBEcRbl1y17+QaSWE04dU5K6a+j9O7WxQ+FCKJfAR1mgKFLS
         qPqQ==
X-Gm-Message-State: ACgBeo3bDZOToxvCrNLOwwHUjBgEk7WbmRFEbtgjzGrXpF+97iE4BTHP
        kskwCvwG52p0B0mb+NL3Kvo1Nc9fqdPx9D3t/oE=
X-Google-Smtp-Source: AA6agR7f+sXxmcjov0hOurO6Wf/3fGVJK8fTqTxyrHeEtiAsDmZ03vijwnstVm8jMX2GJnTEOzwEyA==
X-Received: by 2002:a17:907:7349:b0:730:61c8:d80d with SMTP id dq9-20020a170907734900b0073061c8d80dmr17060387ejc.699.1660077049545;
        Tue, 09 Aug 2022 13:30:49 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id kv21-20020a17090778d500b0072b33e91f96sm1485479ejc.190.2022.08.09.13.30.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 13:30:46 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id a11so6830031wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 13:30:45 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed0:b0:3a3:3ef3:c8d1 with SMTP id
 g16-20020a05600c4ed000b003a33ef3c8d1mr130608wmq.154.1660077044845; Tue, 09
 Aug 2022 13:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220808073232.8808-1-david@redhat.com> <CAHk-=wgsDOz5MfYYS9mE7PvFn4kLhTFdBwXvN6HCEsw1kvJnRQ@mail.gmail.com>
 <91e18a2f-c93d-00b8-7c1b-6d8493c3b2d5@redhat.com> <CAHk-=whg0ddey-LqFAPfZJDXHMjaHJNojAV3q17yvjc6W8QRvQ@mail.gmail.com>
 <c096cc82-60b4-9e75-06ad-156461292941@redhat.com>
In-Reply-To: <c096cc82-60b4-9e75-06ad-156461292941@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Aug 2022 13:30:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1q7ZSWhDWOyqmVawqjq55sUVkn8ASjE_b2VOcE1vFaA@mail.gmail.com>
Message-ID: <CAHk-=wh1q7ZSWhDWOyqmVawqjq55sUVkn8ASjE_b2VOcE1vFaA@mail.gmail.com>
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

On Tue, Aug 9, 2022 at 1:20 PM David Hildenbrand <david@redhat.com> wrote:
>
> IIUC VM_MAYSHARE is always set in a MAP_SHARED mapping, but for file
> mappings we only set VM_SHARED if the file allows for writes

Heh.

This is a horrific hack, and probably should go away.

Yeah, we have that

                        if (!(file->f_mode & FMODE_WRITE))
                                vm_flags &= ~(VM_MAYWRITE | VM_SHARED);


but I think that's _entirely_ historical.

Long long ago, in a galaxy far away, we didn't handle shared mmap()
very well. In fact, we used to not handle it at all.

But nntpd would use write() to update the spool file, adn them read it
through a shared mmap.

And since our mmap() *was* coherent with people doing write() system
calls, but didn't handle actual dirty shared mmap, what Linux used to
do was to just say "Oh, you want a read-only shared file mmap? I can
do that - I'll just downgrade it to a read-only _private_ mapping, and
it actually ends up with the same semantics".

And here we are, 30 years later, and it still does that, but it leaves
the VM_MAYSHARE flag so that /proc/<pid>/maps can show that it's a
shared mapping.

                 Linus
