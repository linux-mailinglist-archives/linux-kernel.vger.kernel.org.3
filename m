Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B39D554782
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351766AbiFVKYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352653AbiFVKXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26A0E3A70E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655893390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q4Vd5UfRrhClnRvajU2UKtAqYXeZzT2WxiMDDNQrFZ4=;
        b=RcZNYMLf8autrN+pyEZhqCcfRFLhW+mbdz7WtsJOkVXE2eR+tO4i6rHdg5uE8crhrjV0X2
        8FGmnzDEotc9yYj7b4PXTXyNVjHZfgNistKcSfhw9cTEO/Xm97nLv+xyNAjBvm8EMt4Ozj
        jgj2IyDwkm+VgX5CZmTQyEpkS2xSKZ8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-0bj_NfqfMX2AISMpBbLW5Q-1; Wed, 22 Jun 2022 06:23:09 -0400
X-MC-Unique: 0bj_NfqfMX2AISMpBbLW5Q-1
Received: by mail-ed1-f70.google.com with SMTP id g8-20020a056402090800b00433940d207eso13077472edz.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q4Vd5UfRrhClnRvajU2UKtAqYXeZzT2WxiMDDNQrFZ4=;
        b=Zby2lT03t4h0D3OUnZlKu3PCQvxhSBqT9X7aEd93T5OcWjAQVK60rewXqlSSXg89PW
         KJxpSE74qu4g8kzGextdjYP7POT9IeGdg13PW7axQO2iZ5pBbF43YIrcDqH4TsAuKS57
         jpjtid/5ZnfJrqMjgMhEEYWlpEu2+N7DcRlKR77jvn1YulKqs2k/Bksmxzo4VVR2hUav
         ny9UcX96LXs956Fi3cqqzIap5lW1EqUEaDVOpR1FymkKS1ZIvSqBKv1bQ4yCOGW6Mht9
         yfVRXpn2cTEyiUnwnjnf8QFKrdBGwvEPldjVTxBXUWtjKm3wMIfffD2rO7CFDDEF16AT
         Uqxw==
X-Gm-Message-State: AJIora8bmufaCSRbI9QPke5w3tc6TFF1s+kDkoZTfYb4+yh/o03A2BzG
        Fwc16BDwENrD6zBKm+tL8VqYp+Z8jUg4WF4YpSudpoHICIE2edxGQLjz/+mdPmE4/jxv/R4qU4V
        paIW7QKTBXp5wqFzMPbV01diS
X-Received: by 2002:a05:6402:149:b0:431:7dde:9b59 with SMTP id s9-20020a056402014900b004317dde9b59mr3240980edu.339.1655893388216;
        Wed, 22 Jun 2022 03:23:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uLmcag7vtQWJsjDk69I3LaddPH5DLFa9DAzI9sfx5/q9tJLuEQEmoAZ+f2nmyMAfvAz7d2DA==
X-Received: by 2002:a05:6402:149:b0:431:7dde:9b59 with SMTP id s9-20020a056402014900b004317dde9b59mr3240961edu.339.1655893388064;
        Wed, 22 Jun 2022 03:23:08 -0700 (PDT)
Received: from [192.168.43.127] ([109.37.135.195])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709063d2200b006fecf74395bsm9039127ejf.8.2022.06.22.03.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 03:23:07 -0700 (PDT)
Message-ID: <caaca84e-1cc4-bf81-f705-fdabe2313d71@redhat.com>
Date:   Wed, 22 Jun 2022 12:23:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1] platform/x86: intel/pmc: Add Alder Lake N support to
 PMC core driver
Content-Language: en-US
To:     Gayatri Kammela <gayatri.kammela@linux.intel.com>
Cc:     irenic.rajneesh@gmail.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>
References: <20220615002751.3371730-1-gayatri.kammela@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220615002751.3371730-1-gayatri.kammela@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/15/22 02:27, Gayatri Kammela wrote:
> Add Alder Lake N (ADL-N) to the list of the platforms that Intel's
> PMC core driver supports. RocketLake reuses all the TigerLake PCH IPs.
> 
> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: David E. Box <david.e.box@linux.intel.com>
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
>  drivers/platform/x86/intel/pmc/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 40183bda7894..a1fe1e0dcf4a 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1911,6 +1911,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>  	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&icl_reg_map),
>  	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&tgl_reg_map),
>  	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&tgl_reg_map),
> +	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&tgl_reg_map),
>  	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_reg_map),
>  	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &tgl_reg_map),
>  	{}
> 
> base-commit: b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3

