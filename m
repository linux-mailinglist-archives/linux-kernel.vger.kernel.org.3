Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278F948F6D9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 13:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiAOMbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 07:31:32 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47638
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230421AbiAOMba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 07:31:30 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B834E3F1EA
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 12:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642249889;
        bh=aTqcIxqAR/af1ox/8rd3oWXS3Q3nu+K4UOt20ffR+bM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=G7ztRExuKM0IC07s1a9ehCKXEz+i3SbjI/c2M5UznEbYsU8xHwRUdZzycw8klXpYC
         ZFg1NLK33IgsBoANU7BU6YL7kFlcExK6aGbpDjtFJ5fU4hzW/MC2/crqvJ2HlcUOQv
         AUhY6MJYu8re88eJp6DPp+O05eTPPqG0WRZLozjyEXhQcby3/3//LSI2jfYSLn7vbh
         ttN+UXMDaEdNsQv4L7+pFuyBAS8hQXCLG+fpICipeNmO5XOm1icc1yEhUo6i5SEzHn
         9+Ccfi44FsRugVYgLnkM+mj0DzJcOHgupE0f3C9o1bfHNv3EkanhWBJvK6A9xJLdXb
         fSHkGNKmhteew==
Received: by mail-ed1-f69.google.com with SMTP id z9-20020a05640240c900b003fea688a17eso10374248edb.10
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 04:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aTqcIxqAR/af1ox/8rd3oWXS3Q3nu+K4UOt20ffR+bM=;
        b=fO26IihmNqyb+Pre3ddBVmGm6nUpsvlMvNQr67kXXKfpqf+oC35AyfbWGVreK+f3vg
         HklIhDWEZdXcoshWr67ROeP229Jo8PvxC/0FafOAPWjt0Z6Kk2kewVpcd5GJabNKtB6a
         di8o4yPzPnkCpy//pnJFKzCVtrjIGmH4nbhHNcfqzZq+gkB+kdmdL+VDYfGIpX2TJ6mL
         FMO8VZIwT0yQPrti2GNr9AzVEMRZPJVXo7SwHOIZK03ktpUKxVG1aE/c10A2hgb1Xrvj
         RJJYti4M2BPZ3e0SRtzn1B/OGVQUZBLS19OkdLRxJ/cZLeCr1W515FsKv9pd+bnkgRBe
         cMXg==
X-Gm-Message-State: AOAM533et118smD8eK+QYA87Yh9xbYQCD5W2qb8rKwGKV83su96hc4G1
        TJqEUJRgzpKS1hJIyd/kwCrZ8CJVIKteY+wIFZ/F6kzJTRu2uENlL23QtlaAtVIeXJixo25wTOV
        s2/23DYo1DCSo65JmHhghNESIizL59XqEt9a3R5JXoA==
X-Received: by 2002:a05:6402:3591:: with SMTP id y17mr13177027edc.386.1642249889433;
        Sat, 15 Jan 2022 04:31:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw76pBOLDbXNjXut5bnS0Si+Bt7OX9gzBeP9sOT2yOjk+C4gHjytpBv5MtB60q356CVn6Gh8Q==
X-Received: by 2002:a05:6402:3591:: with SMTP id y17mr13177016edc.386.1642249889264;
        Sat, 15 Jan 2022 04:31:29 -0800 (PST)
Received: from [192.168.0.35] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id d1sm2577349ejo.176.2022.01.15.04.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jan 2022 04:31:28 -0800 (PST)
Message-ID: <dc675285-1ece-cfc6-d68f-12f58c470c41@canonical.com>
Date:   Sat, 15 Jan 2022 13:31:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 1/7] nfc: llcp: fix NULL error pointer dereference on
 sendmsg() after failed bind()
Content-Language: en-US
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     syzbot+7f23bcddf626e0593a39@syzkaller.appspotmail.com,
        stable@vger.kernel.org
References: <20220115122650.128182-1-krzysztof.kozlowski@canonical.com>
 <20220115122650.128182-2-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220115122650.128182-2-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2022 13:26, Krzysztof Kozlowski wrote:
> Syzbot detected a NULL pointer dereference of nfc_llcp_sock->dev pointer
> (which is a 'struct nfc_dev *') with calls to llcp_sock_sendmsg() after
> a failed llcp_sock_bind(). The message being sent is a SOCK_DGRAM.
> 
> KASAN report:
> 
>   BUG: KASAN: null-ptr-deref in nfc_alloc_send_skb+0x2d/0xc0
>   Read of size 4 at addr 00000000000005c8 by task llcp_sock_nfc_a/899
> 
>   CPU: 5 PID: 899 Comm: llcp_sock_nfc_a Not tainted 5.16.0-rc6-next-20211224-00001-gc6437fbf18b0 #125
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x45/0x59
>    ? nfc_alloc_send_skb+0x2d/0xc0
>    __kasan_report.cold+0x117/0x11c
>    ? mark_lock+0x480/0x4f0
>    ? nfc_alloc_send_skb+0x2d/0xc0
>    kasan_report+0x38/0x50
>    nfc_alloc_send_skb+0x2d/0xc0
>    nfc_llcp_send_ui_frame+0x18c/0x2a0
>    ? nfc_llcp_send_i_frame+0x230/0x230
>    ? __local_bh_enable_ip+0x86/0xe0
>    ? llcp_sock_connect+0x470/0x470
>    ? llcp_sock_connect+0x470/0x470
>    sock_sendmsg+0x8e/0xa0
>    ____sys_sendmsg+0x253/0x3f0
>    ...
> 
> The issue was visible only with multiple simultaneous calls to bind() and
> sendmsg(), which resulted in most of the bind() calls to fail.  The
> bind() was failing on checking if there is available WKS/SDP/SAP
> (respective bit in 'struct nfc_llcp_local' fields).  When there was no
> available WKS/SDP/SAP, the bind returned error but the sendmsg() to such
> socket was able to trigger mentioned NULL pointer dereference of
> nfc_llcp_sock->dev.
> 
> The code looks simply racy and currently it protects several paths
> against race with checks for (!nfc_llcp_sock->local) which is NULL-ified
> in error paths of bind().  The llcp_sock_sendmsg() did not have such
> check but called function nfc_llcp_send_ui_frame() had, although not
> protected with lock_sock().
> 
> Therefore the race could look like (same socket is used all the time):
>   CPU0                                     CPU1
>   ====                                     ====
>   llcp_sock_bind()
>   - lock_sock()
>     - success
>   - release_sock()
>   - return 0
>                                            llcp_sock_sendmsg()
>                                            - lock_sock()
>                                            - release_sock()
>   llcp_sock_bind(), same socket
>   - lock_sock()
>     - error
>                                            - nfc_llcp_send_ui_frame()
>                                              - if (!llcp_sock->local)
>     - llcp_sock->local = NULL
>     - nfc_put_device(dev)
>                                              - dereference llcp_sock->dev
>   - release_sock()
>   - return -ERRNO
> 
> The nfc_llcp_send_ui_frame() checked llcp_sock->local outside of the
> lock, which is racy and ineffective check.  Instead, its caller
> llcp_sock_sendmsg(), should perform the check inside lock_sock().
> 
> Reported-by: syzbot+7f23bcddf626e0593a39@syzkaller.appspotmail.com

Syzbot confirmed fix, so this could be replaced with:

Reported-and-tested-by: syzbot+7f23bcddf626e0593a39@syzkaller.appspotmail.com


Best regards,
Krzysztof
