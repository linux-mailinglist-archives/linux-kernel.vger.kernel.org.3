Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F8549A290
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 03:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2362853AbiAXXnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384553AbiAXXGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 18:06:07 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A6EC06E021
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 13:17:05 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id z19so15945804lfq.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 13:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WbkbP5nVlpDQIH9bUIpldZ6mTxuvHwEsP/vz+04zBU4=;
        b=Q6sI+Z6Z71Mx42IsUTyF6awNbPcATnJiPiYOKwXUz9swnUbSoS4xUkddTF/7VsV5fN
         BCcWCyeyGtLxVzsqBJtGngvZzNPI/LU9pT0pcFWu4+NuHGp/Z2dKT+PaZmQilgKSrRSO
         8cHnac0/7bDdh6bZoLXzc+j1fr1HDosy4o1D4TUkhcZ+Jf7koKKOmjn2YZZLcejBsaRi
         yXpfPwwub2lqZ522I4c6cxV4dhBthVYI3PA6MhsfknOWYTVucRT8uYeeKcLczVK3Ip4v
         9HYxoW9NNPYuWQHimdWPimjVuRD7pSM/jhw/CnP4Nr6988X1t70cXWGjSrYg0+s4DU1y
         mQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WbkbP5nVlpDQIH9bUIpldZ6mTxuvHwEsP/vz+04zBU4=;
        b=XBWQRasvqK10b1liJTBRl8t00883DOXSeUSkxfUWLMjsdQgfAnmO/fkdZJo/7rL00n
         khBQeZ9QqyJEopuqXzn9RnQcrHcdER/WPx9hKCCjF9aZz9hIzJhO5/izBdyvSOjVqEo3
         kMovNJzzrgrX220jSCRtlZg3vLG9qoTtKe4399p6Q7XvEU2tQdbUv8ItmzsdrDlIb2JQ
         EFffnJswxKC0zymYUhT0KqkkssEdDTbGumkz/CAWHh+ei2X+JP3+b19IwwPIY/uD+2un
         qvASfYVii5NhQFFQkNKmRLmjays5pY7yhc8UKfZX7mffjQMpktcrgBCM0+dPwiTD5iU0
         3YlA==
X-Gm-Message-State: AOAM530RCvYHlljYmomkRJ8EKZh3GroTbdqHVpOtLdtli+IaJNP9ue5S
        9kO8S1+muzklqvIW6mUQttHNv7EcPV+o16CFTMBbE9q7Y8gKNw==
X-Google-Smtp-Source: ABdhPJy9RK6Butf2E0AAENlu1WrXV+YKd8v47TmwV2fieI/5rJA7b/x6HcFea/Vvg3Lc9a4f0LpmH3BaOVSIS3ZzZFU=
X-Received: by 2002:a19:ad02:: with SMTP id t2mr14199612lfc.82.1643059023997;
 Mon, 24 Jan 2022 13:17:03 -0800 (PST)
MIME-Version: 1.0
References: <20210920180853.1825195-1-keescook@chromium.org>
 <20210920180853.1825195-2-keescook@chromium.org> <aa42ebfa-03b8-93fa-e036-a7507397d0dc@rasmusvillemoes.dk>
 <202201241237.C82267B66C@keescook>
In-Reply-To: <202201241237.C82267B66C@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Jan 2022 13:16:51 -0800
Message-ID: <CAKwvOdk+S=sTJWePADwrHFbVKKW1-WijzcS898GU2B0h57vt3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] overflow: Implement size_t saturating arithmetic helpers
To:     Kees Cook <keescook@chromium.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Len Baker <len.baker@gmx.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 1:13 PM Kees Cook <keescook@chromium.org> wrote:
>
> What I'd really like is a "store this in a size_t" check to catch dumb
> storage size problems (or related overflows). In other words:
>
> size_t big1 = 2147483647;
> size_t big2 = 2147483647;
>
> /* Doesn't overflow, but 4611686014132420609 becomes a 1 for int */
> int size = size_mul(big1, big2);
> ...
> ptr = kmalloc(size, GFP_KERNEL); /* Allocates a 1 instead... */

-Wshorten-64-to-32
?

-- 
Thanks,
~Nick Desaulniers
