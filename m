Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369364DD4F5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbiCRHCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 03:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiCRHCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:02:51 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3595725CBB9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 00:01:33 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id f38so14344907ybi.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 00:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9b/KRxUeKJdr9tBjx3GZecOKR9c6gmbiKalwI9udBpo=;
        b=0BZnH5Vm/s0PNxUpyB9nyOVytbFTh0wVLkEgEkhIW6R1QA5OSApfh7dtnd1Pnc0I1b
         VUyn/7uuT6QrHv7qoCRkluAM8/SQXmSM5+CWwKPEKapkaYJZLNaLtfO6d9S12MN1o6Nz
         JfYZ/Aga+bNgb5aOseYnbo5yDjPljX21nfgV/dhaByhGCBWBEebvvtQHliNJfl/p+wqp
         AItD4tO9BGdk9anftCzypvwdPEN+rCgIURH1C3O09KNZlUfISSo5R6re80PB7dLkO0BN
         +0KDblWDOJQ5vVuyXFXoAvUcEL+JiOnYodk7GflTHYoCOphXRDe9FhZ2J8SRuZGbRnB0
         6Spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9b/KRxUeKJdr9tBjx3GZecOKR9c6gmbiKalwI9udBpo=;
        b=IgmlHu7lCDEWnDPftg6NDM5lVM3XBJqA7kSzToX4N1oqazk1IuV/64wttvGIbGhGGC
         AKCMAIvQa7zE3l1co3E+DcYLZGGpx2sklprY81VcRPuNqSJR8gN4iXpdthf4BbODoawp
         ACz9k3UwIQbLR+UJ0/A7wgmPJDhTKmILQtkieysGCacESv8fWRa8ud61hH7p+WpKzAqK
         G6lnzebCiusZvwvZGurcRhk2SgVXrF89QgTYJW9zsi4zZ5O/fCEDU49fmdpHgY+KGY1f
         +cXTH4ZcvIXThNMomkGKqh3k1IaVhOxxlhOgpEmKDJHIymLZIMDwFZtfdhX7tjiYKaOI
         JBHg==
X-Gm-Message-State: AOAM531XXNIrt903wlOHZbRFiUoUuPDgltZ76ptDp1qCHhhoi999ckMi
        xA6jRCztN0kTUitiktN9IrhbVlAIUemz7hUEpv5X9CKqm3HYmg==
X-Google-Smtp-Source: ABdhPJyYrJucUrmQnQmivCoL7ZugzrqxGtEdlqBdsSZTelK6fp5J/Id+NNl9YWbl6/SPST4imOvlbZVfoGdFz4y1snk=
X-Received: by 2002:a25:3d47:0:b0:624:7b42:9f0f with SMTP id
 k68-20020a253d47000000b006247b429f0fmr8984898yba.254.1647586892489; Fri, 18
 Mar 2022 00:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220318111709.60311-1-linmiaohe@huawei.com> <20220318111709.60311-12-linmiaohe@huawei.com>
In-Reply-To: <20220318111709.60311-12-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 18 Mar 2022 14:59:40 +0800
Message-ID: <CAMZfGtWQO3RAX+86O8=_gbiaWfNvxztfMY4S6zBsaVFDEFJPFQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] mm/migration: fix possible do_pages_stat_array
 racing with memory offline
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

On Thu, Mar 17, 2022 at 10:42 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> When follow_page peeks a page, the page could be migrated and then be
> offlined while it's still being used by the do_pages_stat_array().
> Use FOLL_GET to hold the page refcnt to fix this potential race.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
