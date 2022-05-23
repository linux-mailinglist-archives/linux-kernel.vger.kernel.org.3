Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF11953109B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbiEWLx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbiEWLxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:53:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAE4425E98
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653306803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7F3S847gNoYJomgUoUZV18TXMjCkXEdtxQeLaDBDuhM=;
        b=R6MM9teEuZ4e4PX647ku+P04aPnoq25kpPVIGHcRpK6fGqwrzXlfJlV/lQycT81b9ldgAS
        Uo2WN/ATsx+kMeZlyrzEdmPf07lxpcRrQmnagA3qyVdsls7BOfpiWL16szaok8YyRfxdtF
        u4EXFDOs+6n09hDnXjh72MLX1RNKLqs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-FllGObz-PQOjGLViKr_Rdw-1; Mon, 23 May 2022 07:53:22 -0400
X-MC-Unique: FllGObz-PQOjGLViKr_Rdw-1
Received: by mail-ed1-f71.google.com with SMTP id s9-20020aa7c549000000b0042ab6ab62f0so10459525edr.14
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7F3S847gNoYJomgUoUZV18TXMjCkXEdtxQeLaDBDuhM=;
        b=j1GxZaNbfVKziH6xt5L69P2ufBNZaITRtVi3humR0LZCF4SZRSwDFoffNMzlthmtdy
         wNP4SEoz2FRsAcwMHYnafoXwPAJp/xPHsEXzljRP1tcm4rMu1KKOlXNOGddowL1PlI0L
         /h6eJzWuYLvOBrARivOd0khkBblYEbeKIQR4ywOYLnKRjt9ZmdHLew1d23QmAY159shp
         xnAxru32AE1CYZY56Qgm4/uPInB5mK2qIHfQtAC9tcwWHmQhaRpMc+Ycm4SLX7UrqcTN
         qOqxuGHqdj5HvaBFczRlgqph7t8PqD5i4HPxQDAj9RsGWCEA7IkPOuZD5h82FjQNuZv3
         DFcQ==
X-Gm-Message-State: AOAM533YPUyeaIcvfv+imyERvKRfNe84h0bdLRAgp0acR98889zNiK9g
        H+wGgoYKqIpKWZAU8oIpA4vV944E/sdq1KEJGwzCUOpDbNHQAhnycVVitDx5dcwa+VCNWMAovrp
        DsDsYm6sxR7vukmU0YC8i9B+0
X-Received: by 2002:aa7:cc01:0:b0:42a:402b:b983 with SMTP id q1-20020aa7cc01000000b0042a402bb983mr23397825edt.257.1653306801373;
        Mon, 23 May 2022 04:53:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZQC9f79vxf9n/pVL1esanudk6sncq8ii/E3gyGPk2KhpEeJpKzIAHGD8JrKhZmVEi+x9pKw==
X-Received: by 2002:aa7:cc01:0:b0:42a:402b:b983 with SMTP id q1-20020aa7cc01000000b0042a402bb983mr23397812edt.257.1653306801228;
        Mon, 23 May 2022 04:53:21 -0700 (PDT)
Received: from [172.18.228.53] ([46.183.103.8])
        by smtp.gmail.com with ESMTPSA id 11-20020a17090602cb00b006f3ef214e59sm6076484ejk.191.2022.05.23.04.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 04:53:20 -0700 (PDT)
Message-ID: <74b7b668-a1f6-596f-8000-041f9ca7b181@redhat.com>
Date:   Mon, 23 May 2022 13:53:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] x86, olpc: Avoid leak OF node on error
Content-Language: en-US
To:     cgel.zte@gmail.com, dvhart@infradead.org
Cc:     andy@infradead.org, tglx@linutronix.de,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220523111253.3114-1-chi.minghao@zte.com.cn>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220523111253.3114-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/23/22 13:12, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> The OF node should be put before returning error in xo1_rtc_init(),
> otherwise node's refcount will be leaked.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  arch/x86/platform/olpc/olpc-xo1-rtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/platform/olpc/olpc-xo1-rtc.c b/arch/x86/platform/olpc/olpc-xo1-rtc.c
> index 57f210cda761..dc5ac56cd9dd 100644
> --- a/arch/x86/platform/olpc/olpc-xo1-rtc.c
> +++ b/arch/x86/platform/olpc/olpc-xo1-rtc.c
> @@ -59,9 +59,9 @@ static int __init xo1_rtc_init(void)
>  	struct device_node *node;
>  
>  	node = of_find_compatible_node(NULL, NULL, "olpc,xo1-rtc");
> +	of_node_put(node);
>  	if (!node)
>  		return 0;
> -	of_node_put(node);
>  
>  	pr_info("olpc-xo1-rtc: Initializing OLPC XO-1 RTC\n");
>  	rdmsrl(MSR_RTC_DOMA_OFFSET, rtc_info.rtc_day_alarm);

of_node_put on a NULL node is a no-op, so this patch
does not make any functional difference and it makes the
code harder to read.

nack.

Regards,

Hans

