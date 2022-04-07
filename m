Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2924F7BB5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238681AbiDGJeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbiDGJeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:34:31 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3F2F4635
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:32:30 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id j2so8639873ybu.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 02:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=62l7lWpaWnFmcE5KSw9n2JkqXdoamhD8Hh1gAz788Uk=;
        b=7Fjzbh/Sm8gK8nPro6LV1yjqabTxBJm9qCUowc7ncFl93HYSSGb9TiVbsEdolByulW
         ZLNWYJEfgx8FrYP+nw6wIKw2btBuNy8ozUjteagSt1oB9S0Gwklnc/YahTkGDoCAOVix
         igRidMJGzQkSVhJ8WyRhWtc5CPkC4PywYzDFRQbvSM9MfSW/NuRIFK+Vpmncji+7guox
         3twrJWYdvfKqfZ7HAuNlGEC1BFnSWQmX7d8lI/BeFue1mJqg24pYDaufEm4lQb1csQmD
         A5JApUHZ4D8oW4Rvs0vPoys0IxVWBR7SGOofo1Ws07IF6BHdGY1SKEdLygAspaXdMr2C
         2QGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=62l7lWpaWnFmcE5KSw9n2JkqXdoamhD8Hh1gAz788Uk=;
        b=dOCilzYti1RiaINmAICn3cVt0leT15O1tNNbexsqEeizn+K+ysL8/L/3o14gkQazGv
         0l6GB2+IbavM1aUFwvVyYNqU4PW+A0eMHZaoOq8U9mUmV6dzGpAdr6ouA4BA247PfXr3
         gFl2WjsqROL5zgxF2MP7FaBNRhX/2inANeRUGugKJ8fVZh/HI/m0YD149PiyVFxX0oFc
         L5UaYFr2PZjQlfkcSUeSbgSnIdJLjeX8kEyGYG0TnzD2f+UYfMwJBOq7R+xz2MHfNoJS
         KeYKVfuyvwHQnyhsx44pGL0g0AlyXQFp/UKkVk9UYRFIsmt0qTanPspSCGskJvNVlN+c
         Gv9A==
X-Gm-Message-State: AOAM533rLYk4Cf/+A/Q0I1K1YdQEHpCUWSzNR/RsaJ0w4aTk9SrL/bt8
        3WoL1P1xMOfD1xDhhKjhNCzMdUFrG442cOIe+HiFXAhSgbOZ+Q==
X-Google-Smtp-Source: ABdhPJxI566MWWnks/diHDfuyZ06GeRsNBqBd4+xL9zJswWBt/4Jez9cug6L1kUO3ogC8RY5GmBkb7nkHJVFFDzZ+ew=
X-Received: by 2002:a25:ab42:0:b0:633:883b:3e21 with SMTP id
 u60-20020a25ab42000000b00633883b3e21mr9941442ybi.132.1649323949480; Thu, 07
 Apr 2022 02:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220407064008.71869-1-pizhenwei@bytedance.com>
In-Reply-To: <20220407064008.71869-1-pizhenwei@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 7 Apr 2022 17:31:52 +0800
Message-ID: <CAMZfGtXr6rnjb4QR8Tce-WcTEWTDTwOjnCGDYV2NFooXDGxzyA@mail.gmail.com>
Subject: Re: [PATCH] mm: fix kernel NULL pointer dereference in page_vma_mapped_walk
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 2:43 PM zhenwei pi <pizhenwei@bytedance.com> wrote:
>
> size_to_hstate(4K) returns NULL pointer, this leads kernel BUG in
> function page_vma_mapped_walk.
>
>  BUG: kernel NULL pointer dereference, address: 0000000000000028
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 102a8b067 P4D 102a8b067 PUD 102a88067 PMD 0
>  Oops: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 0 PID: 16 Comm: kworker/0:1 Kdump: loaded Tainted: G   M        E     5.18.0-rc1.bm.1-amd64 #3
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>  Workqueue: events mce_gen_pool_process
>  RIP: 0010:page_vma_mapped_walk+0x4aa/0x850
>  Code: 8b 77 20 48 89 c2 4c 89 ef e8 b2 c4 02 00 49 89 c4 48 89 43 30 48 85 c0 0f 84 a7 fd ff ff 48 89 ef e8 fa 9c 02 00 49 8d 7d 74 <83> 78 28 09 0f 84 1e 03 00 00 48 89 7b 38 e8 a3 cc 60 00 48 89 df
>  RSP: 0018:ffffc9000008bc58 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: ffffc9000008bca0 RCX: 0000000000000009
>  RDX: 0000000000200000 RSI: ffffffff82b4a460 RDI: ffff88810ac5c3f4
>  RBP: 0000000000001000 R08: 0000000000001000 R09: 0000000000000000
>  R10: 0000000000000000 R11: 0000000000000007 R12: ffff888072cafd10
>  R13: ffff88810ac5c380 R14: ffff888101afc440 R15: 0000000000000000
>  FS:  0000000000000000(0000) GS:ffff88823fc00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000028 CR3: 0000000106ca2002 CR4: 0000000000772ef0
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   ? preempt_count_add+0x68/0xa0
>   page_mapped_in_vma+0xb4/0x230
>   collect_procs.part.35+0x11b/0x440
>   hwpoison_user_mappings+0x165/0x5b0
>   ? zone_pcp_enable+0x16/0x30
>   memory_failure+0xbea/0xd90
>   ? _printk+0x58/0x6f
>   uc_decode_notifier+0x4b/0xd0
>   blocking_notifier_call_chain+0x60/0x90
>   mce_gen_pool_process+0x3c/0x60
>   process_one_work+0x1c2/0x390
>   ? process_one_work+0x390/0x390
>   worker_thread+0x30/0x360
>   ? process_one_work+0x390/0x390
>   kthread+0xe6/0x110
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x1f/0x30
>   </TASK>
>
> Fixes: 2aff7a4755bed ("mm: Convert page_vma_mapped_walk to work on PFNs")
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>

Good catch.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
