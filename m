Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECFE53D4F9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 05:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350293AbiFDDB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 23:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiFDDBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 23:01:25 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD49227FCE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 20:01:24 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id e184so16777746ybf.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 20:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ewMgCGOsQ1FxmxdvCIZNwEIAt8nDNWHxM1ob+w0hhVs=;
        b=X/im8WVlax5+ol2CNNKIThbSUjdi+Vh3Pe4wnsHRp6FqgXQqkqAHmxeHE4USsFm5bo
         Oh/okEljdH9Buv+zXhNaElVDP7ZaLZre77qUze/UQyoSMeMS241Q62yhnmMwuB7vEEp8
         0Du/7RDOfoJG5cHQDbYLIfAdGdfqI1QBVUiawvrVSeOrCXVTbbG7p5Ab7ylHVDgfWAtj
         px7Z+CXBBwTZ/7Gr48hGtpYLvMnnMGTYkwXI6/hcsVDY4RJK00IQ7Vg7MoZFWCbMYuGi
         3TV68Sdj/k1ou6etrYtQl1+QCCIZWh0wWGVGAiGKjUFkyhPM+lIIlyTRkf3De8Fg3pVx
         B45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ewMgCGOsQ1FxmxdvCIZNwEIAt8nDNWHxM1ob+w0hhVs=;
        b=LV37CAZoSBxulSjTmTVhVFRcYGz2umJfd/n6u8LHB1R7otuNnZmxJKjl8So4UHuc8u
         94YSKH2k4BVWywoTNfIYOaWh32sp5fgVp5JkFxAcNkxtaO9KszEvDGnI9+Uu0MGxS0nO
         SV/Y4D1oUeSMhnWG3lGPFxllwRHloSo48NzybzmZlk37MiZaEMI8ibx6yZbEAEJ2Ibqu
         hrhYeBVLhcbU/vs28wA1LygK6roLWqbPQ/wHCh2qf6x8EcGImrHwHL3cDMLEWLDynhKN
         joH2QXdx6UzTb06+zIQGKy5qI2K+7Ej915YEz5P48XfqQ6c4SRO3U68ZZM9ZvnqP6Lb/
         eCjQ==
X-Gm-Message-State: AOAM532rvQDNxDzuBRhPg1GvM3agS0h0ujzhjtXKy36Z/DClQUQB9qV6
        KMn5o23zCfS+tDW0JCuwOJT3Wgf1JpPJlFz9Iyo=
X-Google-Smtp-Source: ABdhPJwcUFG66mxqZltFJCzIPadd+i0ZcbH9bRlYrjHajqkO7z1c3HPjm4MGxY2WP2kd0Rl6FNIxiXJatWytpcohhdc=
X-Received: by 2002:a5b:20b:0:b0:65c:a0cf:812b with SMTP id
 z11-20020a5b020b000000b0065ca0cf812bmr14027400ybl.48.1654311684032; Fri, 03
 Jun 2022 20:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220603035415.1243913-1-patrick.wang.shcn@gmail.com> <YpnqDlI0nRJA0gtg@arm.com>
In-Reply-To: <YpnqDlI0nRJA0gtg@arm.com>
From:   patrick wang <patrick.wang.shcn@gmail.com>
Date:   Sat, 4 Jun 2022 11:01:13 +0800
Message-ID: <CAGcnep9v=DEZ-ENa9UqrFnnD72Qd-UJyY0boCxFGJMaJe4nzqQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] mm: kmemleak: store objects allocated with
 physical address separately and check when scan
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, Yee Lee <yee.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 3, 2022 at 7:01 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Jun 03, 2022 at 11:54:11AM +0800, Patrick Wang wrote:
> > Patrick Wang (4):
> >   mm: kmemleak: add OBJECT_PHYS flag for objects allocated with physical
> >     address
> >   mm: kmemleak: add rbtree for objects allocated with physical address
> >   mm: kmemleak: handle address stored in object based on its type
> >   mm: kmemleak: kmemleak_*_phys() set address type and check PA when
> >     scan
>
> This looks fine at a very quick look but I'll do a in-depth review next
> week. One more thing needed is to remove the min_count argument to
> kmemleak_alloc_phys() and assume it's always 0. After this series we
> can't track them for leaking anyway.

Will do in the next version.

Thanks,
Patrick
