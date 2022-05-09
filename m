Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B6A5201AB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbiEIP4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238754AbiEIP4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:56:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA3E1C5E28
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:52:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d22-20020a25add6000000b00645d796034fso12384516ybe.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 08:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EthTtQDUrpipFQD0rJkKc9pv5XwzIQQETVz7McYZec8=;
        b=F4CoU8RsUWJt8MVDcuBdI5IyacBfsKkDmbyWBR5agiSrMiC/IVNzjZ6qBTm/mZ40aJ
         fq6Lpqp2jeogdEk8rH0PfMrAj6vMm+UfwSwelQwmZ3voD8UXZZ9oQ3jpn/h8wsQWXpMc
         OaxlfEGCVT88Lr2Idc3VrEcdjunkpAR53p0kE7fvnswo3paZtL/kINTLJDzXYwMdiIj2
         dSMGI7Ye9u0juN3ppXUfZd9g8NvgEaobKX9WEvLcu6vBivbGlvon9AUpRNmrcOmc3JZX
         CLSA+iBP/8GUKFzVkCfuWNFl8HPc2vM8GSE2V6/Uy7gL0+M1lQeXiC486Wtjxr+SIhx0
         mCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EthTtQDUrpipFQD0rJkKc9pv5XwzIQQETVz7McYZec8=;
        b=hlcegoII70f9/xLv+EhjaRl/kjjdnrHtj+a059edPJG0nFHDlcitv1x8mPa5t3TLWC
         WdqFvL4hfNm/erxhEKlooEbr/SnbU+r1fIpDj5jK6yfL3+By3FlDU1FSdXHb/+gIdh5k
         2eRZKVP7ffMjCV18lMQqyzqVaesLppezqLfXftAkDmKxN2osKcnw8LeJhJ4hyvvflVR3
         CQSgGvg5Kimb7NpDbg6s/USi+KaN98a17uhjuJHJYiu1Cockvq280HPfg5U2mF5UTpwt
         zj+7WRJCASQ7ap/2slVv92p7n8UPUOjuwyXeY7rNTLz++1mbZH8mayHS3VawVPi/7XNe
         o5Ew==
X-Gm-Message-State: AOAM531unTKLeVoJXYrE3A4nZF+qzxUKkNvDmS+PL8oBDDy0oXo1muOR
        ZYhAvSYc8IWfcMloRzKxWxshi2AogK+nNA==
X-Google-Smtp-Source: ABdhPJwMSobU5lLkP9gFyup+2NqUl4oDxUipxzjeiKvjpxFz3dmc9pf3/U7cmesVAWBdnF3PlNijKQW2UZlbuA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a25:5085:0:b0:648:efed:a38a with SMTP id
 e127-20020a255085000000b00648efeda38amr12991226ybb.208.1652111532350; Mon, 09
 May 2022 08:52:12 -0700 (PDT)
Date:   Mon, 9 May 2022 15:52:09 +0000
In-Reply-To: <20220509145949.265184-1-eric.dumazet@gmail.com>
Message-Id: <20220509155209.5gilgrvntpt5vlf5@google.com>
Mime-Version: 1.0
References: <20220509145949.265184-1-eric.dumazet@gmail.com>
Subject: Re: [PATCH] mm/page_owner: use strscpy() instead of strlcpy()
From:   Shakeel Butt <shakeelb@google.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 07:59:49AM -0700, Eric Dumazet wrote:
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
>  <IRQ>
>  __fortify_strlen include/linux/fortify-string.h:128 [inline]
>  strlcpy include/linux/fortify-string.h:143 [inline]
>  __set_page_owner_handle+0x2b1/0x3e0 mm/page_owner.c:171
>  __set_page_owner+0x3e/0x50 mm/page_owner.c:190
>  prep_new_page mm/page_alloc.c:2441 [inline]
>  get_page_from_freelist+0xba2/0x3e00 mm/page_alloc.c:4182
>  __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5408
>  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2272
>  alloc_slab_page mm/slub.c:1799 [inline]
>  allocate_slab+0x26c/0x3c0 mm/slub.c:1944
>  new_slab mm/slub.c:2004 [inline]
>  ___slab_alloc+0x8df/0xf20 mm/slub.c:3005
>  __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3092
>  slab_alloc_node mm/slub.c:3183 [inline]
>  slab_alloc mm/slub.c:3225 [inline]
>  __kmem_cache_alloc_lru mm/slub.c:3232 [inline]
>  kmem_cache_alloc+0x360/0x3b0 mm/slub.c:3242
>  dst_alloc+0x146/0x1f0 net/core/dst.c:92
> 
> Fixes: 865ed6a32786 ("mm/page_owner: record task command name")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Cc: Waiman Long <longman@redhat.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
