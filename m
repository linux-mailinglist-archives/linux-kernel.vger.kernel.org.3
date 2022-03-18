Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E294DD8AC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiCRLF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiCRLFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFBEE1A82F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 04:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647601443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zllBQhArZnpwN+9LcU5/uYXvhQg2SWpOR7mVblQ0ybY=;
        b=BUkXhdyDOcqYftGLbfbYj/BjSaGvnHlrKwhKlPUehPYXRye65mTEnzz1YjhDOJ/XyJnxsk
        uQa6u6zvTcibX4B3bDP8KtQorDCozPGdquzB/vSkBUHKy7CcvbFFNGF+2AEQW53+Cffksv
        yvjyx27sLAnRLSaR0UhL3WzsEHFhZWk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-835hdsSEMSKZPFE8xHqK4A-1; Fri, 18 Mar 2022 07:04:02 -0400
X-MC-Unique: 835hdsSEMSKZPFE8xHqK4A-1
Received: by mail-ed1-f69.google.com with SMTP id f2-20020a50d542000000b00418ed3d95d8so4052975edj.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 04:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zllBQhArZnpwN+9LcU5/uYXvhQg2SWpOR7mVblQ0ybY=;
        b=pjIXm/Vg8h8U2IrziUEiPW222TBy3X/g4KyTzLJsIL46OKdKGeh8lGowed6AqEgV4W
         H/g+FGI4g6XL6OWYpUUSVl78Xfq5nDwccjrEYtBHT4CuM6VClDuXhGIyDJMoVFiDArdr
         8f5AVntyzJscopY/ISWEz2a6rLo7mKJg1yKOY1vri7Jp8aT7CgcawjlpzxVnA4V49KYk
         jk+o5DBNqKqTxr6frEeoR1oNBlVqQsYW0j46Rnk9pZ75PHhIwqCCGRrIjy5nLyX/HOnv
         lKyUWPHQw+1+/st13dVDdFp1TZ01c4odRFZVPnxhx7lnieRpHaHpBaAuVGP3Fo3iAK82
         F46w==
X-Gm-Message-State: AOAM531WtowDNdNwgAQ+YtLLrMBE7EFe82dx+hKbWYC834hPJDOlRBgl
        ezLdj2qxmu3c2ykbjPTjsYZsP1ZEG6tRKAK2fDOWiOeZGy6jM1jhhTvv5Sv1ySwY0pOrTcAy27g
        lRd7Uxq3wctS7Zs7ujYuoCw6x
X-Received: by 2002:a17:906:b757:b0:6d6:e990:b0de with SMTP id fx23-20020a170906b75700b006d6e990b0demr8293468ejb.603.1647601440722;
        Fri, 18 Mar 2022 04:04:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyjnOw+D0qWUOdtZ+gCVK4486nEGJim91rftoLPhBmY9TUL15x5+KGyZtAaW4a7t0X+qc5tA==
X-Received: by 2002:a17:906:b757:b0:6d6:e990:b0de with SMTP id fx23-20020a170906b75700b006d6e990b0demr8293451ejb.603.1647601440485;
        Fri, 18 Mar 2022 04:04:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id l9-20020a056402254900b00416b0ec98b5sm3996711edb.45.2022.03.18.04.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 04:04:00 -0700 (PDT)
Message-ID: <adf4dbff-6259-5f29-325c-26bd9211cf6f@redhat.com>
Date:   Fri, 18 Mar 2022 12:03:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] platform/x86: amd-pmc: Only report STB errors when STB
 enabled
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mark Gross <mgross@linux.intel.com>,
        "open list:AMD PMC DRIVER" <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220317190301.6818-1-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220317190301.6818-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/17/22 20:03, Mario Limonciello wrote:
> Currently if STB is disabled but an earlier function reported an
> error an incorrect error will be emitted about failing to write to
> STB.
> 
> Correct this logic error by only showing errors when STB is enabled.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

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
>  drivers/platform/x86/amd-pmc.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
> index 7317993cd91b..e9d0dbbb2887 100644
> --- a/drivers/platform/x86/amd-pmc.c
> +++ b/drivers/platform/x86/amd-pmc.c
> @@ -655,10 +655,11 @@ static void amd_pmc_s2idle_prepare(void)
>  		return;
>  	}
>  
> -	if (enable_stb)
> +	if (enable_stb) {
>  		rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_PREDEF);
> -	if (rc)
> -		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
> +		if (rc)
> +			dev_err(pdev->dev, "error writing to STB: %d\n", rc);
> +	}
>  }
>  
>  static void amd_pmc_s2idle_restore(void)
> @@ -679,10 +680,11 @@ static void amd_pmc_s2idle_restore(void)
>  	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
>  
>  	/* Write data incremented by 1 to distinguish in stb_read */
> -	if (enable_stb)
> +	if (enable_stb) {
>  		rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_PREDEF + 1);
> -	if (rc)
> -		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
> +		if (rc)
> +			dev_err(pdev->dev, "error writing to STB: %d\n", rc);
> +	}
>  
>  	/* Notify on failed entry */
>  	amd_pmc_validate_deepest(pdev);

