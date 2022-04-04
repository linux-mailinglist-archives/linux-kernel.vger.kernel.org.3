Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE11F4F16E6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357947AbiDDO1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiDDO1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E322035DF8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649082326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7sHibVkOaKYcZky1fBvELrAejFdIIbZy2kYf1v6ONMw=;
        b=anxX+ceKCrR9de8GqhFW/EwyKiLAO3adhyMSLLeJY6pTHtbQqhEeou8/DwmkAFvkSacIv6
        FKdvT4sd6J2qgrytPJf053t09BpjY/eGEPKVxl+vz+mnJebgy4P/lQo5xYnHV3x6ZZjchb
        UC54E3fmsxWgky9x5BG1wVa4N0K+Qs0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-qQmyy-UnPQ6i8GX5GEFYbA-1; Mon, 04 Apr 2022 10:25:24 -0400
X-MC-Unique: qQmyy-UnPQ6i8GX5GEFYbA-1
Received: by mail-ed1-f69.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso5574901edt.20
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 07:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7sHibVkOaKYcZky1fBvELrAejFdIIbZy2kYf1v6ONMw=;
        b=2Chz23IxF1zd1v4i6v+bIvD3/MriPWUX2xNS+AaqfWziI3sH1IpYoRzJPjBS/1dOAg
         t0GDvLNSNBtK1wljb3wdEXzjVevx2h0cvFL44n0/GnKUWDoajL4Gms+oJTC2nuJKtAcD
         juJbchr7oIBgTniPZwAWrOO5RoEw4+i6GyNDIOKlypcNIDHtdtK0TmafVCbqKZ63hNNB
         V8E9hFzGXO1qANYRf7EsWj8wxxD3fT6OCqfuXefKzRY5diJ76MRlrCmAQqqETodOk0W2
         Jk1G2/QcJAezZyDkdPC5DUG1TosD8BGmdK+GLgnJ3TnpGMryhqyCsSe5W+3Tb1shQ+VO
         Dibg==
X-Gm-Message-State: AOAM531DV6SaqMn9f9JTLqlvxrxeWzaJfEfDaEdl2GOI8wD8tMxs2Tqz
        WnHaONdC6Mbt2kwzqxcV34hxgGmxItmHxSxnW0B7DHZOVHeKTO/j5bv8ZYPFNTRKg223uRdb8Il
        9KRNcRATtnRkQvktrI1Tk7GZG
X-Received: by 2002:a17:906:5d12:b0:6e7:eb3a:eae5 with SMTP id g18-20020a1709065d1200b006e7eb3aeae5mr298910ejt.644.1649082323689;
        Mon, 04 Apr 2022 07:25:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLETcDlvTPckmX/v16yKBGxwUPw9/RGG+yVqtYnX0l8y1I39Ld3a73FYCa4KSgwT5Jn++z9Q==
X-Received: by 2002:a17:906:5d12:b0:6e7:eb3a:eae5 with SMTP id g18-20020a1709065d1200b006e7eb3aeae5mr298886ejt.644.1649082323491;
        Mon, 04 Apr 2022 07:25:23 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id dd6-20020a1709069b8600b006df08710d00sm4545618ejc.85.2022.04.04.07.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 07:25:21 -0700 (PDT)
Message-ID: <e8c35673-c8b4-b44c-3ca0-e1f3f22a16af@redhat.com>
Date:   Mon, 4 Apr 2022 16:25:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] platform/x86: acerhdf: Cleanup str_starts_with()
Content-Language: en-US
To:     Wei Li <liwei391@huawei.com>, Peter Kaestle <peter@piie.net>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.xiang@huawei.com
References: <20220326020249.3266561-1-liwei391@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220326020249.3266561-1-liwei391@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/26/22 03:02, Wei Li wrote:
> Since there is already a generic function strstarts() that check if a
> string starts with a given prefix, cleanup str_starts_with().
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>

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
>  drivers/platform/x86/acerhdf.c | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
> index 6b8b3ab8db48..3c589437b41e 100644
> --- a/drivers/platform/x86/acerhdf.c
> +++ b/drivers/platform/x86/acerhdf.c
> @@ -584,21 +584,6 @@ static struct platform_driver acerhdf_driver = {
>  	.remove = acerhdf_remove,
>  };
>  
> -/* checks if str begins with start */
> -static int str_starts_with(const char *str, const char *start)
> -{
> -	unsigned long str_len = 0, start_len = 0;
> -
> -	str_len = strlen(str);
> -	start_len = strlen(start);
> -
> -	if (str_len >= start_len &&
> -			!strncmp(str, start, start_len))
> -		return 1;
> -
> -	return 0;
> -}
> -
>  /* check hardware */
>  static int __init acerhdf_check_hardware(void)
>  {
> @@ -651,9 +636,9 @@ static int __init acerhdf_check_hardware(void)
>  		 * check if actual hardware BIOS vendor, product and version
>  		 * IDs start with the strings of BIOS table entry
>  		 */
> -		if (str_starts_with(vendor, bt->vendor) &&
> -				str_starts_with(product, bt->product) &&
> -				str_starts_with(version, bt->version)) {
> +		if (strstarts(vendor, bt->vendor) &&
> +				strstarts(product, bt->product) &&
> +				strstarts(version, bt->version)) {
>  			found = 1;
>  			break;
>  		}

