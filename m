Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9F9569F01
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbiGGKAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbiGGKAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:00:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAD8C4F19A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 03:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657188009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5BlLzfOx3FLxzW29hP5Bj1ajkUHJeIlb1UbxuDrAMzo=;
        b=bqUoLusW/JewCv8kB+6K/dJgwV0VUzmCLLYzQLXsZXSa8bGua051Yqz6xqlHEoWmzYGCPw
        QGhP478fBXnbsRkwkF5B1FVeZ2sM7+0oy5qo+e39zlW4laItmmDl8i6esCPCOIr7ZxwZRX
        wI8aWndhBesxuc8ARLooHb7Jdnazifs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-inWWG_MSMxi60dUtGys8Ww-1; Thu, 07 Jul 2022 06:00:08 -0400
X-MC-Unique: inWWG_MSMxi60dUtGys8Ww-1
Received: by mail-ed1-f71.google.com with SMTP id o11-20020a056402438b00b0043676efd75dso13708497edc.16
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 03:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=5BlLzfOx3FLxzW29hP5Bj1ajkUHJeIlb1UbxuDrAMzo=;
        b=HPRsd7qKufFixFlJAQ0Y02OpUu0rSgOvWvLFXJENNCyO6ct0JkzbDU+dN/1zhhsVB/
         edKpRaiJnMror62l0myl0bhBc6M1xRhUMV7y9Wr5dHvbcBGr7pT4VWwOKrsm7DnlmBwY
         O1ZRwdZ8S5BBkvNsgozPS33Xt8hczyv3NXkOGvQ3YVZOEcuI3iwMLMXkS91dPmVxMO9N
         gIVMMZfIqQNflzbX4jvtWKc8gJMY331Jg4F5++E2F1dn7ir8E+c2KPS7dgkgbgOzXzYp
         JM2UAsdEuzuyslGV41KNZPmhBHnXhCnAesFIqWtl+lQk3n9kRu50O1P7J/Hlh5+PQUtK
         WHDQ==
X-Gm-Message-State: AJIora/GSmbG3YbRmAu3/vy0EXZ70DBPthsSJtVMH2jNxuxdmsfq928p
        6+5QrpFYrJavOmly1fnN1ayio6kcKYVJR/NChQeGWmmROGV9f7Fi33GjrU+4A93uiuwTtXNrNrm
        pYCCFrz8XJ8H/DcQA48JS+cdw
X-Received: by 2002:a17:906:4ccc:b0:6fe:9155:47ae with SMTP id q12-20020a1709064ccc00b006fe915547aemr42781584ejt.246.1657188006735;
        Thu, 07 Jul 2022 03:00:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vCcqxxR9iYFoEqi0TCN+XK4jUnidd2zGq8y1AASMZW6c4WUTTDCUQ6aEVHyqlMF/LQ2T/HNw==
X-Received: by 2002:a17:906:4ccc:b0:6fe:9155:47ae with SMTP id q12-20020a1709064ccc00b006fe915547aemr42781562ejt.246.1657188006501;
        Thu, 07 Jul 2022 03:00:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b40:2ee8:642:1aff:fe31:a15c? ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id g17-20020aa7c591000000b0043a4a5813d8sm9613259edq.2.2022.07.07.03.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 03:00:06 -0700 (PDT)
Message-ID: <a063d7f3-cacf-c51a-a306-5acd85b680d8@redhat.com>
Date:   Thu, 7 Jul 2022 12:00:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/4] drm/gem: rename struct drm_gem_dma_object.{paddr
 => dma_addr}
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220706124352.874528-1-dakr@redhat.com>
 <20220706124352.874528-4-dakr@redhat.com>
 <YsXGPfKYhPsayHpv@pendragon.ideasonboard.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <YsXGPfKYhPsayHpv@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 7/6/22 19:28, Laurent Pinchart wrote:
