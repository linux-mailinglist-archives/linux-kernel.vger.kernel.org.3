Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F044EE170
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239974AbiCaTMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239649AbiCaTMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:12:06 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10CFB7C6D
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:10:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h7so913375lfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sb1sT+u6ablw0kksF/Yt0iartvSesMxCgmS0SrVksdo=;
        b=gDKF+dLjcOnSjIMebIXzaYQ9ONdWOzkNZ/cID6yTOYxKaldboAWktm2qja3fELJ9PU
         TjHcNgP08lEeTDZHQ7OKr6SVVmRh7MwPo1wJ6Y8MYZsX1wdM9elp5+fGEkw54gzK277b
         NZ96HzwJhZsWSX5Se7NprNoZWquf3xWcqI/lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sb1sT+u6ablw0kksF/Yt0iartvSesMxCgmS0SrVksdo=;
        b=xiApi+LG4JBQSWVyJSBJcZm5be1R9O6A6T872xJGVhn1LzKWUvXufPiF/IX1CplBcw
         vOtYQgmkPwyeaIOf9yYMmPN1jB1xeHQRDYQo/ivYqdlDX2KPx2sF9CHGd90rnN59+5lH
         LWt8nytw5G5Dfi0tOid1QnXfUN+XpHvEbAGiGCd/av7s6Tft5r98s7NIf61a5qT6S5wc
         QfP1QRlY4gVlRM4ACH7bKE4BvpgNj77WspMSCH5Q4RPBP6BbvGpz/mYDMGfZFa0wF1XZ
         MIKYRjG3FPRPapuNdfs5GinGO/IsJTA/4GFdTqPOQoFZ1FPqmHQ091IDmONQKGymusgA
         wLqA==
X-Gm-Message-State: AOAM530vS7T2fs5hU5dvVHOBmoxWTU6AGRV9KH/TgJrM1ToH7iYXAN4r
        W0gDm82TD5CWjjDvea0a8SF3cZT1qG25OLzSpo0=
X-Google-Smtp-Source: ABdhPJxrNFmK9Ug63y+PHlyEbRFGbbigyl5F1M9ynIB4VnK2UA14AnUOtR1fdrCDQ63Lqw1nIsBK0w==
X-Received: by 2002:a05:6512:2245:b0:44a:9971:de44 with SMTP id i5-20020a056512224500b0044a9971de44mr11871220lfu.564.1648753815552;
        Thu, 31 Mar 2022 12:10:15 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id p2-20020a056512328200b0044a2d3f889fsm20846lfe.293.2022.03.31.12.10.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 12:10:14 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 17so1079858lji.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:10:14 -0700 (PDT)
X-Received: by 2002:a2e:a790:0:b0:249:906a:c6f1 with SMTP id
 c16-20020a2ea790000000b00249906ac6f1mr11347514ljf.164.1648753814138; Thu, 31
 Mar 2022 12:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <202203311127.503A3110@keescook> <CAHk-=wjQ0+9jBy6bm850h1jms1tja8xnon4X5v0LSO4biLhFGg@mail.gmail.com>
 <202203311157.F7FA779@keescook>
In-Reply-To: <202203311157.F7FA779@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Mar 2022 12:09:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPctCni+b7SDLtqnqW5qtiMnVqXQLZRA2iaQNStN7wXw@mail.gmail.com>
Message-ID: <CAHk-=whPctCni+b7SDLtqnqW5qtiMnVqXQLZRA2iaQNStN7wXw@mail.gmail.com>
Subject: Re: [GIT PULL] hardening fixes for v5.18-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zi Yan <ziy@nvidia.com>
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

On Thu, Mar 31, 2022 at 12:00 PM Kees Cook <keescook@chromium.org> wrote:
>
> I can do that, but it seemed like more work for folks: a larger diff to
> look at, and a rebase for Matthew or me. It's not MUCH more work, but
> given the timing of the merge window, I wanted to have a minimal diff.

Stuff that just does obvious code removal may _look_ big, but I
actually think it's conceptually a smaller patch than the subtle one
that just made the code impossible to enable.

Marking something broken implies that maybe we'll be able to fix it.

This seems to be more of a "let's just get rid of it".

               Linus
