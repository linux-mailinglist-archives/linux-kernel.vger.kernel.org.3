Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616F45B2884
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiIHVZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiIHVZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:25:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A35E9C217
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:25:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15704B822A3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 21:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6281AC433C1;
        Thu,  8 Sep 2022 21:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662672313;
        bh=PIkwN801hWDtiC90RvyMfOz9A3fCD2G50BPGSmF8eQg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=okDFr2aBiUNfcNhypfgsJPqPJRc9nV0bxDgmDYYW9Qq1xKz0E3Cdtw+0fuoUvNXfp
         1bw0yYAMvKkCjwbT4rtH6y0a08ADcMA2a0vLuI6HQp0ApugBfRNTC7DBMl2lk3G1uO
         uQ0WEP6Ijb8e9ag0I8g5yXtTYnqQUQNBw9E012ewMBgkVWrNq7O4cyvsCe4VxaLVMp
         4b44hugJ9nR04/F4un5dF75biEaeYm14zQKqgRob0fOE+o7TCFAOs8yBh687zQ5Z20
         b81HJNV7HJ+/diwsA/ojgnGXhEj5dXbTaYbx22CDgxs3idho6lvxAYULiVo/gJCDv4
         2UW190/hk89aQ==
Message-ID: <dbef29b2-ab0a-c3df-638c-381916a0d15a@kernel.org>
Date:   Thu, 8 Sep 2022 23:25:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] mm/slub: fix to return errno if kmalloc() fails
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>, Chao Yu <chao@kernel.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, jaegeuk@kernel.org,
        Chao Yu <chao.yu@oppo.com>, stable@kernel.org,
        syzbot+81684812ea68216e08c5@syzkaller.appspotmail.com,
        David Rientjes <rientjes@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>
References: <20220830141009.150075-1-chao@kernel.org>
 <BAC9CE6A-5873-429F-ACE2-E0A9E507D807@linux.dev>
From:   "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <BAC9CE6A-5873-429F-ACE2-E0A9E507D807@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/22 05:09, Muchun Song wrote:
> 
> 
>> On Aug 30, 2022, at 22:10, Chao Yu <chao@kernel.org> wrote:

Please use scripts/get_maintainer.pl next time, I could have missed this.

>> From: Chao Yu <chao.yu@oppo.com>
>> 
>> In create_unique_id(), kmalloc(, GFP_KERNEL) can fail due to
>> out-of-memory, if it fails, return errno correctly rather than
>> triggering panic via BUG_ON();
> 
> I tend to agree with you. A mount operation shouldn’t panic the
> kernel.

Hmm kmalloc(64) shouldn't normally due that due to the the underlying page
allocation falling into the "too small to fail" category, wonder if
syzkaller was doing anything special here?

But yeah we should get rid of all BUG_ONs eventually, just not sure if
stable@ is needed here.

>> 
>> kernel BUG at mm/slub.c:5893!
>> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>> 
>> Call trace:
>> sysfs_slab_add+0x258/0x260 mm/slub.c:5973
>> __kmem_cache_create+0x60/0x118 mm/slub.c:4899
>> create_cache mm/slab_common.c:229 [inline]
>> kmem_cache_create_usercopy+0x19c/0x31c mm/slab_common.c:335
>> kmem_cache_create+0x1c/0x28 mm/slab_common.c:390
>> f2fs_kmem_cache_create fs/f2fs/f2fs.h:2766 [inline]
>> f2fs_init_xattr_caches+0x78/0xb4 fs/f2fs/xattr.c:808
>> f2fs_fill_super+0x1050/0x1e0c fs/f2fs/super.c:4149
>> mount_bdev+0x1b8/0x210 fs/super.c:1400
>> f2fs_mount+0x44/0x58 fs/f2fs/super.c:4512
>> legacy_get_tree+0x30/0x74 fs/fs_context.c:610
>> vfs_get_tree+0x40/0x140 fs/super.c:1530
>> do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
>> path_mount+0x358/0x914 fs/namespace.c:3370
>> do_mount fs/namespace.c:3383 [inline]
>> __do_sys_mount fs/namespace.c:3591 [inline]
>> __se_sys_mount fs/namespace.c:3568 [inline]
>> __arm64_sys_mount+0x2f8/0x408 fs/namespace.c:3568
>> 
>> Cc: <stable@kernel.org>
>> Reported-by: syzbot+81684812ea68216e08c5@syzkaller.appspotmail.com
>> Signed-off-by: Chao Yu <chao.yu@oppo.com>
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> 
> Thanks.
> 
> 

