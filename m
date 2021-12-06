Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F84E46A2F7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241452AbhLFRbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242884AbhLFRbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:31:39 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A04C061A83
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 09:28:09 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id m9so13933034iop.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 09:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kv5Kmq6bDRAJBmG1SVlRDoAoHxJBOtT9kYYIeRZ+OOM=;
        b=144+E2pznZKUc/Tgs4vIgh9ELBH7Endl2jpKG2ujF1Kbk6OtrkfBZ+DV8crzH4Pe0M
         64xVy1EYCpbFY3AkIyNv87MtxgkzeSMyTtWjJ3TEWq2CpCp/la3f/PbFvWN6MSdRz0ne
         KtWoL8aK2NEO0BYrZg4cZ4pm/BG4dSFdFHpBFrRU7s8J9FvA2PRtvES0J+dwu72R4AOo
         gPb6c0zluf5096A8UHhwUAW+KsJFMLuzhOaHxIz710S9gGQATbRcTWalipHOs0s6ABgP
         u9mX/P9StaKl18xe+rNXs/DmmpYN9YYa68UB7Tt1IPUWOaH80OFx8N4daAPRdYY3gV8Q
         2MhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kv5Kmq6bDRAJBmG1SVlRDoAoHxJBOtT9kYYIeRZ+OOM=;
        b=ne9NxZM2wUPsA50GhQtCgjKBFtYHLMYksQaYxhqlb2K5DrtqVtErYAFI7VyyoG7Sc7
         NmVuNS+gZzBZjG6OFBt+I/L4gOJ3Tm+oQvk7EVHj9OZlQVsfByneUsde+012u8X1role
         GBU1RfHsz0Jng91YN3OtLPk9COltSnqWG7+wShE9XGY23cEcVpx2aDiiz33YpvEB5T4y
         YMbvr6IMp3aNQkE0BSdQ2vOROPlFpswgS6+fZetUukH/EazY10jztP/4N0fqBS6ymZgZ
         5Oa5xBhqZhAiX14cya3NPMB09qvY2T6NQwN1Ljosttkwa/5AMcyJzXItijLZ49rOnJLU
         +oig==
X-Gm-Message-State: AOAM5330LA2/I7KDqsKA7qHCEB/iVEByXyJPivtYwrTn9s7jXqO/y0CI
        +0BaUVmB5vLi4WoqFU6BA0ug6g==
X-Google-Smtp-Source: ABdhPJzPd3O6+vYBQXcTdotzPmwCZbuwh8F7tVT76LsvKsov4u6iBYJGF80F1r/z9Zxw3WYXmizBuQ==
X-Received: by 2002:a5e:9b07:: with SMTP id j7mr33966034iok.136.1638811689340;
        Mon, 06 Dec 2021 09:28:09 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f11sm8877446ila.17.2021.12.06.09.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 09:28:08 -0800 (PST)
Subject: Re: [syzbot] KASAN: use-after-free Write in io_queue_worker_create
To:     syzbot <syzbot+b60c982cb0efc5e05a47@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000a9162005d27492b0@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <abb6e52f-327e-7846-4bc6-b0be7ea03514@kernel.dk>
Date:   Mon, 6 Dec 2021 10:28:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000a9162005d27492b0@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/21 11:43 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    944207047ca4 Merge tag 'usb-5.16-rc4' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13ebd129b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=171728a464c05f2b
> dashboard link: https://syzkaller.appspot.com/bug?extid=b60c982cb0efc5e05a47
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b60c982cb0efc5e05a47@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in instrument_atomic_write include/linux/instrumented.h:86 [inline]
> BUG: KASAN: use-after-free in clear_bit_unlock include/asm-generic/bitops/instrumented-lock.h:25 [inline]
> BUG: KASAN: use-after-free in io_queue_worker_create+0x453/0x4e0 fs/io-wq.c:363
> Write of size 8 at addr ffff888023e068d8 by task kworker/3:4/13798

Looks like a spurious clear that can race with the task_work already ran and
the worker got dropped. Both handlers do clear it, so I think we just need:

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 50cf9f92da36..35da9d90df76 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -359,10 +359,8 @@ static bool io_queue_worker_create(struct io_worker *worker,
 
 	init_task_work(&worker->create_work, func);
 	worker->create_index = acct->index;
-	if (!task_work_add(wq->task, &worker->create_work, TWA_SIGNAL)) {
-		clear_bit_unlock(0, &worker->create_state);
+	if (!task_work_add(wq->task, &worker->create_work, TWA_SIGNAL))
 		return true;
-	}
 	clear_bit_unlock(0, &worker->create_state);
 fail_release:
 	io_worker_release(worker);

-- 
Jens Axboe

