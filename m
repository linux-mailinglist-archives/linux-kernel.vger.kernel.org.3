Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05B453799A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbiE3LOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbiE3LOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:14:48 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6002C79816
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:14:47 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id bo5so10325756pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HJSdgcuK4aBK7WvVZ3jjMmg2JsOtEFs5Q/G06ql/0YM=;
        b=KjSi+vqRex30uFWXic9sXcJStCRuKOrDdpmV8fPRTD1QuEPKBrBfWD1Y9cXiJmpMXR
         a8AXnEreUuie6RZoAqqUpzn6KchVxyQG/DmvLY+G1oCCC8ZScJ5YQ97Ymgeym/upa5dP
         tiUMQJYUeSr+hKMdYFtHeYSU7lX4B9LLlhdFd+M0Ate49CryU84da6+6SVKTqHRJ1whj
         uYCuQTiPy9uztRTlUBPm5q/yR5qhKRUvGwG0KA4EOe5Na4of/ilhUNuE7wpiNHiOim/V
         lwDRABFc/uoPRTSxdixI3pIJoZ+z5ZqtgF11/PxBGeneyDBnbqwpmBiCLHr/OT0B4zhq
         LJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HJSdgcuK4aBK7WvVZ3jjMmg2JsOtEFs5Q/G06ql/0YM=;
        b=yX/B4UQLhu6jbP3rJED1dBtE99VgJ5Xby7TNUcBcT6K6YIjqgyjC75FAIxcGvHRbNG
         sFvytbuAwf6AQ2pk3REJZ4HxAla0cqbqAZOm1eGUsk44g9fBMSQ4egWg53E5NF8AhakJ
         1MQQxh1eR3tNYDiQfvD0vFtUao2e6lrj4hzBRRbTWfEBgXKb+PjLxLmbHOvsOkA1okN4
         xhBoApt4tn7c6RiIHB0aRaU95I7Hq/LH6Dg5mktNegGe9WcYcwBTb/vmN4cmN2qj4abt
         yBBnALUYHOHvrHyg9P207B4FZiyDgObRoSU9f0EO3BkAz0WeFqSsFMuEefnzXW5B2wyI
         7BPg==
X-Gm-Message-State: AOAM533WZcWIDmEx/E/hQO4jnf/rwq+HNBlAczPZMCJw/+2DupVbzBO6
        oCgLWqW8OhZcOj1BfbS9sg8X0+hVyxdCCI0bqAM=
X-Google-Smtp-Source: ABdhPJzg7n+/guo7/sglTcTdVapzEO+2nA+dclteRDSAxvXl5LtF2FTYOGTxdKxoif5Tfq6h27oIEmLideo2F/qekmc=
X-Received: by 2002:a65:6a50:0:b0:3f6:4566:581d with SMTP id
 o16-20020a656a50000000b003f64566581dmr46245743pgu.122.1653909286904; Mon, 30
 May 2022 04:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220527211708.839033-1-matenajakub@gmail.com>
 <20220527211708.839033-3-matenajakub@gmail.com> <20220529164718.ed1eac7d614804c825fae9fd@linux-foundation.org>
In-Reply-To: <20220529164718.ed1eac7d614804c825fae9fd@linux-foundation.org>
From:   =?UTF-8?Q?Jakub_Mat=C4=9Bna?= <matenajakub@gmail.com>
Date:   Mon, 30 May 2022 13:15:03 +0200
Message-ID: <CABsDyaK87nC_bJ1OAc9LOsL53M7qrfkkoO-QzSwGhtt=Np0p2w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [PATCH 2/2] mm: add merging after mremap resize
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        mhocko@kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, Liam Howlett <liam.howlett@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, riel@surriel.com,
        rostedt@goodmis.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 1:47 AM Andrew Morton <akpm@linux-foundation.org> w=
rote:
>
> On Fri, 27 May 2022 23:17:08 +0200 Jakub Mat=C4=9Bna <matenajakub@gmail.c=
om> wrote:
>
> > When mremap call results in expansion, it might be possible to merge th=
e
> > VMA with the next VMA which might become adjacent. This patch adds
> > vma_merge call after the expansion is done to try and merge.
>
> Thanks.
>
> Would it make sense to add a test case for this in (I assume)
> tools/testing/selftests/vm/mremap_test.c?  Maybe parse /proc/self/maps
> and check that the merging occurred as expected?
>

It shouldn't be a problem and it makes sense. I will do it.

Jakub Mat=C4=9Bna
