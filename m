Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F230F4D4861
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 14:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242554AbiCJNuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 08:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242553AbiCJNus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 08:50:48 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDB114F98C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 05:49:47 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id l2so10972784ybe.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 05:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YrHkxxw7wa90Lz7KvljazCkAUUcPibWKOq87Yk0/n0Y=;
        b=XGmoL/c7V6Yac4ZEaR34Gjm6a6GdVsGuTpFSzLBHc7yEcOzghG/dIhCfJ+IGa6DGll
         um2nX+BPpcofKOEbHuoL0ARr8fftC54cYzbFusMr6qktOlTX3nwet/pOE/oOrbEgTbIm
         srktgS+dbasgTIFOXTRuTk/81fHPS2YRD5Neg1yH/Cl5HvDHv3i0A72w/W3xYjyBQMzc
         EsCvzG6S6GbCocy2VVx00HQUHM2UZlwJ+TSmxKTBTpCMToZr7jfpd1ggOOExyE3B8Yrg
         WIa0Nno/JDdKOiGkQZstYOF7gMjwyDZY62fKy6S1uh2KkxNO/Jr9NuUMbgUc+oyiHHoM
         aWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YrHkxxw7wa90Lz7KvljazCkAUUcPibWKOq87Yk0/n0Y=;
        b=kC82jHiKZdeltID1v/JDuc/kWIO3w5o5mcOMRiIyo1MXDP3hOjM15BgM6AOJqL7cbq
         Zd+YNcj6xV7bKRf/liqJrP87QRao/tV3jhcTte+zIZ+9ckaofnZnNfnPbOUm3o8u+Jmd
         6PHVRIgCeWVXCM43SHsEtAZmYjuvbICdbF056IAwBgjYos+0qwSI/WPMaHGd/qznyA6q
         PABUowX8J8qGsoW7WkhYAMBgaymn2B6VPb5LV9iGsOFdjmeKk9ubRI8OSg8L/i+8luOH
         NY2iZ8p5POZEJHlzoOUKLy+Tmh1HjKxvEQJgNfI0McxXySJRy1wUdfU7FZ4dIiGTktyv
         GLag==
X-Gm-Message-State: AOAM533naME6XbBU8LoEqdN3UMTWU1wV3/15a7xuNv/IgJyWXbnkcrRv
        FPTxVvmGd7NNk6zPmn6kW5qmzEXFDHbHsJSTidmp7g==
X-Google-Smtp-Source: ABdhPJxEyh0BnHyunA1YVnIuCNPWGZHleKd1WO6N3gi7S+63k2cJ+dICHYCAS3kauxgrvZDRc7AkiSHCwy8gPXQMxcI=
X-Received: by 2002:a25:8390:0:b0:629:2839:9269 with SMTP id
 t16-20020a258390000000b0062928399269mr3888598ybk.246.1646920186546; Thu, 10
 Mar 2022 05:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20220302082718.32268-1-songmuchun@bytedance.com>
 <20220302082718.32268-3-songmuchun@bytedance.com> <CAPcyv4j7rn8OzWKydcCJNXdrhXm6h6Vq5n7uLzP5BSMJ_qSZgg@mail.gmail.com>
In-Reply-To: <CAPcyv4j7rn8OzWKydcCJNXdrhXm6h6Vq5n7uLzP5BSMJ_qSZgg@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 10 Mar 2022 21:48:01 +0800
Message-ID: <CAMZfGtUNRAb3qnx5-ZV1uPEx1aLNbkzjJw5JrUzX8tMbR9AGNg@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] dax: fix cache flush on PMD-mapped pages
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 8:06 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Mar 2, 2022 at 12:29 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > The flush_cache_page() only remove a PAGE_SIZE sized range from the cache.
> > However, it does not cover the full pages in a THP except a head page.
> > Replace it with flush_cache_range() to fix this issue.
>
> This needs to clarify that this is just a documentation issue with the
> respect to properly documenting the expected usage of cache flushing
> before modifying the pmd. However, in practice this is not a problem
> due to the fact that DAX is not available on architectures with
> virtually indexed caches per:

Right. I'll add this into the commit log.

>
> d92576f1167c dax: does not work correctly with virtual aliasing caches
>
> Otherwise, you can add:
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Thanks.
