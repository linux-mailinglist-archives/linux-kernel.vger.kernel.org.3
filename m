Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DDB50F269
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343962AbiDZHdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbiDZHdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:33:02 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D50BDF493
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:29:55 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id p18so16030182edr.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hOlzS7teepghKhHO3I5ZYfaNXKKQM3quot1pS5vaaSA=;
        b=pxC8l347puOLWyO6G1ZGyd+C/Nz//nCN/6cIsiH++0mvA5dNwhwPzdcRlT765RoY9p
         QrFZE9BaeQw/fuVUn7GHPhZh6oGtalAhytz84V9CHjQ4x7tAlmXwGY3pge9/vbI25DgA
         XZfASJpK/+QEiZy4a2KJDMmru+YRyLgLRVbeVVgNFsFP0WZBgvNsV+3booyLzmAPat3N
         Pk6p1AMJcR9UcwoLzdlQOSYULiFvxMwwXKofT1EpqLZfzsrGU//yITs8Q3rGw+MivfLq
         MaEYIXHEdnYMnj6rmYTkZp6we9gDav1GjZmSNvaMWx8k3I8pMxOZ8TZa2l3qkzSynP6q
         mwrg==
X-Gm-Message-State: AOAM53220vHJHDN+340OlpFwAbOq3QJ1Gv3n4wkTXQWjJQPTUF7ThlOL
        Ixt7ogZGIyizeAd3VZgf4ko=
X-Google-Smtp-Source: ABdhPJwdtxQjyz2PID87gQkYXoDXvRITcke2EmvtcsG/Izql7n9Ce8e7NkkGkhbJN8TWTPJqnM2HvQ==
X-Received: by 2002:a05:6402:42d4:b0:416:5cac:a9a0 with SMTP id i20-20020a05640242d400b004165caca9a0mr23253479edc.86.1650958194022;
        Tue, 26 Apr 2022 00:29:54 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906700a00b006efdb748e8dsm4433107ejj.88.2022.04.26.00.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 00:29:53 -0700 (PDT)
Message-ID: <47accf18-ca39-8b36-100e-a6dbfd8705fe@kernel.org>
Date:   Tue, 26 Apr 2022 09:29:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] tty/hvc_opal: simplify if-if to if-else
Content-Language: en-US
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
References: <20220426071041.168282-1-wanjiabing@vivo.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220426071041.168282-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26. 04. 22, 9:10, Wan Jiabing wrote:
> Use if and else instead of if(A) and if (!A).

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
> Change log:
> v2:
> - add braces to the if block.
> ---
>   drivers/tty/hvc/hvc_opal.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
> index 84776bc641e6..794c7b18aa06 100644
> --- a/drivers/tty/hvc/hvc_opal.c
> +++ b/drivers/tty/hvc/hvc_opal.c
> @@ -342,9 +342,9 @@ void __init hvc_opal_init_early(void)
>   		 * path, so we hard wire it
>   		 */
>   		opal = of_find_node_by_path("/ibm,opal/consoles");
> -		if (opal)
> +		if (opal) {
>   			pr_devel("hvc_opal: Found consoles in new location\n");
> -		if (!opal) {
> +		} else {
>   			opal = of_find_node_by_path("/ibm,opal");
>   			if (opal)
>   				pr_devel("hvc_opal: "


-- 
js
suse labs
