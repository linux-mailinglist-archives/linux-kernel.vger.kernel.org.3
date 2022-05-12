Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B934524EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354759AbiELNzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354571AbiELNzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:55:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAC951A90CF
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652363709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qDfBXl6r47NAGtbUw1Qhe9k0Xvma8CxuKm51vIrp78w=;
        b=YABs9JA5OnCfEOUKh3w7hM0nM4xb/8MIT7svKridGmdFP6xrYbo09MAKchRxOncwbMNURa
        61CZHjBrJ6V9Wh19+hktd01LR0rNMyaLf2kuj/9dMOhtdoO0Cyu3nriw1wm/Y7/Kmu7SOv
        Ia5sgkisP2hn86ED16noMHivZQApuQE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-hIZL-F0TN1ObpA_IDBRFBw-1; Thu, 12 May 2022 09:55:08 -0400
X-MC-Unique: hIZL-F0TN1ObpA_IDBRFBw-1
Received: by mail-ej1-f71.google.com with SMTP id jx8-20020a170906ca4800b006f88b28f2f6so2905844ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qDfBXl6r47NAGtbUw1Qhe9k0Xvma8CxuKm51vIrp78w=;
        b=NB+gfA5ZcYIK9TIvDlBcfCmKPr0iBy2/KoSP0YPQep8FyE9nj96kgpnq8XmlqQYphO
         kaSqP0nNcYgouc47/vMv3K+E6srqzKlLVHiBuewMjr4o+L1x2sRDx3t/0hxFXzGEd+Mi
         E5LWwiwZVGXySz2VlUzHKWR3fF5y+x57ZwUZKKC2XmWpCFhTAQNZd9mFTXyZkqrP4zkC
         01tEHM7SkNZXhT2QpvezgYvd0sByix504r8ILsKC3Eyr70WDXS1rMrUx016E5q76ecBm
         diGZBYttK1ds1r2mPQ39T2xWmTpXCcxD6fim9YQ86y4hCYaexVlyaV6916ASinx9vTev
         8t4w==
X-Gm-Message-State: AOAM531MYYitemRFxrBmJQXi9DpkSkjY6gp+8Ydwf6npkwpms/9FUoqX
        /LqXeTyzBmXDCXFR+pxWWmNfQx0QSHKuvP8YWE6u/51fd9I4KevQ+AhTDRW6+moi1NcHD7stXVD
        L+aqmzTYfx9NbrvpuIaF14Ons
X-Received: by 2002:a50:9b43:0:b0:42a:34e4:3339 with SMTP id a3-20020a509b43000000b0042a34e43339mr4502627edj.381.1652363707231;
        Thu, 12 May 2022 06:55:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqdEfLnTYtIeTFKIFwucUrfmhE8MEITozzyBckxOyc5BS8qjhhb66YtSJMUD2rupkNZ2eV7g==
X-Received: by 2002:a50:9b43:0:b0:42a:34e4:3339 with SMTP id a3-20020a509b43000000b0042a34e43339mr4502606edj.381.1652363706989;
        Thu, 12 May 2022 06:55:06 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id n19-20020a05640206d300b0042617ba63absm2596508edy.53.2022.05.12.06.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 06:55:06 -0700 (PDT)
Message-ID: <201b3558-7968-3a16-ad15-f963752eb359@redhat.com>
Date:   Thu, 12 May 2022 15:55:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] tools/power/x86/intel-speed-select: Fix warning for
 perf_cap.cpu
Content-Language: en-US
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220511171208.211319-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220511171208.211319-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/11/22 19:12, Srinivas Pandruvada wrote:
> Initialize perf_cap struct to avoid warning:
> 
>   CC      hfi-events.o
> In function ‘process_hfi_event’,
>     inlined from ‘handle_event’ at hfi-events.c:220:5:
> hfi-events.c:184:9: warning: ‘perf_cap.cpu’ may be used
> uninitialized [-Wmaybe-uninitialized]
>   184 |         process_level_change(perf_cap->cpu);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> hfi-events.c: In function ‘handle_event’:
> hfi-events.c:193:25: note: ‘perf_cap.cpu’ was declared here
>   193 |         struct perf_cap perf_cap;
>       |                         ^~~~~~~~
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  tools/power/x86/intel-speed-select/hfi-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/x86/intel-speed-select/hfi-events.c b/tools/power/x86/intel-speed-select/hfi-events.c
> index e85676711372..761375062505 100644
> --- a/tools/power/x86/intel-speed-select/hfi-events.c
> +++ b/tools/power/x86/intel-speed-select/hfi-events.c
> @@ -190,7 +190,7 @@ static int handle_event(struct nl_msg *n, void *arg)
>  	struct genlmsghdr *genlhdr = genlmsg_hdr(nlh);
>  	struct nlattr *attrs[THERMAL_GENL_ATTR_MAX + 1];
>  	int ret;
> -	struct perf_cap perf_cap;
> +	struct perf_cap perf_cap = {0};
>  
>  	ret = genlmsg_parse(nlh, 0, attrs, THERMAL_GENL_ATTR_MAX, NULL);
>  

