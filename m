Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C86457C93F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiGUKmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbiGUKmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52083481C3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658400133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S6Oe91FRPICcN6nsmsOytc0+ZsDZ34nAjk4onRd6keo=;
        b=Vc1a7G/Knl1Dlk4q7kujdqJXvqSKqU1cTeNWe5nlaF8QvbaVfPRKCNoFFlWu6627XTK5n5
        3dDekguRrLaDjPyGsQXLWHj8VYTHR6+symJGosb6k1eoeOg6k2dJIwNHvkM0Jt9RJLKYIc
        R7tVIStxfCMjHkJJzLcgHnAqK7qK0ak=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-BaFXTEAAPk6jtXTqiC_ohw-1; Thu, 21 Jul 2022 06:42:09 -0400
X-MC-Unique: BaFXTEAAPk6jtXTqiC_ohw-1
Received: by mail-ed1-f71.google.com with SMTP id b7-20020a056402350700b0043baadc4a58so879212edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=S6Oe91FRPICcN6nsmsOytc0+ZsDZ34nAjk4onRd6keo=;
        b=wHPpFbFZqrkvHK2Bo3a3wIa8CoE65ByOOKm43U1bN6dAaLDbtl2RIENezZ5Rf44R/f
         8j20frDQwkV0mTji6R0mnKg+n++kvlUas0CarNHnjb6HdmhB+gosgLAEkrNvY8ZzKSiS
         IP0emP8Cmo6x/QGJ+jClj2f1vDqKjkPc3T4P/cnsUBlkQimGdb50OP/8deVkjv21Aosy
         pcz3Bspp0YYraYXeT2xOtN/o+S0HQDtc2xVPRkdm0XRoMRoc/tx7yVenIAb99m+jYybv
         cFQaApR+sHJPk5ATmtBQIRit4PX5Jq2oNq2gHR/62qjdwU4NYV1oGNakV5jOuoqwnpQY
         bKPw==
X-Gm-Message-State: AJIora+ym/bB8PSO2cAyQny9u9i9EBWSVTWW4tNOvQCSK4s3UuuTkeoO
        EK3iVMk+3gpoVJF30WjgBwRWUowaBu77SFy+/3Dx5ZA09Iiq4rsjmH4RLO6wcNSdzYyurPlV1R3
        Q6SmvxhAKL1oXsbaLuPDgFE42
X-Received: by 2002:aa7:d9ce:0:b0:43a:6758:7652 with SMTP id v14-20020aa7d9ce000000b0043a67587652mr56423053eds.351.1658400128456;
        Thu, 21 Jul 2022 03:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v17EzhGOch3a86h6Zsqe2LPHMxB/daHzlg6AZ3KMDLM8+xOpfJmbSL9eUobzfldn8e8sBHvg==
X-Received: by 2002:aa7:d9ce:0:b0:43a:6758:7652 with SMTP id v14-20020aa7d9ce000000b0043a67587652mr56423023eds.351.1658400128121;
        Thu, 21 Jul 2022 03:42:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b40:2ee8:642:1aff:fe31:a15c? ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id v15-20020a17090606cf00b0072b810897desm680205ejb.105.2022.07.21.03.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 03:42:07 -0700 (PDT)
Message-ID: <94904971-94b6-4e6f-3297-8ef4d1a04c30@redhat.com>
Date:   Thu, 21 Jul 2022 12:42:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH drm-misc-next v5 1/4] drm/fb: rename FB CMA helpers to FB
 DMA helpers
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     daniel@ffwll.ch, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, tzimmermann@suse.de, mripard@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220720153128.526876-1-dakr@redhat.com>
 <20220720153128.526876-2-dakr@redhat.com> <Ytg596Lk4kumqeRD@ravnborg.org>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <Ytg596Lk4kumqeRD@ravnborg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 7/20/22 19:23, Sam Ravnborg wrote:
