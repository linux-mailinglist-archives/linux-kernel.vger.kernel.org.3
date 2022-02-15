Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225064B7735
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbiBOTyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:54:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiBOTyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:54:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C145027FFC;
        Tue, 15 Feb 2022 11:53:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E33061839;
        Tue, 15 Feb 2022 19:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD370C340F3;
        Tue, 15 Feb 2022 19:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644954837;
        bh=ybVzBbvmSOoVbs8OTAqgC9k7dcWxXzPNvdGTlxM4esw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XiVUyL4al8GHXE+UgzwigR7X6pH993Bu63Z0W1Z517LncckN+4p91ba/TO5NWXQpp
         U1vWjpJONv3koPrD/mTCQn2wG59ZnyoYcqC24otLIxisbduauF07K6jsfuKF7k5IPi
         +Hw1LyLfz4KFU1iFNEABzel5jNUlcgSKiLZTXhgdUbVpBQhvQZook17Z26oC8x+I92
         Kqw26/a9rxOHNFUPyA1v8xkCofJMAgh45s4p7T9SEsz5KknpGQn+JSam3udRoSF79D
         JcwPKgnF+Gb7n0xG2o5q3ZdCK1XwGP234FVVLgPnpE7Dny5AEZWXqxbge/dQJ7fmyT
         BLnrlNNGDqbSg==
Received: by mail-ej1-f42.google.com with SMTP id p15so46563567ejc.7;
        Tue, 15 Feb 2022 11:53:57 -0800 (PST)
X-Gm-Message-State: AOAM530+dxLygZ4ehCRoNuOogzpeEtjW+AgB93hbxnfaAaz0QX8Ll7q6
        tyQ0yJNan7+9sYdgABhHImWkLgCtEj9QWC+qiA==
X-Google-Smtp-Source: ABdhPJzC9sVdAIFHy7S1BKRXKLnYS/B1vXl5yMVBOJv/Qip68D1M6dRfb08LeY0VUnzZG5cmUksF3YA2hW+Y4jYVYLc=
X-Received: by 2002:a17:907:628c:: with SMTP id nd12mr586045ejc.82.1644954836019;
 Tue, 15 Feb 2022 11:53:56 -0800 (PST)
MIME-Version: 1.0
References: <20220214174132.219303-1-david@redhat.com> <20220214174132.219303-2-david@redhat.com>
In-Reply-To: <20220214174132.219303-2-david@redhat.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 15 Feb 2022 13:53:44 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKzL6xBXfuTv423EoWw=fYPnK_q5paqUSDWyyoNx1thRA@mail.gmail.com>
Message-ID: <CAL_JsqKzL6xBXfuTv423EoWw=fYPnK_q5paqUSDWyyoNx1thRA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] cma: factor out minimum alignment requirement
To:     David Hildenbrand <david@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Zi Yan <ziy@nvidia.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        devicetree@vger.kernel.org,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 11:42 AM David Hildenbrand <david@redhat.com> wrote:
>
> Let's factor out determining the minimum alignment requirement for CMA
> and add a helpful comment.
>
> No functional change intended.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/include/asm/fadump-internal.h |  5 -----
>  arch/powerpc/kernel/fadump.c               |  2 +-
>  drivers/of/of_reserved_mem.c               |  9 +++------

Acked-by: Rob Herring <robh@kernel.org>

>  include/linux/cma.h                        |  9 +++++++++
>  kernel/dma/contiguous.c                    |  4 +---
>  mm/cma.c                                   | 20 +++++---------------
>  6 files changed, 19 insertions(+), 30 deletions(-)
