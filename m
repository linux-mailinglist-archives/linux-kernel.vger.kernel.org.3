Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AB44C33E8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiBXRnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiBXRnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:43:16 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790532177F8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:42:45 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bg10so5963787ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s6RSUvrfQyVDu1K4DQ7l1PJWccys/B56pfoP2UXlTjM=;
        b=CMiJRr3TZReunnWs7oexaEgQRHI+PZN2gbfEQ7stEIebHxwsxa2vItFFPHfDG8XqfE
         4y29FK3bqoQAkbrH5qXUm+UtofHgO2s+n0WQ2uTHbmyI4nW03QAd25PsvnIBzyHNNleO
         hpu+HCU7qnlyXL5HWf1fvT86HG2hr4T+bGsSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6RSUvrfQyVDu1K4DQ7l1PJWccys/B56pfoP2UXlTjM=;
        b=YSE7Vug2pX2/f2mpk1XUzqH1YfW/mi4C5bEyKgJtsG0MTxCaxjDny6LF410VBSpjlI
         tlSQ2laDXQfQs+en511cIQ7jzktcKofmkjPrwGMAPJC4xaI9Iu4MPJ86uE4FXXTVXssb
         u09f5xcjEDaRGKZcOchX6Sz4HwS1sKwtR0/tFdh6ZABWcl9mdTgamWe7NODPpHi7Kw6u
         TUc8NaqNqlfwjbLp/7aNktyZOW69in/CUiKs5A7c0aqKrZjYtEHeuI3Ng6VRIpNaod/s
         /XmWrIoA0YpRz3XiHZXoy/FSEfnhgP12BBjaC2skuMcMutmw5yYZNKqkXC59u7bXt+St
         HZYg==
X-Gm-Message-State: AOAM5311Oq5iA+RgoHtQjv1uF6Kfh9Qq6uFATBhDSGoxB6cAc2kd87jC
        +iLwJnKM7azh02E47upd9YByuhF8mhzT3rf835Q=
X-Google-Smtp-Source: ABdhPJzDw2T+X9DS171ab1+lb5jbJDqerabo2n3zSnT429nVt0SgAj6kIn20CQDLcXsJYf+cp3eJxA==
X-Received: by 2002:a17:907:3347:b0:6ce:6bc4:d18a with SMTP id yr7-20020a170907334700b006ce6bc4d18amr3149231ejb.612.1645724563838;
        Thu, 24 Feb 2022 09:42:43 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id w20-20020a50f114000000b00405ef64c174sm55058edl.57.2022.02.24.09.42.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 09:42:43 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id s1so790824wrg.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:42:43 -0800 (PST)
X-Received: by 2002:a2e:aaa2:0:b0:244:bf42:3e6e with SMTP id
 bj34-20020a2eaaa2000000b00244bf423e6emr2668077ljb.176.1645724242833; Thu, 24
 Feb 2022 09:37:22 -0800 (PST)
MIME-Version: 1.0
References: <20220224122614.94921-1-david@redhat.com> <20220224122614.94921-7-david@redhat.com>
In-Reply-To: <20220224122614.94921-7-david@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Feb 2022 09:37:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=whV9vGhSniUj1hPgK66ejeqzHBiPGhFnHxM1hp9-w_wxQ@mail.gmail.com>
Message-ID: <CAHk-=whV9vGhSniUj1hPgK66ejeqzHBiPGhFnHxM1hp9-w_wxQ@mail.gmail.com>
Subject: Re: [PATCH RFC 06/13] mm/rmap: pass rmap flags to hugepage_add_anon_rmap()
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Linux-MM <linux-mm@kvack.org>
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

On Thu, Feb 24, 2022 at 4:30 AM David Hildenbrand <david@redhat.com> wrote:
>
> -                               hugepage_add_anon_rmap(new, vma, pvmw.address);
> +                               hugepage_add_anon_rmap(new, vma, pvmw.address, 0);

This now has the same "what does 0 mean?" issue.

(And grepping for RMAP_, I notice that we have a namespace clash, with
xfs and kvm also using "RMAP_xyz" for their own things. Oh wel, at
least they don't look like they'd ever mix).

            Linus
