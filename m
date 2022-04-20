Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E3F508696
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377900AbiDTLJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377896AbiDTLJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B44C529C81
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650452828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UwOF3HOL5RSWCpIsMDkzBg+WBg3G3TFS0qjQ6oEuYGo=;
        b=V5KjpUwrrFUtna1aR9oGlipgpUews6pVZtX73SsBXR5FyQl9ndVuUaItDDoQNC14Cto9SG
        Cj8KSZmFc9PHl6dTNitZ48LTNy1EU9PnRdHMcs+diYaVDXBq2/4DSXirS8Rk4Tv0/RUUHr
        VIvJhvow01eRHIepjZDziTTfCkNILfc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-cFxE2s6WNqOKEGqSHR2-9Q-1; Wed, 20 Apr 2022 07:07:07 -0400
X-MC-Unique: cFxE2s6WNqOKEGqSHR2-9Q-1
Received: by mail-ed1-f72.google.com with SMTP id n4-20020a5099c4000000b00418ed58d92fso994003edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UwOF3HOL5RSWCpIsMDkzBg+WBg3G3TFS0qjQ6oEuYGo=;
        b=4Ir3vq8u9s+A20MraV6DW8OhZbc83x6L5dRR6szyxguz4JwRkwPR4hXEvp8B3KBXHJ
         LasefChN1unW0IQYC3KnWljBylWX22Ct8YF6rv2E+0WfZaYgm5mUw7rCIOit70rbGX9w
         Or/WpsQf1beUTRPbuLy+JKFHyQ/0ejKidhm1p7fxYqugZR+omxZDFlZPxJb4bahsiTXJ
         OJu7YMJqsLqZoXIZKHXFWEQU671mn8yARGSwALsOhQ1YV4sNxylTPSVddm/d921hAjcQ
         nN9tLE2mRmiR5UYFoXSsKJ2ZSAI/EpYZRtlvkp6S7SX3LpGw5OdE1Y5vIcLX7OJCwNLX
         hq/A==
X-Gm-Message-State: AOAM53017eWZfdYPSBrI4/L+d0VY/GBWCv72Uke5DzV69jMGE5ADJypp
        FJM1MnXHecifuPdaJwBTLGsTloBHXco9+7x1Cj1CXRPwGs9FY77BT/+W/wJTXWuvrHMsNqa7h3H
        FUAaeYa7CQ8bjF21HdDQ6ClXK
X-Received: by 2002:a05:6402:608:b0:41e:ce5:f02d with SMTP id n8-20020a056402060800b0041e0ce5f02dmr22940024edv.104.1650452826545;
        Wed, 20 Apr 2022 04:07:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKbC85ZGMPknAiJCsVTUPZVUdQiALgx50L9YEQctGci04sT/7JOLUTRhYvUOLdSGyH3zdyLg==
X-Received: by 2002:a05:6402:608:b0:41e:ce5:f02d with SMTP id n8-20020a056402060800b0041e0ce5f02dmr22940009edv.104.1650452826359;
        Wed, 20 Apr 2022 04:07:06 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id cw23-20020a056402229700b00421c1574f01sm9117548edb.9.2022.04.20.04.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 04:07:05 -0700 (PDT)
Message-ID: <0b04ad1a-e442-1728-ef2c-bab386a4c64c@redhat.com>
Date:   Wed, 20 Apr 2022 13:07:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] staging: media: atomisp: Use kmap_local_page() in
 hmm_set()
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Martiros Shakhzadyan <vrzh@vrzh.net>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        outreachy@lists.linux.dev
References: <20220413212210.18494-1-fmdefrancesco@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220413212210.18494-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/13/22 23:22, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page()
> where it is feasible. In file pci/hmm/hmm.c, function hmm_set() calls
> kmap() / kunmap() where kmap_local_page() can instead do the mapping.
> 
> With kmap_local_page(), the mapping is per thread, CPU local and not
> globally visible. Therefore, hmm_set()() is a function where the use
> of kmap_local_page() in place of kmap() is correctly suited.
> 
> Convert the calls of kmap() / kunmap() to kmap_local_page() /
> kunmap_local().
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>


I've successfully tested this on both the front and back cams
of a chuwi hi8 tablet:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/staging/media/atomisp/pci/hmm/hmm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm.c b/drivers/staging/media/atomisp/pci/hmm/hmm.c
> index 6394385b6637..46ac082cd3f1 100644
> --- a/drivers/staging/media/atomisp/pci/hmm/hmm.c
> +++ b/drivers/staging/media/atomisp/pci/hmm/hmm.c
> @@ -563,7 +563,7 @@ int hmm_set(ia_css_ptr virt, int c, unsigned int bytes)
>  		idx = (virt - bo->start) >> PAGE_SHIFT;
>  		offset = (virt - bo->start) - (idx << PAGE_SHIFT);
>  
> -		des = (char *)kmap(bo->page_obj[idx].page) + offset;
> +		des = (char *)kmap_local_page(bo->page_obj[idx].page) + offset;
>  
>  		if ((bytes + offset) >= PAGE_SIZE) {
>  			len = PAGE_SIZE - offset;
> @@ -579,7 +579,7 @@ int hmm_set(ia_css_ptr virt, int c, unsigned int bytes)
>  
>  		clflush_cache_range(des, len);
>  
> -		kunmap(bo->page_obj[idx].page);
> +		kunmap_local(des);
>  	}
>  
>  	return 0;

