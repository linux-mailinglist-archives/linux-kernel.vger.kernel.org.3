Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB40F58F73F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 07:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiHKFYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 01:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHKFYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 01:24:24 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B3D89CEB
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 22:24:22 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id s11so21534226edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 22:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=hpa+54kBM5ci25cGFXj378J1kkxwao4NEuC3olvq8yo=;
        b=shOr0GKXhJV3e7zSI9gYiOZFb1LvrYB5Rj6ypvIdjRWfA2F65bUKHGEPT4xJ+yUuBK
         gTLCx9W6pi3PZtEM6pfSG0Yv/+/UCKFsvMDqpCKOX//1+aMcUPrANzbV6DS0N3A67h9R
         xAD7XDArrELFjV+MhQy5Rn885+RQxVHbJt7fAzTuPpSzzN2qu9C7x9cICuulLNkgf/Lq
         hkbew3PcTtaqxPR9y0IYwzk81Buh/pJnqDl5xOwaL2mBtUYY5CDo1MzNXRVuTgHvnKE8
         sFcGrfhjJML9XCVItyKrCoQBsVR4X0aAcf4G+j2JByFkjedxlF7UD2z5GsxkIKxDnWG5
         A8CA==
X-Gm-Message-State: ACgBeo2M0z5rjnXlOR3NBwoDOEBl5xwiAWqy/35MlOuIPgZuEWDsRMSD
        jstIunRBZKqY+ikxADm3zdI=
X-Google-Smtp-Source: AA6agR54ykwy8OLueJk3Pdm+5cEP+TGLwweSJwF8J4EjbFAfKOVOGOoi2Td2oxOA4dwT6OYLLk/CmQ==
X-Received: by 2002:a05:6402:3892:b0:43b:d872:a66 with SMTP id fd18-20020a056402389200b0043bd8720a66mr29316255edb.139.1660195461212;
        Wed, 10 Aug 2022 22:24:21 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id e4-20020a170906314400b007309a570bacsm3076234eje.176.2022.08.10.22.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 22:24:20 -0700 (PDT)
Message-ID: <c967d09c-9882-d770-18b7-fdba992638f7@kernel.org>
Date:   Thu, 11 Aug 2022 07:24:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH] tty: n_gsm: fix NULL pointer dereference in
 gsmld_receive_buf()
Content-Language: en-US
To:     ChenXiaoSong <chenxiaosong2@huawei.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, zhangxiaoxu5@huawei.com,
        "D. Starke" <daniel.starke@siemens.com>
References: <20220811042848.3017861-1-chenxiaosong2@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220811042848.3017861-1-chenxiaosong2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Daniel.

It looks like what he proposed at:
https://lore.kernel.org/all/DB9PR10MB58813E33D3516BAB526156B1E0659@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM/

On 11. 08. 22, 6:28, ChenXiaoSong wrote:
> Syzkaller reported NULL pointer dereference bug as follows:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> PGD 0 P4D 0
> Oops: 0010 [#1] PREEMPT SMP KASAN PTI
> CPU: 3 PID: 1360 Comm: a.out Not tainted 5.19.0-next-20220810 #9
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>   BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> RIP: 0010:0x0
> Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
> RSP: 0018:ffffc9000570fcf8 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: ffff8880189c2000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880189c2000
> RBP: ffffc9000570fda1 R08: 0000000000000000 R09: ffffffff8f59ab27
> R10: ffffc9000570fd58 R11: ffff8880196f8000 R12: 0000000000000001
> R13: 0000000000000000 R14: ffffc9000570fd90 R15: dffffc0000000000
> FS:  00007f382232c540(0000) GS:ffff888107d80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 0000000101452005 CR4: 0000000000770ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>   <TASK>
>   gsmld_receive_buf+0x1c7/0x320
>   tty_ioctl+0x50e/0x1520
>   __x64_sys_ioctl+0x19c/0x210
>   do_syscall_64+0x38/0x90
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f382225e9b9
> Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7
>   48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
>   ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffd1c0fdd98 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f382225e9b9
> RDX: 00007ffd1c0fdda4 RSI: 0000000000005412 RDI: 0000000000000004
> RBP: 00007ffd1c0fddb0 R08: 000000000000000e R09: 000000001c0fdea0
> R10: 0000000000000000 R11: 0000000000000217 R12: 0000560d89007070
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>   </TASK>
> Modules linked in:
> CR2: 0000000000000000
> ---[ end trace 0000000000000000 ]---
> 
> Reproducer(c program):
> 1. int fd = open("/dev/char/4:20", O_RDWR, 0);
> 2. int arg = 0x15; ioctl(fd, 0x5423, &arg);
> 3. int arg2 = 0; ioctl(fd, 0x5412, &arg2);
> 
> gsm->receive is NULL when gsm_mux is not activated by gsm_activate_mux():
> 
>    ioctl(fd, 0x5423, &arg)
>      vfs_ioctl
>        tty_ioctl
>          tiocsetd
>            tty_set_ldisc
>              tty_ldisc_open
>                gsmld_open
>                  gsm_alloc_mux
>                    gsm = kzalloc(sizeof(struct gsm_mux), GFP_KERNEL)
>                    gsm->receive == NULL
>    ioctl(fd, 0x5412, &arg2)
>      vfs_ioctl
>        tty_ioctl
>          tiocsti // fake input character
>            gsmld_receive_buf
>              gsm->receive == NULL
> 
> Fix this by adding sanity check on struct gsm_mux->receive.
> 
> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> ---
>   drivers/tty/n_gsm.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index caa5c14ed57f..f1621667b69f 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2850,6 +2850,9 @@ static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
>   	struct gsm_mux *gsm = tty->disc_data;
>   	char flags = TTY_NORMAL;
>   
> +	if (!gsm->receive)
> +		return;
> +
>   	if (debug & 4)
>   		gsm_hex_dump_bytes(__func__, cp, count);
>   

-- 
js
suse labs

