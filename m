Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3364552018D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbiEIPwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238529AbiEIPwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:52:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D8672D76E7
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652111320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t41mLb2CHoozgZBbJV2mqxblkUXL3qgQ9BaS0ec36pA=;
        b=GqrnichxuzzoFhFp9vsdwUNagoGoumxv+LtFYRF48pUli2oyAS9AIksk4oLoWukG6gw4NV
        0msD7nyTElo6fBl2Uz9kvXkvE4S3d7f70co4sOrQxd5+dqyXk6OJ+gtwWQN8cEREe4EUNC
        7EncwWMflYyS0w6s4poxLWmvw2bY04k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-7hH4sju1OWekDDaQwxs_FQ-1; Mon, 09 May 2022 11:48:29 -0400
X-MC-Unique: 7hH4sju1OWekDDaQwxs_FQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58FB5801E80;
        Mon,  9 May 2022 15:48:29 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 204714010E40;
        Mon,  9 May 2022 15:48:29 +0000 (UTC)
Message-ID: <d5a9d228-df0a-2209-618f-c963c62f0e24@redhat.com>
Date:   Mon, 9 May 2022 11:48:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] mm/page_owner: use strscpy() instead of strlcpy()
Content-Language: en-US
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>
References: <20220509145949.265184-1-eric.dumazet@gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220509145949.265184-1-eric.dumazet@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/22 10:59, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
>
> current->comm[] is not a string (no guarantee for
> a zero byte in it).
>
> strlcpy(s1, s2, l) is calling strlen(s2), potentially
> causing out-of-bound access, as reported by syzbot:
>
> detected buffer overflow in __fortify_strlen
> ------------[ cut here ]------------
> kernel BUG at lib/string_helpers.c:980!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 4087 Comm: dhcpcd-run-hooks Not tainted 5.18.0-rc3-syzkaller-01537-g20b87e7c29df #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:fortify_panic+0x18/0x1a lib/string_helpers.c:980
> Code: 8c e8 c5 ba e1 fa e9 23 0f bf fa e8 0b 5d 8c f8 eb db 55 48 89 fd e8 e0 49 40 f8 48 89 ee 48 c7 c7 80 f5 26 8a e8 99 09 f1 ff <0f> 0b e8 ca 49 40 f8 48 8b 54 24 18 4c 89 f1 48 c7 c7 00 00 27 8a
> RSP: 0018:ffffc900000074a8 EFLAGS: 00010286
>
> RAX: 000000000000002c RBX: ffff88801226b728 RCX: 0000000000000000
> RDX: ffff8880198e0000 RSI: ffffffff81600458 RDI: fffff52000000e87
> RBP: ffffffff89da2aa0 R08: 000000000000002c R09: 0000000000000000
> R10: ffffffff815fae2e R11: 0000000000000000 R12: ffff88801226b700
> R13: ffff8880198e0830 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f5876ad6ff8 CR3: 000000001a48c000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> Call Trace:
>   <IRQ>
>   __fortify_strlen include/linux/fortify-string.h:128 [inline]
>   strlcpy include/linux/fortify-string.h:143 [inline]
>   __set_page_owner_handle+0x2b1/0x3e0 mm/page_owner.c:171
>   __set_page_owner+0x3e/0x50 mm/page_owner.c:190
>   prep_new_page mm/page_alloc.c:2441 [inline]
>   get_page_from_freelist+0xba2/0x3e00 mm/page_alloc.c:4182
>   __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5408
>   alloc_pages+0x1aa/0x310 mm/mempolicy.c:2272
>   alloc_slab_page mm/slub.c:1799 [inline]
>   allocate_slab+0x26c/0x3c0 mm/slub.c:1944
>   new_slab mm/slub.c:2004 [inline]
>   ___slab_alloc+0x8df/0xf20 mm/slub.c:3005
>   __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3092
>   slab_alloc_node mm/slub.c:3183 [inline]
>   slab_alloc mm/slub.c:3225 [inline]
>   __kmem_cache_alloc_lru mm/slub.c:3232 [inline]
>   kmem_cache_alloc+0x360/0x3b0 mm/slub.c:3242
>   dst_alloc+0x146/0x1f0 net/core/dst.c:92
>
> Fixes: 865ed6a32786 ("mm/page_owner: record task command name")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Cc: Waiman Long <longman@redhat.com>
> ---
>   mm/page_owner.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index fb3a05fdebdbf1c3646ba1584cbf06facf0e7a9a..19bc559e49040e60c03a5f4268c89618fa0f1b1c 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -168,7 +168,7 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
>   		page_owner->pid = current->pid;
>   		page_owner->tgid = current->tgid;
>   		page_owner->ts_nsec = local_clock();
> -		strlcpy(page_owner->comm, current->comm,
> +		strscpy(page_owner->comm, current->comm,
>   			sizeof(page_owner->comm));
>   		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
>   		__set_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);

Yes, I think it is more correct to use strscpy().

Acked-by: Waiman Long <longman@redhat.com>

Thanks,
Longman

