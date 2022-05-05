Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C1251C3FC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381375AbiEEPfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243039AbiEEPfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:35:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7113B2A3;
        Thu,  5 May 2022 08:31:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE55C61CEB;
        Thu,  5 May 2022 15:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBACC385AE;
        Thu,  5 May 2022 15:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651764678;
        bh=sPIo4DFRBYDXNLF9h52050tG2IIqnqgkCur/2xVX4RY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IuEL6pCf+Eii24RzycPRwG0r4ohcorRk6bDSYHA40PghP1aqdXmFTE4NMDazOaoM+
         Vq56pNXFGt6/X2NN14zCRqcEaUBeNXUT7ktjgNEhW7RVk53ZcWKYObq5XOd3BcW1cM
         dlWLWny3HWBxTrZ9cIjfBJNVUC9U/uwbeXeSzRDSpgg5aIGteFDop8srQVh+0wSbS1
         q/UoCIjzEWjTz3jxO3iduBPL5MjtbRrEQycA/PgLmSghRzTqi/edXyiiVKaXuuTMEQ
         za8tLZg4k7/fLyqpYkd/+S3eJJwP2rNXBJ7voenBSl9tsWbdXzH08VkHnVMnPeox9D
         0+JNUUCfhu9YA==
Received: by mail-pf1-f173.google.com with SMTP id i24so3911736pfa.7;
        Thu, 05 May 2022 08:31:18 -0700 (PDT)
X-Gm-Message-State: AOAM531XspIzYmJAz5as66ztBA5eV55/A0eh3nO7n7tdX8gMEOGtuswp
        mLQm7fouD7E1mOZVU1c7E4dxGDh17MyYcQT64g==
X-Google-Smtp-Source: ABdhPJwSOuGri32j9UE9tHP99j3+jizUJpjlElDHAjjsjaVe4nVM8XEUeJjxcwZYmriEW9V8tFEBkPx2tFnqxBg0TV0=
X-Received: by 2002:aa7:9519:0:b0:510:5175:7649 with SMTP id
 b25-20020aa79519000000b0051051757649mr5997617pfp.15.1651764677741; Thu, 05
 May 2022 08:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <1649704172-13181-1-git-send-email-quic_faiyazm@quicinc.com>
 <YlW2TO0O8qDHpkGW@kernel.org> <7b18bea8-b996-601d-f490-cb8aadfffa1b@quicinc.com>
In-Reply-To: <7b18bea8-b996-601d-f490-cb8aadfffa1b@quicinc.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 5 May 2022 10:31:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKc07YZ=b5mKcw1+3Gtu+Le2H-gezAdnthh9JNyRfdngg@mail.gmail.com>
Message-ID: <CAL_JsqKc07YZ=b5mKcw1+3Gtu+Le2H-gezAdnthh9JNyRfdngg@mail.gmail.com>
Subject: Re: [PATCH] mm: memblock: avoid to create memmap for memblock nomap regions
To:     Faiyaz Mohammed <quic_faiyazm@quicinc.com>
Cc:     Mike Rapoport <rppt@kernel.org>, quic_vjitta@quicinc.com,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Quentin Perret <qperret@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 10:17 AM Faiyaz Mohammed
<quic_faiyazm@quicinc.com> wrote:
>
>
> On 4/12/2022 10:56 PM, Mike Rapoport wrote:
> > On Tue, Apr 12, 2022 at 12:39:32AM +0530, Faiyaz Mohammed wrote:
> >> This 'commit 86588296acbf ("fdt: Properly handle "no-map" field in the
> >> memory region")' is keeping the no-map regions in memblock.memory with
> >> MEMBLOCK_NOMAP flag set to use no-map memory for EFI using memblock api's,
> >> but during the initialization sparse_init mark all memblock.memory as
> >> present using for_each_mem_pfn_range, which is creating the memmap for
> >> no-map memblock regions. To avoid it skiping the memblock.memory regions
> >> set with MEMBLOCK_NOMAP set and with this change we will be able to save
> >> ~11MB memory for ~612MB carve out.
> > The MEMBLOCK_NOMAP is very fragile and caused a lot of issues already. I
> > really don't like the idea if adding more implicit assumptions about how
> > NOMAP memory may or may not be used in a generic iterator function.
>
> Sorry for delayed response.
> Yes, it is possible that implicit assumption can create
> misunderstanding. How about adding command line option and control the
> no-map region in fdt.c driver, to decide whether to keep "no-map" region
> with NOMAP flag or remove?. Something like below

No. That just added another dimension to the test matrix. Having
things from multiple sources is always a mess.

>
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1180,8 +1180,10 @@ int __init __weak
> early_init_dt_reserve_memory_arch(phys_addr_t base,
>                  */
>                 if (memblock_is_region_reserved(base, size))
>                         return -EBUSY;
> -
> -               return memblock_mark_nomap(base, size);
> +               if (remove_nomap_region)
> +                       return memblock_remove(base, size);
> +               else
> +                       return memblock_mark_nomap(base, size);
> Thanks and regards,
> Mohammed Faiyaz
>
