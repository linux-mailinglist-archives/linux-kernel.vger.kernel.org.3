Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2125358E604
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 06:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiHJEHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 00:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiHJEHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 00:07:10 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19942715C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 21:06:50 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id q15so14016718vsr.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 21:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=AKJTj1uSxKC85ZXfRsar8hsdgHcA0CafqUxx+fbP6cg=;
        b=Mc+959cQTtJPdEsFz++sc/bmogjrLy3bGoku3IYVZ1zSjczqAk+SrxenHfba70IpFb
         wRJgK8DTbMSTJI512xvlMdYSGUcbjGCcDzXg8+e2oM0NDoDT7B3lyTcgFmIdIJHrJqoQ
         pxR1yoZYFCZD791gDJ2hrfqEa0hHFkmiPw/6j2nznWWXdiTvC1TXvKv6NzQeiOzWt5Hk
         1nEmlZT6odTfgEncyWyTwJfiug0KyhUgfZJLe10wHvEUpI8R6pG+3KXusmkF144aL90H
         HZqxk7hrJBxQ2EckbyLV9cbxWoBcKMt1bafZuV+aJ20iKP/iX+4wnDgUodFglLShwXZE
         TW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=AKJTj1uSxKC85ZXfRsar8hsdgHcA0CafqUxx+fbP6cg=;
        b=45OcjT35+GPOBQCvt0+jxAsPUpFcowJt1R5eEHwsbN33WyaS867pzhqHCvlvMR9QRT
         85mlhv3oo8yyz0dAn/pBBH35k3wc+CgyneLi/gLSWh4SApw6GdgbvCz5mkHlrA/3YofG
         KsaluWPZsiNUowO81dm4WZGUDdHvpctzW2dXIArIoxBlUE0ovLOUfsna+VVfPOqFrzTz
         Kuyfqi0nMpFEu9pNm7ZmzSHjlU1NRXeegfwE5kSpit9vyGXKlvz3pxtugB7hGNM1A1G8
         1ZMC+D7T2WeM3ct/98Q3ImOW7iqaGrAJI/siWz3bOAMnt6HMVJZa3V9HkCcqVC1l2Mmc
         5orw==
X-Gm-Message-State: ACgBeo3pee/YL6jrN8gv+F9qk1gDJUrNjdY3l8ruMT8QWVxbK3Q5Ftgh
        QIeOQ4rVz9ZcBByaaV4/jFP4K2pOmDB2NRIlhvkeNA==
X-Google-Smtp-Source: AA6agR7LA9nPXBbaSoWRee7gz81BJsA6SpYsFZ5mELdEh+CKPo3tAVoI1tOfvpTHkhW18+MVGCotbiT/TbLwptINfCs=
X-Received: by 2002:a67:c885:0:b0:38a:7a34:cbca with SMTP id
 v5-20020a67c885000000b0038a7a34cbcamr1552877vsk.22.1660104409795; Tue, 09 Aug
 2022 21:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660068429.git.sander@svanheule.net> <01cf5f4ee3a2d2ef56b19a91056496fd4d648cb1.1660068429.git.sander@svanheule.net>
In-Reply-To: <01cf5f4ee3a2d2ef56b19a91056496fd4d648cb1.1660068429.git.sander@svanheule.net>
From:   David Gow <davidgow@google.com>
Date:   Wed, 10 Aug 2022 12:06:38 +0800
Message-ID: <CABVgOSmHvG0JsHd0iZPVHM-OXVivmp06jjeGMB_OEuoUWa+aAg@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] lib/test_cpumask: fix cpu_possible_mask last test
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 2:09 AM Sander Vanheule <sander@svanheule.net> wrot=
e:
>
> Since cpumask_first() on the cpu_possible_mask must return at most
> nr_cpu_ids - 1 for a valid result, cpumask_last() cannot return anything
> larger than this value.  As test_cpumask_weight() also verifies that the
> total weight of cpu_possible_mask must equal nr_cpu_ids, the last bit
> set in this mask must be at nr_cpu_ids - 1.
>
> Fixes: c41e8866c28c ("lib/test: introduce cpumask KUnit test suite")
> Link: https://lore.kernel.org/lkml/346cb279-8e75-24b0-7d12-9803f2b41c73@r=
iseup.net/
> Reported-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> Cc: David Gow <davidgow@google.com>
> ---

Much better, thanks.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/test_cpumask.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/test_cpumask.c b/lib/test_cpumask.c
> index 4ebf9f5805f3..4d353614d853 100644
> --- a/lib/test_cpumask.c
> +++ b/lib/test_cpumask.c
> @@ -73,7 +73,7 @@ static void test_cpumask_first(struct kunit *test)
>  static void test_cpumask_last(struct kunit *test)
>  {
>         KUNIT_EXPECT_LE(test, nr_cpumask_bits, cpumask_last(&mask_empty))=
;
> -       KUNIT_EXPECT_EQ(test, nr_cpumask_bits - 1, cpumask_last(cpu_possi=
ble_mask));
> +       KUNIT_EXPECT_EQ(test, nr_cpu_ids - 1, cpumask_last(cpu_possible_m=
ask));
>  }
>
>  static void test_cpumask_next(struct kunit *test)
> --
> 2.37.1
>