> Hi Danilo,
> 
> On Wed, Jul 20, 2022 at 05:31:25PM +0200, Danilo Krummrich wrote:
>> Rename "FB CMA" helpers to "FB DMA" helpers - considering the hierarchy
>> of APIs (mm/cma -> dma -> fb dma) calling them "FB DMA" seems to be
>> more applicable.
>>
>> Besides that, commit e57924d4ae80 ("drm/doc: Task to rename CMA helpers")
>> requests to rename the CMA helpers and implies that people seem to be
>> confused about the naming.
>>
>> In order to do this renaming the following script was used:
>>
>> ```
>> 	#!/bin/bash
>>
>> 	DIRS="drivers/gpu include/drm Documentation/gpu"
>>
>> 	REGEX_SYM_UPPER="[0-9A-Z_\-]"
>> 	REGEX_SYM_LOWER="[0-9a-z_\-]"
>>
>> 	REGEX_GREP_UPPER="(${REGEX_SYM_UPPER}*)(FB)_CMA_(${REGEX_SYM_UPPER}*)"
>> 	REGEX_GREP_LOWER="(${REGEX_SYM_LOWER}*)(fb)_cma_(${REGEX_SYM_LOWER}*)"
>>
>> 	REGEX_SED_UPPER="s/${REGEX_GREP_UPPER}/\1\2_DMA_\3/g"
>> 	REGEX_SED_LOWER="s/${REGEX_GREP_LOWER}/\1\2_dma_\3/g"
>>
>> 	# Find all upper case 'CMA' symbols and replace them with 'DMA'.
>> 	for ff in $(grep -REHl "${REGEX_GREP_UPPER}" $DIRS)
>> 	do
>> 	       sed -i -E "$REGEX_SED_UPPER" $ff
>> 	done
>>
>> 	# Find all lower case 'cma' symbols and replace them with 'dma'.
>> 	for ff in $(grep -REHl "${REGEX_GREP_LOWER}" $DIRS)
>> 	do
>> 	       sed -i -E "$REGEX_SED_LOWER" $ff
>> 	done
>>
>> 	# Replace all occurrences of 'CMA' / 'cma' in comments and
>> 	# documentation files with 'DMA' / 'dma'.
>> 	for ff in $(grep -RiHl " cma " $DIRS)
>> 	do
>> 		sed -i -E "s/ cma / dma /g" $ff
>> 		sed -i -E "s/ CMA / DMA /g" $ff
>> 	done
>> ```
>>
>> Only a few more manual modifications were needed, e.g. reverting the
>> following modifications in some DRM Kconfig files
>>
>>      -       select CMA if HAVE_DMA_CONTIGUOUS
>>      +       select DMA if HAVE_DMA_CONTIGUOUS
>>
>> as well as manually picking the occurrences of 'CMA'/'cma' in comments and
>> documentation which relate to "FB CMA", but not "GEM CMA".
>>
>> This patch is compile-time tested building a x86_64 kernel with
>> `make allyesconfig && make drivers/gpu/drm`.
>>
>> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> 
> For the most part I like the patch.
> But there is a few cases I would like to see fixed.
> 
> 
>> diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
>> index e89ae0ec60eb..fab18135f12b 100644
>> --- a/drivers/gpu/drm/arm/hdlcd_drv.c
>> +++ b/drivers/gpu/drm/arm/hdlcd_drv.c
>> @@ -25,7 +25,7 @@
>>   #include <drm/drm_crtc.h>
>>   #include <drm/drm_debugfs.h>
>>   #include <drm/drm_drv.h>
>> -#include <drm/drm_fb_cma_helper.h>
>> +#include <drm/drm_fb_dma_helper.h>
>>   #include <drm/drm_fb_helper.h>
>>   #include <drm/drm_gem_cma_helper.h>
>>   #include <drm/drm_gem_framebuffer_helper.h>
> 
> 
> The only change in the file above is the rename of the include file.
> This is a strong hint that the include is not needed and the correct fix
> is to drop the include. There are more cases like the above.

Yep, good catch.

> 
> This is a manual process on top of what you could automate, but then I
> suggest to identify them and remove the includes before you change the
> file name.
> 
> Or if anyone applies the patches then at least do it in a follow-up at
> the places will never be easier to spot.
> 
> So with this cleanup done either before or after this patch.

I'll add anther patch to remove the unused includes before doing the 
renaming.

> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> 
> 	Sam
> 

- Danilo

