Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E516B4DD618
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiCRI2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbiCRI2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:28:00 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79FB184620
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:26:40 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2e5827a76f4so83753617b3.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBzdXH14sNTPS2biTeLVHAwNzH4AqH+YPPgAMnqAjy0=;
        b=gfoHkNQokHiSsL2oyZtVNFLI08STGD0lbZbe6YWRufgZZMTC/O+wtNbAuCmIbc/QmB
         4DCWDvVb34zUpe28mt/yzyPAY6tGPL00CrkXdaeF0F7vSKOuvCxAm4XcqF/0+6qJ3pB+
         csA78xcZh55zs9blxkIUT3fmIehVjaoclX3tragC0NPhCh50XtBHmaVyO/+H/a6+JORd
         f84wp6I/1SoFQ7Qn34WYPJa7XeXwBaXuNempw9xqyRol4dht95wwNzdJWOeOljlWfd0F
         GsVaV9UntWm2N/9FYNjiFSm9ASDGaCGh8uTKmPU6eEAi0fpAAUaVmOg6wjiYIav60elj
         qEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBzdXH14sNTPS2biTeLVHAwNzH4AqH+YPPgAMnqAjy0=;
        b=KBqzKrVz7AX1t/EHd+IgBFxyUZTiaRNhXL+dX4X7zGhh+HupFxZaR3pYutKrioGd4J
         KCfC8Ovho9QPWod59H9kVbblLqKCXCmd0qmZjjfvYSvjzSWmQ28w8J1uAKNpLQdBQhXD
         GQlLDh5sh/kGGpLEm96zgiXeRcynotamaI1AdfzbHhbyAoDuzNVp6Lj9yd11OX09PclF
         fNOHqrWr3ntHDLZ1RbVTeWR6DYuwrt+gQl5zj5IW5GaGeR4ndoSDFJVO3WCgdlyKLyAz
         D13OMjE1xNkmGcvw4foRhxR6OOkrasXCbSjC+y0VZvLfMrfkb0CP+7HIjePVV9tluA4m
         mSew==
X-Gm-Message-State: AOAM5330wTnzllGMDKWKFYjK+mkVWZ/TQTIzlDhKYNb8MFpGl5Ks0s6Y
        4vtRQlMAWrG08ZzUlpJLymGD9YZoMMyMvHyAZ+SlOg==
X-Google-Smtp-Source: ABdhPJxvSDU15uyxATrFQe8YsZC7pCXOmIX++HPMNYnq1JUO+5+f89bnTizEEVAbwJihPB8SdjkVq7xvsNfpd1gzBZo=
X-Received: by 2002:a81:1c4f:0:b0:2e5:9db3:7a8e with SMTP id
 c76-20020a811c4f000000b002e59db37a8emr9412053ywc.319.1647591999889; Fri, 18
 Mar 2022 01:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220318111709.60311-1-linmiaohe@huawei.com> <20220318111709.60311-10-linmiaohe@huawei.com>
In-Reply-To: <20220318111709.60311-10-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 18 Mar 2022 16:24:48 +0800
Message-ID: <CAMZfGtXbU5EzVD8SH3S0vvTvzzHN7UE6qJ51KU9P5n_KC8JLJA@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] mm/migration: fix potential page refcounts leak
 in migrate_pages
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        baolin.wang@linux.alibaba.com, Huang Ying <ying.huang@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
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

On Thu, Mar 17, 2022 at 10:41 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> In -ENOMEM case, there might be some subpages of fail-to-migrate THPs
> left in thp_split_pages list. We should move them back to migration
> list so that they could be put back to the right list by the caller
> otherwise the page refcnt will be leaked here. Also adjust nr_failed
> and nr_thp_failed accordingly to make vm events account more accurate.
>
> Fixes: b5bade978e9b ("mm: migrate: fix the return value of migrate_pages()")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
