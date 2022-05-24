Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271F7532A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 14:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbiEXMiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 08:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237416AbiEXMiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 08:38:01 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415F587224
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 05:38:00 -0700 (PDT)
Received: from mail-yw1-f171.google.com ([209.85.128.171]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mhl0I-1nOWhS15xw-00dmXG for <linux-kernel@vger.kernel.org>; Tue, 24 May
 2022 14:37:58 +0200
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2ff90e0937aso105341937b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 05:37:58 -0700 (PDT)
X-Gm-Message-State: AOAM531NdmsDM+Yh1enKhObORArFSizUTo+CWArXRxkD49ZMf2Aq3uBJ
        8EC9iAS1wALqS5uKYan0P5Bi28bgOy6oztC7ZQk=
X-Google-Smtp-Source: ABdhPJx+pOz2MDU2NITSHyjL28/g5r+nN7bHb7KpfKqjLOGOqmggd/HyMXX1mE/rep3OWY+xalb+HtpnZq+e2n5DUFQ=
X-Received: by 2002:a0d:cfc7:0:b0:300:26d2:30eb with SMTP id
 r190-20020a0dcfc7000000b0030026d230ebmr3208573ywd.320.1653395877066; Tue, 24
 May 2022 05:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220519082552.117736-1-wangkefeng.wang@huawei.com> <20220519082552.117736-5-wangkefeng.wang@huawei.com>
In-Reply-To: <20220519082552.117736-5-wangkefeng.wang@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 24 May 2022 14:37:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1DbNY6NzcwzjVFvd9yw6L3YBHQos_hmE=nG=6cuv1DAg@mail.gmail.com>
Message-ID: <CAK8P3a1DbNY6NzcwzjVFvd9yw6L3YBHQos_hmE=nG=6cuv1DAg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] mm: ioremap: Add arch_ioremap/iounmap()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:uF43Og7S3/Q5QsroQnSXa+StauFJblrG6f+dy7/qgzWbz8uACvY
 luhfUQwOJc515jDSfQH2PZwcr5LIanbnds2FJCcpaY5Hv6BRNwr+DfT1KWRSJRH3ufI5SsE
 8vJIJPBqC2N/zV5lhSfmpiV/EfAlZ8Q0NqftBxMDMi7s8/9XbqwgWSGWXcmmwyHegg69YcU
 dctcrbG74fupZabzfiIug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xb08Rai1JJE=:KxAw/jA2pap4TjOmzkhTef
 UbT8ATUnEJuXrOObiQCB/ajBAHSvOgjwzVe6SQag6juu1SxPFPJQSy8pNQa/y5Ypd4GCUXd4k
 19Czf2cvb4RJnqq9wOauzjhd2rnF1FkNboGLJ9qK6BK9LrEKdc75UgzTydJDZKlq/Vn8SBH44
 xKJtPaj5FooSE5ytuger66vrQisBI3X4kAnPRiz8lEn8l7mjZgUlfZCkodLK+aeDkWhC5T8Wp
 vr7MW4YSXcqWvbRgPefzU1fIWmoQKMSIir4H/DNPKyB4tVqs3h6bVMjzpp95atu+Ho/VYgYQq
 9mofSeAEvR4QJN0dZmbsUiRM2sOi5QwamBNUAOksOABYkMF/QsVmICAV0vx+cMGKCvHq9wFUg
 rMBxOVDAKdoq/K1OZhMszJ/M9v6dEZH8WwN7AJQB9fk4aH7IZVGHy/YgAweg94ncJneN2XMur
 lfKclydXqLgt851rPeVbTibLm34FuY3U9sZmZyv2i9JXo5jQRT6CSAq/aSH7Jkk3h622mt3Nu
 z9rAK3ylkbmFhMZWEBboOg5VEYh0ITwOmdBx/ixOb2lr0xbs8VvjbVKmW3u0lBbs3PsLmU1ca
 lykjBl/Hqj78/qDwFaCfaJrLtm4gWVka1N4yyXEaXGIkY2OiXA7fIPRM7GIyMrW3ZdEdRJ9bf
 /rYT0/dzrEX+g+LA1RdG5GfWpwEC6msFjk3HdygZb6FWKl8Bn3Uwhubch4txzGBDaBXIpxyfd
 RLPzO721dIFNW4Pfkqb6Bsr4vXf2YMF0fDapnhaMOnZ/Iri3bMvWMhliTXBEBw5aOPllRfewn
 dsO99Hgwll4sPfU8c8QwMotxn6xRNs+jWD0/kvUNwwOV3+lnuAs24Rj3ZYaop1MCT1j8Ntqum
 C18SyYTy6CeFnJGfZ+MQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 10:25 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> Add special hook for architecture to verify or setup addr, size
> or prot when ioremap() or iounmap(), which will make the generic
> ioremap more useful.
>
>   arch_ioremap() return a pointer,
>     - IS_ERR means return an error
>     - NULL means continue to remap
>     - a non-NULL, non-IS_ERR pointer is directly returned
>   arch_iounmap() return a int value,
>     - 0 means continue to vunmap
>     - error code means skip vunmap and return directly
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

I don't really like interfaces that mix error pointers and NULL pointer
returns.

Would it be possible to have a special error code other than NULL
for the fallback case?

       arnd
