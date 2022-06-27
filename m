Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B7355D520
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiF0F4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 01:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiF0F4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 01:56:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701392DE3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 22:56:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m14-20020a17090a668e00b001ee6ece8368so2010055pjj.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 22:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bgGjIZMQi9zPseLwcTQISWkTzjFMEgBUdyAykEEFOv4=;
        b=Oe5p1iABnBF6/fGExyGi30NSTjr0bFRYVqoTFnPu8qX2eqlenGsnAn0GVMY7RoiFCc
         TCHYmxJL9UTUONyirC5ImxBG0EY+OtKWQ9aTVou4alzG0aMUkw/y2wPw37iu4wf1yiFb
         zB4i5Z/bZ2dBXyX6eqbDo6kRDhlL/DAzAKZmr/jI8rtJqilhfNuOUUmy5YjWTcKKxNBi
         kI7vexDUTEuWWNDgwe2VBFI0qaJ89i9OlgPndoDRyuQCStteqQixg/k+9DExmwwddfZv
         BULKUBRq5dE1E1HyEbU/UFLm5BKD68T0ecMggiTU/YQ1FxrjvIEvmOt0kx8P+iLjmbm8
         nXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bgGjIZMQi9zPseLwcTQISWkTzjFMEgBUdyAykEEFOv4=;
        b=JdYl2O08W2Qno0F3/F+aVApFT71YmWebHqUFMYv1qdZUfJKEEmuimXnQ0PoBEGhc/I
         yd5zToY/12yuqobMLm95C25al5og0Ihgopim+xvEgUD7XwyFMSvjHX2o6YG31SVVBsaQ
         PHPHn/UCJZM/bCGOz0qqyQcAyETVvllQW3GBt9378uZ1rlJIajduZSrDXJJYCnDRSgYu
         QBGCDkxIt0SFDUrLL6f7XpPpxYPSqNLqmZAKaR1AVu+/O9Tk58GKEEdgT1Ry42/t7EAq
         YYaqCXuVD+H5haCDYjlL51cQ5vrUUDViFH/1rrmNRAPvCCSCqkU02YRNZ+0qYufMOQH0
         GkPQ==
X-Gm-Message-State: AJIora8KsGGQQDWKUjHAR31LzrM1yxJ8H/9MmoAcUgG3DVdIG1Idl8Xp
        Q/8exUKrCKTUeMMSVGYmlvU=
X-Google-Smtp-Source: AGRyM1t1CnaacjaxbLUAI3PrusjR5hzrugJjX/H7Hvul4kfHgGqFr8fI3YMelLlcYjowRPox0/UqlQ==
X-Received: by 2002:a17:902:c401:b0:16a:1873:5ca3 with SMTP id k1-20020a170902c40100b0016a18735ca3mr12713755plk.157.1656309411898;
        Sun, 26 Jun 2022 22:56:51 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id a8-20020a1709027e4800b0016a100c9a2esm6167713pln.112.2022.06.26.22.56.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jun 2022 22:56:51 -0700 (PDT)
Date:   Mon, 27 Jun 2022 13:57:54 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Yuwen Chen <chenyuwen1@meizu.com>
Cc:     <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: Wake up all waiters after z_erofs_lzma_head
 ready.
Message-ID: <20220627135754.00000999.zbestahu@gmail.com>
In-Reply-To: <20220625145000.2720-1-chenyuwen1@meizu.com>
References: <20220625145000.2720-1-chenyuwen1@meizu.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jun 2022 22:50:00 +0800
Yuwen Chen <chenyuwen1@meizu.com> wrote:

> When the user mounts the erofs second times, the decompression thread
> may hung. The problem happens due to a sequence of steps like the
> following:
> 
> 1) Task A called z_erofs_load_lzma_config which obtain all of the node
>    from the z_erofs_lzma_head.
> 
> 2) At this time, task B called the z_erofs_lzma_decompress and wanted to
>    get a node. But the z_erofs_lzma_head was empty, the Task B had to
>    sleep.
> 
> 3) Task A release nodes and push nodes into the z_erofs_lzma_head. But
>    task B was still sleeping.
> 
> One example report when the hung happens:
> task:kworker/u3:1 state:D stack:14384 pid: 86 ppid: 2 flags:0x00004000
> Workqueue: erofs_unzipd z_erofs_decompressqueue_work
> Call Trace:
>  <TASK>
>  __schedule+0x281/0x760
>  schedule+0x49/0xb0
>  z_erofs_lzma_decompress+0x4bc/0x580
>  ? cpu_core_flags+0x10/0x10
>  z_erofs_decompress_pcluster+0x49b/0xba0
>  ? __update_load_avg_se+0x2b0/0x330
>  ? __update_load_avg_se+0x2b0/0x330
>  ? update_load_avg+0x5f/0x690
>  ? update_load_avg+0x5f/0x690
>  ? set_next_entity+0xbd/0x110
>  ? _raw_spin_unlock+0xd/0x20
>  z_erofs_decompress_queue.isra.0+0x2e/0x50
>  z_erofs_decompressqueue_work+0x30/0x60
>  process_one_work+0x1d3/0x3a0
>  worker_thread+0x45/0x3a0
>  ? process_one_work+0x3a0/0x3a0
>  kthread+0xe2/0x110
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x22/0x30
>  </TASK>
> 
> Signed-off-by: Yuwen Chen <chenyuwen1@meizu.com>
> ---
>  fs/erofs/decompressor_lzma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
> index 05a3063cf2bc..5e59b3f523eb 100644
> --- a/fs/erofs/decompressor_lzma.c
> +++ b/fs/erofs/decompressor_lzma.c
> @@ -143,6 +143,7 @@ int z_erofs_load_lzma_config(struct super_block *sb,
>  	DBG_BUGON(z_erofs_lzma_head);
>  	z_erofs_lzma_head = head;
>  	spin_unlock(&z_erofs_lzma_lock);
> +	wake_up_all(&z_erofs_lzma_wq);
>  
>  	z_erofs_lzma_max_dictsize = dict_size;
>  	mutex_unlock(&lzma_resize_mutex);

Please do not end the summary line(title) with a period.
