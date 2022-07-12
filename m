Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43405571371
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiGLHvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiGLHvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:51:10 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21949A69E;
        Tue, 12 Jul 2022 00:51:06 -0700 (PDT)
Received: from mail-yw1-f174.google.com ([209.85.128.174]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M9Wqa-1oEU3x0SqC-005aPt; Tue, 12 Jul 2022 09:51:05 +0200
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-31cac89d8d6so72844987b3.2;
        Tue, 12 Jul 2022 00:51:04 -0700 (PDT)
X-Gm-Message-State: AJIora+lnbQj5ZbYTwSYbSk85goa1cAFM1nI3diUF5yCH0zl+VWAgJRD
        7QWjtIx4M8EnOaRHYLKGVUD0cO5zfM/guUn7xHs=
X-Google-Smtp-Source: AGRyM1ufca0XkARKSb1i/9Hgo/QC/CH6QUlrdoqUuF3Jwpyoc+XbP0yMd1avuvBxh4Bz5/H8vuI4X+XdchTTBll8UJg=
X-Received: by 2002:a0d:df0f:0:b0:31b:e000:7942 with SMTP id
 i15-20020a0ddf0f000000b0031be0007942mr23243135ywe.320.1657612263753; Tue, 12
 Jul 2022 00:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220711122459.13773-1-me@linux.beauty> <20220711122459.13773-5-me@linux.beauty>
 <CAK8P3a2Mr0ZMXGDx6htYEbBBtm4mubk-meSASJjPRK1j1O-hEA@mail.gmail.com> <181efcca6ae.de84203d522625.7740936811073442334@linux.beauty>
In-Reply-To: <181efcca6ae.de84203d522625.7740936811073442334@linux.beauty>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 12 Jul 2022 09:50:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a30o1RLifV1TMqDJ26vLhVdOzz3wP6yPrayLV2GPxUtwQ@mail.gmail.com>
Message-ID: <CAK8P3a30o1RLifV1TMqDJ26vLhVdOzz3wP6yPrayLV2GPxUtwQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] sample/reserved_mem: Introduce a sample of struct
 page and dio support to no-map rmem
To:     Li Chen <me@linux.beauty>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li Chen <lchen@ambarella.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:8lGB+NJxQc33gsettBfh+xxQK2l7f7QQa6CRc7EbjKMRsczPJNE
 RleVsYCFJ5qzVX75nxJDSfDnpieQHNQeE3BV8s1lu9tjZq66+IvwtIM6yWHc/DJwLGT/zOD
 FmH8sAMgupnOzmmrDMMhxfMZgyvvtW1mNFDfrw4/ef4wGhw1QT6Ipu62I5rW0MpTj7fiT9c
 3kllEkLiMCE6U4R9V//vg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5DhGn80DuMo=:D8xdg5OOtkkwpau06UnTPj
 xH7LpWsAJK5ajA+jUCJ7aoIasKSlcDVvL31LgSuBxX+O+KgJnUnWF4oqC2DDtOGpLURLVOvtF
 BYzdrRJTgyg0G/e2Erp0hhQOIbLyhcoOJ/sSASTCAqub1e3gnPFkfId6vYe8WCO76koaqPnDL
 1dAHFsNsthaoygdnWJHviHD8kPAs3ckQaK7a9LypXKSVeEYt2QlUoLLc2IjLXSp2wgzXzxjCr
 uIsMbmtpynQ9S9RzaEGrNtUpt/mVX7Z3cKUQyzZ9GgSzy5eCyKrmjwCgaD8/1TTuG8GrXriU3
 QiD2MSA7fL2RVwmFHJC1AOObN8092H7z/7EhB94Yj+04SVQ2rykAh1WD/NKhqWm7+1MDtbJuS
 jBU8SwOIR/MKizBUmulpVKvoCERTsvIAIWRXwaT+S1Bx2mlwxjf9fzvq5hfAuYlZ1Su49MiLV
 OHLmzVDR/huGzfqOGUpQnAIXULLGM7oTvWfTJV+b+GBdBGS2vBJnP18UchCBvbvrJfjK9CRCt
 Mq0ynQyxq7aU6x8njaAKSQIrpPJsZWIY1iXOzSGesrouk+b2y5b0fUBRVVp8mEVJQuy2VWZjY
 13+yQ+9l9aIjvZiBe+kqXPNao2+/sp6qnhNEY6Fjv0G7UeO98zFYZKO81s2kFE+9WAa+Sv23V
 HGRuj0dOTf4qLRBwfTIuYcc4qaf55NnZEHQoFvmWJ+roa/4IUNL42CI75zOGHOuyikFj7HBhD
 IGFkvto9qtz6nok4nVFfqdYuuzw2drSfxmjbpgvEPZAcz4kVxrrdYx4xuDfz/BnyTXebJTXX2
 jzvQgKFsWZjWtbV19912STsnqGGMyrbB/JVWMOJgaikiHin1bfqXjgVhHVBAg05mYs0AFgKzd
 8LJwiceZdLoUPsq9CtGcu8Bfd4/phgSBVo+2ryy8E=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 2:26 AM Li Chen <me@linux.beauty> wrote:
>  ---- On Mon, 11 Jul 2022 21:28:10 +0800  Arnd Bergmann <arnd@arndb.de> wrote ---
>  > On Mon, Jul 11, 2022 at 2:24 PM Li Chen <me@linux.beauty> wrote:
>  > >
>  > > From: Li Chen <lchen@ambarella.com>
>  > >
>  > > This sample driver shows how to build struct pages support to no-map rmem.
>  > >
>  > > Signed-off-by: Li Chen <lchen@ambarella.com>
>  >
>  > Not sure what a sample driver helps here if there are no actual users in-tree.
>  >
>  > It would make more sense to merge the driver that wants to actually use this
>  > first, and then add the additional feature.
>
> Totally agree, but we plan to start rewriting our video driver in a long time, it
> has many legacy codes and I need to rewrite a lot of codes to migrate to v4l2.
> That's why I also submit a sample driver here: to make the review progress
> easier and don't need reviewers to read video driver codes.

The problem is that this patch may not be the right solution for your new
driver either.  As Christoph also commented, what you do here is rather
unusual, and without seeing the video driver first, we have no way of
knowing whether there is something the driver should be doing
differently to solve the original problem.

>  > > +/*
>  > > + * dts example
>  > > + * rmem: rmem@1 {
>  > > + *                     compatible = "shared-dma-pool";
>  > > + *                     no-map;
>  > > + *                     size = <0x0 0x20000000>;
>  > > + *             };
>  > > + * perf {
>  > > + *             compatible = "example,rmem";
>  > > + *             memory-region = <&rmem>;
>  > > + *     };
>  >
>  > The problem here is that the DT is meant to describe the platform in an OS
>  > independent way, so having a binding that just corresponds to a user space
>  > interface is not a good abstraction.
>
> Gotcha, but IMO dts + rmem is the only choice for our use case. In our real
> case, we use reg instead of size to specify the physical address, so
> memremap cannot be used.

Does your hardware require a fixed address for the buffer? If it can be
anywhere in memory (or at least within a certain range) but just has to
be physically contiguous, the normal way would be to use a CMA area
to allocate from, which gives you 'struct page' backed pages.

         Arnd
