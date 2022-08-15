Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1690359293E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiHOGBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbiHOGBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:01:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C770E167F0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:01:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8283FB80D26
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50611C4347C
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660543287;
        bh=XW8nwUdPudaWVo0dt//flSghPs1lU6OIRWxkvQWoIqw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sv7j+aHvAi18BT6kivLOfUMxwCAhU73Lnc+1NP2Y2HDduxjbS0IGFnJrzSNVbe8WO
         8BF/decj7HD7bJbSTWYjABQY497VJItPnpt9nNP+qvSQE9IhAY2yRwU/rcOczpTjtQ
         vUli3bZEer7LMZrkeQx62rMRSVY8INYx6beFf2ITlmbhRnpxN7svYcaZmJDibQdr7o
         FcfWM4L7/0WvYQLKJ/y3V8jLrxd7SNlbhmOveH3dBz6siU/y/GBgPlERQ+5wf3JPsc
         CRAeSXdzjUBJ6vB0XOUtxeEaJcoesBIK1KR2brw4fQR2Du5EVaUyAlPV289sPQ38fl
         qbN0gBGj0k+ww==
Received: by mail-oo1-f41.google.com with SMTP id c17-20020a4a8ed1000000b004452faec26dso1200843ool.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:01:27 -0700 (PDT)
X-Gm-Message-State: ACgBeo2uAgGo4m/cjUxfPkp7kgUk+1aFspj8FnXqYxfx0XosU/nQCq5b
        OLNjllouDCtp09sECfeScDz++Kb8RJA8V/FiP/w=
X-Google-Smtp-Source: AA6agR5iwPmXagsOQjUXh80oht6TfUGZOwhYiZqY+5DBc7JEirD/payJDDNA40HhHFxq8swN0i6THb+4pR707BXQto8=
X-Received: by 2002:a4a:434d:0:b0:441:9b4:ffad with SMTP id
 l13-20020a4a434d000000b0044109b4ffadmr4413232ooj.31.1660543286495; Sun, 14
 Aug 2022 23:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220815040554.1455722-1-chenhuacai@loongson.cn>
In-Reply-To: <20220815040554.1455722-1-chenhuacai@loongson.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 15 Aug 2022 14:01:13 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQjhyAp6bP3gu1JTFhOB4N63G3fWydNdFcQKUtYyvqDVg@mail.gmail.com>
Message-ID: <CAJF2gTQjhyAp6bP3gu1JTFhOB4N63G3fWydNdFcQKUtYyvqDVg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: mm: avoid unnecessary page fault retires on
 shared memory types
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
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

It's an optimization to shared memory types. Looks good.

Reviewed-by: Guo Ren <guoren@kernel.org>

On Mon, Aug 15, 2022 at 12:05 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> Commit d92725256b4f22d0 ("mm: avoid unnecessary page fault retires on
> shared memory types") modifies do_page_fault() to handle the VM_FAULT_
> COMPLETED case, but forget to change for LoongArch, so fix it as other
> architectures does.
>
> Fixes: d92725256b4f22d0 ("mm: avoid unnecessary page fault retires on shared memory types")
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/mm/fault.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
> index 605579b19a00..1ccd53655cab 100644
> --- a/arch/loongarch/mm/fault.c
> +++ b/arch/loongarch/mm/fault.c
> @@ -216,6 +216,10 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
>                 return;
>         }
>
> +       /* The fault is fully completed (including releasing mmap lock) */
> +       if (fault & VM_FAULT_COMPLETED)
> +               return;
> +
>         if (unlikely(fault & VM_FAULT_RETRY)) {
>                 flags |= FAULT_FLAG_TRIED;
>
> --
> 2.31.1
>


-- 
Best Regards
 Guo Ren
