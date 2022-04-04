Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9637D4F1770
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378198AbiDDOql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378938AbiDDOoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:44:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BAAB7C3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:38:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AA9D614E2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD67FC34114
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649083136;
        bh=XlJz6nqbt7DjoTGH/YZm/uYhk4Fzk2jZzYYIbhnu7tU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b/BpcpuIQyA66RP3b3+fwhSBV2aZeMb8MbmB6wcieItmRbE9hFMpupA9LOvdbW7m9
         RIuhyId/Q9JhAUUv8LhgC2FbOHOGW88Z41HLTTVN1WMwt5jBXJoxr966I/nlz0xqLQ
         8YQlmC5TWXqAF8lQ10TQgAKSRKk6QKlMqBeJzgKgp8+3LSjOu8mAu5igq/2m2FqhV3
         IXeJmBdjYxltv9fR2qKvJflcKo8LwH+y9pKYPVI4zhzmvzV7/M4ZdIfoO3+KJREmT2
         an2l8fuDuXoYWwqqdHtQ5Irg/MvapQSRIHR1QiIsWWx2GOh7tAtEKkdgIDKCo6AjaA
         RU6nX7OOL2eEQ==
Received: by mail-yb1-f180.google.com with SMTP id f38so17986474ybi.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 07:38:56 -0700 (PDT)
X-Gm-Message-State: AOAM531xl8TXbtKBybejE57PEuIqkXdP7jFDgOh43ckvOqjSIRTyyxky
        UzPCcrz+Lio7C+QPwqIrqyxxvBE1oGSwbmUKPU4=
X-Google-Smtp-Source: ABdhPJwyJxCjXq4QAZtDUpNHCQTjKXqZ+R3EJFnuPsF+yohUVFZbV8wPHSDkOxFq119l9+bjlK95RGdK+/EgFrJ+jWk=
X-Received: by 2002:a05:6902:572:b0:63d:a52c:d144 with SMTP id
 a18-20020a056902057200b0063da52cd144mr68991ybt.403.1649083135924; Mon, 04 Apr
 2022 07:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220404134859.3278599-1-linux@roeck-us.net>
In-Reply-To: <20220404134859.3278599-1-linux@roeck-us.net>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 4 Apr 2022 17:38:29 +0300
X-Gmail-Original-Message-ID: <CAFCwf10Nbpr1H1-qTx4kSyC6YFdeAb=xOfq6uKzejJKLuyKw5A@mail.gmail.com>
Message-ID: <CAFCwf10Nbpr1H1-qTx4kSyC6YFdeAb=xOfq6uKzejJKLuyKw5A@mail.gmail.com>
Subject: Re: [PATCH v2] habanalabs: Fix test build failures
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Ohad Sharabi <osharabi@habana.ai>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 4, 2022 at 4:49 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> allmodconfig builds on 32-bit architectures fail with the following error.
>
> drivers/misc/habanalabs/common/memory.c: In function 'alloc_device_memory':
> drivers/misc/habanalabs/common/memory.c:153:49: error:
>         cast from pointer to integer of different size
>
> Fix the typecast. While at it, drop other unnecessary typecasts associated
> with the same commit.
>
> Fixes: e8458e20e0a3c ("habanalabs: make sure device mem alloc is page aligned")
> Cc: Ohad Sharabi <osharabi@habana.ai>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Drop unnecessary (u64) typecasts
>
>  drivers/misc/habanalabs/common/memory.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
> index e008d82e4ba3..a13506dd8119 100644
> --- a/drivers/misc/habanalabs/common/memory.c
> +++ b/drivers/misc/habanalabs/common/memory.c
> @@ -111,10 +111,10 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
>
>         if (contiguous) {
>                 if (is_power_of_2(page_size))
> -                       paddr = (u64) (uintptr_t) gen_pool_dma_alloc_align(vm->dram_pg_pool,
> -                                                               total_size, NULL, page_size);
> +                       paddr = (uintptr_t) gen_pool_dma_alloc_align(vm->dram_pg_pool,
> +                                                                    total_size, NULL, page_size);
>                 else
> -                       paddr = (u64) (uintptr_t) gen_pool_alloc(vm->dram_pg_pool, total_size);
> +                       paddr = gen_pool_alloc(vm->dram_pg_pool, total_size);
>                 if (!paddr) {
>                         dev_err(hdev->dev,
>                                 "failed to allocate %llu contiguous pages with total size of %llu\n",
> @@ -150,12 +150,12 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
>                 for (i = 0 ; i < num_pgs ; i++) {
>                         if (is_power_of_2(page_size))
>                                 phys_pg_pack->pages[i] =
> -                                               (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
> -                                                                               page_size, NULL,
> -                                                                               page_size);
> +                                       (uintptr_t)gen_pool_dma_alloc_align(vm->dram_pg_pool,
> +                                                                           page_size, NULL,
> +                                                                           page_size);
>                         else
> -                               phys_pg_pack->pages[i] = (u64) gen_pool_alloc(vm->dram_pg_pool,
> -                                                                               page_size);
> +                               phys_pg_pack->pages[i] = gen_pool_alloc(vm->dram_pg_pool,
> +                                                                       page_size);
>                         if (!phys_pg_pack->pages[i]) {
>                                 dev_err(hdev->dev,
>                                         "Failed to allocate device memory (out of memory)\n");
> --
> 2.35.1
>

Hi Guenter,
Thanks for the patch, but Greg already merged a patch that was sent to him.
Oded
