Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7735548F248
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 23:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiANWNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 17:13:13 -0500
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:43468
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230314AbiANWNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 17:13:12 -0500
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CB5423FCEA;
        Fri, 14 Jan 2022 22:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642198383;
        bh=stGyB9cd3q3CzvP5bfN9x0UvNGnJIW50M58RyeoH8Qk=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=HyrqdRbjSVeJEAq+7koFIlRXDgoGGrGJVOi0EFvxO5GrG+YvnP0Je/kLVEbR/NAfu
         5BVvWojcBRxZV2lM7/AuKgTwfLR5Tq1PvHAEa6WQ9DH3tCcR1uH6itxnhnQMwZIrWz
         aUEjcc7KTBFqmXXzAkWY9Fc7Ls94AYMxpX/+p56cZUjW0IF0+W2VFk2vWiO8GC0RLs
         Wox7ORHwiwRUwkm0ntSS7moTPhigFCF6ekcC2ObUK9XUV61cZeHsP3NkLGvC/+8ejv
         HB0nrTRadWjRMKBrO8aCJ21q7M848tYYhRWGhPdEfdYbjD80lceQk5/uDOGgtKGOh6
         4Ok4bJGF9BYtA==
Subject: Re: [PATCH] security/apparmor: remove redundant ret variable
To:     cgel.zte@gmail.com
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220112080356.666999-1-chi.minghao@zte.com.cn>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <d5b23c25-971a-dc67-1f97-b70ccb2160a6@canonical.com>
Date:   Fri, 14 Jan 2022 14:12:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220112080356.666999-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/22 12:03 AM, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from nf_register_net_hooks() directly instead
> of taking this in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>

Acked-by: John Johansen <john.johansen@canonical.com>

I will pull this into my tree

> ---
>  security/apparmor/lsm.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index ce7d96627810..f3deeb8b712e 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1799,11 +1799,8 @@ static const struct nf_hook_ops apparmor_nf_ops[] = {
>  
>  static int __net_init apparmor_nf_register(struct net *net)
>  {
> -	int ret;
> -
> -	ret = nf_register_net_hooks(net, apparmor_nf_ops,
> +	return nf_register_net_hooks(net, apparmor_nf_ops,
>  				    ARRAY_SIZE(apparmor_nf_ops));
> -	return ret;
>  }
>  
>  static void __net_exit apparmor_nf_unregister(struct net *net)
> 

