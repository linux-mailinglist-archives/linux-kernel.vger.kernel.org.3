Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973985373B4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 05:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiE3DVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 23:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiE3DVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 23:21:24 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C7D57B02
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 20:21:21 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gd1so1611995pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 20:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oKTxyqHKV6Y4Q04nTfwFIxPEKKD5FrMOG1VemYyqUD0=;
        b=acCkzLQ/S/obsEI7AFkSJHJ616FCDG1yKoM1lpRHNClhdVTcnuYB2a0kF0OzCPxs30
         jL9ARmC6vn3hnj/a7cH8zoRs1e4wTUJPF/yiQyiBFSM2qvNeMbyppXY6CpfHMaOJeyLx
         GOUHR1CeL26nGasw8SdWmC/1xHJNq2kfE74dXmeHCYDCD7dwBUeNnryfmL0FQkDmvnJy
         4jHRES8g/dFtZ5/TxbIeGX1JHwYaxsGOvqu5d0aeve0s72Cy/DFs8++PJfRp58+6LFqu
         t3AMV98NvWwUmq5kg+gB9iKgIHWQrO/gHuSx5N7IaWm78fS7gzyIa/5SB8wI4JH1M4jh
         HWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oKTxyqHKV6Y4Q04nTfwFIxPEKKD5FrMOG1VemYyqUD0=;
        b=b8ExOTDsntG8vdyYw5tFlitHMikLH85sGjtTTgNEywNt1ZG8FvBk4v15TLOgNaZp+q
         UaRs7CVmg0pyDg2rzvr+wmYNcY66C8H9dBGOjcVXjeaXcteIBVBiYxTVyjtN41J64Ska
         MkJGSsy4rq0IFs63tcw0OW3RzecXUQx6Gr3jlkyn3UooweHPZcu+S4GLzgqViAYIgcPV
         YVMe5gIWavYae2I2lzxPSb01Q4/dNYxxgdmJjcO9SOhuuZsSOJGb2ETZY1YN9Yq6ER0J
         q3PV2fQ9wc67jCdeCVh1xMGy65i0p62E6OmEzwylX3SiPn4ClQf8KE/WN6wkfJ7YOgcJ
         MsUw==
X-Gm-Message-State: AOAM530o04vKz5fj4fCKt78rL0JhZUgWZbSepaTPu+jqI5CcXIPif0Te
        gJLKOK7iIUqFmWeMZe1Mpy4gNg==
X-Google-Smtp-Source: ABdhPJzSofslggTbJcruV7Fpclh+BpIX3CLebNGEtIss8t8A2kPfhu+aeyuPXc3VC0fdAszRmSiVlg==
X-Received: by 2002:a17:902:da84:b0:161:d2d2:184d with SMTP id j4-20020a170902da8400b00161d2d2184dmr54956194plx.81.1653880880505;
        Sun, 29 May 2022 20:21:20 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t189-20020a6281c6000000b005187c4d53c9sm7578340pfd.160.2022.05.29.20.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 20:21:19 -0700 (PDT)
Message-ID: <b8400bfc-c47e-2791-6f73-c6f174e8736d@kernel.dk>
Date:   Sun, 29 May 2022 21:21:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH -next] block: fix use-after-free in
 __cpuhp_state_remove_instance
Content-Language: en-US
To:     Ye Bin <yebin10@huawei.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ming.lei@redhat.com
References: <20220530024729.2621465-1-yebin10@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220530024729.2621465-1-yebin10@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/22 8:47 PM, Ye Bin wrote:
> We got issue when remove device mapper as follows:
> dmsetup create test --table "0 1048576 linear /dev/sda 0"
> dmsetup suspend --nolockfs test
> dmsetup load test --table "0 1048576 error /dev/sda 0"
> dmsetup resume test
> dmsetup suspend --nolockfs test
> dmsetup load test --table "0 1048576 linear /dev/sda 0"
> dmsetup resume test
> dmsetup remove test
> ==================================================================
> BUG: KASAN: wild-memory-access in __cpuhp_state_remove_instance+0x1ea/0x310
> Write of size 8 at addr dead000000000122 by task dmsetup/1969
> 
> CPU: 1 PID: 1969 Comm: dmsetup Not tainted 5.18.0-next-20220524 #225
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x6e/0x91
>  print_report.cold+0x494/0x6b7
>  kasan_report+0xa9/0x120
>  __cpuhp_state_remove_instance+0x1ea/0x310
>  bioset_exit+0x45/0x2e0
>  cleanup_mapped_device+0x4f/0x190
>  __dm_destroy+0x230/0x3c0
>  dev_remove+0x18b/0x1d0
>  ctl_ioctl+0x3d8/0x7c0
>  dm_ctl_ioctl+0x21/0x30
>  __x64_sys_ioctl+0x12c/0x170
>  do_syscall_64+0x3b/0x90
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f0d9aa7a8d7
> RSP: 002b:00007fff1ecedce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f0d9ad5ff50 RCX: 00007f0d9aa7a8d7
> RDX: 000055c98c17d130 RSI: 00000000c138fd04 RDI: 0000000000000003
> RBP: 00007f0d9ad9a503 R08: 00007f0d9ad9b040 R09: 00007fff1ecedc10
> R10: 0000000000000006 R11: 0000000000000246 R12: 000055c98c17d130
> R13: 00007f0d9ad9a503 R14: 000055c98c17d050 R15: 00007f0d9ad9a503
> ==================================================================
> 
> As load different table may lead to bioset flag changes. But bio_alloc_cache_destroy
> to free cache depends on if cache is NULL, and also this after free cache didn't
> set 'bs->cache' NULL. So this will lead to UAF.
> To solve above issue just set ''bs->cache' NULL after free cache.
> 
> Fixes: be4d234d7aeb("bio: add allocation cache abstraction")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  block/bio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index a3893d80dccc..be3937b84e68 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -722,6 +722,7 @@ static void bio_alloc_cache_destroy(struct bio_set *bs)
>  		bio_alloc_cache_prune(cache, -1U);
>  	}
>  	free_percpu(bs->cache);
> +	bs->cache = NULL;
>  }
>  
>  /**

I already queued this up, just haven't sent it out yet:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.19/block&id=605f7415ecfb426610195dd6c7577b30592b3369


-- 
Jens Axboe