> Hi Danilo,
> 
> Thank you for the patch.
> 
> On Wed, Jul 06, 2022 at 02:43:51PM +0200, Danilo Krummrich wrote:
>> The field paddr of struct drm_gem_dma_object holds a DMA address, which
>> might actually be a physical address. However, depending on the platform,
>> it can also be a bus address or a virtual address managed by an IOMMU.
>>
>> Hence, rename the field to dma_addr, which is more applicable.
>>
>> Since 'paddr' is a very commonly used term and symbol name a simple regex
>> does not do the trick. Instead, users of the struct were fixed up
>> iteratively with a trial and error approach building with
>> `make allyesconfig && make drivers/gpu/drm`.
> 
> Not for this patch as you've already done the work manually, but can I
> recommend the excellent coccinelle tool ? Its semantic patches can very
> easily rename structure members.
Actually, I should have and I will. It seems like there are a few 
drivers I missed with that - the ones not using CONFIG_COMPILE_TEST.

Additionally, I will also test cross-compiling for ARM and ARM64.

- Danilo
> 
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>> ---
>>   .../arm/display/komeda/komeda_framebuffer.c   |  4 ++--
>>   drivers/gpu/drm/arm/malidp_mw.c               |  2 +-
>>   drivers/gpu/drm/arm/malidp_planes.c           | 12 +++++-----
>>   drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c      |  2 +-
>>   drivers/gpu/drm/drm_fb_dma_helper.c           | 10 ++++----
>>   drivers/gpu/drm/drm_gem_dma_helper.c          | 23 +++++++++++--------
>>   drivers/gpu/drm/imx/ipuv3-plane.c             |  6 ++---
>>   drivers/gpu/drm/sprd/sprd_dpu.c               |  2 +-
>>   drivers/gpu/drm/sun4i/sun8i_ui_layer.c        | 14 +++++------
>>   drivers/gpu/drm/sun4i/sun8i_vi_layer.c        | 14 +++++------
>>   drivers/gpu/drm/tidss/tidss_dispc.c           | 16 ++++++-------
>>   drivers/gpu/drm/tiny/arcpgu.c                 |  2 +-
>>   drivers/gpu/drm/vc4/vc4_bo.c                  |  2 +-
>>   drivers/gpu/drm/vc4/vc4_gem.c                 |  8 +++----
>>   drivers/gpu/drm/vc4/vc4_irq.c                 |  2 +-
>>   drivers/gpu/drm/vc4/vc4_plane.c               |  4 ++--
>>   drivers/gpu/drm/vc4/vc4_render_cl.c           | 14 +++++------
>>   drivers/gpu/drm/vc4/vc4_txp.c                 |  2 +-
>>   drivers/gpu/drm/vc4/vc4_v3d.c                 |  4 ++--
>>   drivers/gpu/drm/vc4/vc4_validate.c            | 12 +++++-----
>>   include/drm/drm_gem_dma_helper.h              |  4 ++--
>>   21 files changed, 81 insertions(+), 78 deletions(-)
> 
> [snip]
> 
>> diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem_dma_helper.c
>> index 56fc1a1e7f87..8851d294bb53 100644
>> --- a/drivers/gpu/drm/drm_gem_dma_helper.c
>> +++ b/drivers/gpu/drm/drm_gem_dma_helper.c
> 
> [snip]
> 
>> @@ -460,10 +461,11 @@ drm_gem_dma_prime_import_sg_table(struct drm_device *dev,
>>   	if (IS_ERR(dma_obj))
>>   		return ERR_CAST(dma_obj);
>>   
>> -	dma_obj->paddr = sg_dma_address(sgt->sgl);
>> +	dma_obj->dma_addr = sg_dma_address(sgt->sgl);
>>   	dma_obj->sgt = sgt;
>>   
>> -	DRM_DEBUG_PRIME("dma_addr = %pad, size = %zu\n", &dma_obj->paddr, attach->dmabuf->size);
>> +	DRM_DEBUG_PRIME("dma_addr = %pad, size = %zu\n", &dma_obj->dma_addr,
>> +							 attach->dmabuf->size);
> 
> The second line should be aligned left, just right of the opening
> parenthesis.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
>>   
>>   	return &dma_obj->base;
>>   }
> 
> [snip]
> 

