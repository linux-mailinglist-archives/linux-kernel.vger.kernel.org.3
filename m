Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0026F51C1E6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380447AbiEEOKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380450AbiEEOKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:10:18 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58DD44A19
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 07:06:36 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t13so3710063pgn.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 07:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q2ljtViJ97MO8Fx257qphwHt+nQ75TNnUf7PUXRqZ2w=;
        b=aOqVKnxxHjfkSNNgo6dj5GOX2bAnYy0by0tdOKMfYjFbgycrfiKPTwxwN1MUesuXpd
         Cd59l4npDzVpoxEUGc/CsE75OtHmFyiOsdCpUnF6ucK+EOQJbIGMNpSbDpnqfdulYYmj
         CZBBBQ4phmsavwma1uOMH1scQdFF+Qwm1CZDoCgUc1/HXorv7AqJSM0/jrNppluwT62k
         6EGnB9xAnfmOid66q/w83ckrkWDRj6yniG2HEtcH5x0A1OwXGRqlv+l5C3zLXzi1e1h1
         PlAI9ijpLeAToeMi2imNIX2jliyQicYyNSB88OqqIJvWylKlGB4oBeIlJ71XQrBL+0Tn
         uRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q2ljtViJ97MO8Fx257qphwHt+nQ75TNnUf7PUXRqZ2w=;
        b=zahV98fyWt/MAfiVu6pzER+Q0Tn+YkDtFSes6yPWUXsBOZqFz8YB7VJAqRKjrfyFwA
         hR4zDCeA+3I1p1HxLrxJIK/Z0B1EywodzRnY2y6e7mCctW+znVb05P8+85kNQ9ER35Qt
         5baVsG3Ep/xFO4XFwZBTd0u2JyDX+oo3zo4o8mv5CRt9XK6pn1v2vSybYpHRHeplaiCr
         F9rjvi0rXN7xf7nYSUv1aI87nsUz1mRXMtcNKRP0coCxEtB5dob9xI1ySor4U6CQFir1
         DpPMDQPeaejUu2TBkjnPRoQB8pczfdYDdDZkvhjzBe3iakv3XDV7c7h2Ept2k5WkaDaA
         OdQw==
X-Gm-Message-State: AOAM533FP8JvPQY0I68rT/nKMOq6CSVRAatgu5/T96St+di3veaGv9kQ
        6FHPDEMkzgVXggqEn0nrecs7Sqr/LIayBg==
X-Google-Smtp-Source: ABdhPJxrGj5lRIZdvSqmPTjoHxM6GE1WuxbKRCnPdk5AEc1NL/F2SsECH09Pl7Da4LnsHVdqpNeUpg==
X-Received: by 2002:a05:6a00:248d:b0:510:5d7d:18ab with SMTP id c13-20020a056a00248d00b005105d7d18abmr3713300pfv.51.1651759596369;
        Thu, 05 May 2022 07:06:36 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:717f:b863:7c3d:2306])
        by smtp.gmail.com with ESMTPSA id m17-20020aa79011000000b0050dc7628177sm1410071pfo.81.2022.05.05.07.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 07:06:36 -0700 (PDT)
Date:   Thu, 5 May 2022 22:06:33 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm/kfence: reset PG_slab and memcg_data before
 freeing __kfence_pool
Message-ID: <YnPZ6ZWS2UTIZUWp@FVFYT0MHHV2J.googleapis.com>
References: <YnPG3pQrqfcgOlVa@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnPG3pQrqfcgOlVa@hyeyoo>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 09:45:18PM +0900, Hyeonggon Yoo wrote:
> When kfence fails to initialize kfence pool, it frees the pool.
> But it does not reset memcg_data and PG_slab flag.
> 
> Below is a BUG because of this. Let's fix it by resetting memcg_data
> and PG_slab flag before free.
> 
> [    0.089149] BUG: Bad page state in process swapper/0  pfn:3d8e06
> [    0.089149] page:ffffea46cf638180 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3d8e06
> [    0.089150] memcg:ffffffff94a475d1
> [    0.089150] flags: 0x17ffffc0000200(slab|node=0|zone=2|lastcpupid=0x1fffff)
> [    0.089151] raw: 0017ffffc0000200 ffffea46cf638188 ffffea46cf638188 0000000000000000
> [    0.089152] raw: 0000000000000000 0000000000000000 00000000ffffffff ffffffff94a475d1
> [    0.089152] page dumped because: page still charged to cgroup
> [    0.089153] Modules linked in:
> [    0.089153] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B   W         5.18.0-rc1+ #965
> [    0.089154] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> [    0.089154] Call Trace:
> [    0.089155]  <TASK>
> [    0.089155]  dump_stack_lvl+0x49/0x5f
> [    0.089157]  dump_stack+0x10/0x12
> [    0.089158]  bad_page.cold+0x63/0x94
> [    0.089159]  check_free_page_bad+0x66/0x70
> [    0.089160]  __free_pages_ok+0x423/0x530
> [    0.089161]  __free_pages_core+0x8e/0xa0
> [    0.089162]  memblock_free_pages+0x10/0x12
> [    0.089164]  memblock_free_late+0x8f/0xb9
> [    0.089165]  kfence_init+0x68/0x92
> [    0.089166]  start_kernel+0x789/0x992
> [    0.089167]  x86_64_start_reservations+0x24/0x26
> [    0.089168]  x86_64_start_kernel+0xa9/0xaf
> [    0.089170]  secondary_startup_64_no_verify+0xd5/0xdb
> [    0.089171]  </TASK>
> 
> Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
> Fixes: 8f0b36497303 ("mm: kfence: fix objcgs vector allocation")
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>

Thanks for your work on this.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
