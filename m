Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2777D51BB6A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351302AbiEEJLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345965AbiEEJK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:10:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D194B856
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 02:07:16 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c11so3799830plg.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 02:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vzFHg7LpC1f5IJb8pgP21cVA3EcMC1zK7MvlkX40SCk=;
        b=0YBWTe/JXyCFcM7dhTqyErMW3J9fHg4Anp14lNd9keICEzbNRzMsbp1T8DPiHhbfMv
         a0bGSiyzndhBZwBq+K0b3Qq7+oRYgL6+f6369FDR9IduzUWXHPXAiXFJMGIyBYbZzMrW
         V5FvnqJDLHHZO1Q8I5HstF1+xNYXYmqQ8uplY9nsdXwB0nOMo/JfIDoa1ykKZ8Cq2tpO
         97SrgRGCW8HcZshF9yuXh41LzIk+0TwKXcYq1DIra3TIHyRct1VT4MCS3DM+xGRnPgmA
         pAq0Bfb9tU2FCHyWHWASEsX6mJHv1YxTW6YEtdshodnyc2Dehfjo5tf1MuGyDwtD5/oM
         EX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vzFHg7LpC1f5IJb8pgP21cVA3EcMC1zK7MvlkX40SCk=;
        b=KC33h/B0Isj3VfzBP4fdcWC9k236O/klq8eNf2cx2goVA8oJDt7mSR7wfrAmwGLZpq
         wmqUsfEGWcxPftIZ01qBTlyDjeXmfr/ACve+cU+1ZnLQW3nwsuAUct9baz74Mb375GVt
         HIw993EwOeSCo0d8RHfXsqbfNs9VnbdnKZSX3Mj0Ad6MgIU/OzAP6g1g6vzt4vjL1Eyg
         0VP5Uq98ijPa9Pju/hSjGB0iyFkurF1PPR+vxvKOcgB/TKkctD1x/hfMtglDEWSs/EJ5
         qZEZh6gkwYWviGLBb1ue3l1b9l91nbkbxvefUZ6aqh4KfDmKjLA9u+S9U37y2BtalrP5
         2Imw==
X-Gm-Message-State: AOAM533qvnp27feOWMDYY8SaDXbXJqplZBJvi0npeoYPkSH1p9xBOp9S
        6TX57iFFJIs7Tbdg6l0p94RMxQ==
X-Google-Smtp-Source: ABdhPJxPyTqYYsJ3ZFTfoesmL2tSuqns/ua0YMiyZo59qZCgtFrdEHC3JJIqM/k72EfBi6XJJHvaRw==
X-Received: by 2002:a17:902:eacd:b0:15c:17fc:31e with SMTP id p13-20020a170902eacd00b0015c17fc031emr26338349pld.4.1651741636318;
        Thu, 05 May 2022 02:07:16 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id 145-20020a630297000000b003c14af505edsm821011pgc.5.2022.05.05.02.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 02:07:16 -0700 (PDT)
Date:   Thu, 5 May 2022 17:07:12 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/kfence: reset PG_slab and memcg_data before
 freeing __kfence_pool
Message-ID: <YnOTwJhB/Eq1FSqM@FVFYT0MHHV2J.googleapis.com>
References: <20220505070105.1835745-1-42.hyeyoo@gmail.com>
 <20220505073920.1880661-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505073920.1880661-1-42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 04:39:20PM +0900, Hyeonggon Yoo wrote:
> When kfence fails to initialize kfence pool, it frees the pool.
> But it does not reset PG_slab flag and memcg_data of struct page.
> 
> Below is a BUG because of this. Let's fix it by resetting PG_slab
> and memcg_data before free.
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

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
