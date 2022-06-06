Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1CF53EED7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbiFFTqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiFFTqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:46:42 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C744C506E0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 12:46:41 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id p8so13528488pfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oyP7iawSbYu6szuRv0XOVFDxgIUuesQD3qgi+nOb5Ic=;
        b=bmqUNgY0eazL6NFiyxPHB5sLnp/hcm+O3t6EOSUPBBm+4lxT07rU+pB/QdoLCS34dK
         WPZS+d6WAdmQSCkS/5p2EpChDEPlkMevRIG8eCmI90JyLB2vacOHnF/L97z94hCOoydp
         J6BleJyzZXmCpJ7EML0qyVmAQnOxNOZ7tGAFzSW7uLCseyaBIDldGL4Ny0WG7MhTP6s3
         AI/x3e1kaONrf4M9MqGyYztOiDNLTV/zIN3/NuOlqewry9fpN8Vmbej5Fgp+71X+ePJE
         meiPzoEUQTh/gJb3N/RYw5PIMC1fcXmserxcuYs6ah1j22Jq2bns6M34lYw7xf4YfcAy
         M65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=oyP7iawSbYu6szuRv0XOVFDxgIUuesQD3qgi+nOb5Ic=;
        b=nlx2NX/HFtFBpFyUdYTiuVp9S/P4nWQ+aG+5B8SlC1TyjtRRxTxh6b0dOkR93uKLzS
         JdDL+c6WW7d0IIR/naLYj4Sfb9w9+Bc74OYsb3jiGDS1aRNX//bqv2re3rnxcSmjcx+B
         N9C+EiI8Sxm0gB6e5cHDQA278qnUjYbMvlLGeRlKmFXM7KwWecr/5qf9Dp7z8sO1CoTi
         wS3Opn4MnIKsKJRrSQVB1AasPRWayj8b065ooPeCCuEOHVb3+62TcyejvYKz6vCy8wd2
         iCzVp6jAXTgaOqRpeTW/kZyILaXLIDOdO46eudxNBgbYqKDEecK7V+F+yNGtH2tJz3H2
         +pwg==
X-Gm-Message-State: AOAM533STmg39L2ehgS7N0tY5rsjUW2RmlXMv6VBZE/emPO/pR5s+ny9
        WcWlN8zLk+67bxkeFByp0G8=
X-Google-Smtp-Source: ABdhPJyy30KovowbLNdcpU/q5Wjo+NmNs4mpvREKu9MiykbVUAVL4ai+Dm2sW8qdLW8kyW++FD/Kww==
X-Received: by 2002:a62:a113:0:b0:51c:1b4c:38d1 with SMTP id b19-20020a62a113000000b0051c1b4c38d1mr6703071pff.13.1654544801164;
        Mon, 06 Jun 2022 12:46:41 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:e75e:2c04:7854:d454])
        by smtp.gmail.com with ESMTPSA id u18-20020a62ed12000000b0050dc7628191sm11106052pfh.107.2022.06.06.12.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 12:46:40 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 6 Jun 2022 12:46:38 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     ngupta@vflare.org, senozhatsky@chromium.org,
        avromanov@sberdevices.ru, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        s.suk@samsung.com, ytk.lee@samsung.com, jaewon31.kim@gmail.com
Subject: Re: [PATCH] zram_drv: add __GFP_NOMEMALLOC not to use
 ALLOC_NO_WATERMARKS
Message-ID: <Yp5ZnkYEA5xrUksX@google.com>
References: <CGME20220603055341epcas1p2dd357326eea0cd818daf6f0db7c2aae1@epcas1p2.samsung.com>
 <20220603055747.11694-1-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603055747.11694-1-jaewon31.kim@samsung.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 02:57:47PM +0900, Jaewon Kim wrote:
