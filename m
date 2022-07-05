Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0294566547
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiGEInw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiGEInu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED051328
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 01:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657010629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kZy/nxlcdzOmZXOvcCR//qWGLqmbIlGg7XXJRIbpjK0=;
        b=Q4k8p5OlrVZ9uc7Rwl7InccRx03B/hUAueBrdAdJmGSOWFeAgjAAfBaOGMc3EMXHRlIpHz
        j01zptQDlwhfB++HgGXMn9MEX9g94dD3k6Y3yccLYob3I+IJ57/eRVV+jXMazXe+w0l+9x
        5FGI3IKTfuWLMgEE9ZFUODI8tHd6eLg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-szaYqf4rPI2KRPGDA7jYHg-1; Tue, 05 Jul 2022 04:43:48 -0400
X-MC-Unique: szaYqf4rPI2KRPGDA7jYHg-1
Received: by mail-wr1-f71.google.com with SMTP id k26-20020adfb35a000000b0021d6c3b9363so888117wrd.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 01:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=kZy/nxlcdzOmZXOvcCR//qWGLqmbIlGg7XXJRIbpjK0=;
        b=LzRL2hgbhrY0gRCfRJpEc7dyJTqwJ5JuaJxHUPIdLfy3t/B8cR/9Yom1sQoclHMmzs
         RO0UnyOObYnn5EgmUZMIno1DCcQeULCWxImjcNB1jVHVDD5B5PO9FWcVuLB57r8MObVd
         blFbL0RdJDbLdELNHSHfjw4eISoONpBX1cw2VoJQrpHp2qclsVTHG/JLTe20OjKCOdKL
         raXJoasUs41nExtMEDrbO+3UHi6CyPWIRcBL6o9w2gmQRGpRb7+lz/pLXmupv0SWq6Vf
         fcKHybJ1koQ0ZLsI2Ap9A6e86sDA9kbhBfm3F7nhrcl08bJlXZVS6ddCJlAN64n+mDVi
         DYbw==
X-Gm-Message-State: AJIora/9ZftV9l1jLLsIhF4kbeUoI1n0EF+wyuSh1gaEa0PuhveU2jyZ
        E4JqNrzo0gzC0QZ6xJw1Ng6JijfKhige0jivGAhWIx3hy/nntNf7n0sY1WeZwH4OgSu8iid301n
        GO79seBNZMtkwI7YmsiGNPi/O
X-Received: by 2002:a1c:f60f:0:b0:3a0:3e0c:1de1 with SMTP id w15-20020a1cf60f000000b003a03e0c1de1mr38133791wmc.56.1657010626600;
        Tue, 05 Jul 2022 01:43:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sHSdV9V2Ob02J3vbepG5ut1Vo9w3OUeEPmUiF13gGLPKO52cGyqadYgkGQJvykeI1zhkowZQ==
X-Received: by 2002:a1c:f60f:0:b0:3a0:3e0c:1de1 with SMTP id w15-20020a1cf60f000000b003a03e0c1de1mr38133775wmc.56.1657010626385;
        Tue, 05 Jul 2022 01:43:46 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-106-148.dyn.eolo.it. [146.241.106.148])
        by smtp.gmail.com with ESMTPSA id w8-20020a1cf608000000b0039c5a765388sm22308049wmc.28.2022.07.05.01.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 01:43:45 -0700 (PDT)
Message-ID: <4a95703c5c1a09e3ed1a64ddf83e65e222326214.camel@redhat.com>
Subject: Re: [PATCH net v5] net: rose: fix null-ptr-deref caused by
 rose_kill_by_neigh
