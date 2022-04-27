Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAE451248E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbiD0VdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 17:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiD0VdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:33:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C79FCE88
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 14:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651094994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qu+9cW5R00FScE94cg2fosnaTUjfEHdj2O3XEUpsTt0=;
        b=Bp1l0OB45ujw81ruw9xJe8r7aocBkGh8GcIMsHVKobW14wMo3IuauMhZ4jz0dvjWh6oH5k
        /sF93C42SXTTsp2uEU0oFo6v+Yg5xzGgxHtsCiWQ2AwGI+lQPMJjjrKTR6cRCfG438Emm4
        KS73BqhstjFSJZGScOfh27zJVAGBDlA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-hso8EEciMt-BovbOtkkICw-1; Wed, 27 Apr 2022 17:29:52 -0400
X-MC-Unique: hso8EEciMt-BovbOtkkICw-1
Received: by mail-wm1-f70.google.com with SMTP id 26-20020a05600c021a00b003940660c053so947454wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 14:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qu+9cW5R00FScE94cg2fosnaTUjfEHdj2O3XEUpsTt0=;
        b=ueUNuMGGVQS4mlby/4gLoUFD1LfLpuklCr5TsThxo2OfM0wTIQYQHNL1w81IeDf9i1
         P7ymjWEQK2pvok3moBH5d4oLfODIXNrDIQ/hKGEHGcRd8BRSbK0m7Zdp+316usS+0K4F
         hRGUHSUkVGnvwjW6wfdY2RzwBrlC+Q5yVvl7wa4tO9Rr7rjac3GUS/3cxUzv6mb6myDG
         adwPQWkksrsssDmp0s8OX+Weku+a3X72PN/Sfpeta83Ar7OkGcoH4a7oAKIrVUHIOgto
         /pPm4XYIGpoMXfgbhdx8Uu1/DHXtgfzh7AlHNOzS33H9oyHsoy5rxFwPD4J24sgod2jF
         smHg==
X-Gm-Message-State: AOAM531WBuF2I0hRmZZ4pChp/aMnJwK71VWxtBQoLMtnkVaC/3s3Z6us
        ToWN8uuz5ULgb50BqWEXk8/tbSEle9VuLLJlqgw2/hRlRkDsovehWsvFYlZ1NgJEQPSywxq1aHm
        SBsy9ZWbDG0MgMwhRNsK17lFWaiItVNHGWjDw7G/0TJW65SO06ASIWPK0miEm7VJSdQwDQypOsU
        s=
X-Received: by 2002:a05:600c:4e8a:b0:393:f169:b261 with SMTP id f10-20020a05600c4e8a00b00393f169b261mr11087062wmq.81.1651094991444;
        Wed, 27 Apr 2022 14:29:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwp3oXACwpueXDePLHDIjsNfwNIfXXGKs7X4UsEVcT/C2ckmWjJ8qHBHGNa+RCk9TBcbbr/WA==
X-Received: by 2002:a05:600c:4e8a:b0:393:f169:b261 with SMTP id f10-20020a05600c4e8a00b00393f169b261mr11087040wmq.81.1651094991105;
        Wed, 27 Apr 2022 14:29:51 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u4-20020a5d6da4000000b0020a8c8d3e00sm15291167wrs.73.2022.04.27.14.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 14:29:50 -0700 (PDT)
Message-ID: <23074b44-27c9-ccab-dc72-c2231947bb30@redhat.com>
Date:   Wed, 27 Apr 2022 23:29:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/display: Select DP helpers for DRM_DP_AUX_CHARDEV and
 DRM_DP_CEC
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
References: <20220427202513.46996-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220427202513.46996-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 22:25, Javier Martinez Canillas wrote:
> The DRM_DP_AUX_CHARDEV and DRM_DP_CEC boolean Kconfig symbols enable code
> that use DP helper functions, exported by the display-helper module.
> 

[snip]

> @@ -32,6 +32,8 @@ config DRM_DISPLAY_HDMI_HELPER
>  config DRM_DP_AUX_CHARDEV
>  	bool "DRM DP AUX Interface"
>  	depends on DRM
> +	select DRM_DISPLAY_DP_HELPER
> +	select DRM_DISPLAY_HELPER

Actually, this is wrong since it will prevent DRM_DISPLAY_HELPER to be set
as a module (it's tristate while this symbol is bool). I now have a better
understanding of the problem and a patch that I believe is the correct one.

I'll post a v2 soon.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

