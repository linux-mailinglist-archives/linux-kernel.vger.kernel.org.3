Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D6B4EBBC1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243835AbiC3HeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243842AbiC3HeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:34:05 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E91D2042B9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:32:14 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2db2add4516so208972907b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fjTDi9n/uLRqxVKGGOaPNySXftZQ6axRJXtPfIo5LUI=;
        b=oy0ldmBjJZfRyL+iZuZ5FQ/Inj2N4hflGyxVltzKvGdTjhOYfkFX8SjWEA2uOlOnz3
         AKOfxviF2B7L+/oZuIvzhkjT00ZrJliFLYhLF5UqAOo0/bMIjxjKCLujhnabL6gKCGgO
         6MdTSmLe+CDGS2g1FopXywQUJWfY5c6avaXqJbsJKiYkTBJ/0avOJLEK3cVY8YflI3R9
         9ZHjM2AsS6qJf+rw0uC4YVZdhi463GG9MmJXC5ZHSj13srAq2ZRVFVYkCDQ6zhypRruU
         I5qQRa/lQIUTWj8p7n28JUDfMbQT8CfQr4x1Gd54i7/6CAtDTanLGOYFGb9GZwXKSAon
         h4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjTDi9n/uLRqxVKGGOaPNySXftZQ6axRJXtPfIo5LUI=;
        b=Hqn+kcqxj81hu0tzpXZEMzYEzBZMpb8XPQNSEB/IEwwDpYxx4rtS39oDPkYr0OPhQt
         TMvEmX/KYrRLNOs6/6lzaZW8tjlfx6Mpil64vWWQKiDDHGdWf6zm9PQ/7sOOGSQB+z8z
         dv3SlsW2qeJcVNL5Ie8eX+FD833ADYT3L8W8grBED1xGGp0GGF9LhFJ/E+1PPOo5L3Oy
         poF8hhcyebGBUKgMVJh+vhDVclO0ozkNi0UfS1xPowRm+94GjBS4thVpSmtioPOxwqYX
         rqvED0lBikgk6iLkXebN6iJTUE84zi9wJuGBFLFwnNmlFRu0SVhPpDutST1PSAM9QAZW
         z+xA==
X-Gm-Message-State: AOAM532f1bqJTsPVZjjJ8MxOfqytW+a2xzQ9xlhzUI0x3XmR8dt84KKl
        77BNpQn/XWV90FoXdmtNdMXLA9OYRBZs79U/PmPfNg==
X-Google-Smtp-Source: ABdhPJz47F/zt8DASramM8wZ7Ct2jmaZz8jkBg/c3k72v2zUuDdQNpuEmcP5Le6BlzGgL/Da/aZVgVfRA9PmmuG+3Qc=
X-Received: by 2002:a81:897:0:b0:2e5:f3b2:f6de with SMTP id
 145-20020a810897000000b002e5f3b2f6demr35325738ywi.141.1648625533474; Wed, 30
 Mar 2022 00:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220329134853.68403-1-songmuchun@bytedance.com>
 <20220329134853.68403-4-songmuchun@bytedance.com> <YkPu7XjYzkQLVMw/@infradead.org>
In-Reply-To: <YkPu7XjYzkQLVMw/@infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 30 Mar 2022 15:31:37 +0800
Message-ID: <CAMZfGtWOn0a1cGd6shognp0w1HUqHoEy2eHSWHvVxh6sb4=utQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] mm: rmap: introduce pfn_mkclean_range() to cleans PTEs
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Muchun Song <smuchun@gmail.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 1:47 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Mar 29, 2022 at 09:48:50PM +0800, Muchun Song wrote:
> > + * * Return the start of user virtual address at the specific offset within
>
> Double "*" here.

Thanks for pointing out this.

>
> Also Shiyang has been wanting a quite similar vma_pgoff_address for use
> in dax.c.  Maybe we'll need to look into moving this to linux/mm.h.
>

I saw Shiyang is ready to rebase onto this patch.  So should I
move it to linux/mm.h or let Shiyang does?

Thanks.
