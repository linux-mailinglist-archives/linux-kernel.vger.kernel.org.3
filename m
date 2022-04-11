Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1344FBFC1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347598AbiDKPDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347522AbiDKPDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:03:40 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED4A22299
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:01:25 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bv19so8463445ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8vzSRBeXvKjyTeUPc4QPwovFMBjJth2YNwp4fztDyrw=;
        b=ngskO0MeMTz8MP1V/LdrseX0mPwNADHPy7XdJdepngtWWQ9BDbSXrbDnn4/5q3QY3q
         oYIw526pTTgrNZVMJ6ESjuLl5dt5pE5Cj/8PLDqQSTxy0+oeX2dzi9d8Sz2Hd/QiLyZp
         6MPr0fCA3HmD9YvNqOgoiETAPLCBkEWsqK7XwZ4a5AsRPviWcrhT0BD6Aj4CHoewrKZ8
         4ElbnMLp5TzYXSlvsj/xhgkoqOBDC9FMmKKG7arIFgjSwitJDjHEfMYKqku1osk7vFsc
         QIOs+pu4KAUCi7+duR/U23VNKYszxWSPvoJ4PFUDh1f5UueUvDxYiFS6NBBsRGmvZfFu
         PRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8vzSRBeXvKjyTeUPc4QPwovFMBjJth2YNwp4fztDyrw=;
        b=cx6furN4w65Thyn8SYrEmaREcIblF4IOSvNx8chAYbBSEF7u87S+ss94jFZcLi0bEn
         VQOhY06Bem5VJui3a2V6t3RW2EJnEqeKzWteYmyMF+qXlbJXzzPIX1LbXaNpv9eFW1b0
         /krRvDnawVq7jNhKaDgMa3sZ18mTHiuN2+OEOPp/FhhI4F3pruyCCR2DvHD5iY+GHdrc
         weGNv/7OxY1vWsOzn1hZO7LM5YI5QaEkiFMkIoxwGmJ4bjAeaBXFj8IOEpcrrjdDekqL
         cMraezK7gZ28T+HPmfcYWTftARjnRaObyLhVClQumMHcj89mKKnSTADd7OH4IlEOCaSB
         j0YQ==
X-Gm-Message-State: AOAM530qN00lOernjuY4rrtlp1lgK5n2tXfJQjU4CKTFxwakwLNxzg2Y
        ThuJyOQRPDIAE0bYZuPi7Gvm8lv0mP+C9QOIBwc=
X-Google-Smtp-Source: ABdhPJwa3H8FRInC0BMJQHSPtoBeu3c19lyO5abPmk8AQ4K2YdqBJB5Fy3XZURkZWKBfKHFCxKl222DKj5IMQoaKB2o=
X-Received: by 2002:a17:907:a411:b0:6e1:2084:99d2 with SMTP id
 sg17-20020a170907a41100b006e1208499d2mr13335085ejc.639.1649689282042; Mon, 11
 Apr 2022 08:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220405135758.774016-1-catalin.marinas@arm.com> <20220405135758.774016-3-catalin.marinas@arm.com>
In-Reply-To: <20220405135758.774016-3-catalin.marinas@arm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Apr 2022 17:57:08 +0300
Message-ID: <CAHp75Ve85_gDMUN91ZOhRLO3TkxmdO1crAcYjb1TGDCBmWbmFQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] drivers/base: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 2:30 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
> operations while ARCH_KMALLOC_MINALIGN is the minimum kmalloc() objects
> alignment.

...

> -        * Thus we use ARCH_KMALLOC_MINALIGN here and get exactly the same
> +        * Thus we use ARCH_DMA_MINALIGN here and get at least the same
>          * buffer alignment as if it was allocated by plain kmalloc().

But then it becomes not true either, because the kmalloc() has other
alignment constraints.

-- 
With Best Regards,
Andy Shevchenko
