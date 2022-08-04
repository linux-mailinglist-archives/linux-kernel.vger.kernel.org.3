Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18ABE5897F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 08:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238887AbiHDG7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 02:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238670AbiHDG7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 02:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B416161B0F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 23:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659596369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ExEtxHMeVEdV8bG+hyv5znpbqanF/kL14mBYzm730MI=;
        b=KvaJG2fMx4mDJ0HUlkHDSpevIPET9ZFnaBd5b9N7Vt4VN3m0kQhB0ziQUiEkD6wJABkpuH
        x8iq42368YQaQzLcM0NaQPGeBgnqOu8Y8i2hDBRqqKtM/3Tog61wv+LpFcG3EVFCQY4URf
        GkYJvDUJPXNM8GibtKCRn4hqTYlX2WQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-0h9aE7qTPPGMH1cFA7sA5g-1; Thu, 04 Aug 2022 02:59:28 -0400
X-MC-Unique: 0h9aE7qTPPGMH1cFA7sA5g-1
Received: by mail-ed1-f70.google.com with SMTP id i5-20020a05640242c500b0043e50334109so2229958edc.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 23:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ExEtxHMeVEdV8bG+hyv5znpbqanF/kL14mBYzm730MI=;
        b=GT1TBQYCIzFBv4YT1WyTt4pQl8vzJO+HGTjEoPYU3noumP1qUSx+zcJGox83iiPgVI
         y/OZpheyYfMKjJH4sbNYAG6Nkyr4YUG5IlpAj2MicFdFx9Cdk3EKjPf9WVLlNj4MPXDy
         uifn3/xn1EBp3AXLi8Yj2yFJi8HOFMv83LBU7hrJLpwTBJ68Y8r8L176XODMwB179GCZ
         eETcq5DJHX0mbm5hvd1JxP5UAZ6JGxHWFb8WpEhcgnERe0aZHELoQIG/Ki61z0wam4+L
         MOQVo7Vt+U3CkUvXwm5e/KTn9/8QvOrnfDR3mlu87JF7Dk8sPuO1wCFsq6vL/teVkgp4
         nEJg==
X-Gm-Message-State: ACgBeo3gAXDkrqi/JrYoPnlxEpPMBbnLWqeMuirfdhYDkRHVcsiB7Sx6
        Z1FnmLByYUPBPCz6c3U9CeYl5c+ovjU0EQpLExFZzsWvcsPJoctsIDMUXZn3hFAvjDk1xGaWuVo
        xUzjwWuRf1BGUaxdOALK1PaFs
X-Received: by 2002:a17:906:7952:b0:730:6ab7:6655 with SMTP id l18-20020a170906795200b007306ab76655mr360577ejo.171.1659596367225;
        Wed, 03 Aug 2022 23:59:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Ik1DuQerRmV01wlFYMNwdnqCD+oKxuFKA0C8LkP/PgPoBMCDxqmCixUtgsIrJfFVs/lJMKQ==
X-Received: by 2002:a17:906:7952:b0:730:6ab7:6655 with SMTP id l18-20020a170906795200b007306ab76655mr360560ejo.171.1659596366980;
        Wed, 03 Aug 2022 23:59:26 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709061da100b0072b2ffc662esm167ejh.156.2022.08.03.23.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 23:59:26 -0700 (PDT)
Date:   Thu, 4 Aug 2022 08:59:23 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Peilin Ye <peilin.ye@bytedance.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next] vsock: Reschedule connect_work for
 O_NONBLOCK connect() requests
Message-ID: <20220804065923.66bor7cyxwk2bwsf@sgarzare-redhat>
References: <20220804020925.32167-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220804020925.32167-1-yepeilin.cs@gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 07:09:25PM -0700, Peilin Ye wrote:
>From: Peilin Ye <peilin.ye@bytedance.com>
>
>An O_NONBLOCK vsock_connect() request may try to reschedule
>@connect_work.  Consider the following vsock_connect() requests:
>
>  1. The 1st, non-blocking request schedules @connect_work, which will
>     expire after, say, 200 jiffies.  Socket state is now SS_CONNECTING;
>
>  2. Later, the 2nd, blocking request gets interrupted by a signal after
>     5 jiffies while waiting for the connection to be established.
>     Socket state is back to SS_UNCONNECTED, and @connect_work will
>     expire after 100 jiffies;
>
>  3. Now, the 3rd, non-blocking request tries to schedule @connect_work
>     again, but @connect_work has already been scheduled, and will
>     expire in, say, 50 jiffies.
>
>In this scenario, currently this 3rd request simply decreases the sock
>reference count and returns.  Instead, let it reschedules @connect_work
>and resets the timeout back to @connect_timeout.
>
>Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
>---
>Hi all,
>
>This patch is RFC because it bases on Stefano's WIP fix [1] for a bug 
>[2]
>reported by syzbot, and it won't apply on current net-next.  I think it
>solves a separate issue.

Nice, this is better!

Feel free to include my patch in this (inclunding also the Fixes tag and 
maybe senidng to syzbot and including its tag as well).

The last thing I was trying to figure out before sending the patch was 
whether to set sock->state = SS_UNCONNECTED in vsock_connect_timeout(). 

I think we should do that, otherwise a subsequent to connect() with 
O_NONBLOCK set would keep returning -EALREADY, even though the timeout 
has expired.

What do you think?

I don't think it changes anything for the bug raised by sysbot, so it 
could be a separate patch.

Thanks,
Stefano

>
>Please advise, thanks!
>Peilin Ye
>
>[1] https://gitlab.com/sgarzarella/linux/-/commit/2d0f0b9cbbb30d58fdcbca7c1a857fd8f3110d61
>[2] https://syzkaller.appspot.com/bug?id=cd9103dc63346d26acbbdbf5c6ba9bd74e48c860
>
> net/vmw_vsock/af_vsock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 194d22291d8b..417e4ad17c03 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1395,7 +1395,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 			/* If the timeout function is already scheduled, ungrab
> 			 * the socket refcount to not leave it unbalanced.
> 			 */
>-			if (!schedule_delayed_work(&vsk->connect_work, timeout))
>+			if (mod_delayed_work(system_wq, &vsk->connect_work, timeout))
> 				sock_put(sk);
>
> 			/* Skip ahead to preserve error code set above. */
>-- 
>2.20.1
>

