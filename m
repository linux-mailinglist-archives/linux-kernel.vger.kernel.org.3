Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D24E58DFC2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345418AbiHITFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344647AbiHITEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:04:16 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6E313D5D
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:41:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b96so16332817edf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 11:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kVwCZBP8xiCx+3wLLImCHnMmFFTnJkwj0aGJ2jKqccw=;
        b=DHx27yMkHy1skZqXZ2CMAcU3H+mg0HNfe2zU+1flo3YTkK3PYdBupattYbASdmKGP4
         onlUm7uo5x58CUDTPSu0jSnI7jo4ZZMSdXxIK1xDJQ9zk0fM5KJrUtY9XVGV0r2ipCGE
         BmeEPBiTPHYD5cEp/375GgspyWLVT8sZcz/cI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kVwCZBP8xiCx+3wLLImCHnMmFFTnJkwj0aGJ2jKqccw=;
        b=sVAlqXiuu21/p465q6sQO0RUePCAXzDXwMs+D99qarB2OshS5PNwXrkjLbKqJ6uqA7
         Hk+1oN9JGW8UPf0SOkE327YYvCW9RrE2fd2PPHNIN7UF1GY8nRmkS6qicyjwuQ7e/6ay
         7TeASRfWc6j7RlUL5y1q6s/HRRvfuqviai/91CPslPOlWOdufSHj2/fYLhdPIeeWf1Bw
         f84+ZqizOur7IcEk3+vXn+WXqo+Rdf3lyJHQqJbBr7qc8MSHGumRg4y9ILWOHO75gc1K
         CgXEguUnRnyhIEcnS8bsVv5/vWNQpB8j0FzR9aTY6iixaA6xXHL5fd6G4z2nk/XLR8a2
         XjMQ==
X-Gm-Message-State: ACgBeo3FpHCZ50M4s57g4Q+JN7jt9iP/5kflVau2ik5AwMpjitHxgelk
        z8063mpwoqM0M/96iXRA5w36YJM+B3WhilefwIg=
X-Google-Smtp-Source: AA6agR6VLVHMKKCMntAbDhzCK4WlTIdJjuzweABBUPLT0U6GpTAs+vJBjGbLQQeWf0LOuKNaLsNSfg==
X-Received: by 2002:a05:6402:40c9:b0:43d:cc0d:e9de with SMTP id z9-20020a05640240c900b0043dcc0de9demr23135280edb.319.1660070467451;
        Tue, 09 Aug 2022 11:41:07 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id kv21-20020a17090778d500b0072b8fbc9be1sm1397499ejc.187.2022.08.09.11.41.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 11:41:07 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id bv3so15253006wrb.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 11:41:06 -0700 (PDT)
X-Received: by 2002:a5d:638b:0:b0:220:6e1a:8794 with SMTP id
 p11-20020a5d638b000000b002206e1a8794mr15353489wru.193.1660070466444; Tue, 09
 Aug 2022 11:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220808073232.8808-1-david@redhat.com>
In-Reply-To: <20220808073232.8808-1-david@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Aug 2022 11:40:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi81ujYGP0gmyy2kDke_ExL742Lo_hLepGjCa8mS81A7w@mail.gmail.com>
Message-ID: <CAHk-=wi81ujYGP0gmyy2kDke_ExL742Lo_hLepGjCa8mS81A7w@mail.gmail.com>
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

On Mon, Aug 8, 2022 at 12:32 AM David Hildenbrand <david@redhat.com> wrote:
>
> For example, a write() via /proc/self/mem to a uffd-wp-protected range has
> to fail instead of silently granting write access and bypassing the
> userspace fault handler. Note that FOLL_FORCE is not only used for debug
> access, but also triggered by applications without debug intentions, for
> example, when pinning pages via RDMA.

So this made me go "Whaa?"

I didn't even realize that the media drivers and rdma used FOLL_FORCE.

That's just completely bogus.

Why do they do that?

It seems to be completely bogus, and seems to have no actual valid
reason for it. Looking through the history, it goes back to the
original code submission in 2006, and doesn't have a mention of why.

I think the original reason was that the code didn't have pinning, so
it used "do a write" as a pin mechanism - even for reads.

IOW, I think the non-ptrace use of FOLL_FORCE should just be removed.

                 Linus
