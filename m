Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D3E4BA013
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbiBQM0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:26:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiBQM0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:26:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A85A12AE280
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 04:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645100747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iUj4J1PFFLeHNXV2hswnucw5C2wWUfAkQGdSpmyWvgs=;
        b=IsXDAXwqtYFlZKTvVgwIV6Hwl9ZWUDF/FGXmSdS3ToUm2ExfH+x1+sxnWEQ2Bh3ECjYcH+
        1F1YclSv3ABvWUv27hv+xfa934tUsxFnm1/IN9zmWBXXKcIV57zFz0282qlVQ9lqBSjTJ/
        SuW2+p/634eCGMq8Q8HAN6x0SZYCvR4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-wSFGdcqhNjG2NqXl264CZw-1; Thu, 17 Feb 2022 07:25:46 -0500
X-MC-Unique: wSFGdcqhNjG2NqXl264CZw-1
Received: by mail-ed1-f72.google.com with SMTP id y13-20020aa7c24d000000b00411925b7829so3253580edo.22
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 04:25:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iUj4J1PFFLeHNXV2hswnucw5C2wWUfAkQGdSpmyWvgs=;
        b=Ssbv3DuIOrTstpa685HZmhd89I6KHMAKrnW3IJMtHvP9fv4k8kE1QuNnspZFkSVNGs
         aE9ThvNcC1TH3d1ut/a0WxYE58lQsZUlE1hdz/ZAuvZVr7XmFcgV7aw2acHG5TVQ/eTo
         +ArWhzyjSOCXDQqv0P30QKvYMd3W2x3pXELN0KIOiZL/MTIpyCq7UrseY/gvnGdU7sqt
         U6q0ZE7gHDfc8iE6k3/G9cowGy0b0L2HCDpvf6tguIuvWGnoAvyFjIwRmrQ9CpVQUfU4
         cTt/24PUTHQ2gbDvkN6C7NLpO5te9w5YkonRUKRJ/bu9eSdEysIA1PZ6v7l5BpfrkAC/
         7csQ==
X-Gm-Message-State: AOAM531aAi0w/KWy4FJ2YIMjLmYcfGgTjLdeM6sf0qcGOdo5Y63XH0fN
        fKOe24V+Rfb2wlWToez+45IoKFYR3rcxfx979LAydOiMJlfBV4I8qptbjuNQk9pGpYXFFM5S0HW
        DLvt1OSsojvpmnCjXK/3nqjP/
X-Received: by 2002:a17:906:70c2:b0:6cf:e1cc:4d8c with SMTP id g2-20020a17090670c200b006cfe1cc4d8cmr2224503ejk.696.1645100745345;
        Thu, 17 Feb 2022 04:25:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyN/iov4B91rfM/jVGW5nEH5EFSej0rTDUYappc11DWR8GVyjT7l+SS39eRGb0gPCW/KsDCjQ==
X-Received: by 2002:a17:906:70c2:b0:6cf:e1cc:4d8c with SMTP id g2-20020a17090670c200b006cfe1cc4d8cmr2224490ejk.696.1645100745075;
        Thu, 17 Feb 2022 04:25:45 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id b11sm3251779edd.17.2022.02.17.04.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 04:25:44 -0800 (PST)
Message-ID: <bfbf91a7-1266-89da-c242-9fef14b6fc70@redhat.com>
Date:   Thu, 17 Feb 2022 13:25:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 0/4] platform/x86/intel/uncore-freq: Enhance HW interface
Content-Language: en-US
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220204000306.2517447-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220204000306.2517447-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/4/22 01:03, Srinivas Pandruvada wrote:
> The uncore frequency scaling is getting used by more customers to either
> have a deterministic performance or control power consumption.
> The uncore frequency scaling depends on non architecture MSRs, format of
> those MSR can be different on different generations of CPUs.
> This series prepares for easy addition of new HW interface.
> 
> There are no functional changes done except adding a new addition to
> read uncore frequency.
> 
> - The first patch creates a separate folder for uncore-freq.
> - The second patch uses sysfs groups to create attributes.
> - The third patch adds capability to read current uncore frequency.
> - The fourth patch splits common and enumeration part. The enumeration
> part will be specific to each HW interface.
> 
> Srinivas Pandruvada (4):
>   platform/x86/intel/uncore-freq: Move to uncore-frequency folder
>   platform/x86/intel/uncore-freq: Use sysfs API to create attributes
>   platform/x86/intel/uncore-freq: Display uncore current frequency
>   platform/x86/intel-uncore-freq: Split common and enumeration part

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Note I've squashed a small MAINTAINERS change in to patch 1/4 so
that the maintainers entry now points to the new sub-dir.

Regards,

Hans



> 
>  drivers/platform/x86/intel/Kconfig            |  14 +-
>  drivers/platform/x86/intel/Makefile           |   4 +-
>  drivers/platform/x86/intel/uncore-frequency.c | 452 ------------------
>  .../x86/intel/uncore-frequency/Kconfig        |  21 +
>  .../x86/intel/uncore-frequency/Makefile       |   9 +
>  .../uncore-frequency-common.c                 | 252 ++++++++++
>  .../uncore-frequency-common.h                 |  62 +++
>  .../intel/uncore-frequency/uncore-frequency.c | 272 +++++++++++
>  8 files changed, 620 insertions(+), 466 deletions(-)
>  delete mode 100644 drivers/platform/x86/intel/uncore-frequency.c
>  create mode 100644 drivers/platform/x86/intel/uncore-frequency/Kconfig
>  create mode 100644 drivers/platform/x86/intel/uncore-frequency/Makefile
>  create mode 100644 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
>  create mode 100644 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
>  create mode 100644 drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
> 

