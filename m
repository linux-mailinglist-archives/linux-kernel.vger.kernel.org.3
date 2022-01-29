Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8F64A32B5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 01:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353488AbiA3AAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 19:00:05 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:42674
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353479AbiA3AAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 19:00:03 -0500
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 29F2841ACE;
        Sun, 30 Jan 2022 00:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643500802;
        bh=aIUC2hjxOfuGOfoZkng+G/9QpgCwaD5HPPeTqAP3wPc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=iJQPkoDjNi2gojVdm7YPA2QHYnXlWIrScCNgnfJcF+OB0eo9Wvly9/cSHZtjbl5+F
         k7InZd/j7E1lAN7AAO57eJ0URJWBT+Xw9BgVVRqS0F4IIeSJ4NsSidNp1zsU2CJaAg
         rlPIp7eiWnEpMoVErpqG9V6HIe/wDxVF/mhHnBFr8kbAIVNXK68CghouwnVLBmnJ5W
         0URm4TADdPT12oa0LruknM/4LHXcdElHa62ebmvR2wWQi9F/XsH49kwhihzzmUo0el
         GG46qxAM8LL43vY0PVGeNUV3HTezMde1WM8Dj3qRqXDe2IbE3RaB/UaeKpRuQtP5mt
         xXWFEbiE5d3uw==
Message-ID: <eca2206d-562f-a85f-ca51-01afcba63dc8@canonical.com>
Date:   Sat, 29 Jan 2022 15:59:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next 2/3] apparmor: Fix some kernel-doc comments
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, serge@hallyn.com
Cc:     jmorris@namei.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220129025101.38355-1-yang.lee@linux.alibaba.com>
 <20220129025101.38355-2-yang.lee@linux.alibaba.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220129025101.38355-2-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 18:51, Yang Li wrote:
> Add the description of @ns_name, change function name aa_u16_chunck to
> unpack_u16_chunk and verify_head to verify_header in kernel-doc comment
> to remove warnings found by running scripts/kernel-doc, which is caused
> by using 'make W=1'.
> 
> security/apparmor/policy_unpack.c:224: warning: expecting prototype for
> aa_u16_chunck(). Prototype was for unpack_u16_chunk() instead
> security/apparmor/policy_unpack.c:678: warning: Function parameter or
> member 'ns_name' not described in 'unpack_profile'
> security/apparmor/policy_unpack.c:950: warning: expecting prototype for
> verify_head(). Prototype was for verify_header() instead
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into my tree

> ---
>  security/apparmor/policy_unpack.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index 55dca9e3af50..3cc0fd2dff87 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -214,7 +214,7 @@ static void *kvmemdup(const void *src, size_t len)
>  }
>  
>  /**
> - * aa_u16_chunck - test and do bounds checking for a u16 size based chunk
> + * unpack_u16_chunk - test and do bounds checking for a u16 size based chunk
>   * @e: serialized data read head (NOT NULL)
>   * @chunk: start address for chunk of data (NOT NULL)
>   *
> @@ -671,6 +671,7 @@ static int datacmp(struct rhashtable_compare_arg *arg, const void *obj)
>  /**
>   * unpack_profile - unpack a serialized profile
>   * @e: serialized data extent information (NOT NULL)
> + * @ns_name: pointer of newly allocated copy of %NULL in case of error
>   *
>   * NOTE: unpack profile sets audit struct if there is a failure
>   */
> @@ -939,7 +940,7 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
>  }
>  
>  /**
> - * verify_head - unpack serialized stream header
> + * verify_header - unpack serialized stream header
>   * @e: serialized data read head (NOT NULL)
>   * @required: whether the header is required or optional
>   * @ns: Returns - namespace if one is specified else NULL (NOT NULL)

