Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD83F49C655
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbiAZJbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:31:08 -0500
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:51872
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231687AbiAZJbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:31:06 -0500
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 0DCCF3F131;
        Wed, 26 Jan 2022 09:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643189465;
        bh=C3TFbDbXFKcqqKVEcUfwOgfrgdi94v6/GW8fG5xPa48=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=jo9dKs5e9Yu2R+73sD5iqoMx+w/QchNyOh+TebWDXpmuX+xqliuGmV4zxHUXkBBo/
         o0MLrWkVxhhLGbOSfbx2mD1hzpvw+i6w3j27H/vIW0CV/0laHGpDJSJhw+fAyvHpgw
         aUerQwU/ad3f3ud2yvZFk2RhSKsSos7paXmrLtQvDxdgP/yIZyXJdSY+gCSnE8Yxbx
         h83BP6Egj6fEsZNviuqUS1b2ZzKwxybbLVNC+oYkdlh+mJxahFenD1oQtbjLESS0Uv
         GMRL12eRk63Vq7JpPTTLphuG7pgnmi7M2cMXpXCGfC7y9xgpj9otnzm96Yk9SUJqN3
         1VA6qiykPy4cg==
Message-ID: <87f35305-324e-6f7a-69a6-710db05c6e7c@canonical.com>
Date:   Wed, 26 Jan 2022 01:30:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH][next] apparmor: Use struct_size() helper in kmalloc()
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220125015606.GA28243@embeddedor>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220125015606.GA28243@embeddedor>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 17:56, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> Also, address the following sparse warnings:
> security/apparmor/lib.c:139:23: warning: using sizeof on a flexible structure
> 
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

thanks, I have pulled this into my tree
Acked-by: John Johansen <john.johansen@canonical.com>

> ---
>  security/apparmor/lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
> index fa49b81eb54c..5eda003c0d45 100644
> --- a/security/apparmor/lib.c
> +++ b/security/apparmor/lib.c
> @@ -136,7 +136,7 @@ __counted char *aa_str_alloc(int size, gfp_t gfp)
>  {
>  	struct counted_str *str;
>  
> -	str = kmalloc(sizeof(struct counted_str) + size, gfp);
> +	str = kmalloc(struct_size(str, name, size), gfp);
>  	if (!str)
>  		return NULL;
>  

