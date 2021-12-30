Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FE2481F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 19:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241729AbhL3Se3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 13:34:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241698AbhL3Se1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 13:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640889267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mats1/+/YWgQmnWm9vHI8IOcoJLT6Zeft53ysmvW3Nw=;
        b=P3Us8B3d7mDCm3xhWnWy50uNasor/nyTEyhVvzWzVcBIbeh9v48FKeSuNlhBKRdQhG50rY
        96jLAhiJ8dcXbxW9oqLF48ed/ERPcPuEcvj7F+jP/ZeHU2BHMHNKTldykjdeaXY38tFhnb
        9dNuk/RLNgkUGJZ0C1TYHl6eASFcsgs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-o7XcaeMnP7e2voRvHtabpQ-1; Thu, 30 Dec 2021 13:34:25 -0500
X-MC-Unique: o7XcaeMnP7e2voRvHtabpQ-1
Received: by mail-ed1-f72.google.com with SMTP id g11-20020a056402090b00b003f8fd1ac475so9754087edz.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 10:34:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mats1/+/YWgQmnWm9vHI8IOcoJLT6Zeft53ysmvW3Nw=;
        b=aBAa1JJ92kSTkVc/xY034hcH1JUvmOu3nmZT81g1yE6jQhGO8WFxcNRUkWZVWEdMNq
         pctZUjwe7nkVZKJnw8p86SquM6Lw4EvVdv7g/wKcz4gv7i4sMwOP4oGZBw4WaURqgvK8
         71gd8rD8owh7ukXo/2pfh199DnKqKhw1Dq8Dx99ie4tl5a+lV+QlhEaJl9/kWGzQdKNC
         OSYQWYbQ3vxC7MUA2uesbgF8S/7wPyoJ845PZf19PiuNqM9MyhQr/6vGmeJMU3pv1s4t
         GBzbHuFIsMA8XSqN7HS7T/OD3seq873qJ9aUd6tui/cbMkOoaX8snIwm7wjRbKaBF1cg
         9G8w==
X-Gm-Message-State: AOAM530Jrc0IcyObzyYDUVBeGS0fTqqEWwlwL8OV8doCfqn5sNrJshJA
        gGgmROeymDqEb+KOuCCL+Ku1ztXlFXLnFezIhArDUJJXzYBGKPGsCUIXolKsFfXYFPOdCNDUn9p
        QOxFIHk6nY2LwJhLMVn0vTDGF
X-Received: by 2002:a05:6402:230e:: with SMTP id l14mr21985243eda.370.1640889264594;
        Thu, 30 Dec 2021 10:34:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqiyU0k5iFfdHsV6fzv6LUW9sYvhc8sQ5NLr31Cl3FjJZ2sodH97kcM7rr37eoiVycKZLN6g==
X-Received: by 2002:a05:6402:230e:: with SMTP id l14mr21985231eda.370.1640889264450;
        Thu, 30 Dec 2021 10:34:24 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id j13sm6118314edw.89.2021.12.30.10.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 10:34:24 -0800 (PST)
Message-ID: <0e54f409-1f9e-00ec-8045-5a614197ebcf@redhat.com>
Date:   Thu, 30 Dec 2021 19:34:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] platform/x86: intel-uncore-frequency: use default_groups
 in kobj_type
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org
References: <20211229141454.2552950-1-gregkh@linuxfoundation.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211229141454.2552950-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/29/21 15:14, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the uncore-frequency sysfs code to use default_groups field
> which has been the preferred way since aa30f47cf666 ("kobject: Add
> support for default attribute groups to kobj_type") so that we can soon
> get rid of the obsolete default_attrs field.
> 
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/x86/intel/uncore-frequency.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency.c
> index 3ee4c5c8a64f..4cd8254f2e40 100644
> --- a/drivers/platform/x86/intel/uncore-frequency.c
> +++ b/drivers/platform/x86/intel/uncore-frequency.c
> @@ -225,6 +225,7 @@ static struct attribute *uncore_attrs[] = {
>  	&min_freq_khz.attr,
>  	NULL
>  };
> +ATTRIBUTE_GROUPS(uncore);
>  
>  static void uncore_sysfs_entry_release(struct kobject *kobj)
>  {
> @@ -236,7 +237,7 @@ static void uncore_sysfs_entry_release(struct kobject *kobj)
>  static struct kobj_type uncore_ktype = {
>  	.release = uncore_sysfs_entry_release,
>  	.sysfs_ops = &kobj_sysfs_ops,
> -	.default_attrs = uncore_attrs,
> +	.default_groups = uncore_groups,
>  };
>  
>  /* Caller provides protection */
> 

