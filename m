Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB254CE238
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 03:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiCECZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 21:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiCECZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 21:25:19 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5FE219EA0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 18:24:30 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2d6d0cb5da4so110517597b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 18:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KaK+5lr9aY7CpYlBgNyNImsYowzjeltr1NfPXrT3b98=;
        b=7PN9fzdnBufyXzQWwLnjRIeqdwUtSVnJkYYxHxZPbPZaH9pK62brJRXw3moWiQiLb8
         AAIac5IuyU8zx5xi259n2dEZVsq5+4ktFWr8DF43aDndpmKgwzcFgqzLMPiHbE0CEVD6
         paW6fGl6iZkLNzTOG0GMwlAPI52v5IS5wPy4ONXU7Rbv5PWPlkLP8uE7df0r1t0U2oUP
         Ykx+b2H2f63683oeQw1sLFVO1V1UEff1wwfDvmXrO0Y4enBPOEN3qn6UOzhGjOqGeBA7
         r54gkaVpIKkAl6h2aj+aVlWg/bNQ8E3HAeecNSFbVY6YVZLOvQ25kr2kel2qT8slYBZG
         muNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KaK+5lr9aY7CpYlBgNyNImsYowzjeltr1NfPXrT3b98=;
        b=PIetB7Ez8/FF2aS0LyLoq9UqT5iOKz98/i7OZjx+UY9TU68BAbxFwsWVRRT6ERM/vF
         aYVXkBkGYBpriblKTC9qaI1rQ/aLB00GgbZcC1BHZSwG32D/1dFnC+b5/lrCAelT+M0k
         wiW4eDJZrNWyA9CuQg8uN5EjHlsqVXfkdS6HdQA5vfTSf7dgK7c0LRaSVNx/dmwcCqhp
         DP655BPShDKHiAauwQvxymmQWhdfdPCg05OS+UdD1TrTLn2B5OHYziOayHJZLTx2idLp
         LX2fZNf8q2APlxYl/9KbmIQ7NAZIwR4yohazd67ezJ4o5Zb3Q6EsJBu+x2FeBO0xC9tT
         hJ0w==
X-Gm-Message-State: AOAM533AMF9gob14sDrvWiKJSo79F5xo+OMkc1itZOIbZI+CHBw/gDtb
        pEOn1wujODehzVLKDgPpK71umZFHKh60rYRy2HU/kA==
X-Google-Smtp-Source: ABdhPJz19QFFrEH/T57gadMoGCEYBqeMptriXEVyGcVX8UohdnQftIBGzpm6ObUyfiJtMUaucss38XklGgW3v1BJSRU=
X-Received: by 2002:a0d:dfd4:0:b0:2dc:572e:10c2 with SMTP id
 i203-20020a0ddfd4000000b002dc572e10c2mr1245960ywe.319.1646447069558; Fri, 04
 Mar 2022 18:24:29 -0800 (PST)
MIME-Version: 1.0
References: <20220304093409.25829-1-linmiaohe@huawei.com> <20220304093409.25829-14-linmiaohe@huawei.com>
In-Reply-To: <20220304093409.25829-14-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 5 Mar 2022 10:23:17 +0800
Message-ID: <CAMZfGtVVoH+tkc7OrZAwWUKbxmj116xnTkyAod5kKj4jcWyoAA@mail.gmail.com>
Subject: Re: [PATCH 13/16] mm/migration: return errno when isolate_huge_page failed
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

On Fri, Mar 4, 2022 at 5:36 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> We should return errno (-EBUSY here) when failed to isolate the huge page
> rather than always return 1 which could confuse the user.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

IIUC, this should be a bug fix since the status reported to the user is
wrong.  A Fixes tag may be needed.  But anyway:

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
