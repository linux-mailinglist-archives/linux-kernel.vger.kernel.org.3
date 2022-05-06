Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402FA51D5E6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391061AbiEFKrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353944AbiEFKrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:47:14 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C497865402
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 03:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651833810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Snzmq85aJhY8SrwLYfIHKZ6vZUi6gYdUUM71Krz7mxs=;
        b=ULfyGS+WkxRLTV1Wc57tGgO9MrNqcek/RKBn73NVYNWy4mDXjnHS6xRD8CSHuICqEBJd3m
        F8rFN6PaXFox1EI7MK9o1hbLLqPbqy//9Ub7Jl1HYweuwP/f/YGPrlSPxM3EkEQr2I7RqA
        hXPB7kZYc+cxbQhZJ0RkKPEyeSZFjtI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-ktN-JynCMs2O6LLUyFBOzg-1; Fri, 06 May 2022 06:43:29 -0400
X-MC-Unique: ktN-JynCMs2O6LLUyFBOzg-1
Received: by mail-ed1-f71.google.com with SMTP id cw28-20020a056402229c00b00425dda4b67dso3806532edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 03:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Snzmq85aJhY8SrwLYfIHKZ6vZUi6gYdUUM71Krz7mxs=;
        b=kENIQ2CTippkehiIqzTleKcRPxykPJOwZ69dSjaWtK514YkhmiSkPqfdLHw01/lDwp
         TzpK8NHfTurAt+tWt25EeE7Xn6JG7gA6Q6zMYpG8cSQRcSX5Rjphnm078wQv6FHv39+c
         HwptZCYqB67BznZ40MMBbNI5cc0S1E6oBB5NkKHd93BEm+1bH97mRY8x5E8MNu/9sRgv
         gO0fwg59zFkuAbjxtrmIkNk9n/I5oabjHaNxshI/nqEm/rpu3WF2mXDkctdTpJl8BGdu
         71w7/uZ6saL7ifpsbDUgY2qVHOU8pluwSketIFRzS8NEDXZS7tSVJFq3WaURvJrfheN3
         rGoQ==
X-Gm-Message-State: AOAM5334+msrolmrjS5Pu9TvdBJ1fBMx/Ix+/s2wTGxg1f2NQbjhH0Gm
        IfJkgw11/LgL4uDFZil0aCt2Md2CGPQ/dRqPVikDH2wsKqdOb+HcHB3rlD83XF7U+2aqCfy03WU
        u7JuLbYSCa6Zomd5shatqCfj0
X-Received: by 2002:aa7:c6d0:0:b0:425:e9f3:10a8 with SMTP id b16-20020aa7c6d0000000b00425e9f310a8mr2770001eds.41.1651833808649;
        Fri, 06 May 2022 03:43:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBTdshAXXd+sfpEZAow87phheMy+OPGT2ZFq8IhkHn2o/yE6x8ikrGKRXl5zKoXxU9Pt9pcw==
X-Received: by 2002:aa7:c6d0:0:b0:425:e9f3:10a8 with SMTP id b16-20020aa7c6d0000000b00425e9f310a8mr2769984eds.41.1651833808435;
        Fri, 06 May 2022 03:43:28 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id z22-20020a50f156000000b0042617ba63c3sm2115354edl.77.2022.05.06.03.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 03:43:28 -0700 (PDT)
Message-ID: <6d63ba54-fe1c-c2ec-7888-a4c5f409457c@redhat.com>
Date:   Fri, 6 May 2022 12:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/4] platform/x86: pmc_atom: remove unused
 pmc_atom_write()
Content-Language: en-US
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20220428062430.31010-1-paul.gortmaker@windriver.com>
 <20220428062430.31010-2-paul.gortmaker@windriver.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220428062430.31010-2-paul.gortmaker@windriver.com>
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

On 4/28/22 08:24, Paul Gortmaker wrote:
> This function isn't used anywhere in the driver or anywhere in tree.
> So remove it.  It can always be re-added if/when a use arises.
> 
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

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
>  drivers/platform/x86/pmc_atom.c            | 12 ------------
>  include/linux/platform_data/x86/pmc_atom.h |  1 -
>  2 files changed, 13 deletions(-)
> 
> diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
> index a40fae6edc84..31cf25d25d66 100644
> --- a/drivers/platform/x86/pmc_atom.c
> +++ b/drivers/platform/x86/pmc_atom.c
> @@ -223,18 +223,6 @@ int pmc_atom_read(int offset, u32 *value)
>  }
>  EXPORT_SYMBOL_GPL(pmc_atom_read);
>  
> -int pmc_atom_write(int offset, u32 value)
> -{
> -	struct pmc_dev *pmc = &pmc_device;
> -
> -	if (!pmc->init)
> -		return -ENODEV;
> -
> -	pmc_reg_write(pmc, offset, value);
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(pmc_atom_write);
> -
>  static void pmc_power_off(void)
>  {
>  	u16	pm1_cnt_port;
> diff --git a/include/linux/platform_data/x86/pmc_atom.h b/include/linux/platform_data/x86/pmc_atom.h
> index 022bcea9edec..6807839c718b 100644
> --- a/include/linux/platform_data/x86/pmc_atom.h
> +++ b/include/linux/platform_data/x86/pmc_atom.h
> @@ -144,6 +144,5 @@
>  #define	SLEEP_ENABLE		0x2000
>  
>  extern int pmc_atom_read(int offset, u32 *value);
> -extern int pmc_atom_write(int offset, u32 value);
>  
>  #endif /* PMC_ATOM_H */

