Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CC85A9BEF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiIAPnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiIAPnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB8E8A6F5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662046986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPoitkGieiA519AGfM1lLFH3EIE6WMP8WybuQF7XBQY=;
        b=h1JO7pzNRNoT/LJ2oR54Hsi157Zg1Y7q/U4HMv3fN5RSqPvTp9An2BOW5CxDmptVWuvEWW
        enOodz28rZhovAxwZP2TvCEBiC6tUWAnootiqAGgza/QQzb9q58hqHyeELV+pwTD1ShUhe
        602kfwHVCBQyRCIFck9pZp9KFdpvKxw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-30-DWxklDMuMPy6Bggc1VKaEA-1; Thu, 01 Sep 2022 11:43:05 -0400
X-MC-Unique: DWxklDMuMPy6Bggc1VKaEA-1
Received: by mail-ej1-f71.google.com with SMTP id qa35-20020a17090786a300b0073d4026a97dso7017133ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 08:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zPoitkGieiA519AGfM1lLFH3EIE6WMP8WybuQF7XBQY=;
        b=cvuVDlQmOd1fH8sZPf908TRfueh0h1vILjKWZGr2ndOLN+KH+V2nabJYliPxqUyyON
         jcuHzmTx92HJfzVeV6+ymNPn4BV8Pr4zIY7vI2tK1VoWiTFnZ+LYW3TtV93g6NYmqp/T
         D1obK2KM6oGnXUklYD7aQwtHs7AfwSa1MmAlrLWNKp/v3llxm6rDuXgXpNVzUVS0U/4v
         nUTdRflNkJu3/t5YdvRERRHcRi/pa//en4gjnAFsJ3q+hsqee2joTqv4CHmL88S9uRTa
         sp7rrKaB0yWHelEoZqL3bly0KFIBQFeBSAEo4x0p9XmVMqn6LZ7mYIft/dRGl9lPeNv5
         ebtA==
X-Gm-Message-State: ACgBeo03Sokd9KSBLRP+10zrtRTqELVKZUw3nAr8ODn/+V86igyFZ5tu
        pA9N00uXXmpNKpWSgvWgH6nxZI78lPbS4ARZFJpIt4iEuDkKKwyLNNuK9tXV1SyGOfD31wNLI+H
        8YYT3WXlEnvPqVwM4zknNxJC/
X-Received: by 2002:a17:906:9b09:b0:741:879e:fa with SMTP id eo9-20020a1709069b0900b00741879e00famr13609768ejc.573.1662046984748;
        Thu, 01 Sep 2022 08:43:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5skRuTJgjGK/5n5XrmzssooAjFbQ1CE9Ph1X052a+kR7D00THN55FR8+GL484EgzVxktcOKw==
X-Received: by 2002:a17:906:9b09:b0:741:879e:fa with SMTP id eo9-20020a1709069b0900b00741879e00famr13609754ejc.573.1662046984592;
        Thu, 01 Sep 2022 08:43:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id vp10-20020a17090712ca00b0072b1bc9b37fsm8612934ejb.22.2022.09.01.08.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 08:43:04 -0700 (PDT)
Message-ID: <b8a5038b-3d3a-4a2c-8fca-32b47f11e85c@redhat.com>
Date:   Thu, 1 Sep 2022 17:43:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1] platform/x86/intel: pmc/core: Add Raptor Lake support
 to pmc core driver
Content-Language: en-US
To:     Gayatri Kammela <gayatri.kammela@linux.intel.com>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, irenic.rajneesh@gmail.com,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Box <david.e.box@intel.com>
References: <20220830182001.3693030-1-gayatri.kammela@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220830182001.3693030-1-gayatri.kammela@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/30/22 20:20, Gayatri Kammela wrote:
> Add Raptor Lake client parts (both RPL and RPL_S) support to pmc core
> driver. Raptor Lake client parts reuse all the Alder Lake PCH IPs.
> 
> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: David Box <david.e.box@intel.com>
> Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>

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
>  drivers/platform/x86/intel/pmc/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index a1fe1e0dcf4a..17ec5825d13d 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1914,6 +1914,8 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>  	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&tgl_reg_map),
>  	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_reg_map),
>  	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &tgl_reg_map),
> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_reg_map),
> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_reg_map),
>  	{}
>  };
>  
> 
> base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5