From:   Paolo Abeni <pabeni@redhat.com>
To:     Duoming Zhou <duoming@zju.edu.cn>, linux-hams@vger.kernel.org
Cc:     ralf@linux-mips.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Jul 2022 10:43:44 +0200
In-Reply-To: <20220702075718.25121-1-duoming@zju.edu.cn>
References: <20220702075718.25121-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-07-02 at 15:57 +0800, Duoming Zhou wrote:
> When the link layer connection is broken, the rose->neighbour is
> set to null. But rose->neighbour could be used by rose_connection()
> and rose_release() later, because there is no synchronization among
> them. As a result, the null-ptr-deref bugs will happen.
> 
> One of the null-ptr-deref bugs is shown below:
> 
>     (thread 1)                  |        (thread 2)
>                                 |  rose_connect
> rose_kill_by_neigh              |    lock_sock(sk)
>   spin_lock_bh(&rose_list_lock) |    if (!rose->neighbour)
>   rose->neighbour = NULL;//(1)  |
>                                 |    rose->neighbour->use++;//(2)
> 
> The rose->neighbour is set to null in position (1) and dereferenced
> in position (2).
> 
> The KASAN report triggered by POC is shown below:
> 
> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
> ...
> RIP: 0010:rose_connect+0x6c2/0xf30
> RSP: 0018:ffff88800ab47d60 EFLAGS: 00000206
> RAX: 0000000000000005 RBX: 000000000000002a RCX: 0000000000000000
> RDX: ffff88800ab38000 RSI: ffff88800ab47e48 RDI: ffff88800ab38309
> RBP: dffffc0000000000 R08: 0000000000000000 R09: ffffed1001567062
> R10: dfffe91001567063 R11: 1ffff11001567061 R12: 1ffff11000d17cd0
> R13: ffff8880068be680 R14: 0000000000000002 R15: 1ffff11000d17cd0
> ...
> Call Trace:
>   <TASK>
>   ? __local_bh_enable_ip+0x54/0x80
>   ? selinux_netlbl_socket_connect+0x26/0x30
>   ? rose_bind+0x5b0/0x5b0
>   __sys_connect+0x216/0x280
>   __x64_sys_connect+0x71/0x80
>   do_syscall_64+0x43/0x90
>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> This patch adds lock_sock() in rose_kill_by_neigh() in order to
> synchronize with rose_connect() and rose_release().
> 
> Meanwhile, this patch adds sock_hold() protected by rose_list_lock
> that could synchronize with rose_remove_socket() in order to mitigate
> UAF bug caused by lock_sock() we add.
> 
> What's more, there is no need using rose_neigh_list_lock to protect
> rose_kill_by_neigh(). Because we have already used rose_neigh_list_lock
> to protect the state change of rose_neigh in rose_link_failed(), which
> is well synchronized.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes in v5:
>   - v5: Use socket lock to protect comparison in rose_kill_by_neigh.
> 
>  net/rose/af_rose.c    | 12 ++++++++++++
>  net/rose/rose_route.c |  2 ++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
> index bf2d986a6bc..6d5088b030a 100644
> --- a/net/rose/af_rose.c
> +++ b/net/rose/af_rose.c
> @@ -165,14 +165,26 @@ void rose_kill_by_neigh(struct rose_neigh *neigh)
>  	struct sock *s;
>  
>  	spin_lock_bh(&rose_list_lock);
> +again:
>  	sk_for_each(s, &rose_list) {
>  		struct rose_sock *rose = rose_sk(s);
>  
> +		sock_hold(s);
> +		spin_unlock_bh(&rose_list_lock);
> +		lock_sock(s);
>  		if (rose->neighbour == neigh) {
>  			rose_disconnect(s, ENETUNREACH, ROSE_OUT_OF_ORDER, 0);
>  			rose->neighbour->use--;

Note that the code can held different socket lock while updating
'neighbour->use'. That really means that such updates can really race
each other, with bad results.

I think the only safe way out is using an atomic_t for 'neighbour->use'
(likely a refcount_t would be a better option).

All the above deserves a separate patch IMHO.

>  			rose->neighbour = NULL;
> +			release_sock(s);
> +			sock_put(s);
> +			spin_lock_bh(&rose_list_lock);
> +			goto again;

This chunk is dup of the following lines, it could be dropped...

>  		}
> +		release_sock(s);
> +		sock_put(s);
> +		spin_lock_bh(&rose_list_lock);
> +		goto again;

... if this would be correct, which apparently is not.

What happens when 'rose->neighbour' is different from 'neigh' for first
socket in rose_list?

Cheers,

Paolo

