Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF5E546CB4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347716AbiFJSsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346230AbiFJSsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:48:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1B6513F5A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654886885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQJvEeLF3FaPSVIqqkc4TorYc9fXCT+vm0vr/Ev8Wck=;
        b=Me8924kzA6/bTKUV9p+6PKXxilgKHvunYSMDTghFrsO5mwYgx2XzL7EroRuiOFzSz7xbJk
        mO/ImtCR+LiF4NCOhfgyfEPaU28dOzFJptn/RuwYrGhzG1l1aB4k2BuSEMvqWERqlB0WFe
        JsDJmEOGoYU7xOlGb51d6gWqkD6GOSM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-eoP5urhqO4m4qqpqjOAzAg-1; Fri, 10 Jun 2022 14:48:04 -0400
X-MC-Unique: eoP5urhqO4m4qqpqjOAzAg-1
Received: by mail-ed1-f72.google.com with SMTP id g7-20020a056402424700b0042dee9d11d0so54054edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cQJvEeLF3FaPSVIqqkc4TorYc9fXCT+vm0vr/Ev8Wck=;
        b=of1ae8XYdTtuyNohFFgolsFboxVWGdYt3uE51y5sXWo7ygmODRJmSYtaZ2q/NWJ9mw
         cH7aANbalyYo6oyz1UrtyTo4Jb5XH64KvHRnH6Gewj6wgR+fJ2Hr6zgc5WHDyGtvroIV
         6eQBYHG4tyEIiwP3F9FKJ5eRFwVuPpdzxfMKwRK1pZUcCJqufGNNEojCHiL1m6URKp0b
         O+3gy7hsNWN9VVX/tIHJHSYnwx2CS2QO0HCLe+xQ54axg4mVrFB/C6Wm2R1JVbycfJqz
         tu5smndH/p35CG9dgDKsTOeevTcrjsLVOcHDljELCjCPZGpndb1QS4It8OmUC9rq/l1l
         FOLA==
X-Gm-Message-State: AOAM531N+Malh3R2T9wB/gDTL69VMe2MtqF8Sadzi9rT/QE6FpjpeB4o
        3PzSBCNo131syonbNUaAmNwQ9nobGDalqkcg937/r7AePv8uhDOLztCzjb2PqBUCON9sd5Jl/ou
        xgWShU3bwFYuZ+kKNKOixNUDh
X-Received: by 2002:a05:6402:5191:b0:42f:b303:ed61 with SMTP id q17-20020a056402519100b0042fb303ed61mr41996444edd.233.1654886882375;
        Fri, 10 Jun 2022 11:48:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7lXvW4sKC5uS5pmUSAk6B7E3AsjomPuvd4DXesgz0gbp4+TrP/ck0tZ0CAi4KKOttG5GVkA==
X-Received: by 2002:a05:6402:5191:b0:42f:b303:ed61 with SMTP id q17-20020a056402519100b0042fb303ed61mr41996424edd.233.1654886882160;
        Fri, 10 Jun 2022 11:48:02 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id e20-20020a056402149400b0042bd75c53casm17024484edv.83.2022.06.10.11.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 11:48:01 -0700 (PDT)
Message-ID: <01b424c3-fd5b-c60f-5b1d-6eb76fe732ea@redhat.com>
Date:   Fri, 10 Jun 2022 20:48:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] [PATCH] platform/x86/intel: Fix pmt_crashlog array
 reference
Content-Language: en-US
To:     David Arcari <darcari@redhat.com>,
        platform-driver-x86@vger.kernel.org
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Mark Gross <markgross@kernel.org>, linux-kernel@vger.kernel.org
References: <20220526203140.339120-1-darcari@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220526203140.339120-1-darcari@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/26/22 22:31, David Arcari wrote:
> The probe function pmt_crashlog_probe() may incorrectly reference
> the 'priv->entry array' as it uses 'i' to reference the array instead
> of 'priv->num_entries' as it should.  This is similar to the problem
> that was addressed in pmt_telemetry_probe via commit 2cdfa0c20d58
> ("platform/x86/intel: Fix 'rmmod pmt_telemetry' panic").
> 
> Cc: "David E. Box" <david.e.box@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: David Arcari <darcari@redhat.com>

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
>  drivers/platform/x86/intel/pmt/crashlog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmt/crashlog.c b/drivers/platform/x86/intel/pmt/crashlog.c
> index 34daf9df168b..ace1239bc0a0 100644
> --- a/drivers/platform/x86/intel/pmt/crashlog.c
> +++ b/drivers/platform/x86/intel/pmt/crashlog.c
> @@ -282,7 +282,7 @@ static int pmt_crashlog_probe(struct auxiliary_device *auxdev,
>  	auxiliary_set_drvdata(auxdev, priv);
>  
>  	for (i = 0; i < intel_vsec_dev->num_resources; i++) {
> -		struct intel_pmt_entry *entry = &priv->entry[i].entry;
> +		struct intel_pmt_entry *entry = &priv->entry[priv->num_entries].entry;
>  
>  		ret = intel_pmt_dev_create(entry, &pmt_crashlog_ns, intel_vsec_dev, i);
>  		if (ret < 0)

