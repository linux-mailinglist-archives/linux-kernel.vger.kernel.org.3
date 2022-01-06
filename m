Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1723F486798
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 17:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbiAFQ0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 11:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241167AbiAFQ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:26:36 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133A7C061245;
        Thu,  6 Jan 2022 08:26:36 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a18so10464221edj.7;
        Thu, 06 Jan 2022 08:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M3WBgNvuzR0WIM72X4IIZhdl+Kt7G0oeF/Hg+m6AnQQ=;
        b=fgiBBLNYIvYGIfdhyPt4wlDj5rXuxLmRzyNOioyVzzAUKj4l3Caq6fqK9F2EsIHX4I
         X4HlCLY/Z0X8Imh4hK8c/IUQPlTTteF7PV185QA3p/gtCMS8jBTLoWndm5NQzRo/HhKl
         Nfzm/wEL6Ug8PUl+nFhKfaKS3Cpa6qigrWMjJAfV+Xa4uF1t37FKDYU6hygy3FTxu6EW
         WFKpGeFU44cT3zVqQYXSpvR9MVqTYHAxqj0OSdHqrtgmm7ILScJav6crXJFK1Vdfcy2z
         L4MlteqfpRl/3cODA32ciAsahNPrTnXuUftywFoc6esuJKy8l5MlM+G4Gzn7okOim+Wz
         xnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M3WBgNvuzR0WIM72X4IIZhdl+Kt7G0oeF/Hg+m6AnQQ=;
        b=gl6vccp8vhMkyaFnzhryIv0zTKbG9F2bRVHYoGVX4B/6FsJ9L9xUbLjfg44oE3vPGM
         zeRKsnWewTPDuE1XgEasY4M9iTku1MU9QcHenBsHU5IKRikuMB1dI7TsrLx/NoK0KcPI
         1scnwZ2lr8yqlJpk09qFJV9cnw2XP+kUyXzqmpRbAuBduott6M1qJmG1RbGqYGKzNUKV
         KkzcBzTGJLmAdwswaBDjjRPWARBNhb051g68FWdCGay34DKBAQvTZqPVLLY75k6n/cxt
         nUjLklx/93emLmQeVWMu2p3GcWILP3KqR9KsBD01U07lRXyk1YqrMNo6s3vSDzB/2Siy
         PXSQ==
X-Gm-Message-State: AOAM530nbyUAdq2KRkbWt0E8plkEqKimv4YilvjCVvrf7V9MPCwcDoGv
        P7wB+34pT0p5jm0C68jvfZ01NEIQrco=
X-Google-Smtp-Source: ABdhPJzkLPEDxZ+Q9y6t19YtLkNWFcwnXI5cBQncyffs1BgDiayMRg1pyYzUb7voCgh6Ar0CWePj4w==
X-Received: by 2002:a17:907:97cd:: with SMTP id js13mr46470367ejc.497.1641486388365;
        Thu, 06 Jan 2022 08:26:28 -0800 (PST)
Received: from [192.168.1.10] ([46.249.74.23])
        by smtp.googlemail.com with ESMTPSA id p8sm889653edq.46.2022.01.06.08.26.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jan 2022 08:26:27 -0800 (PST)
Subject: Re: [PATCH] drm: omapdrm: Fix implicit dma_buf fencing
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        sumit.semwal@linaro.org, christian.koenig@amd.com
Cc:     openpvrsgx-devgroup@letux.org, merlijn@wizzup.org,
        philipp@uvos.xyz, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-omap@vger.kernel.org
References: <1641397018-29872-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <0ba4b947-57e0-8a80-68d6-a481d5145ab4@ideasonboard.com>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <e55b3d0f-2217-c949-f166-63ca738b44f6@gmail.com>
Date:   Thu, 6 Jan 2022 18:26:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0ba4b947-57e0-8a80-68d6-a481d5145ab4@ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6.01.22 г. 15:43 ч., Tomi Valkeinen wrote:
> Hi,
> 
> On 05/01/2022 17:36, Ivaylo Dimitrov wrote:
>> Currently omapdrm driver does not initialize dma_buf_export_info resv
>> member, which leads to a new dma_resv being allocated and attached to
>> the exported dma_buf. This leads to the issue that fences created on
>> dma_buf objects imported by other drivers are ignored by omapdrm, as only
>> fences in gem object resv are waited on. This leads to various issues 
>> like
>> displaying incomplete frames.
>>
>> Fix that by initializing dma_buf resv to the resv of the gem object being
>> exported.
>>
>> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>> ---
>>   drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c 
>> b/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c
>> index f1f93cabb61e..a111e5c91925 100644
>> --- a/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c
>> +++ b/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c
>> @@ -88,6 +88,7 @@ struct dma_buf *omap_gem_prime_export(struct 
>> drm_gem_object *obj, int flags)
>>       exp_info.size = omap_gem_mmap_size(obj);
>>       exp_info.flags = flags;
>>       exp_info.priv = obj;
>> +    exp_info.resv = obj->resv;
>>       return drm_gem_dmabuf_export(obj->dev, &exp_info);
>>   }
> 
> Thanks! Pushed to drm-misc-next.
> 

Thanks,

I think lts kernels shall get that fix too, but I have no idea how :) .

Ivo.
