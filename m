Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D89D549D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348317AbiFMTUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351207AbiFMTT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B434952E68
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655141058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yGvm3qwPoTuLTdX5NWsaOkcpvKYLKtr/ysaBv6CZIVc=;
        b=TozptT0xEY1aP5OSkkSo+GH0XDUt1LkOJXV4DM6uNDVL4mSaJYLbvW0DZyVpgsA/Dvq3Is
        WLwkGpPNIt0kVF3ZtqJ4b46smEQSQJe9RTrbk3PHJPfgLgZ8HUElwMmpo10NuNAtS/fpd3
        X9RmSVuKXM08g1j+7ORIwJeImkhX7Ys=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-AfnhMt6vOumKmHm09ZLWog-1; Mon, 13 Jun 2022 13:24:17 -0400
X-MC-Unique: AfnhMt6vOumKmHm09ZLWog-1
Received: by mail-wm1-f72.google.com with SMTP id l4-20020a05600c1d0400b0039c60535405so2774385wms.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yGvm3qwPoTuLTdX5NWsaOkcpvKYLKtr/ysaBv6CZIVc=;
        b=zt4aWBgFJhRhHeW0p998NprviVP51be9XfyLuHt6KoM5czPbKuQcZO8hFgs8jd6tWi
         07k6Awl3gwwERzcl7rQRtH188KEP+0Al0mkcckaSg/jpkLm25B0DSsMOb15UtCoZ8cKP
         jaZK7AHVUXzWlu1KLYzcVP2Sbe1aFXWWpsrsW5t56ayD7SiSiFXeb3LqJB3sA1GUDALY
         l5EQd/9ocyZ+DUn3FjV0W0VVUwbLyUCE7D0XE6Qj7cL09m+0IwXtl6fBLYU+iN6v1DfT
         cSyguIzdA5HD5pzr+qjQJylwaODAb0E7rM746U0efrgv0uL97fTCfYCLpzowhgJ8huzU
         JOjA==
X-Gm-Message-State: AJIora/wBBMH/OWn72fsNU9GpxPgni6a/KH7y2y3pN7+ZIhFzNO06GtO
        fcRRsogFKcf+ekUcwnxGkWHyZV2HQxWv9tapz3z+WHh3PnPH29wX+VodK4AwWeiEzdee/08Tntt
        sUXMuSr5Abl5RNsyXk1x4HDiNQu42Un/0zyu7NzQ3l1cEBc25g0NWi9IVEeUUJxqZxxdlVx7HKJ
        w=
X-Received: by 2002:a5d:5109:0:b0:218:40cc:a29b with SMTP id s9-20020a5d5109000000b0021840cca29bmr858421wrt.601.1655141055883;
        Mon, 13 Jun 2022 10:24:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1umQvbmUV5kyQfsWQKm16COOgbaUu2gIG10MNTDJcGldHmXD3XO1wIjQhiRvT60PcbnoxxDAQ==
X-Received: by 2002:a5d:5109:0:b0:218:40cc:a29b with SMTP id s9-20020a5d5109000000b0021840cca29bmr858386wrt.601.1655141055500;
        Mon, 13 Jun 2022 10:24:15 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d5-20020a5d5385000000b00213b93cff5fsm9082661wrv.98.2022.06.13.10.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 10:24:15 -0700 (PDT)
Message-ID: <bbddcf97-7ab2-209b-e777-1874557491a3@redhat.com>
Date:   Mon, 13 Jun 2022 19:24:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] Revert "fbdev: vesafb: Allow to be built if COMPILE_TEST
 is enabled"
Content-Language: en-US
To:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fbdev@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20220610085450.1341880-1-javierm@redhat.com>
 <YqMTI3yxmWq/f+Gp@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YqMTI3yxmWq/f+Gp@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/22 11:47, Daniel Vetter wrote:
> On Fri, Jun 10, 2022 at 10:54:50AM +0200, Javier Martinez Canillas wrote:
>> This reverts commit fa0e256450f27a7d85f65c63f05e6897954a1d53. The kernel
>> test robot reported that attempting to build the vesafb driver fails on
>> some architectures, because these don't define a `struct screen_info`.
>>
>> This leads to linking errors, for example on parisc with allyesconfig:
>>
>>   hppa-linux-ld: drivers/video/fbdev/vesafb.o: in function `vesafb_probe':
>>>> (.text+0x738): undefined reference to `screen_info'
>>>> hppa-linux-ld: (.text+0x73c): undefined reference to `screen_info'
>>    hppa-linux-ld: drivers/firmware/sysfb.o: in function `sysfb_init':
>>>> (.init.text+0x28): undefined reference to `screen_info'
>>>> hppa-linux-ld: (.init.text+0x30): undefined reference to `screen_info'
>>    hppa-linux-ld: (.init.text+0x78): undefined reference to `screen_info'
>>
>> The goal of commit fa0e256450f2 ("fbdev: vesafb: Allow to be built if
>> COMPILE_TEST is enabled") was to have more build coverage for the driver
>> but it wrongly assumed that all architectures would define a screen_info.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

