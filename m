Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D99B553779
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353749AbiFUQK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353491AbiFUQKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:10:25 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA07DE1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:10:24 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id r3so25284227ybr.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DaVXixvInX7Tije8Ym//sMBlj70LFPbdDShlLVQqFLs=;
        b=J/SWUBYSO1uT8oN30UoSsUFLbBMwF1LdwJeSz7ZJajlGm6CfvEEn8+sanhyyFTap73
         kvsJdepoWsBMC/WVi+BYzpT9h8sAVRRJMi020alPJgZSLJxrcvhGidhEgN8Luek65GpT
         +s2Qk23ok6Ur0Aojv1+1x4aO6I1GIP6SUzkYYNRu2shwAOkGcd46PJS+7gBNt7liXILV
         G0MS+nmwnoI4IkghITv48qE1c6vlLowScBNEP+gvIKeit4BDTXdQM1GUQkYfowDHoh3K
         npPCwAFqfW9DkVyWHl5kaIDZ4M9fZTEYPbXDg6LPG7xARxYheWJTS0b3b9UbsIB0buit
         brTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DaVXixvInX7Tije8Ym//sMBlj70LFPbdDShlLVQqFLs=;
        b=bZybxFOzMuZOcKQGWpr1lszdsfRRoxJJB5P6AEtcUPW7qQ66q6SD8NLND4UhUXI8GN
         Q3ZYvr7v6jfZQKd41hODNornYfpVYTNigfOCrHG1ves/0uX4K1huXy6lXKr7L2PENic2
         eVUirDaHj1b1D22DkfB+zi91XMtv9JMeoGHxqv4fGHE/AjzYrr0GGW9WeTbxD6+7ZnAr
         XXtVgsU4K+zGdBg8NXLVH8p+hRMv+yCB8eDjFo6B7ESZJ9K5D4eewds0TaIvkVA16Aor
         Pgor0CaGzXzbaiAk71InGKiN/OxphMFoeJ19nf+pg7OSkEpfCvCDLomIeo0IuSL5LqgS
         V6JQ==
X-Gm-Message-State: AJIora/K2VxLb92vTa/hdnb2skhAZ8SyhbGbuyZT0+x4dnPPzTTPZ/MZ
        M/wHRTdIEsf5AJTfSPjSE9broR5Q73mWeNtcIUA=
X-Google-Smtp-Source: AGRyM1vPTY5fnnYz8SMXMdXAFLn+4mX9lO6IqVjSY2QhCKA6LPbKcYS/X/8JwoA4JP55dvzx/XV4QYuV1HoFE7/Y7vk=
X-Received: by 2002:a25:b218:0:b0:664:6da5:b5c5 with SMTP id
 i24-20020a25b218000000b006646da5b5c5mr32419923ybj.6.1655827823953; Tue, 21
 Jun 2022 09:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220620173843.1462198-1-daeho43@gmail.com> <20220620173843.1462198-2-daeho43@gmail.com>
 <YrEXmiRH+DcbW2EI@B-P7TQMD6M-0146.local>
In-Reply-To: <YrEXmiRH+DcbW2EI@B-P7TQMD6M-0146.local>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 21 Jun 2022 09:10:13 -0700
Message-ID: <CACOAw_zBi_TnOmqLZwBF9Zdd=0m7EkRP9M210BOrabh3L=7bqQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: handle decompress only post
 processing in softirq
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 5:58 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> On Mon, Jun 20, 2022 at 10:38:43AM -0700, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Now decompression is being handled in workqueue and it makes read I/O
> > latency non-deterministic, because of the non-deterministic scheduling
> > nature of workqueues. So, I made it handled in softirq context only if
> > possible, not in low memory devices, since this modification will
> > maintain decompresion related memory a little longer.
> >
>
> Again, I don't think this method scalable.  Since you already handle
> all decompression algorithms in this way.  Laterly, I wonder if you'd
> like to handle all:
>  - decompression algorithms;
>  - verity algorithms;
>  - decrypt algorithms;
>
> in this way, regardless of slow decompression algorithms, that would be a
> long latency and CPU overhead of softirq context.  This is my last words
> on this, I will not talk anymore.
>
> Thanks,
> Gao Xiang

I understand what you're worried about. However, verity cannot be
inlined because of its nature triggering I/Os. Except that, other twos
are almost inducing overhead comparable to memcpy. Still, decrypt part
is done in a H/W way mostly these days, though.

Thanks,
