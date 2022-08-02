Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107A95883B1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 23:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbiHBVh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 17:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237169AbiHBVhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:37:20 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5980C1011
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 14:37:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gb36so2611378ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 14:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OKtGK5sIPibPNqcR6q99LYNIzHJsqP/Ejs1dmn/8SIk=;
        b=Mj8eI2OCfNotqPrABVWGaqA7+gZkpOh5zRHQPIi+DjoSYb9SSYuXQK2xd4chptvWX3
         t6E23pXV6D+gR9KSHqWK2+FvPHdgpyiB99JD8ukiFVv39NoW69m6VimX0eXW4u2evro/
         YU8vGErs+6zLx6tSNwvqVQNe11QjdZ+DPujtBI5Ld6GM8GL0avsCGk9newQDeW7tCsm6
         vd5/NX3nbzrivN3peKk9fR3t+uuNw3FKPOASBFdeEgKbGGAPunXR6U/ZsJxje8sbQKPT
         QObgclWm2c8x8EU5aDnDB8R9fKMcSYVglUcjIv9MrWON425OEWHe3Tvellnd9x1+TIIr
         nycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OKtGK5sIPibPNqcR6q99LYNIzHJsqP/Ejs1dmn/8SIk=;
        b=dZYj5Xw/tDVen13JF2lEuLSsiNbClZpB6x1L/xg0OSxfFFowQ1N20nNa/hVmhymo2U
         /VZnl0hp/AUzXZ472a2nHf0fAU0a+23ghPthpTTCF/PMUEiMyWcPCK49b2O/rBgpJdev
         4mpI27d/qBFvkBJl8fcz6+7B+afM1dxbXM4KaCEiz7lzOT45n7Rxb2y27tqYHfO8Dbpx
         gJOnX86EU6CpLZpbNF1N9K0S4XRop7QOvoV+x2c8uHT0ruONk1CBzcZnZ5Uu0cr6jBME
         14aBQToThZ7/drPB+IGRiEg4BKAxTKrOKoKcVqPLZhnzaPDnNLaeV7GKcBIjWSYfw+3K
         KP+w==
X-Gm-Message-State: ACgBeo1FyYTwjdDe8OAde/b6BGjYqHQnaMLZ+ZK8n6+31WmkngkUGz1z
        p2Vsplaf7NyxPLhhI9sL54CY5abfspABBKWzPNodIPrKw7+O6g==
X-Google-Smtp-Source: AA6agR5OYcw/xET3GCFep7z8eRGZJMrBD9QCWerywjCpk+i4kdACYjgQfgkQgG8hBAobADAOe4YqLUeKcgH2COjgavA=
X-Received: by 2002:a17:907:3ea5:b0:730:8b95:dc69 with SMTP id
 hs37-20020a1709073ea500b007308b95dc69mr8449191ejc.34.1659476237901; Tue, 02
 Aug 2022 14:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <814dee5d3aadd38c3370eaaf438ba7eee9bf9d2b.1659399696.git-series.apopple@nvidia.com>
In-Reply-To: <814dee5d3aadd38c3370eaaf438ba7eee9bf9d2b.1659399696.git-series.apopple@nvidia.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 2 Aug 2022 17:36:41 -0400
Message-ID: <CA+CK2bCxuSs8aDre7B7cr=B1FpD+d1kJL_1uCU1qtNKErpUSSQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/gup.c: Simplify and fix check_and_migrate_movable_pages()
 return codes
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm <linux-mm@kvack.org>, jgg@nvidia.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 8:32 PM Alistair Popple <apopple@nvidia.com> wrote:
>
> When pinning pages with FOLL_LONGTERM check_and_migrate_movable_pages()
> is called to migrate pages out of zones which should not contain any
> longterm pinned pages.
>
> When migration succeeds all pages will have been unpinned so pinning
> needs to be retried. This is indicated by returning zero. When all pages
> are in the correct zone the number of pinned pages is returned.
>
> However migration can also fail, in which case pages are unpinned and
> -ENOMEM is returned. However if the failure was due to not being unable
> to isolate a page zero is returned. This leads to indefinite looping in
> __gup_longterm_locked().

Hi Alistair,

During prohibiting pinning movable zone development, there was a
discussion where we figured that isolation errors should be transient
[1]. What isolation errors are you seeing that lead to infinite loop?
Why do they happen?

Pasha

[1] https://lore.kernel.org/linux-mm/20201218104655.GW32193@dhcp22.suse.cz
