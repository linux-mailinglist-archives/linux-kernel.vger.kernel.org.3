Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F95B4E22E1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345617AbiCUJEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344263AbiCUJEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:04:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40AA1401D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:03:01 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id pv16so28519882ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S7Ih0GIdL2IRJV2P9aqSBBoFQM0S6/aadePd/xvhhTY=;
        b=Lxcd85X1HFbRn2AoPylXg3IejQxbIEUgPS9ZWX/1g7wD2B4lVYPIs27UTd8DCF/rtO
         i09t2fft1c/ndQYrIX+YTLxug17vvfd/H7SZXjRGgR8VmY9TKWVLC4HsdGPsZCZ2j5q2
         g1INQoGIYkoFVF5/ttl6pEAue/25SOP953cCgiyi3r7HmNFcBhBzGZjr2nVKLbTK321v
         K6UUlmaeYxTiAaDRUGjo3nl5Ptv98i9SP+GDvecBsDrjLwQxaaZ7FGlAKNy5XpXd6ARe
         kvOUSgdYLLqQ+4HPkke67jrFq79W1f6GZR0NKDnc9CJ/CETXuURL4nk3YKEguClYsVHs
         QWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S7Ih0GIdL2IRJV2P9aqSBBoFQM0S6/aadePd/xvhhTY=;
        b=qbccJxPq1N3fQQn5S6ZXbvzP1tMYlpzqjAfPPJNtUOAS4nFzuXDFdg4GiWOYYazjyQ
         XoMt8WYBb7k4cRCKz3TXJR0IHQvP+5S0bgiu0zdyGP7c5FiqMaMz/KZezoMdH8Q21gTx
         5V9LZ/HQxpmttrBMqLEdr5e8Sz6t9pdv59XtWQi79NYxi6s3gzAiDtGyMDTZ4vHghSIj
         hBaxzFAC6hkVHt5meyWplbV5ohaHOTZk9TZW6Cf8fS6VPh5K+zMgZGRzMssbRVweE6cp
         L5BG9YuNtcHcyFMS4S8G7k3O2k4We3bNxOn/hurOJ+iJ5iUWo4ySvEqx4nsXwZzoHXTu
         2qQA==
X-Gm-Message-State: AOAM532jMdG9OSJfmZSiz2xWUWBFMmZenpQquElL7vga8YYdn2ybh3nr
        ncrDzeStlQi6M85T6/FfwJo=
X-Google-Smtp-Source: ABdhPJws/U3Pye7DvoYeSotBoz8bIFGG49dTSYDNpZEbcTpvXWfaf0OyvzGSyAr+0YzU2jjewAnfVQ==
X-Received: by 2002:a17:907:2daa:b0:6da:924e:955 with SMTP id gt42-20020a1709072daa00b006da924e0955mr20092255ejc.1.1647853380107;
        Mon, 21 Mar 2022 02:03:00 -0700 (PDT)
Received: from leap.localnet (host-87-20-105-171.retail.telecomitalia.it. [87.20.105.171])
        by smtp.gmail.com with ESMTPSA id d11-20020a170906c20b00b006d584a09b9fsm6796654ejz.98.2022.03.21.02.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 02:02:58 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     dhowells@redhat.com, christophe.jaillet@wanadoo.fr,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in __free_pages
Date:   Mon, 21 Mar 2022 10:02:57 +0100
Message-ID: <1745593.TLkxdtWsSY@leap>
In-Reply-To: <977073.1647852411@warthog.procyon.org.uk>
References: <1821968.CQOukoFCf9@leap> <000000000000b1807c05daad8f98@google.com> <977073.1647852411@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned? 21 marzo 2022 09:46:51 CET David Howells wrote:
> Hi Fabio,
> 
> How about using my patch instead?  I wonder if __free_pages() should check for
> a NULL pages pointer...
> 
> David
> ---
> watch_queue: Fix NULL dereference in error cleanup
> 
> In watch_queue_set_size(), the error cleanup code doesn't take account of
> the fact that __free_page() can't handle a NULL pointer when trying to free
> up buffer pages that did get allocated.
> 
> Fix this by only calling __free_page() on non-NULL pointers extracted from
> the list (the list was allocated by kcalloc() so was pre-cleared).
> 
> Without the fix, this can lead to something like the following:
> 
> BUG: KASAN: null-ptr-deref in __free_pages+0x1f/0x1b0 mm/page_alloc.c:5473
> Read of size 4 at addr 0000000000000034 by task syz-executor168/3599
> ...
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  __kasan_report mm/kasan/report.c:446 [inline]
>  kasan_report.cold+0x66/0xdf mm/kasan/report.c:459
>  check_region_inline mm/kasan/generic.c:183 [inline]
>  kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
>  instrument_atomic_read include/linux/instrumented.h:71 [inline]
>  atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
>  page_ref_count include/linux/page_ref.h:67 [inline]
>  put_page_testzero include/linux/mm.h:717 [inline]
>  __free_pages+0x1f/0x1b0 mm/page_alloc.c:5473
>  watch_queue_set_size+0x499/0x630 kernel/watch_queue.c:275
>  pipe_ioctl+0xac/0x2b0 fs/pipe.c:632
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:874 [inline]
>  __se_sys_ioctl fs/ioctl.c:860 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Fixes: c73be61cede5 ("pipe: Add general notification queue support")
> Reported-and-tested-by: syzbot+d55757faa9b80590767b@syzkaller.appspotmail.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>  kernel/watch_queue.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
> index 00703444a219..09f35bab496e 100644
> --- a/kernel/watch_queue.c
> +++ b/kernel/watch_queue.c
> @@ -272,7 +272,8 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
>  
>  error_p:
>  	for (i = 0; i < nr_pages; i++)
> -		__free_page(pages[i]);
> +		if (pages[i])
> +			__free_page(pages[i]);
>  	kfree(pages);
>  error:
>  	(void) account_pipe_buffers(pipe->user, nr_pages, pipe->nr_accounted);
> 
> 
I cannot have any objection, it's up to you to decide :)

I just noticed that you now have two tests in one loop:
the first is for the index less than an unnecessary high value:
the second is for pages[i] being NULL.

However, I have no other objections. Please use your patch instead.

Thanks,

Fabio M. De Francesco


