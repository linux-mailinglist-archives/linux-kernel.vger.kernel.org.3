Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA4D4D9B93
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348488AbiCOMuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348389AbiCOMuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F28031205
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647348577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A8YB/zouyCs2m8bIpB0HNPrzD15OIyDhGFrmSggKmO0=;
        b=f27hGqUVLcOihoYodU66FUI2mBxNzxrOvKNTYY0ysVVA63Pf6EmcYhDZK4xGWQJpXG85Ys
        7RHIyb4jhjS/HTgDLxI0gXvTaP///1x5QYpOBZUz55EFJM4dY6CBSktfBWil9u7AAtZQ/5
        8Jj1BqEKJga6U7ZURMEfZ1qGEh+fD0U=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-2IqbUVpZPrGgkp17VXO5dQ-1; Tue, 15 Mar 2022 08:49:36 -0400
X-MC-Unique: 2IqbUVpZPrGgkp17VXO5dQ-1
Received: by mail-qk1-f197.google.com with SMTP id bj2-20020a05620a190200b005084968bb24so14166975qkb.23
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=A8YB/zouyCs2m8bIpB0HNPrzD15OIyDhGFrmSggKmO0=;
        b=Jqam4C/uXfoUABKBiWbpJrEBzVObnzZIcrEBidpyZDpsJ+iXegHCpvYtEQuPxNi5RU
         jyRJJFCA4OkvbMOAjF6DLKkka4jmeTQeU3T/t4/aVJ06C6BwSuY6ejAiyU6bYqToud8G
         dgumGJn4CyqNs/w8mIpiPZGwnvqC9Vq8CW5LXymzjv/9oTq0jcqg7+RLXM1tDkG58GAZ
         HHPTGKvA7Hsbn085IRrI1AeRLu1e8ZSFv9NdUr6dj0tQI1vW4HOsn7lKA1LR575XKiim
         1SRNfQuqXnzj4ipi0iR5YwJR4HSj/+YuTccnhgDxN9IHo50ELGG+v0vRupsZES3mLgFn
         sgCQ==
X-Gm-Message-State: AOAM531XsyXcPXoGMQzXFPu6RaNimg/9TKumG+OXZ+vjzSM+ZuRrUt3F
        mjpPrQj/qltFn+WHCZ+k6RjXvTiTEvlj7IwDCH2CjJ/vml2h0O23JdkLThBeqIBirQlP2tIR08Y
        n9f+t/4C0EK2wyFexfrn4Bpb2
X-Received: by 2002:a05:622a:43:b0:2e1:4e:a784 with SMTP id y3-20020a05622a004300b002e1004ea784mr22472649qtw.240.1647348575276;
        Tue, 15 Mar 2022 05:49:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySZNgzLvqshSrfyIaulX9BUiVIIovtIEdrD1Ud0s8XPceC7N4NZNZ0FQQO4xA+4EEcVHK/8g==
X-Received: by 2002:a05:622a:43:b0:2e1:4e:a784 with SMTP id y3-20020a05622a004300b002e1004ea784mr22472621qtw.240.1647348575015;
        Tue, 15 Mar 2022 05:49:35 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-135.dyn.eolo.it. [146.241.232.135])
        by smtp.gmail.com with ESMTPSA id k1-20020ac85fc1000000b002e1c6420790sm7984298qta.40.2022.03.15.05.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 05:49:34 -0700 (PDT)
Message-ID: <5ebf8873334a3a38855e378748cb6d8948fbd0c7.camel@redhat.com>
Subject: Re: [PATCH net-next 2/3] net: icmp: add skb drop reasons to
 ping_queue_rcv_skb()
From:   Paolo Abeni <pabeni@redhat.com>
To:     menglong8.dong@gmail.com, dsahern@kernel.org, kuba@kernel.org
Cc:     davem@davemloft.net, rostedt@goodmis.org, mingo@redhat.com,
        yoshfuji@linux-ipv6.org, imagedong@tencent.com,
        edumazet@google.com, kafai@fb.com, talalahmad@google.com,
        keescook@chromium.org, alobakin@pm.me, dongli.zhang@oracle.com,
        maze@google.com, aahringo@redhat.com, weiwan@google.com,
        yangbo.lu@nxp.com, fw@strlen.de, tglx@linutronix.de,
        rpalethorpe@suse.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Date:   Tue, 15 Mar 2022 13:49:29 +0100
In-Reply-To: <20220314113225.151959-3-imagedong@tencent.com>
References: <20220314113225.151959-1-imagedong@tencent.com>
         <20220314113225.151959-3-imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, 2022-03-14 at 19:32 +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> In order to get the reasons of skb drops, replace sock_queue_rcv_skb()
> used in ping_queue_rcv_skb() with sock_queue_rcv_skb_reason().
> Meanwhile, use kfree_skb_reason() instead of kfree_skb().
> 
> As we can see in ping_rcv(), 'skb' will be freed if '-1' is returned
> by ping_queue_rcv_skb(). In order to get the drop reason of 'skb',
> make ping_queue_rcv_skb() return the drop reason.
> 
> As ping_queue_rcv_skb() is used as 'ping_prot.backlog_rcv()', we can't
> change its return type. (Seems ping_prot.backlog_rcv() is not used?)
> Therefore, make it return 'drop_reason * -1' to keep the origin logic.
> 
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
>  net/ipv4/ping.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
> index 3ee947557b88..cd4eb211431a 100644
> --- a/net/ipv4/ping.c
> +++ b/net/ipv4/ping.c
> @@ -936,12 +936,13 @@ EXPORT_SYMBOL_GPL(ping_recvmsg);
>  
>  int ping_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  {
> +	enum skb_drop_reason reason;

Please insert an empty line between variable declaration and code.

>  	pr_debug("ping_queue_rcv_skb(sk=%p,sk->num=%d,skb=%p)\n",
>  		 inet_sk(sk), inet_sk(sk)->inet_num, skb);
> -	if (sock_queue_rcv_skb(sk, skb) < 0) {
> -		kfree_skb(skb);
> +	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
> +		kfree_skb_reason(skb, reason);
>  		pr_debug("ping_queue_rcv_skb -> failed\n");
> -		return -1;
> +		return -reason;

This changes the return value for the release callback.  Such callback
has a long and non trivial call chain via sk_backlog_rcv. 

It *should* be safe, but have you considered factoring out an
__ping_queue_rcv_skb() variant returning the full drop reason, use it
in the next patch and build ping_queue_rcv_skb() on top of such helper
to that backlog_rcv() return code will not change?

The above should additionally avoid the IMHO not so nice:

	reason = ping_queue_rcv_skb(sk, skb2) * -1;

in the next patch - it will become:

	reason = __ping_queue_rcv_skb(sk, skb2);

Thanks!

Paolo

