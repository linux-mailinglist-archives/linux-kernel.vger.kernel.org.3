Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB37856BD81
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbiGHPzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbiGHPzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A3F570E51
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 08:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657295730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oKdAwSdJ/bJ3Bw0hAeddnXNTwTE7lsij6rfMDatygts=;
        b=Oq7nES0XGNZaG3dsXlsTtUcNZViQw2BHoi5YYhM5+m8SGZP1q1I+1Ewd0S9hEl9n58iaEw
        Zz8QoQ8hn9KeHP6IEjZnjH1GprUdsv9RsiaxJLn7WZoZqSaF0Mu4d7BKAMRGHEhgpDDI1J
        dRq/RMVrF63K2J9F2tQSYM4Kq5ZDcn0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-FGIuw2hsP6SlUkfg77b75Q-1; Fri, 08 Jul 2022 11:55:29 -0400
X-MC-Unique: FGIuw2hsP6SlUkfg77b75Q-1
Received: by mail-ej1-f70.google.com with SMTP id hs18-20020a1709073e9200b0072a3e7eb0beso5827451ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 08:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oKdAwSdJ/bJ3Bw0hAeddnXNTwTE7lsij6rfMDatygts=;
        b=RjN3eIkO+UgqoiV6TuGx9DE96DKl4CEMXQNlJcL69uCYUGyD6Bjsg/0ds3Q/nl95Lr
         3Y68Y/52oYdtri/qzppbvb3NzQZc3yyyCHXAOaDVselae7x5b98llklq9/jwXMcRDQZM
         o/kCpHUnvUbQdF09/sr5evdkPZ0FYO/wFgFgPaoBlV7+H4Zg5952yjHCbB1Kj4VxIsFs
         9CSVM8aZ4KJ/m+IbIyL4du795MbSRVIv4iHJHuZsTzXOt6qpJbBO8HOgZN28wfYTqyc8
         OnArQjF9dmdy1dKHkyjwEQxqLxsaLKcrVerfNQVTcWsINCR26tFB/8UEGvj6ucdxdUU/
         DSLw==
X-Gm-Message-State: AJIora8MSyAlm0U/uN7oJe1V/wbmMTfXaIpS/LS21uBRtYpmFNl89PDX
        XPFDhRRa+wOj43j799F3kCMbneJjnH6qxBUPPL1HQu77xh3MgAPoHTdzjcysolIj4E3ePRVWiRK
        Z14GTkM4vg5dQXLhBgKtdejQ1
X-Received: by 2002:a05:6402:248c:b0:437:afe7:818b with SMTP id q12-20020a056402248c00b00437afe7818bmr5677234eda.239.1657295728242;
        Fri, 08 Jul 2022 08:55:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tS6ezXylb9NB8yOq946U7TpYv2hDEboyPOJ0JMfhIrtFj8VcfNQ8NXJAahocj9nZjCtYa/Kw==
X-Received: by 2002:a05:6402:248c:b0:437:afe7:818b with SMTP id q12-20020a056402248c00b00437afe7818bmr5677225eda.239.1657295728101;
        Fri, 08 Jul 2022 08:55:28 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id fd5-20020a056402388500b00436f3107bdasm29009592edb.38.2022.07.08.08.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 08:55:27 -0700 (PDT)
Message-ID: <becfe58a-b4c3-4ae1-4ab2-456057ac7d22@redhat.com>
Date:   Fri, 8 Jul 2022 17:55:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RESEND PATCH 0/3] staging: media: atomisp: Convert to
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
References: <20220707200718.26398-1-fmdefrancesco@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220707200718.26398-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/7/22 22:07, Fabio M. De Francesco wrote:
> After waiting months, I'm resending three conversions to
> kmap_local_page(). I'd like to ask if there is anything which prevents
> these patches from being accepted.
> 
> Please note that these patches were submitted on April 2022.
> 
> For you convenience here are the links to the patches, the "Reviewed-by:" 
> and "Tested-by:" tags:
> 
> [PATCH] staging: media: atomisp: Use kmap_local_page() in hmm_store()
> https://lore.kernel.org/lkml/20220413225531.9425-1-fmdefrancesco@gmail.com/
> https://lore.kernel.org/lkml/Yli+R7iLZKqO8kVP@iweiny-desk3/
> https://lore.kernel.org/lkml/2d096f20-dbaa-1d49-96e9-a7ae6c19f7fe@redhat.com/
> 
> [PATCH] staging: media: atomisp: Use kmap_local_page() in hmm_set()
> https://lore.kernel.org/lkml/20220413212210.18494-1-fmdefrancesco@gmail.com/
> https://lore.kernel.org/lkml/YldNhErgt53RqYp7@iweiny-desk3/
> https://lore.kernel.org/lkml/0b04ad1a-e442-1728-ef2c-bab386a4c64c@redhat.com/
> 
> [PATCH] staging: media: atomisp: Convert kmap() to kmap_local_page()
> https://lore.kernel.org/lkml/20220408223129.3844-1-fmdefrancesco@gmail.com/
> https://lore.kernel.org/lkml/b0aed731-b56f-4378-b50e-fc0cbccbdb84@redhat.com/
> 
> Fabio M. De Francesco (3):
>   staging: media: atomisp: Convert kmap() to kmap_local_page()
>   staging: media: atomisp: Use kmap_local_page() in hmm_set()
>   staging: media: atomisp: Use kmap_local_page() in hmm_store()

Thanks, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

