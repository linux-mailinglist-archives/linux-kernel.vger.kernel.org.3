Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A4150869B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377925AbiDTLKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377896AbiDTLKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:10:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7328940E68
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650452840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TUFhF3hl2SKfIxx89PLl432LqDZkfSZvjeGeXMqsrlg=;
        b=DlP6HBVAzN85ERZBfKj73Xwblojf2/57/+XM/SD3c6wNy4SGhZq7Gxn+l5f8f9kSbqwFPU
        E+WTyGEOO3YF2+08YLt1ldp3oWBG+mr9qvaMa1Zc+dVhGrSBOTg2mNWVykhiU5HIABNpEt
        SbPwc5guF2k5wTDnAj2QHBl2BwHp5RM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-k5nJtn8_OwOZ3rYWdyVWqA-1; Wed, 20 Apr 2022 07:07:19 -0400
X-MC-Unique: k5nJtn8_OwOZ3rYWdyVWqA-1
Received: by mail-ed1-f69.google.com with SMTP id bc9-20020a056402204900b0041fe60f6ff9so977103edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TUFhF3hl2SKfIxx89PLl432LqDZkfSZvjeGeXMqsrlg=;
        b=bl2mdINz4atj7pee7go9B8wEdBlRXlq9dzqTNfO+B/a90/rfKR9L1EmAVsdGYb78Ji
         4DAzcE6Id2NoO8wGxClli2/NjxqG2XEOqwTBQDmC7klCnb/Ef1cv3kD8df/V/4KNpRum
         UF8ajIiTCaFOCGZzH2FZfrYuQbgqYBtrjOmqz2wbf+qCyACZu3jq+tsuXVf9zHQsXKR3
         wXAtMsUunioTFCsbZDjG5OMFZ5/2oXNeqcKSTFYwmOYEdcoiRKmo37KdPkou3ZFcaek2
         CpvIecvvSDrMn69T26+Krvn8l8yh9y6bdL82GycY02Fg+yRfa3DLycm7nB9Z1ZRbH6oF
         Oo5g==
X-Gm-Message-State: AOAM530kd66JF7wIX59q3WhwHUyHEkGM3DPQQvpeWnzUXdao4qBnFz/v
        FP5wr6UF1bWavN2jtmSfQRVWWiaNSmq9dop2EqLBUdUMilnf2JsPcEozAN3MwWYLLH2ChMalLar
        mDDFC3uawJBNT6/sEOVU7aUhn
X-Received: by 2002:aa7:d292:0:b0:41d:7933:1f00 with SMTP id w18-20020aa7d292000000b0041d79331f00mr22321191edq.237.1650452838091;
        Wed, 20 Apr 2022 04:07:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4xkdSFzHKfg4PBYhoD0/mOJsBUEzZ2dXQcXai1pQkf6+YZSMmE+Tg6Ubf6jiqCkiDSYI/Sw==
X-Received: by 2002:aa7:d292:0:b0:41d:7933:1f00 with SMTP id w18-20020aa7d292000000b0041d79331f00mr22321172edq.237.1650452837920;
        Wed, 20 Apr 2022 04:07:17 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id u6-20020a170906408600b006e87d654270sm6560779ejj.44.2022.04.20.04.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 04:07:17 -0700 (PDT)
Message-ID: <2d096f20-dbaa-1d49-96e9-a7ae6c19f7fe@redhat.com>
Date:   Wed, 20 Apr 2022 13:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] staging: media: atomisp: Use kmap_local_page() in
 hmm_store()
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
References: <20220413225531.9425-1-fmdefrancesco@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220413225531.9425-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/14/22 00:55, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page()
> where it is feasible. The same is true for kmap_atomic().
> 
> In file pci/hmm/hmm.c, function hmm_store() test if we are in atomic
> context and, if so, it calls kmap_atomic(), if not, it calls kmap().
> 
> First of all, in_atomic() shouldn't be used in drivers. This macro
> cannot always detect atomic context; in particular, it cannot know
> about held spinlocks in non-preemptible kernels.
> 
> Notwithstanding what it is said above, this code doesn't need to care
> whether or not it is executing in atomic context. It can simply use
> kmap_local_page() / kunmap_local() that can instead do the mapping /
> unmapping regardless of the context.
> 
> With kmap_local_page(), the mapping is per thread, CPU local and not
> globally visible. Therefore, hmm_store()() is a function where the use
> of kmap_local_page() in place of both kmap() and kmap_atomic() is
> correctly suited.
> 
> Convert the calls of kmap() / kunmap() and kmap_atomic() /
> kunmap_atomic() to kmap_local_page() / kunmap_local() and drop the
> unnecessary tests which test if the code is in atomic context.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>


I've successfully tested this on both the front and back cams
of a chuwi hi8 tablet:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/staging/media/atomisp/pci/hmm/hmm.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm.c b/drivers/staging/media/atomisp/pci/hmm/hmm.c
> index 46ac082cd3f1..54188197c3dc 100644
> --- a/drivers/staging/media/atomisp/pci/hmm/hmm.c
> +++ b/drivers/staging/media/atomisp/pci/hmm/hmm.c
> @@ -482,10 +482,7 @@ int hmm_store(ia_css_ptr virt, const void *data, unsigned int bytes)
>  		idx = (virt - bo->start) >> PAGE_SHIFT;
>  		offset = (virt - bo->start) - (idx << PAGE_SHIFT);
>  
> -		if (in_atomic())
> -			des = (char *)kmap_atomic(bo->page_obj[idx].page);
> -		else
> -			des = (char *)kmap(bo->page_obj[idx].page);
> +		des = (char *)kmap_local_page(bo->page_obj[idx].page);
>  
>  		if (!des) {
>  			dev_err(atomisp_dev,
> @@ -512,14 +509,7 @@ int hmm_store(ia_css_ptr virt, const void *data, unsigned int bytes)
>  
>  		clflush_cache_range(des, len);
>  
> -		if (in_atomic())
> -			/*
> -			 * Note: kunmap_atomic requires return addr from
> -			 * kmap_atomic, not the page. See linux/highmem.h
> -			 */
> -			kunmap_atomic(des - offset);
> -		else
> -			kunmap(bo->page_obj[idx].page);
> +		kunmap_local(des);
>  	}
>  
>  	return 0;

