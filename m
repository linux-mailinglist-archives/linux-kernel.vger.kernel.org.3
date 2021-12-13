Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78BA47313E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbhLMQGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbhLMQGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:06:33 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F09C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:06:33 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id b187so19007453iof.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wosmB9PxFEFwiBTzx+ccKeiFCy43oa7nLi45YgJ+TwI=;
        b=nIafQMrPaOkkx8ilGxdiTnYhtxnsm6iIl+ZubseP4x9pa5KrkyFSb8gn16j/6j1uHE
         XCoMwMiQLzQreqtEcA9ZmgEWVHHeB9ipW7IDCQDO53h3UMRjuWAOglJsNI+AU5E4HhQA
         RWoNuG7YlcY47vdDBqRsqaoDpCSgFOWRaJpYPgOfSgbzvDwKUKG1zaVJV7lr0+V25wSx
         rBTkdIwvdN0HbXzTaSZEn5wKCR4/NovHreqxn4JSIHGZlQdLvLYmyJ3ZppbW5ogltXjW
         fJ9qAMAfE0hviIhG3MzgTCpz2ozOp3TxgIM3Hl+eTzlpSed6PvZfzX7NAaRTieGtDz1L
         915g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wosmB9PxFEFwiBTzx+ccKeiFCy43oa7nLi45YgJ+TwI=;
        b=vXXRg9DgKNv26zWTANB6wZ0WuktZieJceKb0bau+IOPGT3KYH1tr+2sK8Fqc8HyXrm
         s4oMT7U45NlbTTu2nRMYjRmHSDRLGtA0Z8XMKCFxtrTm/YgUPdIkqu2Y8nMWLe9BEC0B
         uaWLCaSkm4npgS98jdF1htoPfrfyRlIjPkrHzgYf7qqBRuNIlM4WyUM/LbOV+Hkcm7nf
         4WaGjx4hDW4Ox6gnFvKXs+3BgWYYZc0/SrROW/l/hxnQ7fvdGqQOV+NoTfcaTQvUNkmH
         QCBtwT/WGPGcxbWbfh1wzLtlmL7bbt+PF+Pb9xLiO1Am79im6pO/NRCMobQiP5Oj/3hT
         VBEA==
X-Gm-Message-State: AOAM5329n7+eOq67lz20Y6bh+UOugAiBxovzBECgJfAopXWaL+y9uRTD
        o/tURmjpFfRDNAaU1jABRnlU5g==
X-Google-Smtp-Source: ABdhPJzsysd5Rxgl49Rp+s2Vk3n19RRPgUULpI3VbWFUOl7QEUjoTN4XMzpCL/pKOImKNofYNR7kXg==
X-Received: by 2002:a05:6602:2cce:: with SMTP id j14mr34874989iow.111.1639411592711;
        Mon, 13 Dec 2021 08:06:32 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n10sm9652148ilk.58.2021.12.13.08.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 08:06:32 -0800 (PST)
Subject: Re: [syzbot] possible deadlock in io_worker_cancel_cb
To:     syzbot <syzbot+b18b8be69df33a3918e9@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, haoxu@linux.alibaba.com,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <00000000000080c88305d300e67f@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <494d69b4-d9da-b698-39e6-ed41b64a09a7@kernel.dk>
Date:   Mon, 13 Dec 2021 09:06:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00000000000080c88305d300e67f@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/21 11:08 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a763d5a5abd6 Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12b900bab00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7d5e878e3399b6cc
> dashboard link: https://syzkaller.appspot.com/bug?extid=b18b8be69df33a3918e9
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143f7551b00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f56825b00000
> 
> The issue was bisected to:
> 
> commit 71a85387546e50b1a37b0fa45dadcae3bfb35cf6
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Fri Dec 10 15:29:30 2021 +0000
> 
>     io-wq: check for wq exit after adding new worker task_work

#syz test git://git.kernel.dk/linux-block io_uring-5.16

-- 
Jens Axboe

