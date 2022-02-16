Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167184B9105
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbiBPTMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:12:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbiBPTM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:12:29 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95316A046
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:12:15 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a23so1498437eju.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MFZAXh0fPBQNBK2R2nIbUxsfdyleJj0WxyfRkLW2ksM=;
        b=Uluo3RZ4Jb1a8toBJUYIYiZsZX8M8bZSJueR1LtDSK2/kjqFPZc2c843qGVD0412tE
         SFliv6hazTgZT8N6TuzuCzJcyQvHI2dObibM/hIL7m+6gPVsOUzZllXCXv/NKfiUW3He
         mdLeagIMwN9s9JKPFRvkLtupmK75oAPH2rWXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MFZAXh0fPBQNBK2R2nIbUxsfdyleJj0WxyfRkLW2ksM=;
        b=uoVBRizFxbzTtN6xEt5VdbdcOD6KFDY6kifPkLRu9KflZ67F43HMh0x5E9raagOJw4
         RMN3372Lx68IEdvjtcbuKTvbSEoNDc5kxFqnjdQ8/rIZPRtosf1Y3LDxKSD3A+HctHCj
         cLKuUP0x+njDq8cx7T3vk7d3vKsPpVKMeTs87cUTAkmU9MyiKyDGoKEwDJFVL+yNITvJ
         4sZr8Ity+Ld4aqKLzQ48czYGxHV5fS8XBjrCgk/DrJ9ERXgA3uOKklVnaayulHcEBr3A
         MsJ+51qJlHtJ6Rt67UUZKROosapP9tJvih8/FIxHMugdbmTxijsumIuT20Y8jLjQxjCy
         incw==
X-Gm-Message-State: AOAM530Yo3D2AN8Ox9D2fvIhoZNH1Wu2esyWcQlgtvWJUj3Bu1mA5+es
        3ETfpvC7oaLLrR5rWAMsf+68hZUpOJATrF0G5xc=
X-Google-Smtp-Source: ABdhPJxq9IzKaZipdbheGQ4Mo4iOx7R9uciFKGtTasJhRH3bVv3g6QV0/e1r5jr+oap56/mee5Jk6A==
X-Received: by 2002:a17:906:9947:b0:6cf:e903:fb75 with SMTP id zm7-20020a170906994700b006cfe903fb75mr3362839ejb.400.1645038734067;
        Wed, 16 Feb 2022 11:12:14 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id j8sm2342038edw.40.2022.02.16.11.12.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 11:12:13 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id k1so5063450wrd.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:12:13 -0800 (PST)
X-Received: by 2002:a05:651c:549:b0:243:d87d:4f5a with SMTP id
 q9-20020a05651c054900b00243d87d4f5amr3232911ljp.443.1645038284648; Wed, 16
 Feb 2022 11:04:44 -0800 (PST)
MIME-Version: 1.0
References: <20200917112538.GD8409@ziepe.ca> <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca> <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1> <20200918173240.GY8409@ziepe.ca>
 <20200918204048.GC5962@xz-x1> <0af8c77e-ff60-cada-7d22-c7cfcf859b19@nvidia.com>
 <20200919000153.GZ8409@ziepe.ca> <20200921083505.GA5862@quack2.suse.cz>
 <20200921120301.GD8409@ziepe.ca> <CAFCwf10eNmwq2wD71xjUhqkvv5+_pJMR1nPug2RqNDcFT4H86Q@mail.gmail.com>
In-Reply-To: <CAFCwf10eNmwq2wD71xjUhqkvv5+_pJMR1nPug2RqNDcFT4H86Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Feb 2022 11:04:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgLk5xWj8v6mQXaWL0zWAf2cis8EpPkQUuEZ7K3LxVQHQ@mail.gmail.com>
Message-ID: <CAHk-=wgLk5xWj8v6mQXaWL0zWAf2cis8EpPkQUuEZ7K3LxVQHQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Added David Hildenbrand to the participants. David, see

    https://bugzilla.kernel.org/show_bug.cgi?id=215616

  for details ]

On Wed, Feb 16, 2022 at 8:59 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> All the details are in the bug, but the bottom line is that somehow,
> this patch causes corruption when the numa balancing feature is
> enabled AND we don't use process affinity AND we use GUP to pin pages
> so our accelerator can DMA to/from system memory.

Hmm. I thought all the remaining issues were related to THP - and
David Hildenbrand had a series to fix those up.

The fact that it also shows up with numa balancing is a bit
unfortunate, because I think that means that that patch series may not
have caught that case.

That said - what does "we use GUP to pin pages" mean? Does it actually
use the pinning logic, or just regular old GUP?

I'm assuming this is just the existing pin_user_pages_fast() (ie a
proper pin) in drivers/misc/habanalabs/common/memory.c. But I wanted
to confirm that it's not some other situation.

                   Linus
