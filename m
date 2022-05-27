Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63610535819
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 05:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbiE0DnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 23:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiE0DnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 23:43:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D21A196
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 20:43:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h11so3934982eda.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 20:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SPBb+g0viJg5NqTEyDBHqBkftk1kmk7JjYgXXaPHViY=;
        b=QU3l08rm3NqbUG4rASTLaS9tNuaMKT998BWPJJS6SNMsHt6Nj82cqHJ09FZe56QEYz
         ItovWKnHQvkgOX0S9uKQ5o+SRbcNcwsRrja5IRwjub0+ItN6yzbgpTUB4iWoPPAH/viN
         iWBtDpLr0KpZjXTH6wz7YJOUUEkerlOMA+sxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SPBb+g0viJg5NqTEyDBHqBkftk1kmk7JjYgXXaPHViY=;
        b=lp6s8YHsk7Fh4mJ6GOJYyaNpXsIX7N4ArPUOKjdwkdm/kVnxtEdSidnGknE2MKHKkk
         G0/6ltC0goD0QQ8sPUflPxMY2IN5nT9SYUVmHONE4Xwf0lqVl4p7x0Mu8Yqy7BHhj+pO
         FuHcc2dTrd14AbHrFeHedi2eIR12CbciPlPci/p1v9Tdv1O64pHOpWLgSNY3mKRUNIJL
         2KZMVMdJp70aY6CcI7gnSWJxda2hI9JiP4gk7JAoNxkBOjkqhM1TW6/JyEQ9sV1mZU9H
         KgG9i0mbHdhiSvsY1G8u9wHf+uJWlGfC6MCcXH02JT2ygX8/1cEQ2SUiKgFh/0cgOwCS
         6ZBg==
X-Gm-Message-State: AOAM5331x56USMPPM8sU5OpZ/yHBkKH6kxOQ5rOBlOTlzhsHJ49KPHaD
        MfrrZwqXKrX1w5q7xJp0R+SduckivS0wLtW0Tt4=
X-Google-Smtp-Source: ABdhPJynvn8cu457o8cEZNw32ObUEZVbWzD4ICYRWFzVW+pXo/sd8JnYKoSa1n67HwkRoa/urljFew==
X-Received: by 2002:a05:6402:3686:b0:42b:764:60c6 with SMTP id ej6-20020a056402368600b0042b076460c6mr39563401edb.384.1653622992267;
        Thu, 26 May 2022 20:43:12 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906641500b006febce7081esm1055763ejm.177.2022.05.26.20.43.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 20:43:11 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id t6so4281457wra.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 20:43:11 -0700 (PDT)
X-Received: by 2002:a5d:6152:0:b0:210:1864:2fbc with SMTP id
 y18-20020a5d6152000000b0021018642fbcmr753156wrt.97.1653622990694; Thu, 26 May
 2022 20:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtDBZaBGkEp5tRMM5C1xHEKeyyNK1S4WoKvrOoFxGm4KQ@mail.gmail.com>
 <ac245d62-2295-8cf6-6808-4a6eb6bdbd21@linux.alibaba.com>
In-Reply-To: <ac245d62-2295-8cf6-6808-4a6eb6bdbd21@linux.alibaba.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 May 2022 20:42:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgGW_jsjZxKLcKCf4Di22vzJU6K56j0Oe8Td6RgKrc+A@mail.gmail.com>
Message-ID: <CAHk-=wjgGW_jsjZxKLcKCf4Di22vzJU6K56j0Oe8Td6RgKrc+A@mail.gmail.com>
Subject: Re: mm: change huge_ptep_clear_flush() to return the original pte
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
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

On Thu, May 26, 2022 at 8:36 PM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> That is caused by commit:
>
> 00df1f1a133b ("mm: change huge_ptep_clear_flush() to return the original
> pte")
>
> interacting with commit:
>
> fb396bb459c1 ("arm64/hugetlb: Drop TLB flush from get_clear_flush()")
>
> And Catalin has fixed the conflict with below changes [1], not sure why
> it is not merged.

Argh. Nobody informed me (or if they did, I clearly missed it).

> Linus, should I send a proper patch to fix this conflict for you?

Yeah, somebody please send me a proper tested fix-up patch with commit
message etc.

Thanks,

              Linus
