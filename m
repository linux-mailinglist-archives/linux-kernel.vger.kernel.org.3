Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1585AF6E3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiIFVeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiIFVeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:34:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DD5BA178
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:34:03 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d12so12556873plr.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 14:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=IKhYcRnVpBMUy44Ky+OSn3unUvUJA/cx1qEki2e9zns=;
        b=aFdBWucaLdZEwZJ6WLrXWIoc4kVWR2vkVsDGZVeMbOQBPDDaWTB4yceHuwQB5jAOMK
         wIC+hC8xCsXUQzYyMl45qUbevm+f+Qvn3EsykPGsVUKT8mtYSe2d74FHpskmHtO4abe6
         SYd0EZuFi6TyVjTE+JCmqLeDq7cVweTo2/xc+4+rl6Esl5btQ8cgLy2avwdOgQ9u6783
         +MTl7act3MHNDxnAGjrQsjl+TZAyzM8D8xrbnjqBqkdKlHmd0b6K1OgohrNJCVFl17f6
         uwRNHdxkmdu5h4g8WbNh5QUfNVddLoPT3MAVaKjelVBHASDU1mbvSpoUXgp4ePr1Z6Cl
         dQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=IKhYcRnVpBMUy44Ky+OSn3unUvUJA/cx1qEki2e9zns=;
        b=R9pmX39xb6lZZEQgwOCJmxLn9heidZvbqcwRFllNh7UZjubmPOX88IUt/TiliA2tIq
         FN5Yslf44jHvyvrQKXOVvHUm1iW+wZMVeJM6h0WeySmqgkML06fTXomoIwJHZ8CaSNt1
         XxDctKQkVoGVhHCfv0a3E/nXFyjqVrRy63o+Ah23sbu9INTwVkUJaphkDF/OzOydDMxR
         tNvztbiTtpovxNK7FWhyqMbAatoLM2hjj8cYjupBaUURkiWWs21rEX9KmWwO3h6KjmHs
         KCh1IldwmAItwQnauTYMUbhN6vOQn7/9T6Ht/OOEvCriR8wvngfgPmpO6Ae70pSc+BY0
         CMjg==
X-Gm-Message-State: ACgBeo0EJFAl2fEFE4A94pTb1SygG9MN5kFQFAs8gaJYIvE1frfUf4PA
        j++aX+2xmuVM8wXxN9Ti84jeezjaAzY4SQ==
X-Google-Smtp-Source: AA6agR6wn83aAjSf0Y1qQOvYqA6bFaDA4t15O18lyRUAhJZFqVIuzshuuA2LhtTdC7TFKV2qwRz9lw==
X-Received: by 2002:a17:902:8f8a:b0:16f:975e:7c6e with SMTP id z10-20020a1709028f8a00b0016f975e7c6emr486509plo.136.1662500042888;
        Tue, 06 Sep 2022 14:34:02 -0700 (PDT)
Received: from [2620:15c:29:203:9177:d472:6043:99cf] ([2620:15c:29:203:9177:d472:6043:99cf])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b0017543086eb3sm10510787plg.274.2022.09.06.14.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 14:34:01 -0700 (PDT)
Date:   Tue, 6 Sep 2022 14:34:01 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Chao Yu <chao@kernel.org>
cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, jaegeuk@kernel.org,
        Chao Yu <chao.yu@oppo.com>, stable@kernel.org,
        syzbot+81684812ea68216e08c5@syzkaller.appspotmail.com,
        Muchun Song <songmuchun@bytedance.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH v2] mm/slub: fix to return errno if kmalloc() fails
In-Reply-To: <20220831145454.858200-1-chao@kernel.org>
Message-ID: <996c5407-711e-18e5-79e1-995afbd6c151@google.com>
References: <20220831145454.858200-1-chao@kernel.org>
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

On Wed, 31 Aug 2022, Chao Yu wrote:

> From: Chao Yu <chao.yu@oppo.com>
> 
> In create_unique_id(), kmalloc(, GFP_KERNEL) can fail due to
> out-of-memory, if it fails, return errno correctly rather than
> triggering panic via BUG_ON();
> 
> kernel BUG at mm/slub.c:5893!
> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> 
> Call trace:
>  sysfs_slab_add+0x258/0x260 mm/slub.c:5973
>  __kmem_cache_create+0x60/0x118 mm/slub.c:4899
>  create_cache mm/slab_common.c:229 [inline]
>  kmem_cache_create_usercopy+0x19c/0x31c mm/slab_common.c:335
>  kmem_cache_create+0x1c/0x28 mm/slab_common.c:390
>  f2fs_kmem_cache_create fs/f2fs/f2fs.h:2766 [inline]
>  f2fs_init_xattr_caches+0x78/0xb4 fs/f2fs/xattr.c:808
>  f2fs_fill_super+0x1050/0x1e0c fs/f2fs/super.c:4149
>  mount_bdev+0x1b8/0x210 fs/super.c:1400
>  f2fs_mount+0x44/0x58 fs/f2fs/super.c:4512
>  legacy_get_tree+0x30/0x74 fs/fs_context.c:610
>  vfs_get_tree+0x40/0x140 fs/super.c:1530
>  do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
>  path_mount+0x358/0x914 fs/namespace.c:3370
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount fs/namespace.c:3568 [inline]
>  __arm64_sys_mount+0x2f8/0x408 fs/namespace.c:3568
> 
> Cc: <stable@kernel.org>
> Fixes: 81819f0fc8285 ("SLUB core")
> Reported-by: syzbot+81684812ea68216e08c5@syzkaller.appspotmail.com
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Signed-off-by: Chao Yu <chao.yu@oppo.com>

Acked-by: David Rientjes <rientjes@google.com>
