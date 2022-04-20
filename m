Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9973508694
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377891AbiDTLJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345841AbiDTLJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:09:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0C70289B5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650452816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nAoKseYG0ZFXZ4TIIvPqFWraz/lYMRREh5HCpMpt4SA=;
        b=Da2jmX2GOFjOwzsQlyquc1OxhNKXyHyz3OPUXP/Oy2lyC41HALtzaXxMxNo7s6FFUrc3Rf
        33LL+24+onHMeHiwgZ2VpcGUn5c3cG2meNW+VwozMA7v58KoxMDxCE5bcXcJ6ZvilF4Zbp
        WE2s805cpfpoIb9bO4GS2II1/GvvbN4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-mmW3oFlXOPusIZm1zMpDdw-1; Wed, 20 Apr 2022 07:06:55 -0400
X-MC-Unique: mmW3oFlXOPusIZm1zMpDdw-1
Received: by mail-ed1-f71.google.com with SMTP id w8-20020a50d788000000b00418e6810364so958317edi.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nAoKseYG0ZFXZ4TIIvPqFWraz/lYMRREh5HCpMpt4SA=;
        b=7KLU1vXi7XK8d8HGH/bNlvUQ3QcuVbkb2GUSkHSDMGnISKMCPRNAW/RYe6A1mXmXRd
         I5ZwU0x55vkiJjadeDAgmzf0lCkBOPER7bH+q/+BgDM55dc1biUcBEtQ8+oH9sroPLOd
         tq+bHRief2GWtfA76Fr/izAAxta6vQJfoISIOOzQ64Cgu+/nAJMbrUxT4RKdz7dQAtQN
         wG8o39rHjYnjWe8oECEm10muxEsovj7I/3U2GeU2u4gDFSjpagqqPun3dung/MACNFpa
         n9of8jbg0MPk4kePCV3KeJYJYVcnqms4iDLE4XAiCvQX3gNka3jIa4gX81CocLWnNPl1
         Ar5w==
X-Gm-Message-State: AOAM533J74a4MCg18IqRDFXF0xzRY3hukggfG5KZeSiczxo0m/HVANk9
        3dB4xYUoyRLtb+zx3nQ7j/s4pbV9TPL/y/xVeVZcg6MzCwQzMbpuPngRLAu3fdA2RDHcDFlcRuX
        IIstnRkLWWco6ZN8k/1PHOjsv
X-Received: by 2002:aa7:d553:0:b0:416:4dfc:126d with SMTP id u19-20020aa7d553000000b004164dfc126dmr22214672edr.213.1650452813009;
        Wed, 20 Apr 2022 04:06:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4lQnFeV1UHw8eIKZeNMMfyCfsjkXPEdIsO3tYie3sWTmFFwMJD3/SNL1PcBjG6qYKpen0OQ==
X-Received: by 2002:aa7:d553:0:b0:416:4dfc:126d with SMTP id u19-20020aa7d553000000b004164dfc126dmr22214651edr.213.1650452812873;
        Wed, 20 Apr 2022 04:06:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id yy18-20020a170906dc1200b006d6e5c75029sm6477872ejb.187.2022.04.20.04.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 04:06:52 -0700 (PDT)
Message-ID: <b0aed731-b56f-4378-b50e-fc0cbccbdb84@redhat.com>
Date:   Wed, 20 Apr 2022 13:06:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] staging: media: atomisp: Convert kmap() to
 kmap_local_page()
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Martiros Shakhzadyan <vrzh@vrzh.net>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
References: <20220408223129.3844-1-fmdefrancesco@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220408223129.3844-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/9/22 00:31, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page() where
> it is feasible. With kmap_local_page(), the mapping is per thread, CPU
> local and not globally visible.
> 
> load_and_flush_by_kmap() is a function where the use of kmap_local_page()
> in place of kmap() is correctly suited.
> 
> Convert load_and_flush_by_kmap() from kmap() to kmap_local_page().
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
> index c1cda16f2dc0..6394385b6637 100644
> --- a/drivers/staging/media/atomisp/pci/hmm/hmm.c
> +++ b/drivers/staging/media/atomisp/pci/hmm/hmm.c
> @@ -350,7 +350,7 @@ static int load_and_flush_by_kmap(ia_css_ptr virt, void *data,
>  		idx = (virt - bo->start) >> PAGE_SHIFT;
>  		offset = (virt - bo->start) - (idx << PAGE_SHIFT);
>  
> -		src = (char *)kmap(bo->page_obj[idx].page) + offset;
> +		src = (char *)kmap_local_page(bo->page_obj[idx].page) + offset;
>  
>  		if ((bytes + offset) >= PAGE_SIZE) {
>  			len = PAGE_SIZE - offset;
> @@ -369,7 +369,7 @@ static int load_and_flush_by_kmap(ia_css_ptr virt, void *data,
>  
>  		clflush_cache_range(src, len);
>  
> -		kunmap(bo->page_obj[idx].page);
> +		kunmap_local(src);
>  	}
>  
>  	return 0;

