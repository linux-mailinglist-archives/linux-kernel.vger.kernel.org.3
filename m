Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234EF50D909
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 07:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbiDYGBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiDYGAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:00:47 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F0B3915B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 22:57:44 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id r13so27523054ejd.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 22:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7gVJ2Utcvosx/ULF+UBSbPDY0euXt/mFCYfcwdEKABE=;
        b=iPTGOxbqIL53Goy2mgOTNQ8ptoW0/oHAmTFOQFPlHhiOucWZBXK1+xDIyji4EZ+ufw
         xAcYAviMVb2D7XtLRww2tyevHpqBg4cHyj7cCDxkvHa538iPmXsL9XUYp1gq+C5AT1uj
         p95R4NeHG6F6sXZnP4M2QSHkMHU1l1xDQGMgb6J7hr9OW1oUldRpis//4GFKI5Iizubh
         8DVq+U8KEUpIYBfmmA9Xdir5u9LMayvHm43454RVLwJGltPcSH84qsCrXiXyrYlYNbHB
         16A+v0yiUsECDpxATWOXqSkDBNmgaJMd0zl9Nt9jljc/heufz3AfJVGxVFrp8M+ZGs0N
         elJg==
X-Gm-Message-State: AOAM533NkqRcjYR3gSK4JqdPCN89h1oU/iStv6AEChi1ys5wr5T4H9y/
        n8UyG70Z11rdjrMH9nFVlR8zTFv4KtU=
X-Google-Smtp-Source: ABdhPJwNjWzQpWbujPmDPI0ystpnRedGsg7AJyeQ/ZLHueI3IpwaY4uVuJMpcbXmNjzSmbYS0LCifg==
X-Received: by 2002:a17:906:4313:b0:6b8:b3e5:a46 with SMTP id j19-20020a170906431300b006b8b3e50a46mr14695767ejm.417.1650866262907;
        Sun, 24 Apr 2022 22:57:42 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id o5-20020a170906974500b006dfc781498dsm3262766ejy.37.2022.04.24.22.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 22:57:42 -0700 (PDT)
Message-ID: <2c1e137b-9866-4f6b-1413-0adaa8fdd57b@kernel.org>
Date:   Mon, 25 Apr 2022 07:57:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] tty/hvc_opal: simplify if-if to if-else
Content-Language: en-US
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
References: <20220424092511.100309-1-wanjiabing@vivo.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220424092511.100309-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 04. 22, 11:25, Wan Jiabing wrote:
> Use if and else instead of if(A) and if (!A).
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>   drivers/tty/hvc/hvc_opal.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
> index 84776bc641e6..2dafa0964c2a 100644
> --- a/drivers/tty/hvc/hvc_opal.c
> +++ b/drivers/tty/hvc/hvc_opal.c
> @@ -344,14 +344,15 @@ void __init hvc_opal_init_early(void)
>   		opal = of_find_node_by_path("/ibm,opal/consoles");
>   		if (opal)
>   			pr_devel("hvc_opal: Found consoles in new location\n");
> -		if (!opal) {
> +		else {

This looks good, except missing braces as noted by Joe.

>   			opal = of_find_node_by_path("/ibm,opal");
>   			if (opal)
>   				pr_devel("hvc_opal: "
>   					 "Found consoles in old location\n");
> +			else
> +				return;

I am not sure this return is more obvious than the previous one. Rather 
the opposite, IMO.

>   		}
> -		if (!opal)
> -			return;
> +
>   		for_each_child_of_node(opal, np) {
>   			if (of_node_name_eq(np, "serial")) {
>   				stdout_node = np;

thanks,
-- 
js
suse labs
