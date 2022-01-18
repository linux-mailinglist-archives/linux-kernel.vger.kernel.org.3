Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5BA492E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348591AbiARTER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348151AbiARTEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:04:14 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3823C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:04:12 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id i129so161343pfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ldKTp6E7VqjIz5n60IX5o6ZyBvDvKwMzZelWXwdNFeI=;
        b=N/nW52q4LecIp5YWIHrgbN0fbb/ldDzctJkkZl6ph1ZkurwfhgqZqx1xcdANF7PLRn
         zP10Hp1rnkr5wQC/gwyfRW0tB7aM9dNVQxhf/pxqGVA+GTBJ0OHrdGAyVEPwUAfTPzUF
         eTVLwrH4B66+L/tjheeSFolyav4/REBZg72ua8DJbpgwvG0yb06x+VjXpJKfIAtGhfy0
         tdY+BauAfjcjb+jR/FI0C1+wb6tRWpQ7gf4IMSJCX38h9twCne+Pi37nqx26CeqLKYyI
         M3M+Wvu+nojDG1kTc/4oYl49N+QcvKetm0akKONQINjQA72xTXzDhTVCC+xae2pqp2PD
         Yybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ldKTp6E7VqjIz5n60IX5o6ZyBvDvKwMzZelWXwdNFeI=;
        b=NPP66aCv9rpsGEonzZdZy5A5n3HDqQU2eQVESeBHQjehYIFVkugOrzQWhGkUHyLoJw
         WcYulBLInFDD1FLBS6/SI2k/aVs89wdOzD0wnb1nFeHDv3fWa6LW9mjHNPYR5xBzE0So
         uUJ7DORnWeL+8efFu7Kuk43QvrGCVXuDqIcEx2cRJULhUxbsGa1ADDtUQjF9V0bwn2Q4
         bBIzCktFAyQkiKUKKa6w+xixrwcMSHzUR5zwFhmohSOP+qQdqHfdLrHmbzunEyAMQXDg
         vdlLyMY0RsIsHMA5KGPjteH2Og3ECLSrKrnfGzLcQYM9glSh0fHlmfz0yrqIuIDu779K
         UWJw==
X-Gm-Message-State: AOAM532jiq78Aatloss222spI9wOLVvyzv78iF2F9QjfgJj96E/dg6IN
        bCaGXYcK+EOKkbTAqdvWwzdTDwciYbgJ8z8XEzs=
X-Google-Smtp-Source: ABdhPJzPCqeBtqW5igPrkRPR21PzuJBtjjHfsxQaR00EvYTpch8FyH9WexAGfKE3RNJqnnFdstLatcpr61qA8x3GYaQ=
X-Received: by 2002:a63:b34c:: with SMTP id x12mr24242780pgt.541.1642532652374;
 Tue, 18 Jan 2022 11:04:12 -0800 (PST)
MIME-Version: 1.0
References: <20220118185354.464517-1-yury.norov@gmail.com> <YecNTJNIfAd/D9GG@casper.infradead.org>
In-Reply-To: <YecNTJNIfAd/D9GG@casper.infradead.org>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 18 Jan 2022 11:04:00 -0800
Message-ID: <CAAH8bW-L+goex5Rn1MVpAjeDKqXF8MG3Ou4h65n7ugStHQEJbg@mail.gmail.com>
Subject: Re: [RFC PATCH] arm64: don't vmap() invalid page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 10:56 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Jan 18, 2022 at 10:53:54AM -0800, Yury Norov wrote:
> > vmap() takes struct page *pages as one of arguments, and user may provide
> > an invalid pointer, which would lead to DABT at address translation later.
> > Currently, kernel checks the pages against NULL. In my case, however, the
> > address was not NULL, and was big enough so that the hardware generated
> > Address Size Abort.
> >
> > Interestingly, this abort happens even if copy_from_kernel_nofault() is used,
> > which is quite inconvenient for debugging purposes.
> >
> > This patch adds an arch_vmap_page_valid() helper into vmap() path, so that
> > architectures may add arch-specific checks of the pointer passed into vmap.
> >
> > For arm64, if the page passed to vmap() corresponds to a physical address
> > greater than maximum possible value as described in TCR_EL1.IPS register, the
> > following table walk would generate Address Size Abort. Instead of creating
> > the invalid mapping, kernel will return ERANGE in such situation.
>
> This seems like a very elaborate way of spelling:
>
>         pfn_valid(page_to_pfn(page));
>
> which doesn't require any architecture hook.  No?

Looks like yes. I'll resend later today if there are no other
comments. Thank you
for the hint.
