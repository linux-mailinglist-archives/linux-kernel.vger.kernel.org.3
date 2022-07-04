Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57071565C29
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbiGDQcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbiGDQcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:32:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D128463FF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656952330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CcX13tRiQ1CUkpKPTfZy53toNrkteRnr+JO8IbyM0ig=;
        b=QGdxRuzj5zv0C+02YH52LS+2PYOB72TMK9Mj3Ub1ZIKdobJPHyOEpEUvPbf1WpWKmIthTW
        6ylt/ABocnPaVVnzMtGoRd6892odwEiJtWrlSOU8yxEwntkwyrj0yARN7ZDsgQDU5MsbZ2
        S+u11KzAyFOx4S3MZbQ35+CDy5gzNIM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-70PY9Rl5OVall7ZKqGZN4Q-1; Mon, 04 Jul 2022 12:32:09 -0400
X-MC-Unique: 70PY9Rl5OVall7ZKqGZN4Q-1
Received: by mail-wm1-f69.google.com with SMTP id z11-20020a05600c0a0b00b003a043991610so5567933wmp.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 09:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=CcX13tRiQ1CUkpKPTfZy53toNrkteRnr+JO8IbyM0ig=;
        b=ApwK4ATWg62SGZ/PRv8oE2x8VwEHZCxpTrSMPGfEuS2ITCDe9g/wN71xDkQjExtiSW
         QsQDckV3uQsFSgnNu6PmY7pIfOBcCp9mTvMny0cFgRIuUA28lN0Q9BvRkLWTO9vHBUB1
         GMI8hUz1bh/aGJjEFYEluIx7R8W1q3Hk+jqlrDVkQzYiAD6hygUOOKcEi4oiyJg4TJZv
         /6ITlrwJi+pOUi/2QMNNOmYGiG8pLjtJjCPbwGtKWIQxjdAAXXdqVqcoIEXpaEDkUeJ8
         QJwtuF9me1m62MDjFpEshiT7oW8NPK3m4XTKHkC/5HfjmWPAMBiJgQTwfzj2+TTXITyY
         U0tA==
X-Gm-Message-State: AJIora+k7octTQWRZiMsbcGsavqa1DffsE6Lf+ZBip9Eh9t1xZzgnGrH
        7ha5na7oXl5x7zkohyidToWm56wyvwJoSHhTzcKYYkII2+uCpOj7iG2x6N3OmAzI4Xuq/DJludd
        wpeR2F0T7ogSFKuY2JCNhplSq
X-Received: by 2002:a05:600c:2207:b0:3a0:4659:a0b0 with SMTP id z7-20020a05600c220700b003a04659a0b0mr34770149wml.48.1656952328703;
        Mon, 04 Jul 2022 09:32:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vnvKWgb7epV/6gnkjXMb5ckPO58u5LCltHJ6GzPrkl+ffwyyTHwI5y63zhOS8rkRw1W7EDBA==
X-Received: by 2002:a05:600c:2207:b0:3a0:4659:a0b0 with SMTP id z7-20020a05600c220700b003a04659a0b0mr34770118wml.48.1656952328435;
        Mon, 04 Jul 2022 09:32:08 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1b12:b300:47b0:25ba:1a2e:72ac? ([2a0c:5a80:1b12:b300:47b0:25ba:1a2e:72ac])
        by smtp.gmail.com with ESMTPSA id v192-20020a1cacc9000000b003975c7058bfsm20288132wme.12.2022.07.04.09.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 09:32:08 -0700 (PDT)
Message-ID: <7c66ffb07a06f1c64985c3b6e3c212f1f247a652.camel@redhat.com>
Subject: Re: [PATCH 5/7] mm/page_alloc: Protect PCP lists with a spinlock
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Date:   Mon, 04 Jul 2022 18:32:06 +0200
In-Reply-To: <20220624125423.6126-6-mgorman@techsingularity.net>
References: <20220624125423.6126-1-mgorman@techsingularity.net>
         <20220624125423.6126-6-mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-24 at 13:54 +0100, Mel Gorman wrote:
> Currently the PCP lists are protected by using local_lock_irqsave to
> prevent migration and IRQ reentrancy but this is inconvenient.  Remote
> draining of the lists is impossible and a workqueue is required and every
> task allocation/free must disable then enable interrupts which is
> expensive.
>=20
> As preparation for dealing with both of those problems, protect the lists
> with a spinlock.  The IRQ-unsafe version of the lock is used because IRQs
> are already disabled by local_lock_irqsave.  spin_trylock is used in
> preparation for a time when local_lock could be used instead of
> lock_lock_irqsave.
>=20
> The per_cpu_pages still fits within the same number of cache lines after
> this patch relative to before the series.
>=20
> struct per_cpu_pages {
>         spinlock_t                 lock;                 /*     0     4 *=
/
>         int                        count;                /*     4     4 *=
/
>         int                        high;                 /*     8     4 *=
/
>         int                        batch;                /*    12     4 *=
/
>         short int                  free_factor;          /*    16     2 *=
/
>         short int                  expire;               /*    18     2 *=
/
>=20
>         /* XXX 4 bytes hole, try to pack */
>=20
>         struct list_head           lists[13];            /*    24   208 *=
/
>=20
>         /* size: 256, cachelines: 4, members: 7 */
>         /* sum members: 228, holes: 1, sum holes: 4 */
>         /* padding: 24 */
> } __attribute__((__aligned__(64)));
>=20
> There is overhead in the fast path due to acquiring the spinlock even
> though the spinlock is per-cpu and uncontended in the common case.  Page
> Fault Test (PFT) running on a 1-socket reported the following results on =
a
> 1 socket machine.
>=20
>                                      5.19.0-rc3               5.19.0-rc3
>                                         vanilla      mm-pcpspinirq-v5r16
> Hmean     faults/sec-1   869275.7381 (   0.00%)   874597.5167 *   0.61%*
> Hmean     faults/sec-3  2370266.6681 (   0.00%)  2379802.0362 *   0.40%*
> Hmean     faults/sec-5  2701099.7019 (   0.00%)  2664889.7003 *  -1.34%*
> Hmean     faults/sec-7  3517170.9157 (   0.00%)  3491122.8242 *  -0.74%*
> Hmean     faults/sec-8  3965729.6187 (   0.00%)  3939727.0243 *  -0.66%*
>=20
> There is a small hit in the number of faults per second but given that th=
e
> results are more stable, it's borderline noise.
>=20
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Tested-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Thanks!

--=20
Nicol=C3=A1s S=C3=A1enz

