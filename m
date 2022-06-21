Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A891552B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346821AbiFUHSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345379AbiFUHSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:18:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C467631C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:17:58 -0700 (PDT)
X-UUID: 073fb03cba0f492da81bfb9d16a26fae-20220621
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:f4cf376d-e335-4209-9b4a-1699ca9b5cce,OB:0,LO
        B:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:51
X-CID-INFO: VERSION:1.1.6,REQID:f4cf376d-e335-4209-9b4a-1699ca9b5cce,OB:0,LOB:
        10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:51
X-CID-META: VersionHash:b14ad71,CLOUDID:278e16ea-f7af-4e69-92ee-0fd74a0c286c,C
        OID:801f2789e3b7,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 073fb03cba0f492da81bfb9d16a26fae-20220621
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 866569992; Tue, 21 Jun 2022 15:17:53 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 21 Jun 2022 15:17:52 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 21 Jun 2022 15:17:52 +0800
Message-ID: <5949bc710889be1324d5dada995a263fd3c29cb5.camel@mediatek.com>
Subject: Re: [PATCH 21/32] kasan: simplify invalid-free reporting
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     "andrey.konovalov@linux.dev" <andrey.konovalov@linux.dev>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
CC:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "Peter Collingbourne" <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 21 Jun 2022 15:17:52 +0800
In-Reply-To: <f7f5cfc5eb8f1a1f849665641b9dd2cfb4a62c3c.1655150842.git.andreyknvl@google.com>
References: <cover.1655150842.git.andreyknvl@google.com>
         <f7f5cfc5eb8f1a1f849665641b9dd2cfb4a62c3c.1655150842.git.andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-14 at 04:14 +0800, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Right now, KASAN uses the kasan_report_type enum to describe report
> types.
> 
> As this enum only has two options, replace it with a bool variable.
> 
> Also, unify printing report header for invalid-free and other bug
> types
> in print_error_description().
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/kasan/kasan.h  |  7 +------
>  mm/kasan/report.c | 16 +++++++---------
>  2 files changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index e8329935fbfb..f696d50b09fb 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -146,16 +146,11 @@ static inline bool kasan_requires_meta(void)
>  #define META_MEM_BYTES_PER_ROW (META_BYTES_PER_ROW *
> KASAN_GRANULE_SIZE)
>  #define META_ROWS_AROUND_ADDR 2
> 
> -enum kasan_report_type {
> -       KASAN_REPORT_ACCESS,
> -       KASAN_REPORT_INVALID_FREE,
> -};
> -
>  struct kasan_report_info {
> -       enum kasan_report_type type;
>         void *access_addr;
>         void *first_bad_addr;
>         size_t access_size;
> +       bool is_free;
>         bool is_write;
>         unsigned long ip;
>  };
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index f951fd39db74..7269b6249488 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -175,14 +175,12 @@ static void end_report(unsigned long *flags,
> void *addr)
> 

Hi Andrey,

Do we need to distinguish "double free" case from "invalid free" or
we just print "double-free or invalid-free"?

I sent a patch[1] to separate double free case from invalid
free last week and I saw it has been merged into akpm tree.

[1] 
https://lore.kernel.org/linux-mm/20220615062219.22618-1-Kuan-Ying.Lee@mediatek.com/

Thanks,
Kuan-Ying Lee

>  static void print_error_description(struct kasan_report_info *info)
>  {
> -       if (info->type == KASAN_REPORT_INVALID_FREE) {
> -               pr_err("BUG: KASAN: double-free or invalid-free in
> %pS\n",
> -                      (void *)info->ip);
> -               return;
> -       }
> +       const char *bug_type = info->is_free ?
> +               "double-free or invalid-free" :
> kasan_get_bug_type(info);
> 
> -       pr_err("BUG: KASAN: %s in %pS\n",
> -               kasan_get_bug_type(info), (void *)info->ip);
> +       pr_err("BUG: KASAN: %s in %pS\n", bug_type, (void *)info-
> >ip);
> +       if (info->is_free)
> +               return;
>         if (info->access_size)
>                 pr_err("%s of size %zu at addr %px by task %s/%d\n",
>                         info->is_write ? "Write" : "Read", info-
> >access_size,
> @@ -435,11 +433,11 @@ void kasan_report_invalid_free(void *ptr,
> unsigned long ip)
> 
>         start_report(&flags, true);
> 
> -       info.type = KASAN_REPORT_INVALID_FREE;
>         info.access_addr = ptr;
>         info.first_bad_addr = kasan_reset_tag(ptr);
>         info.access_size = 0;
>         info.is_write = false;
> +       info.is_free = true;
>         info.ip = ip;
> 
>         print_report(&info);
> @@ -468,11 +466,11 @@ bool kasan_report(unsigned long addr, size_t
> size, bool is_write,
> 
>         start_report(&irq_flags, true);
> 
> -       info.type = KASAN_REPORT_ACCESS;
>         info.access_addr = ptr;
>         info.first_bad_addr = kasan_find_first_bad_addr(ptr, size);
>         info.access_size = size;
>         info.is_write = is_write;
> +       info.is_free = false;
>         info.ip = ip;
> 
>         print_report(&info);
> --
> 2.25.1
> 
> 

