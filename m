Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E2359D1E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240627AbiHWHUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240547AbiHWHUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849C261B17
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661239198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hs7LaJusbzewq19gjdvDDnrR8mb0KyO4+8e+b1s4GsY=;
        b=ZmANCAZuCXh4PUajuX6pS5RnAR+nV7kcrzPX/tgxgPx/K+IJepU0BAEmTrduvL02Txb7dy
        Mwb+Vpdj3rvgIS62J9CHRQ/xVz0mAGSCx4R4rjzOCB6NmYTYuET3VomyZpprAeYCigFSxL
        5zVB6qYRDC2DXGJatLtwY+9zQAzTejg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-475-Fr_43cKwPny3soR5NoeWjg-1; Tue, 23 Aug 2022 03:19:56 -0400
X-MC-Unique: Fr_43cKwPny3soR5NoeWjg-1
Received: by mail-wm1-f69.google.com with SMTP id i132-20020a1c3b8a000000b003a537064611so7530689wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=Hs7LaJusbzewq19gjdvDDnrR8mb0KyO4+8e+b1s4GsY=;
        b=nzknxjEbg/6PAAB5y/7b3RWzI+ghFmQYvdirmeYFeHxpmgiluxKTb3MulyXiBXCRAl
         /8jGGlhDYCU+2Lklj0sy2qdqRIkekCd3Z9cr1QsSiqkWnJGY4vCipQqmHvLcjsMZLjto
         hWXi6tAGf4CQmB+qWB0Q4dXZmiNL12NYXA2iRvs+QhYU1tVnBzJeV1MRXKW6YBXYu2S/
         4/Thh+m0GMFLN2+LBLtEXlZvxiKKti/VYrGbNm8f53/4QcEkm89qdwT2XsjRw9FQ6a9W
         CrH5q2o0DV5sdWoOgYcm8V5pLERMJLHqJf+juxNUdtPwOcuavKB7NpEE3RkPnLbL92EW
         8dlQ==
X-Gm-Message-State: ACgBeo3GOXTqx+oCIdV/pZH/UHsu0mxy2HvIkRBZYUJRakpBrQ52DPHR
        tDWgOUIG0CW+eqhkQbUypWVognrdAmqyP3HPnQwmF1ZRlp8SbE/LMC4c3YqfKglfCdXBbdxPwf0
        +zrHFRIYb2AIJDkJwS7KOPY5U
X-Received: by 2002:a05:600c:4e45:b0:3a5:f383:b917 with SMTP id e5-20020a05600c4e4500b003a5f383b917mr1191625wmq.61.1661239195845;
        Tue, 23 Aug 2022 00:19:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7PodDLS/vNSvRNlNhwQt9d+MLAK2dUzwryvTeI3ossUG3lgTEZFazWxtHKJSxP9A6EWrzFAw==
X-Received: by 2002:a05:600c:4e45:b0:3a5:f383:b917 with SMTP id e5-20020a05600c4e4500b003a5f383b917mr1191611wmq.61.1661239195612;
        Tue, 23 Aug 2022 00:19:55 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id bn26-20020a056000061a00b0021d7b41255esm13578498wrb.98.2022.08.23.00.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 00:19:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Wei Liu <wei.liu@kernel.org>,
        Deepak Rawat <drawat.floss@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v1 2/4] drm/hyperv: Don't forget to put PCI device when
 removing conflicting FB fails
In-Reply-To: <PH0PR21MB3025F3C8768EB3ADE16E8B9AD7719@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220818142508.402273-1-vkuznets@redhat.com>
 <20220818142508.402273-3-vkuznets@redhat.com>
 <PH0PR21MB3025F3C8768EB3ADE16E8B9AD7719@PH0PR21MB3025.namprd21.prod.outlook.com>
Date:   Tue, 23 Aug 2022 09:19:54 +0200
Message-ID: <87zgfvwhnp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Kelley (LINUX)" <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Thursday, August 18, 2022 7:25 AM
>> 
>> When drm_aperture_remove_conflicting_pci_framebuffers() fails, 'pdev'
>> needs to be released with pci_dev_put().
>> 
>> Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic video device")
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
>> b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
>> index 46f6c454b820..ca4e517b95ca 100644
>> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
>> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
>> @@ -82,7 +82,7 @@ static int hyperv_setup_gen1(struct hyperv_drm_device *hv)
>>  	ret = drm_aperture_remove_conflicting_pci_framebuffers(pdev,
>> &hyperv_driver);
>>  	if (ret) {
>>  		drm_err(dev, "Not able to remove boot fb\n");
>> -		return ret;
>> +		goto error;
>>  	}
>> 
>>  	if (pci_request_region(pdev, 0, DRIVER_NAME) != 0)
>> --
>> 2.37.1
>
> This patch appears to be obsoleted by commit a0ab5abced55
> that was merged into 6.0-rc1.  Of course, it does beg the question of
> why the original function hyperv_setup_gen2(), which is now renamed
> to hyperv_setup_vram(), doesn't check the return value from
> drm_aperture_remove_conflicting_framebuffers().

AFAICT this commit (which I've obviously missed) also solves the worst
issue I'm trying to address with this series: conflict between
framebuffer and SR-IOV VF config space. It would probably still make
sense to reserve the whole FB region on Gen1 first thing and use it
as-is for DRM/FB later (Patches 3-4).

-- 
Vitaly

