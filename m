Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6D94CD588
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbiCDNxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiCDNx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:53:27 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D9E41FB4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 05:52:38 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id g26so16936575ybj.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 05:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aW9lvZ4dtbSnb5vRxxWyeix7lFOlWIDTA4WPLsisdRU=;
        b=G4L/o3FtfwOM+5U7v/cMasla1R/gqvL/VZv0ArvW/oJWzkNill5citnJWlLID1Q8vN
         T9HHDfrjDB3xRwZhz3vm30xArsDCvnzMNGMTv8QBkCj+1u5oC7eCxe3wFAMEr4J79l4v
         59rLrohmpXqWbT5q8lqmJa4n2iksPBYV9dDXtKxDEEsAhc2j1xCWQ9hbkoABI1PocRai
         Tgkg0NNtcoOqToCqHMAzPCK1PDp/srNvjfaaKZK8pOWWXoXDrrHusjSOdMggXeSZ3+Sn
         gqCJVYU4jb12782LqmOHxjsmLwSCFViJ+WdVsTLAJ4oasOwoQs4QpHk+AqLtUn4Epv4L
         mGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aW9lvZ4dtbSnb5vRxxWyeix7lFOlWIDTA4WPLsisdRU=;
        b=khsVn9w5OX2MAe2ODc3SSrqBVBG4TDh+imE/6Dt1/fQBlxhPawxW6SHFOguxiqqfrO
         8SwVszSpcFHIKB5EgqNnQ4GliZ/mDMOrNah6kfFDUm41MnAYyoHUXYGZjqQIUJzkpCSR
         rAROVbA19f1czaA2hGkpH/FwrMXcwU6N//NpN1jK75Pgi7aG/9tGxCXG95RlNT9OpRc3
         liG8sS46OsLVQnpmIWK1PXHUhm5FVpQYr1l/K7crL67GlULz52Pb1Jf9jolBR6K+26yS
         9gllH6qo9krwlYieJt/+tR5FKvLlAuGXgF34lq2Gmt9REzqFstUtTtChLWiBu4m8Au0d
         VwPw==
X-Gm-Message-State: AOAM531aaEF6WnW08hAs+YSUEomG1nPCslLdPXa/dIe04qFIX4ZEKusy
        wqkXlwm3r+ygS/gbwk6DIfjhzWxLSD7GW+RcGze1/w==
X-Google-Smtp-Source: ABdhPJyLltATlo0f89Vp3BjE4yhlcJkg1/ykBk/5seu2FTYAdxWR+1yTqu866B+W9szNBtvq5h0HRSW+4ljB0mzafa0=
X-Received: by 2002:a25:e646:0:b0:628:9707:9872 with SMTP id
 d67-20020a25e646000000b0062897079872mr14462120ybh.6.1646401957883; Fri, 04
 Mar 2022 05:52:37 -0800 (PST)
MIME-Version: 1.0
References: <20220304093409.25829-1-linmiaohe@huawei.com> <20220304093409.25829-8-linmiaohe@huawei.com>
In-Reply-To: <20220304093409.25829-8-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 4 Mar 2022 21:51:50 +0800
Message-ID: <CAMZfGtUNincrMx3kK79sWHaSsPEu6YYTf3RfeR8pWy6Y_Y41tQ@mail.gmail.com>
Subject: Re: [PATCH 07/16] mm/migration: use helper macro min_t in do_pages_stat
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
> We could use helper macro min_t to help set the chunk_nr to simplify
> the code.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
