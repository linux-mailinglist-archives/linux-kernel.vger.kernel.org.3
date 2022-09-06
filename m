Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AF15AF6E2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiIFVdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIFVdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:33:35 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD720B8F23
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:33:34 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 65so2438379pfx.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 14:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=ZGYMVwiUEuLgtCDiQ8JfQCJPv9C+qcRU1c030cWDM0I=;
        b=aK9f85kNRa+1y5yKwv2P5ffGl1MdLdYym3bJvNDQqFvl1BAGrABmVa4NGeLFAKyI4I
         LolMhPS6SJFzYs8R687/VEtDa6xfuNehAJkSlbiTM5KOq355WspKihLK3QY8Kq5zTHGX
         S9+xb3hU1ETK+YenJ3YLR36Uc4o/2LF4kfTqnVNwSFyR1iLQuPlhmXRqeZ00obBwGvmu
         kAYEpwpe39C2RyYWCnZxNx/5HgMWjpRnbgOr6l+SAGCBJI2wfmrp529QqzuqyD3BJPj0
         Xo+YU3nLQnH41+CaN5h+9GzwQq4uZgo3fajv1p004iqsKnDIXnu7lNmfVgfAgMQlf7PM
         m1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZGYMVwiUEuLgtCDiQ8JfQCJPv9C+qcRU1c030cWDM0I=;
        b=WhXR2mlp58JDIN8Au2dMNY+ntfWpW2xcnzXkSkU/O9JY62Q+qaUC1I7PsDIbZn6BKd
         5ry6q+Rml6dAQmLGoliyYTUq+rU8QA/wutBjBt7nWtT2lv8bf461wSF7xL4ZZv9I3SRU
         RA4d2zmmnutGBJmsnsTGMvMJjE+1glOpTyRkWD85ueTRn5q9BTtiTEFHltXpHmZNC0Yl
         2AnRHnGmIqMKsbcFofSSLJwQvQ463ooCI55lcO0Rk/h0IXcj4EHBsdcx1E2eBvyi3ykH
         yoHao+H3tdTDyN4Tp5W/HHRn8IMLj0av6GY7KQhAfCYGdSJobkmpRXGZKKfQ8aoCbSNH
         VyMg==
X-Gm-Message-State: ACgBeo1B3qbiSVA9arUK74su4+RaBtO12Gc7a80IlGfnWL1/AeGP7W4l
        AWTIevytQYqwmUBB4YID/O3kKh1Cp1rRaQ==
X-Google-Smtp-Source: AA6agR6Pt8dwvjHQ1jZb5gCP4MjBLzUhUsv4HzaDF9b2ihXBReQO2vBIYu8ZtERIRk87fhEXxlyVMw==
X-Received: by 2002:a62:be0e:0:b0:536:76fe:ee96 with SMTP id l14-20020a62be0e000000b0053676feee96mr389440pff.44.1662500014172;
        Tue, 06 Sep 2022 14:33:34 -0700 (PDT)
Received: from [2620:15c:29:203:9177:d472:6043:99cf] ([2620:15c:29:203:9177:d472:6043:99cf])
        by smtp.gmail.com with ESMTPSA id a25-20020a62d419000000b005366696b735sm10587853pfh.77.2022.09.06.14.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 14:33:33 -0700 (PDT)
Date:   Tue, 6 Sep 2022 14:33:32 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Chao Yu <chao@kernel.org>
cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, jaegeuk@kernel.org,
        Chao Yu <chao.yu@oppo.com>, stable@kernel.org,
        syzbot+81684812ea68216e08c5@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/slub: fix to return errno if kmalloc() fails
In-Reply-To: <20220830141009.150075-1-chao@kernel.org>
Message-ID: <cd671416-cff5-994b-01ea-2fc2b9cfba9c@google.com>
References: <20220830141009.150075-1-chao@kernel.org>
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

On Tue, 30 Aug 2022, Chao Yu wrote:

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
> Reported-by: syzbot+81684812ea68216e08c5@syzkaller.appspotmail.com
> Signed-off-by: Chao Yu <chao.yu@oppo.com>

Acked-by: David Rientjes <rientjes@google.com>
