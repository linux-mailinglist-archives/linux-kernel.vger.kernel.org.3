Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C014CD424
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiCDMWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiCDMWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:22:23 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE68A1AF8F6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 04:21:35 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2dbd97f9bfcso89131687b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 04:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Va7pm6YfkZeAbrpNqakjmUYEWCDrVBcf2Tch6HcV5QU=;
        b=a6tmluHUdF4MvXjWaVWyG8XU8E/xgviObiZjdI56I7Nf6V9/94iQLqae+1MK6cZo/v
         KAQhYhOOBzMhszXbPBM43MyDSegi+YnyM34ZNhGQ8Z+Ya+dMoSbmKW3eG6daKhg4ZOXr
         mdV26fYFNXHFOKaeypZPbdU+Hhc/oBaiSjolXfEgwlh9f9zp1Xe7KkIRxf0mkzbz2yaG
         mk3p/PDNBzhLKN0lgKMH626+fuftiP00EEKiDZsY9ohDKDW85JMV2HM+S/lJQJLQNFai
         /RHA9tByZfoGN3u66XVLwLz7/COxxo1BW0CzdwkuIni2fTsG0AqQX4hYr3bkVzDFIhjV
         8Iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Va7pm6YfkZeAbrpNqakjmUYEWCDrVBcf2Tch6HcV5QU=;
        b=5ImHwT+uhDP6mjj2MZv0vLmgYtpvmbzl0aexUz5SCBRlr80xfKImx68F2In7zi4i8w
         Rssirb8fIPvU2aGRKU2aLKqFpfAXub7pG8XsGES8KXOJ6NRCXf0u925OxHF3J/tKczKJ
         PIJfSz3PSxHrhAqvfAieDh0SErXXvJYZYPomnYDSBsjjztEH2iloHD1X8VaDwTcPAY7w
         r+LvXDwy1QvOsUHxKnpmK7MgdmmXcUnYmv90EM9PjIB7pGlPVKIT1Nj6yXVeJNwBek+Q
         /GJVBaaQ5MU7eMXeADTgDNQepZx3bAvDmiOBkiQwkwrZoZ14fYiF7k+D1RzeqoCVI7JW
         UMCw==
X-Gm-Message-State: AOAM532NT3Gwq5XST2/FTZw/4sDqUbKSIUUChaXrHhvXq1jZcQj5OJbp
        ASZKv2eEFLQC0sAqw1kc/vjcijMO+QY+98LCwg8adQ==
X-Google-Smtp-Source: ABdhPJyHvKka/8zMcjAtJ/XCTgTutSyz0KT1yEf538GK3/3f0c3A3QcjwBZA7xpOYJmjeYtm/U2YsACZaTS9No71OFI=
X-Received: by 2002:a81:6344:0:b0:2d5:e25c:3ceb with SMTP id
 x65-20020a816344000000b002d5e25c3cebmr39290031ywb.418.1646396495195; Fri, 04
 Mar 2022 04:21:35 -0800 (PST)
MIME-Version: 1.0
References: <20220304093409.25829-1-linmiaohe@huawei.com> <20220304093409.25829-6-linmiaohe@huawei.com>
In-Reply-To: <20220304093409.25829-6-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 4 Mar 2022 20:20:47 +0800
Message-ID: <CAMZfGtVrbciBcCzAnNu85Gu3SEuEZf0fCRWEi4C2uT==80M_tA@mail.gmail.com>
Subject: Re: [PATCH 05/16] mm/migration: fix the confusing PageTransHuge check
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        ave.hansen@linux.intel.com, o451686892@gmail.com,
        Mina Almasry <almasrymina@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Michal Hocko <mhocko@suse.com>,
        riel@redhat.com, Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 4, 2022 at 5:35 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> prep_transhuge_page should be called when PageTransHuge(page) is true.
> The newly allocated new_page is not yet PageTransHuge though it could
> pass the check as PageTransHuge only checks PageHead now.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

At least I agree with you.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
