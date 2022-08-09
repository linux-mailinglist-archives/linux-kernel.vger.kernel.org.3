Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B328358E000
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245561AbiHITPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345739AbiHITPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:15:00 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AFC1CB1D
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 12:07:59 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gk3so23840816ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 12:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=vMeWdqqUKrZihbEodx8DwkpktZOsjqJwuhJAUzg6EtM=;
        b=fsrqe+6vo9uENLGFyCV6+pgoTqjKv1mEg1PRj6og2Ud/MBa8diFjRhLhNp/FTkemmU
         vUWMlyD0tpPtsXxRgtuml1g7Ab5JSwvzh4+5oeiGYZVt4iAWoilXnit41pgP1cvRktE8
         SjaI6/b5+Nxv18jobwJDWK6xFLulMWU2a18Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=vMeWdqqUKrZihbEodx8DwkpktZOsjqJwuhJAUzg6EtM=;
        b=o98ieh23+KODBG1jCjxMby+ol2NKXPqTYsAAu6sqximtshl5AWIAEOBhS23RdVp4G8
         bHmlSLoKiFT2dszKk8vBb5B15g1pTOtl6c/QsZTd+gmWuHQ6frcO4t5h725orJ2jDu2X
         UbAI2/sisqG61x1sQVpULHW1I201aU0yDUG32W6nmbSYFT+cIyWneCbJZV69xgt0aMn9
         PRgTZ0qa//o/DNTBo4zbDBC9/7gpoU3vH8cbgEhmBMcwGUicmbq41Ru++NEUzLlAXF7N
         j2RRGpujx73M66uOdqlLnCaR6IDuVaduJFxIuD+yfLtltwYHUAFQxz+zNoDX5/4AAcbJ
         HKnQ==
X-Gm-Message-State: ACgBeo303Kr82r38Lpy8mZcpWqr0YE62+fLoDU4Ip4X4YegzrO03BGf/
        D+iOj2ZTXCL4fFurSI0u/oDEi48xBx1cwO6Wzyk=
X-Google-Smtp-Source: AA6agR4cKiL+LW0HbLLj7Xe3TmVdKWyTD3FVzZamxa6CqUPmCIpwhdMZcpevLdFZpLOf4MXxRIfN6A==
X-Received: by 2002:a17:907:28d4:b0:730:9d69:6801 with SMTP id en20-20020a17090728d400b007309d696801mr17106853ejc.93.1660072077703;
        Tue, 09 Aug 2022 12:07:57 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id o9-20020a170906358900b007313a2575d2sm1421175ejb.104.2022.08.09.12.07.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 12:07:51 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id v5so6763871wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 12:07:47 -0700 (PDT)
X-Received: by 2002:a05:600c:1d94:b0:3a4:ffd9:bb4a with SMTP id
 p20-20020a05600c1d9400b003a4ffd9bb4amr16389223wms.8.1660072067208; Tue, 09
 Aug 2022 12:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220808073232.8808-1-david@redhat.com> <CAHk-=wi81ujYGP0gmyy2kDke_ExL742Lo_hLepGjCa8mS81A7w@mail.gmail.com>
 <YvKsBUuwLNlHwhnE@nvidia.com>
In-Reply-To: <YvKsBUuwLNlHwhnE@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Aug 2022 12:07:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjh3wkhQWN8BHFUT6t52kfNMcRd+1JczD4Sgp_q11w8eA@mail.gmail.com>
Message-ID: <CAHk-=wjh3wkhQWN8BHFUT6t52kfNMcRd+1JczD4Sgp_q11w8eA@mail.gmail.com>
Subject: Re: [PATCH v1] mm/gup: fix FOLL_FORCE COW security issue and remove FOLL_COW
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>
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

On Tue, Aug 9, 2022 at 11:48 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> It is because of all this madness with COW.

Yes, yes, but we have the proper long-term pinning now with
PG_anon_exclusive, and it actually gets the pinning right not just
over COW, but even over a fork - which that early write never did.

David, I thought all of that got properly merged? Is there something
still missing?

                     Linus
