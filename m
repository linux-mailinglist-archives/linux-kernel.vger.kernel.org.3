Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFAD58E0F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345290AbiHIUV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345844AbiHIUU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:20:58 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1224193F2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:20:54 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s11so16490256edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DGKHHAUwuZfCazjxcNKKHUT7rJIi8ll9zTOb4y7hCUc=;
        b=WEfpeEZLySvke8oWrURAvNB0cuhg5p2fhHNFSr8Ptu4Bkc8DH9B5yKXXkiA0f8ZSUv
         Wk+tTMhRbTpst7yfa9aNELS/+G+R2Y1Y3t1e8NW7tW/W29tb/gDh8ah0vHJT8w/US+Z4
         v7PoDdCm6NLn1YJYubR0e9eymGioz29VRHsSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DGKHHAUwuZfCazjxcNKKHUT7rJIi8ll9zTOb4y7hCUc=;
        b=pFUxNF6KHCoIp5X7CAYhn9P+hNqKvUN/IYyFR5ytZTLi4ybhBqv5nX/bo+rJhDDqyM
         pOCIMlAdZ1KvzZPXTaxY8fXfUZ4piA2HYQrGo1QEtUrYc9sNZIM3k7LkE63uEHW8GzIi
         4rEJVB/PS/NBg135tD+W7At1RWjJZHYaaVvHpBJr4XFzLSrcCD2AUx5UXnk8M1tM+w1k
         T49/A6k7Kj8dfy8zMZyu5g19+fA8X9NtQMG06pnLLPA4fX0lGDVVegWr69rRcs0lJiQY
         FoSu2tNpYMCmdCZOYSzPCAgxT3g0XMBP/59lzXaU1WuH+Eoh7uUwPKUFwnEPu1DUl2xQ
         A8uw==
X-Gm-Message-State: ACgBeo1N+c+qDaLVUnkUGeoQ/l0KK6DbWFsR1drzakPNKEFzEa8hNn7h
        isOPbTVWZUL/cag2QCq6qonlf/xxfdXAh2GZ+0E=
X-Google-Smtp-Source: AA6agR5Y6wVYgHL588850zPI8L7NdpCC6nJ0vVEZ7PCr/AW5aUbpx6RX7OE2et7HIIWxDGQdtwT1PA==
X-Received: by 2002:a05:6402:1703:b0:43c:c03a:db3d with SMTP id y3-20020a056402170300b0043cc03adb3dmr23288404edu.384.1660076453110;
        Tue, 09 Aug 2022 13:20:53 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id hx22-20020a170906847600b0070efa110afcsm1491885ejc.83.2022.08.09.13.20.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 13:20:52 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id z12so15510885wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 13:20:52 -0700 (PDT)
X-Received: by 2002:a5d:6248:0:b0:222:cd3b:94c8 with SMTP id
 m8-20020a5d6248000000b00222cd3b94c8mr7137394wrv.97.1660076452117; Tue, 09 Aug
 2022 13:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220808073232.8808-1-david@redhat.com> <CAHk-=wgsDOz5MfYYS9mE7PvFn4kLhTFdBwXvN6HCEsw1kvJnRQ@mail.gmail.com>
 <91e18a2f-c93d-00b8-7c1b-6d8493c3b2d5@redhat.com> <CAHk-=whg0ddey-LqFAPfZJDXHMjaHJNojAV3q17yvjc6W8QRvQ@mail.gmail.com>
In-Reply-To: <CAHk-=whg0ddey-LqFAPfZJDXHMjaHJNojAV3q17yvjc6W8QRvQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Aug 2022 13:20:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgYAy5ho0Wqx+eri_+a5apYU1Th826UScE7rZRiyhPcGA@mail.gmail.com>
Message-ID: <CAHk-=wgYAy5ho0Wqx+eri_+a5apYU1Th826UScE7rZRiyhPcGA@mail.gmail.com>
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

On Tue, Aug 9, 2022 at 1:14 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But as there are two bits, I'm sure somebody ends up touching one and
> not the other.

Ugh. The nommu code certainly does odd things here. That just looks wrong.

And the hugetlb code does something horrible too, but never *sets* it,
so it looks like some odd subset of VM_SHARED.

                 Linus
