Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4459F4C8F17
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbiCAPaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiCAPaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:30:06 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E168213FA6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 07:29:20 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id c14so18775076ioa.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 07:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JLpzyiylffXpYKOI4/wAJpbR1EAOvSqSarR62ILfzxg=;
        b=h/wWCF7mJ71VhkAmufHh/jZRBTnW8Ap+8K0IssvuDfBRN/sRD4jRPUFLvR6LmX84e9
         GswDevPUad3Q4j2uZ2lre3MssU18K2ziQWstwFFOCKPyTqG0uDg8EFFEQ2SM8tVb1jIN
         TykcNl20dBaBkYEzkHTvxxQSyK5anbq4ZVe+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JLpzyiylffXpYKOI4/wAJpbR1EAOvSqSarR62ILfzxg=;
        b=VlYEAPaAAKGI7jli0emMNvKaMtusj9Mnehne268f1zeqp/argsVOJqA9tbsLh2FO1/
         yxqvBxP6TVehxPN1InaXIo50H3iBQSkIueCPAneftWMO9/qfVOwGQ2D1rqXrovWBxeMU
         aqmK0bkmD/Sq7wreP9GdEBdffZyd5vp3XnWZMHPHNboP5AoP4SJ47fKNAVcAukE1Jqms
         M1WawNgBSVJO3umzBH+e0fEfRgkol9CcaPCKdtyUIpjXGBkHw3iMMV3BR3QyBIVkgJje
         SaLw+25MX0lv/m1uKs67qkq+Qpnd+IBbG+1hNTN89v+Wd2f1K0d11Twld1/jLoEBbUjp
         87vg==
X-Gm-Message-State: AOAM531V4w2EWXvWPb978ogr5lbFZWfbsHM6rPHLvfu+KzJAjc9NzV8t
        KsGn1jBV1BGVNzzPnMyCgGEcNg==
X-Google-Smtp-Source: ABdhPJyItWAaR2S2fFhZiwhlqaYDrGakTJS0a+yeNdq+94aUuWcwG7Z8OmCFwTybYus7Kg+BORZ8Mw==
X-Received: by 2002:a5e:df41:0:b0:642:8c0:ce78 with SMTP id g1-20020a5edf41000000b0064208c0ce78mr18726025ioq.142.1646148560263;
        Tue, 01 Mar 2022 07:29:20 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id i16-20020a056e02055000b002c2877213bdsm8118473ils.3.2022.03.01.07.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 07:29:19 -0800 (PST)
Subject: Re: [PATCH] selftests: vm: remove duplicated macro and use swap() to
 make code cleaner
To:     cgel.zte@gmail.com, akpm@linux-foundation.org
Cc:     shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lv Ruyi (CGEL ZTE)" <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220301014404.2052655-1-lv.ruyi@zte.com.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9d6ae3b1-3f36-8196-c136-fa2d07dbca5d@linuxfoundation.org>
Date:   Tue, 1 Mar 2022 08:29:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220301014404.2052655-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/22 6:44 PM, cgel.zte@gmail.com wrote:
> From: "Lv Ruyi (CGEL ZTE)" <lv.ruyi@zte.com.cn>
> 
> The macro is duplicated, so remove one. And use swap to make code cleaner.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi (CGEL ZTE) <lv.ruyi@zte.com.cn>
> ---
>   tools/testing/selftests/vm/userfaultfd.c | 13 ++-----------
>   1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index ab394e6bff43..100f08362164 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -121,9 +121,6 @@ struct uffd_stats {
>   #define swap(a, b) \
>   	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
>   
> -#define swap(a, b) \
> -	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
> -
>   const char *examples =
>       "# Run anonymous memory test on 100MiB region with 99999 bounces:\n"
>       "./userfaultfd anon 100 99999\n\n"
> @@ -1424,7 +1421,6 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
>   static int userfaultfd_stress(void)
>   {
>   	void *area;
> -	char *tmp_area;
>   	unsigned long nr;
>   	struct uffdio_register uffdio_register;
>   	struct uffd_stats uffd_stats[nr_cpus];
> @@ -1535,13 +1531,8 @@ static int userfaultfd_stress(void)
>   					    count_verify[nr], nr);
>   
>   		/* prepare next bounce */
> -		tmp_area = area_src;
> -		area_src = area_dst;
> -		area_dst = tmp_area;
> -
> -		tmp_area = area_src_alias;
> -		area_src_alias = area_dst_alias;
> -		area_dst_alias = tmp_area;
> +		swap(area_src, area_dst);
> +		swap(area_src_alias, area_dst_alias);

Where is swap() defined? Does this patch compile? I reverted a
change like this one reported by Zeal Robot recently. Let's
make sure this change compiles and runs.

>   
>   		uffd_stats_report(uffd_stats, nr_cpus);
>   	}
> 

thanks,
-- Shuah
