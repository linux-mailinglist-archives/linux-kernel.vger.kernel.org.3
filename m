Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F028476DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbhLPJpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbhLPJpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:45:15 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0839EC06173F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 01:45:15 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id v138so63124700ybb.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 01:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A1MFole7nFko6XzmDNfgE5E+/1W8AedAM5ImSr4t3Mo=;
        b=nsmQ/apsKdQztyc0yc5tiUuptN+9XlsBEAr0qz+gI5SZ+IV3uSUUFj52fE9YbQVI8n
         SMbjtHrTJA6hukMVpoe9h0y6Rmfyrl+OHG/iOHic+VH5G02tOBfDdwGMpC7FfUrBGTu3
         8XpRGgzs7x86Dl8C0S2EHzI480i8bV0jQS8+RviV1BOSx6kp/P/aMy3Hx325lxQFnmHw
         X0cG1oWo6GktwZFd78AaZBgbbhnACTQenYXojWdQRhiJtzNFPn30D0eC0JI1ooH1p6wQ
         p1NWPJE7pjmTIGoCX0RY9/cuWQjZRO11Ex/D2pnSThLbuR6dO5PA2wjt+xORpiYjw6W8
         bveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A1MFole7nFko6XzmDNfgE5E+/1W8AedAM5ImSr4t3Mo=;
        b=amSvlnaG0jlJSrc4kBR0koYAeRvVky/mljQpuQ54MFD5/oY+iFN+5/PgOKnW8q49y0
         asjJ9lclGcUfuXNlc+mGnNgok+E1nND7oEwekojYslRTcvONH/IPIR3uihF3Iv39i4+G
         xA1iXG8/kvAnYV0ev83qYTBtZXTL+b30iQ8CTUEl+z1viedBR1T5sY+ZnB56h+giw2pI
         vEotuS1BnXNnVRIb9eKrm+GMQ6hP5Ak4KdjAH00H2GWMn5yvd9o63H1p6mEksR65C/R3
         3JPItfrBZG/iaCS+Ocnw6PN4CwMVMVi0bC60nx7U2QbXVAZuLsCSmnMxGOybBVB6MVEW
         x8Bg==
X-Gm-Message-State: AOAM531mX4COYNXenppNRPljXQKomJaKuppVie8Fyk5qhdN5LYx3CWOu
        mxChgR041yPHwN789Y5xJj+dvLTqS9o8ulo9it47bA==
X-Google-Smtp-Source: ABdhPJytpY6IKx476YQCSWtivg98+adXT5ZH0jbr+l9j/D8Pt8zWvBRmB8J/jyRv6XgbIY/CqxeyMFRbwZaiwwEiQw8=
X-Received: by 2002:a25:9c81:: with SMTP id y1mr12149005ybo.49.1639647914325;
 Thu, 16 Dec 2021 01:45:14 -0800 (PST)
MIME-Version: 1.0
References: <20211216022024.127375-1-wangweiyang2@huawei.com>
In-Reply-To: <20211216022024.127375-1-wangweiyang2@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 16 Dec 2021 17:44:38 +0800
Message-ID: <CAMZfGtUBSqgnHM+DSG7na=7tbNMyj_qS8pEOCn9nDdkPEzi-4g@mail.gmail.com>
Subject: Re: [PATCH -next] mm/memcg: Use struct_size() helper in kzalloc()
To:     Wang Weiyang <wangweiyang2@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 10:21 AM Wang Weiyang <wangweiyang2@huawei.com> wrote:
>
> Make use of the struct_size() helper instead of an open-coded version, in
> order to avoid any potential type mistakes or integer overflows that, in
> the worst scenario, could lead to heap overflows.
>
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