> The atomic page allocation failure sometimes happened, and most of them
> seem to occur during boot time.
> 
> <4>[   59.707645] system_server: page allocation failure: order:0, mode:0xa20(GFP_ATOMIC), nodemask=(null),cpuset=foreground-boost,mems_allowed=0
> <4>[   59.707676] CPU: 5 PID: 1209 Comm: system_server Tainted: G S O      5.4.161-qgki-24219806-abA236USQU0AVE1 #1
> <4>[   59.707691] Call trace:
> <4>[   59.707702]  dump_backtrace.cfi_jt+0x0/0x4
> <4>[   59.707712]  show_stack+0x18/0x24
> <4>[   59.707719]  dump_stack+0xa4/0xe0
> <4>[   59.707728]  warn_alloc+0x114/0x194
> <4>[   59.707734]  __alloc_pages_slowpath+0x828/0x83c
> <4>[   59.707740]  __alloc_pages_nodemask+0x2b4/0x310
> <4>[   59.707747]  alloc_slab_page+0x40/0x5c8
> <4>[   59.707753]  new_slab+0x404/0x420
> <4>[   59.707759]  ___slab_alloc+0x224/0x3b0
> <4>[   59.707765]  __kmalloc+0x37c/0x394
> <4>[   59.707773]  context_struct_to_string+0x110/0x1b8
> <4>[   59.707778]  context_add_hash+0x6c/0xc8
> <4>[   59.707785]  security_compute_sid.llvm.13699573597798246927+0x508/0x5d8
> <4>[   59.707792]  security_transition_sid+0x2c/0x38
> <4>[   59.707804]  selinux_socket_create+0xa0/0xd8
> <4>[   59.707811]  security_socket_create+0x68/0xbc
> <4>[   59.707818]  __sock_create+0x8c/0x2f8
> <4>[   59.707823]  __sys_socket+0x94/0x19c
> <4>[   59.707829]  __arm64_sys_socket+0x20/0x30
> <4>[   59.707836]  el0_svc_common+0x100/0x1e0
> <4>[   59.707841]  el0_svc_handler+0x68/0x74
> <4>[   59.707848]  el0_svc+0x8/0xc
> <4>[   59.707853] Mem-Info:
> <4>[   59.707890] active_anon:223569 inactive_anon:74412 isolated_anon:0
> <4>[   59.707890]  active_file:51395 inactive_file:176622 isolated_file:0
> <4>[   59.707890]  unevictable:1018 dirty:211 writeback:4 unstable:0
> <4>[   59.707890]  slab_reclaimable:14398 slab_unreclaimable:61909
> <4>[   59.707890]  mapped:134779 shmem:1231 pagetables:26706 bounce:0
> <4>[   59.707890]  free:528 free_pcp:844 free_cma:147
> <4>[   59.707900] Node 0 active_anon:894276kB inactive_anon:297648kB active_file:205580kB inactive_file:706488kB unevictable:4072kB isolated(anon):0kB isolated(file):0kB mapped:539116kB dirty:844kB writeback:16kB shmem:4924kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
> <4>[   59.707912] Normal free:2112kB min:7244kB low:68892kB high:72180kB active_anon:893140kB inactive_anon:297660kB active_file:204740kB inactive_file:706396kB unevictable:4072kB writepending:860kB present:3626812kB managed:3288700kB mlocked:4068kB kernel_stack:62416kB shadow_call_stack:15656kB pagetables:106824kB bounce:0kB free_pcp:3372kB local_pcp:176kB free_cma:588kB
> <4>[   59.707915] lowmem_reserve[]: 0 0
> <4>[   59.707922] Normal: 8*4kB (H) 5*8kB (H) 13*16kB (H) 25*32kB (H) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1080kB
> <4>[   59.707942] 242549 total pagecache pages
> <4>[   59.707951] 12446 pages in swap cache
> <4>[   59.707956] Swap cache stats: add 212408, delete 199969, find 36869/71571
> <4>[   59.707961] Free swap  = 3445756kB
> <4>[   59.707965] Total swap = 4194300kB
> <4>[   59.707969] 906703 pages RAM
> <4>[   59.707973] 0 pages HighMem/MovableOnly
> <4>[   59.707978] 84528 pages reserved
> <4>[   59.707982] 49152 pages cma reserved
> 
> The kswapd or other reclaim contexts may not prepare enough free pages
> for too many atomic allocations occurred in short time. But zram may not
> be helpful for this atomic allocation even though zram is used to
> reclaim.
> 
> To get one zs object for a specific size, zram may allocate serveral
> pages. And this can be happened on different class sizes at the same
> time. It means zram may consume more pages to reclaim only one page.
> This inefficiency may consume all free pages below watmerk min by a
> process having PF_MEMALLOC like kswapd.

However, that's how zram has worked for a long time(allocate memory
under memory pressure) and many folks already have raised min_free_kbytes
when they use zram as swap. If we don't allow the allocation, swap out
fails easier than old, which would break existing tunes.

> 
> We can avoid this by adding __GFP_NOMEMALLOC. PF_MEMALLOC process won't
> use ALLOC_NO_WATERMARKS.
> 
> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> ---
>  drivers/block/zram/zram_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index b8549c61ff2c..39cd1397ed3b 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1383,6 +1383,7 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
>  
>  	handle = zs_malloc(zram->mem_pool, comp_len,
>  			__GFP_KSWAPD_RECLAIM |
> +			__GFP_NOMEMALLOC |
>  			__GFP_NOWARN |
>  			__GFP_HIGHMEM |
>  			__GFP_MOVABLE);
> -- 
> 2.17.1
> 
> 
