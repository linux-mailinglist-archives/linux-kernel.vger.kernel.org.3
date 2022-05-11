Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A2C522EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiEKJEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiEKJEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:04:15 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F7033EB7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:04:14 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id v65so1930891oig.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jK23TSWrd5T+xFmke6tHapRqyW15z312qhwW+MUc3c4=;
        b=gJlbBY6zHgkKcHFOdXBhecGt1utSUi1KDZrGwDY3NWUT34P1dlpZ1GaQRfUMCECNJj
         6R/r4jSTyBIeZtlUnoUIX4VE69yTnkp4ZoQPL/ZWjigYdoQPmGcAQgVV6jP4eMiJxuJ3
         3jiEwcAXlcjpQpTXWXwe8MmRi9jE8ppJBDxwGNf8fyRZCCtaWxcBu2pTthvQFDcz+dro
         ONt9zZefAe7QTS6FwUvJkBQ039YAnjOgxyijc5ARSbx/nC5r/pUH6gkBfYJ1iGhmXE34
         GHtl98uO08M96p11DDhfUf+0GhNNCV4C47x0sLvSJwXq6U28hsxrKvZxSkpURLwNREao
         tOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jK23TSWrd5T+xFmke6tHapRqyW15z312qhwW+MUc3c4=;
        b=1KAo5x4yJr7WFPqU5rVKjMmjVXZx1WedXmOu9wC15DX+HldW5WoiDLj9hl47gRvxcJ
         K95OsKcO4+E2x3wzyqagAewb8tQDoKZFeQ9wlvRG6LhuPAz75aLguVnsDKZFUW5RWbEU
         DhXYxdNf/SydZgXYMVWayZcBg7qRzBWIbLcpMJfmvqgccsFhEMvdRiau5f68cNfB8tbA
         Rw7rCIT5VCynXidhdZLQn8/ka1l3acF7EAWTEGcTuuwzlUOonQFHXE9N2a4PGJRhMv8U
         azUQ9rRV/QCWSoA747xfvOrT3QIsqYa4VurLhCTW9JhZ3BTkUIypO6+YVCpGAJp2ZVSc
         ALlg==
X-Gm-Message-State: AOAM531xcYtWS4jWA0YjoZEKgLi0l3w7ZO7ucJKxhEusHkglM3oVOhKs
        6qdR8ObWeqxxAWqG4CBvrBw6kVRhFNf6mV9jAFo=
X-Google-Smtp-Source: ABdhPJxcmTJCzsthDif6I4z95xvOxyGnSzmO/Pkxow3cx13GFRU7df5eZuvREDhLxrrcYiJFyGxoCehhlHrExMVwpqI=
X-Received: by 2002:a05:6808:1202:b0:2f9:c7b4:fd56 with SMTP id
 a2-20020a056808120200b002f9c7b4fd56mr1850684oil.55.1652259853760; Wed, 11 May
 2022 02:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220510080533.51032-1-yiyang13@huawei.com>
In-Reply-To: <20220510080533.51032-1-yiyang13@huawei.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 11 May 2022 02:04:02 -0700
Message-ID: <CAMo8BfJr1jSr-K8tOFb6Qkco1L1om2oP30rKt2X+RdCQgOWKSw@mail.gmail.com>
Subject: Re: [PATCH -next] xtensa/simdisk: fix error handling in proc_read_simdisk()
To:     Yi Yang <yiyang13@huawei.com>
Cc:     Chris Zankel <chris@zankel.net>, Al Viro <viro@zeniv.linux.org.uk>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yi,

On Tue, May 10, 2022 at 1:07 AM Yi Yang <yiyang13@huawei.com> wrote:
>
> The frist simple_read_from_buffer() will change ppos. if ppos >= 1.
> The second simple_read_from_buffer() will does not work and return 0.
>
> Fixes: a69755b18774 ("xtensa simdisk: switch to proc_create_data()")
> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> ---
>  arch/xtensa/platforms/iss/simdisk.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)

Thank you for the fix. I've rearranged the patch a bit, expanding the commit
message and fixing the build warning that it introduced and have posted v2.
If there's no objections to it I'll add it to my xtensa tree.

-- 
Thanks.
-- Max
