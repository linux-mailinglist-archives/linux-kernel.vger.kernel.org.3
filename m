Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA31528508
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243119AbiEPNLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243778AbiEPNLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:11:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 122FA167CE
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652706674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hWqbVpSXlRnUW98z3sLnmKnw5Je1+k/fACI3ag9jrI4=;
        b=QEzxDleZAqIlW2y5h3gOn6WRqOXGyvLL6lq2xnPls9ijE3bbThig+BqRWvLlox+GLKOvkp
        LctfQIv9G+dvhfiURo5DHUwyiE4MGk77Ys4WjOoR/BBqiFZ6ayMduBAU76qBGqJDJVwGKA
        f6KgeGUpFrAXNmUzeXCbLWWKkYh9oao=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-hGHr0rcQO5uehuXbsg8q2w-1; Mon, 16 May 2022 09:11:10 -0400
X-MC-Unique: hGHr0rcQO5uehuXbsg8q2w-1
Received: by mail-wm1-f72.google.com with SMTP id 26-20020a05600c021a00b003940660c053so6753920wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=hWqbVpSXlRnUW98z3sLnmKnw5Je1+k/fACI3ag9jrI4=;
        b=YM8Pm9ElFefVztn6XP4acT2WCq1gTxPzrgHusQ5j+P/MEwyRCGsdk58Oxam2RKYv17
         Q7tMTq+bb8PJXOlK2/D1K0ikn//l7FakLAqjunmP+Gs5DMblXXjVoUokUSxGxrheXRr0
         WCZxLCB+LUNBADWDGFFhr+n/WQLrctXGUQ1cMyXN7DBZq3esslDcqZ67Jfm3WFTJQOgT
         66sg/KFbukByV+27rRcs4E/xVAjxWm90Q+c4QKyrzjW8qY3qdt2t/V9CVgD2TKBAR5eO
         UsmSrm0qeEr/06OhLxbEi59nh4PtNaT98pViEHoIUV2yNccYJnrSiG3dtcoCyYy7m0Xx
         N+lQ==
X-Gm-Message-State: AOAM531ijmUtvjjg+zprswQ5E2Db+2O7nwZfIA4R4UkuM6iMyVqTbaxD
        HXCKFXo6Q+L3CAJs0uifSCWjdyC78KH39arfG8S37w88SbjxNLJOP0NYfYCGbRgtohkHfO46q+Z
        oQkTvuSwM9G6do6+bfIdfbB6a
X-Received: by 2002:a5d:6c64:0:b0:20d:599:ac5 with SMTP id r4-20020a5d6c64000000b0020d05990ac5mr5817857wrz.188.1652706669675;
        Mon, 16 May 2022 06:11:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMIpxXZkSv8yNPofszxOJdJeN+qIyr7YJ2LBcjlLRnEL3eW+abpUDrUBz1fM+68QQmFMF1HA==
X-Received: by 2002:a5d:6c64:0:b0:20d:599:ac5 with SMTP id r4-20020a5d6c64000000b0020d05990ac5mr5817836wrz.188.1652706669339;
        Mon, 16 May 2022 06:11:09 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-184.dyn.eolo.it. [146.241.112.184])
        by smtp.gmail.com with ESMTPSA id l20-20020a1c7914000000b00394538d039esm13126585wme.6.2022.05.16.06.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 06:11:09 -0700 (PDT)
Message-ID: <b9844f3ce486c5aff8547e79abf4344488db6568.camel@redhat.com>
Subject: Re: [PATCH net-next v3 02/10] udp/ipv6: move pending section of
 udpv6_sendmsg
From:   Paolo Abeni <pabeni@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 May 2022 15:11:07 +0200
In-Reply-To: <a0e7477985ef08c5f08f35b8c7336587c8adce12.1652368648.git.asml.silence@gmail.com>
References: <cover.1652368648.git.asml.silence@gmail.com>
         <a0e7477985ef08c5f08f35b8c7336587c8adce12.1652368648.git.asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-13 at 16:26 +0100, Pavel Begunkov wrote:
> Move up->pending section of udpv6_sendmsg() to the beginning of the
> function. Even though it require some code duplication for sin6 parsing,
> it clearly localises the pending handling in one place, removes an extra
> if and more importantly will prepare the code for further patches.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  net/ipv6/udp.c | 70 ++++++++++++++++++++++++++++++--------------------
>  1 file changed, 42 insertions(+), 28 deletions(-)
> 
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 11d44ed46953..85bff1252f5c 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1318,6 +1318,46 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  	ipc6.sockc.tsflags = sk->sk_tsflags;
>  	ipc6.sockc.mark = sk->sk_mark;
>  
> +	/* Rough check on arithmetic overflow,
> +	   better check is made in ip6_append_data().
> +	   */
> +	if (unlikely(len > INT_MAX - sizeof(struct udphdr)))
> +		return -EMSGSIZE;
> +
> +	getfrag  =  is_udplite ?  udplite_getfrag : ip_generic_getfrag;
> +
> +	/* There are pending frames. */
> +	if (up->pending) {
> +		if (up->pending == AF_INET)
> +			return udp_sendmsg(sk, msg, len);
> +
> +		/* Do a quick destination sanity check before corking. */
> +		if (sin6) {
> +			if (msg->msg_namelen < offsetof(struct sockaddr, sa_data))
> +				return -EINVAL;
> +			if (sin6->sin6_family == AF_INET6) {
> +				if (msg->msg_namelen < SIN6_LEN_RFC2133)
> +					return -EINVAL;
> +				if (ipv6_addr_any(&sin6->sin6_addr) &&
> +				    ipv6_addr_v4mapped(&np->saddr))
> +					return -EINVAL;

It looks like 'any' destination with ipv4 mapped source is now
rejected, while the existing code accept it.

/P

