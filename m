Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E82551D582
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390864AbiEFKW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239719AbiEFKW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:22:26 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E9EF5DE59
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 03:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651832323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iu7ch3lFZ/rvnkTE15PMZ9rAZCAf+Uerimsw5YSLRGs=;
        b=UJn6gFbM4PIQWgFqht6SvgXGR5grtlT3d4M3oSk9lXntjdGIzhg3bTK+gxNRE7DPDU+bm0
        l63AYdo14TT+ViG/CziYmiWw1fCauR3E0mxQC574J2anlbEmFTnabckiL4ZR3Y1qxehzgp
        I6WtpF2X0tyDCzZPJg3CzEWipISEBFQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-28kTslioNOmtVUDfcHg7ng-1; Fri, 06 May 2022 06:18:42 -0400
X-MC-Unique: 28kTslioNOmtVUDfcHg7ng-1
Received: by mail-ed1-f70.google.com with SMTP id e3-20020a50a683000000b00427afcc840aso3737588edc.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 03:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iu7ch3lFZ/rvnkTE15PMZ9rAZCAf+Uerimsw5YSLRGs=;
        b=C6O7a6xGk9kzJeoZgCOqUNH8N9g1X/ukEvqhZA4xHkr5glCZdl0H8AxcSH/KCXO2Hx
         FA6cGm9Fodc+D6RjrWrMLGiehpKP2v+LQahKqsxtSJcRbx0n4hPKsRptZTkd2ENTXRVa
         VIx83UPwe4AMGWkW8Ht/sNg/IK3j7keh9t1EH0/St2W+w6/Or8PZtuzYKqodncQ2Z2Nt
         faftbRUohFIcG1t+u9htA8WOvd3cS9LMdyfq4m1STOLCjhDIcaszDZOhMktU5/weuULY
         GdDbFRyjyDfGGJLR/CFSZDmuEpGn5ljakhWfPguJ3F1paFOgfoKFqwfH61btEoFrkHpZ
         5Q0A==
X-Gm-Message-State: AOAM533yesacBUUXxpLNKDmliwtPgSU/3MwAUgjK61/ri+UtlIhkr3/m
        UDpYPvt1H0RlltX86RsJ7RwEfBJ2B4FYkB1DHLuMi6XGEt4VcSlXvZbZ0vaIBLZiatPfklaRKcO
        jnrnevYuSRNKJHMhxKOLqY/Nl
X-Received: by 2002:a05:6402:35cb:b0:427:d231:3741 with SMTP id z11-20020a05640235cb00b00427d2313741mr2651069edc.369.1651832321142;
        Fri, 06 May 2022 03:18:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6uXTig16v/KF0Sf68c1jorh0YVHM0KHakRadSICnB+8bE8+Q4X+Ko/OdMKSEN1+Ga4NvJEg==
X-Received: by 2002:a05:6402:35cb:b0:427:d231:3741 with SMTP id z11-20020a05640235cb00b00427d2313741mr2651058edc.369.1651832320976;
        Fri, 06 May 2022 03:18:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id og9-20020a1709071dc900b006f3ef214e58sm1697197ejc.190.2022.05.06.03.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 03:18:40 -0700 (PDT)
Message-ID: <86b00878-7d53-90b1-0891-e004094dc8b3@redhat.com>
Date:   Fri, 6 May 2022 12:18:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] platform/x86: hp-wmi: simplify the return expression of
 platform_profile_omen_set()
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220505021919.54462-1-chi.minghao@zte.com.cn>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220505021919.54462-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/5/22 04:19, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Simplify the return expression.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

omen_thermal_profile_set(tp) returns the value of tp on
success which is not necessarily always 0, so this
patch is invalid.

Regards,

Hans



> ---
>  drivers/platform/x86/hp-wmi.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
> index 667f94bba905..9edb1f877189 100644
> --- a/drivers/platform/x86/hp-wmi.c
> +++ b/drivers/platform/x86/hp-wmi.c
> @@ -1119,7 +1119,7 @@ static int platform_profile_omen_get(struct platform_profile_handler *pprof,
>  static int platform_profile_omen_set(struct platform_profile_handler *pprof,
>  				     enum platform_profile_option profile)
>  {
> -	int err, tp, tp_version;
> +	int tp, tp_version;
>  
>  	tp_version = omen_get_thermal_policy_version();
>  
> @@ -1149,11 +1149,7 @@ static int platform_profile_omen_set(struct platform_profile_handler *pprof,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	err = omen_thermal_profile_set(tp);
> -	if (err < 0)
> -		return err;
> -
> -	return 0;
> +	return omen_thermal_profile_set(tp);
>  }
>  
>  static int thermal_profile_get(void)

