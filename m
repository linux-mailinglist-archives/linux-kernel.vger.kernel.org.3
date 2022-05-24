Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9EC532C87
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 16:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbiEXOrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 10:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiEXOrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 10:47:37 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798127628D
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 07:47:36 -0700 (PDT)
Received: from mail-yw1-f180.google.com ([209.85.128.180]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MBDvU-1nzXho2Lza-00Cm85 for <linux-kernel@vger.kernel.org>; Tue, 24 May
 2022 16:47:34 +0200
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2ff7b90e635so118482687b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 07:47:34 -0700 (PDT)
X-Gm-Message-State: AOAM533Ps7IurWXHDrwPho2KXyWrsqIGTgJWJv0+iZn0XBwKD0TDbGzr
        p0OoWpI94DOT6jIwHHfCZ6wwGUCePP+6uB/ABIw=
X-Google-Smtp-Source: ABdhPJztaIcIMWnqLP/suBLoexCji+3v0BT7iVjvVWSzoaliWtH4kcQa4bC92SqaCbiMIbBetuCzXWl9S2aiwfoPNdk=
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr29295789ywk.209.1653403653308; Tue, 24
 May 2022 07:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220519082552.117736-1-wangkefeng.wang@huawei.com>
 <20220519082552.117736-5-wangkefeng.wang@huawei.com> <CAK8P3a1DbNY6NzcwzjVFvd9yw6L3YBHQos_hmE=nG=6cuv1DAg@mail.gmail.com>
 <4c848b48-6ddf-664a-6296-d85ab49a694d@huawei.com>
In-Reply-To: <4c848b48-6ddf-664a-6296-d85ab49a694d@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 24 May 2022 16:47:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a19S8CFxJKQo_8UXSKA0L8J40DsjL+u649oDhqUPHSW7A@mail.gmail.com>
Message-ID: <CAK8P3a19S8CFxJKQo_8UXSKA0L8J40DsjL+u649oDhqUPHSW7A@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] mm: ioremap: Add arch_ioremap/iounmap()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:kaTJBZ5VHVv+NdGJG/YeK5ApS4Sya1LuUUGGg2m8W8ROVcuexuz
 mzAlGBdLjM4+B0qBThXwatOhfoPVfwvZXxFcMmSW4WkphVwb0eaEBaXD9kCbL6QRpaUIZHT
 KNDZ3Lur3qPx5Fa4VaVPgy0oqA5nQuwGCaqOh9C1BIx5vJB0X5K2rr0iF52cU/tTCAja5CX
 9bspYoWfmlvs8hBpZjP/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F8JyZP6UEVA=:km8znRQULAmSfpTaexmwYS
 HGn8jL8RJsWWZdpd1Vj40HYPWaPCwY0FAq7lLcBD9gBdCLAnezRLW9VzxfzllIxZttI3s+h95
 SD1TP9ECo9qYI/pEYnZcp7G2J2FBVeBeunRfgyrdx9xhnq8m0CM1Jsb+TCeEKVgZNh/fdd3HS
 sKLBKsIpm9k3zqR1nE7DTXeGxvtA7rVp7YBTzFeXeDICqmt4gy2Sd8zoeMG8d+k+Eob6z1GNv
 w3SBTxRNRpfhOuuPMvAW2YseeuVmh2mR0mQdS6eG4Bn3TOuceseai57dj6wpKcXgL93lbktkt
 xv13y1VOuWBM2BeoGUFk4DlRtnIHjxNkDKomwGEQEu2v7kMRw5dDEmU7925bmVVx6BNa8ZnN+
 DdkKEfkIpWLGytuesVoaAOs1zgcS4az2QswKdlVMtPBiRw6jQcsM+KRp/N7r5FuzSUFuD7rI8
 KZZ4YDZelKigOJK/XOKmsWghuKMmNyCttaUd2mo5NqyxjZeBTbM+XUQ83gpRJl/WqgXPVlpmH
 s1yGG2olO+8hwakr6k2QHpw+/lIZoBRRw7do7SUdzqT5bWIP3uwdVlrf5tzngmetJKBBT5cw/
 fe8z5m0zildzxZGhsbVMsJQ46tNb2tVNeK9P4+kp38Ige+Jm5pEsmLJdgyq8m2/7TgGyiCIxU
 tVZkzeiwtXnXEzQmaLjVxpFV/q7nwfL9aIePymVQNRKeH8+IWbX3RC/tzcOdzoLmflsDn4wVl
 ciS5ryir/lI2bvjXUBmktjRg65N2dwHWzEt2ho2+xcn3h0jpjmgs0ZPXrrAOB6gvWFmDqWd4t
 8la0ytXB7ay4r4zYel7di4yPtCffM4gSaLHlAK5XG9bOkrG+l7V6k40IP4CQ3QPb6FfQ92Zb1
 UvlV5ee/FF5WKvJ6csaA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 4:32 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> On 2022/5/24 20:37, Arnd Bergmann wrote:
> > On Thu, May 19, 2022 at 10:25 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >> Add special hook for architecture to verify or setup addr, size
> >> or prot when ioremap() or iounmap(), which will make the generic
> >> ioremap more useful.
> >>
> >>    arch_ioremap() return a pointer,
> >>      - IS_ERR means return an error
> >>      - NULL means continue to remap
> >>      - a non-NULL, non-IS_ERR pointer is directly returned
> >>    arch_iounmap() return a int value,
> >>      - 0 means continue to vunmap
> >>      - error code means skip vunmap and return directly
> >>
> >> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > I don't really like interfaces that mix error pointers and NULL pointer
> > returns.
> >
> > Would it be possible to have a special error code other than NULL
> > for the fallback case?
>
> I don't find a good error code, maybe  ENOTSUPP, any better suggestion?

I had another look at the resulting arm64 function, and it appears that
you never actually return a non-error pointer here. If I didn't miss anything,
I think the best way would be to change the return type to just indicate
success or an error code, and drop the case of returning the actual result,
and changing the function name accordingly.

Would that work, or do you actually require returning an __iomem
token from somewhere else?

       Arnd
