Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9D146EC60
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbhLIQBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240192AbhLIQBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:01:46 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E59BC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 07:58:12 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id iq11so4747085pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 07:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=biv5OTi9ySXLAnrzcd/teCA8NX2vw4nxLXTxzbrLMPQ=;
        b=tHRLi5to+H4EjBwccLnByww/gm1JUZym5mUe+YOKjx6/ETopTeXWC94Po5bRg7j+cC
         dwPDxyBfOEs1GndutpZzbxHDQzXX7bPSsJzVNucaadRMKjFDHjw/IhJcqobFU58zZhIn
         VGLcdIZpXHTJOTLP1kybtC1JIMXbkzwhvthiXvk9zq0+wRdChKm64TDh07KhLyUPyIfA
         aNy7i4swkoZLGFZJvtJFG5TovILAG2u4ZLeYiadfbsDUFtUCWBLJqA5P1GZNogUINye8
         0shT2rGDUjKvk395Jrv7fSIB+TVd1He94kEEPk9N77bLMQDzGJDTEZlb2DV5qS2qWB/9
         ZfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=biv5OTi9ySXLAnrzcd/teCA8NX2vw4nxLXTxzbrLMPQ=;
        b=2d36RZt55u4TLXNRuDbt9TDqAHiNSPVt4l5+QAlCzYboMratqgXSeOpWK1uv38auMc
         A8GAJ5WzK6/8zsjQvZEpKo2XPS94aqlbBk3qc5cSdJDi5pxL7LumKm8AKKsVV1541Bsr
         nFlTKXWT6ziiH+yprMPP3d50F/oVxI8yyFzg2QPp7trdNMgi3QQBC7zYONTc/fyJh85W
         C/WYXicHkw2w96w3OUhYri1d1qdPK19T4UEcldBjoQZGYGsj2X0zItEKjWRnuYr/FniD
         3VuSvroB5x0MKXdIV2r7UZLpnRpwpETut1C/f8QDNXhv+l+wuhL6AQuGR9SYjNI/0XJu
         SXrQ==
X-Gm-Message-State: AOAM530ENUtktZLqvPTU2GgGQElDyRoyNd+v5GNZI2fINebVKuHPIISf
        hPT2m+FKUAYM872UT5rgMae65g==
X-Google-Smtp-Source: ABdhPJx9AV16TY4XwyxRRoUmtkt9/ytp79OHBNK2x67X/9jHLAI3NsiGUhgfOsdGmFlPKdqsX6ARCQ==
X-Received: by 2002:a17:90a:a786:: with SMTP id f6mr16637212pjq.158.1639065491356;
        Thu, 09 Dec 2021 07:58:11 -0800 (PST)
Received: from [172.20.4.26] ([66.185.175.30])
        by smtp.gmail.com with ESMTPSA id k15sm82825pgn.91.2021.12.09.07.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 07:58:10 -0800 (PST)
Subject: Re: [syzbot] INFO: task hung in io_uring_cancel_generic (2)
To:     syzbot <syzbot+21e6887c0be14181206d@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000060ab3b05d2973c1a@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <053430b4-8b7a-249e-19a9-17752b47504a@kernel.dk>
Date:   Thu, 9 Dec 2021 08:58:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00000000000060ab3b05d2973c1a@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 5:04 PM, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    cd8c917a56f2 Makefile: Do not quote value for CONFIG_CC_IM..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=153be575b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5247c9e141823545
> dashboard link: https://syzkaller.appspot.com/bug?extid=21e6887c0be14181206d
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1218dce1b00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f91d89b00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+21e6887c0be14181206d@syzkaller.appspotmail.com

#syz test git://git.kernel.dk/linux-block io_uring-5.16

-- 
Jens Axboe

