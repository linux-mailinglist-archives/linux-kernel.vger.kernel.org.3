Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2475746846E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 12:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhLDLYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 06:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238982AbhLDLYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 06:24:03 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC510C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 03:20:37 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id y196so4387890wmc.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 03:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uWqiqy7vDZn3+KGLTyPgkZoejg00STnXi3fNAW1y/gw=;
        b=GmiMVv4me781WVb1WDaBLs58pFGBg4MnY4EtemaouXy6qEUATlnAiBwWFa8xi+tcYD
         SSG1Yp5tXcv6zG5OKJaQ6VFE2YI5qR/KwYFbpf+EZwqxG6dZUhhY8qIw59qDEtmrbBef
         ju+1dMursOXrEbhZhQRbwUN75BOGEnLy7HOXncZnPlwEtpmfRjrONl3xhXYtEeDJ+5qx
         UqBfcz4CsHdYKY/IbpIS+wAr231eLjMNDXPDu9GMapRfy7+61XQqN3nV/8+/RX3t+U78
         hgF+ANsxKrQBMyCKHE0GrlDR2fkcLSG0chw1h95WYnjLBe6BfkyrltCLUttfm8Xja9gU
         PcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uWqiqy7vDZn3+KGLTyPgkZoejg00STnXi3fNAW1y/gw=;
        b=LMO+exM4IXeqDZMwhqPmGp43+C9Xzbt60WxYX5NZTUIPYp29Vj4XrTxv92DSDkZzzD
         7qGulYQzw81MZlT/6qHmJPpnFcnoS/pftLnHfiL9q4CA2PjhA3fLkDOLkAH2MeHCm6Hl
         NlKfA9HoripUwCnmeBmPSBlRG7ArfA2K7v/1UvTjR5iTnNfSqMdPsSsjLprL3n6r20oC
         n3ghQ4gJefMa75uoHPMEaPfwf4TBB8Ku1oWL41AsCzAcLuI+iEypCj6R4YqYKkNWuW7u
         Wy7ukcjc7JYVe7L4uMO/RQb4UpqBHu44uM2vB32w2SLEOPlOfKgdmVnscWaGKPfdRp/V
         dTLw==
X-Gm-Message-State: AOAM533N/VjyFfZ4gYZZy5397yAjfGeskqSw7mkDoGIVBDwU7920OeFw
        72nr0uTu75fS57IjsdiQmXc=
X-Google-Smtp-Source: ABdhPJzQxapOfPHFT20eXMEv7Y2XUifh1xtn7JV0dlu1H01BO0x4ij2wuckIbdIYHNTjD0eaTpC+VQ==
X-Received: by 2002:a05:600c:3227:: with SMTP id r39mr23719211wmp.120.1638616836450;
        Sat, 04 Dec 2021 03:20:36 -0800 (PST)
Received: from hamza-OptiPlex-7040 ([39.48.153.81])
        by smtp.gmail.com with ESMTPSA id b11sm7573677wmj.35.2021.12.04.03.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 03:20:36 -0800 (PST)
Date:   Sat, 4 Dec 2021 16:20:32 +0500
From:   Ameer Hamza <amhamza.mgc@gmail.com>
To:     jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tipc: fixed possible memory leak issue
Message-ID: <20211204112032.GA16952@hamza-OptiPlex-7040>
References: <20211203174848.43879-1-amhamza.mgc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203174848.43879-1-amhamza.mgc@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 10:48:48PM +0500, Ameer Hamza wrote:
> Fixed coverity warning by freeing the memory before return
> 
> Addresses-Coverity: 1494433 ("Resource leak")
> 
> Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
> ---
>  net/tipc/crypto.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
> index b4d9419a015b..10e6d0e9ddbc 100644
> --- a/net/tipc/crypto.c
> +++ b/net/tipc/crypto.c
> @@ -599,6 +599,7 @@ static int tipc_aead_init(struct tipc_aead **aead, struct tipc_aead_key *ukey,
>  	tmp->key = kmemdup(ukey, tipc_aead_key_size(ukey), GFP_KERNEL);
>  	if (!tmp->key) {
>  		tipc_aead_free(&tmp->rcu);
> +		kfree_sensitive(tmp);
>  		return -ENOMEM;
>  	}
>  	memcpy(&tmp->salt, ukey->key + keylen, TIPC_AES_GCM_SALT_SIZE);
> -- 
> 2.25.1
> 
I reviewed this change again and coverity is generating a false
positive here. tipc_aead_free() is already releasing the allocated
memory for tmp. Please ignore this patch and sorry for the
inconvinience.

