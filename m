Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5077D516903
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 02:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379230AbiEBAQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 20:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356170AbiEBAQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 20:16:51 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5388D50469
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 17:13:24 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso14884741pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 17:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=9R9pDWjRYUdR6pwNJcQ0BhfgQvycoYpQ1Dw84U1v8cI=;
        b=U19vS23LukiEuLMoapkp69LTWVJV0KGALWAFdzg7aIINUEMbbSyJlAdt214ftmsJKy
         b5s4aVb+usOqiuK3gMbsk2r452wCBBmosOWbCJjuui+3coFh1Ydb91n7yBJ0+BWRLyd4
         M18KDCgKoO9zPrr+2lEawjACZLTB+fe9UieGxC5S2Orjuc8MLrwE9bYNyQNlcSGDembS
         qrB+TneqZ5/Cxiy2pEn7hP1mtjnNHPJHgzfUyojjQBxCzYlk6Yzv/7FR9jOQfp2ISqb1
         4BcV0yS4cXArzF2s+GSW8f2PJr1EgEVWpeip1hU0w9DMO5wFFcccUFqwZxmV+J0SfZG6
         mkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=9R9pDWjRYUdR6pwNJcQ0BhfgQvycoYpQ1Dw84U1v8cI=;
        b=7oMlIG5E0LdZlenMAN0bQKzHUN+9Ee4clH1upavg8RaVtT88QiKGvOFFAxUNUTkkZ2
         Ze5ITp1yM9Fh3DH32antzjIFe7XCyd/kcBbGGKJmplmKzvKqO8bAxTZQ9aF4Pf7jQfRt
         5GXsErj4JHpITNQR+pVOvh0jJ3vgZ8WHYy5GDsRdcmT5y1JEaT/REYhEvMzDi92n8ePj
         9BS6J3Cz6osa6kqC6hxQgfSp7zSFRyrAetMyJyP59M6aKam7ELgVHmzJjCzh+qkcEV1m
         4VCwXlJM09Dws32lRsiG5ekTJzFtfH7PVG2IwBClu8izkkrBy551cZioRTFTDsTn4HFS
         3oPQ==
X-Gm-Message-State: AOAM5300vaXRJMemIJgsp/FX485wsP2LTNac/UGOTwjCML41+Nyq5zjc
        7aHkf7SdbqIWVMR+3tswcAxUeA==
X-Google-Smtp-Source: ABdhPJzw8TVyU1eweUd06dvUpu2vHox9CWqMTniqEgpck5aBJTB+93ZXTK/VG9qL0AsMgBN6GEhOQQ==
X-Received: by 2002:a17:902:aa46:b0:159:6cb:163 with SMTP id c6-20020a170902aa4600b0015906cb0163mr9152926plr.83.1651450403646;
        Sun, 01 May 2022 17:13:23 -0700 (PDT)
Received: from [2620:15c:29:204:e310:ef81:d548:9992] ([2620:15c:29:204:e310:ef81:d548:9992])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d90500b0015e8d4eb1fasm3384682plz.68.2022.05.01.17.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 17:13:23 -0700 (PDT)
Date:   Sun, 1 May 2022 17:13:22 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     andrey.konovalov@linux.dev
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 2/2] mm: slab: fix comment for
 __assume_kmalloc_alignment
In-Reply-To: <84d8142747230f2015eaf9705ee7c2e1a9f56596.1651161548.git.andreyknvl@google.com>
Message-ID: <fad4a239-c2bc-33ee-ca2e-f1f1cd6a5d79@google.com>
References: <fe1ca7a25a054b61d1038686d07569416e287e7b.1651161548.git.andreyknvl@google.com> <84d8142747230f2015eaf9705ee7c2e1a9f56596.1651161548.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022, andrey.konovalov@linux.dev wrote:

> From: Andrey Konovalov <andreyknvl@google.com>
> 
> The comment next to the __assume_kmalloc_alignment definition is not
> precise: kmalloc relies on kmem_cache_alloc, so kmalloc technically returns
> pointers aligned to both ARCH_KMALLOC_MINALIGN and ARCH_SLAB_MINALIGN,
> not only to ARCH_KMALLOC_MINALIGN.
> 
> (See create_kmalloc_cache()->create_boot_cache()->calculate_alignment()
>  for SLAB and SLUB and __do_kmalloc_node() for SLOB.)
> 
> Clarify the comment.
> 
> The assumption specified by __assume_kmalloc_alignment is still correct,
> although it can be made stronger. I'll leave this to a separate patch.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: David Rientjes <rientjes@google.com>
