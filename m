Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79F651240C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 22:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiD0Uti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 16:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiD0Uth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 16:49:37 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10251F620
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:46:24 -0700 (PDT)
Received: from mail-yw1-f182.google.com ([209.85.128.182]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MqJVd-1oEjG92pb1-00nPn1 for <linux-kernel@vger.kernel.org>; Wed, 27 Apr
 2022 22:46:22 +0200
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2f7bb893309so32109867b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:46:22 -0700 (PDT)
X-Gm-Message-State: AOAM530Dm0tXB8QoQU/3ZH1CS79mPcX2mxFpvTw62ZhWdwgqH1Wwml0O
        3nHzq88gD0s1WuQruw4FzE0ynNDbTW6cpvqZXw0=
X-Google-Smtp-Source: ABdhPJxANmMoqAuHMC+ZEgkn1SQ7RkZSRhYC7mHz9ENipwBcb4dwpBkcMTggyEdiYrS6+jwmvudQ9Iia7DEbG1xmsXA=
X-Received: by 2002:a81:9213:0:b0:2f6:eaae:d22f with SMTP id
 j19-20020a819213000000b002f6eaaed22fmr27226869ywg.249.1651092381529; Wed, 27
 Apr 2022 13:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220427121413.168468-1-wangkefeng.wang@huawei.com>
 <20220427121413.168468-3-wangkefeng.wang@huawei.com> <CAK8P3a1E1vP-vS=-aH-XP=5taSTy8EUTfNSpQk9x47WLRMCOzQ@mail.gmail.com>
 <20220427112545.3b8b9c46e5e5731b02394ace@linux-foundation.org>
In-Reply-To: <20220427112545.3b8b9c46e5e5731b02394ace@linux-foundation.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 Apr 2022 22:46:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2BJA6KCJuyJOcy640=rTXfL7VEP8uFdLQH+2FRftFMfg@mail.gmail.com>
Message-ID: <CAK8P3a2BJA6KCJuyJOcy640=rTXfL7VEP8uFdLQH+2FRftFMfg@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm: ioremap: Add arch_ioremap/iounmap_check()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ueVOf2bFTs4MRDkUAsM5E4vvnfNvXPJ2UhUE45eELqfxBkTqzgN
 5dPLJYO8VeDRJbjKl0FdtSE/bl5UEKZfDpYivSC0s0PTuAxjVra0p6vwxjipw8ckOstnMd+
 WQTDipHYGJWlINQaFtQFdEOMOD63ciHnzUi0gGiSXNoauK1IUvD3USjXpSABCopwVKISSba
 BGqSaRE8QOEPfNtailiUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kgzBLYwYm9Q=:089UrPCDg+qAaH9UDSgv5U
 hBEv4QcKjrirQQ9kzLiBcjOe86LOgLXOSayHg9zC80xFjYQaaXheKHJJ0nqakTQAlYRvQI5/X
 7SC7QmyIa5oiQ3ybRQU/JRcJAnwOnevReYlWQ7D3/y4mEtWoUCN6pNS7x61mKvp81OWv9mYUg
 kuEXPiAMFzUMP3jrA9Xt70Gb5ooLwZuS4zj+jf8KbLs4UCIsWJWf9vzVbeVkU+SqN1tNog+4F
 QCjbu/gCN3/QlA0bsKPy55XpfGtJoVaRAPYi0VsJMqj2e8rzX9dSM6liSXtRgKCsVtRrcs78K
 C6bUwg1uzjchsZlP3UstGbh9X5yhKPmvblpVstOPmcPvD4trNS+HocLdgEnij8/gCjJ11jRX1
 Px7MvPHtIwJugTESxdujdnAXegs7xArIkwA6LyHPt9wx8gp/ye/dH4/thiZUDRKwNrlGq1jCQ
 7oMeL7UmExyXgF5yw/50B6QPi7FGY4uFNiNW7XnLXIn2bigbsOMgR7SDStUf6MwwseifcyD62
 2H5hb8xCQoz8sxZ8JBHBv+nptKzbjxLwq2AQhl9iXQ6hOzvBNHWIruzOQ4YTsr3XY/RhlxVqF
 8gX0wlyJu/MsLkyjvq2A4OyFp59NgFVoNhj6jN05UW86YbDOz7LahGf8PP8u59NkH4o9+/uw8
 enFTwEKNXu9SishQoAxa2TsXEIDkUv8KPPTbTFOgDjXiakAXazM2ivoIp50/sOYnsjv8=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 8:25 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> On Wed, 27 Apr 2022 20:20:30 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, Apr 27, 2022 at 2:14 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> > >
> > > +bool __weak arch_ioremap_check(phys_addr_t addr, size_t size, unsigned long prot)
> > > +{
> > > +       return true;
> > > +}
> > > +
> > > +bool __weak arch_iounmap_check(void __iomem *addr)
> > > +{
> > > +       return true;
> > > +}
> > > +
> >
> > I don't really like the weak functions.
>
> How come?  They work quite nicely here?

I find them rather confusing, mostly because it is less clear whether the
fallback function is used in a given configuration, or a replacement one is
present.

This is a bigger problem in some subsystems than others, and the main
place I don't like is the drivers/pci/ subsystem. A number of the uses
there should be driver specific but happen to be implemented by
architectures instead. Maybe I'm just projecting that onto other uses,
but I definitely have a bad feeling about them here.

       Arnd
