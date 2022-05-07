Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E9F51E894
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 18:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446600AbiEGQoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 12:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446654AbiEGQoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 12:44:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07E6C2650
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 09:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651941620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=inhGipBUDTXnB2qKEYfxvYqIWIZ4u692zATmOyojLEY=;
        b=DGn71tS+FTNn/jiB0hJwTlqvs9YOZI8QMMY1QOVJNj4fotIs7SLOf5GdbYTrb3dW5eGedF
        BSojKAUMzEQBoplguA7fb1XOvrU2U+xqAdWYTkCPufXJV2VbzR1Gs89K6IKq5MnLANV5tV
        Dz1WyURenHTzXLFWgoybeG1ehnq4P8o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-dA8vIxHVMaGFce8Rzal_1A-1; Sat, 07 May 2022 12:40:19 -0400
X-MC-Unique: dA8vIxHVMaGFce8Rzal_1A-1
Received: by mail-wm1-f71.google.com with SMTP id n26-20020a1c721a000000b003941ea1ced7so2978205wmc.7
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 09:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=inhGipBUDTXnB2qKEYfxvYqIWIZ4u692zATmOyojLEY=;
        b=gkjDi1FXtCEr66SHlpBuvEHLfNTbrG66AQ0K/Ejc6WQnd7B+c93S117dypPbpGzjG+
         xTyq5BzFsKku7+FhrQAxP1300/VyH3eHcKhYbp4xDBGjR8w5k4UBnyGX31SPTvXsU2fZ
         6n81NEyUVO9kk7EgYs0GAO0QvcvcYY3LK2RconZGWUDcld0zbeI76DZKKpol//R/FBmo
         Hsexz7rM5YsD6tJHBLjRJtw5xxeL9REJFpVilNCP8C3ya7ENsPvPh9sjnfWEcpDsQzNV
         u7tPXU2IRsSR/+2Qm8XaSL/eLjPTp5ShZ/d/niO9Ne6h4dReOhofUPI2E4DMyJuWeI+v
         ouaA==
X-Gm-Message-State: AOAM533yKwz/bQS5QciuCzo+DMRJqOsWSfkyMZMnS9aXkTpUmDFdB+70
        r74pDkH4QNT3a2AWTOU1DJ9z7X5H28YOtQ/91d52OsKbivSBOT9RPMt1Ur6Lm/PKcAKlMNZXY2e
        rqPDzxc7V5ArXGuC+34b4LQGS
X-Received: by 2002:a1c:f705:0:b0:37d:f2e5:d8ec with SMTP id v5-20020a1cf705000000b0037df2e5d8ecmr15431648wmh.21.1651941618492;
        Sat, 07 May 2022 09:40:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykhasS4dK4eppFGtBqCb2g0PaleaocuXsAQca/dvV5qInWX6ynRAZXrO0TJxqEd2vidA73gA==
X-Received: by 2002:a1c:f705:0:b0:37d:f2e5:d8ec with SMTP id v5-20020a1cf705000000b0037df2e5d8ecmr15431630wmh.21.1651941618195;
        Sat, 07 May 2022 09:40:18 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e2-20020a5d5942000000b0020c5253d8e1sm7951521wri.45.2022.05.07.09.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 09:40:17 -0700 (PDT)
Message-ID: <981d7ed4-8554-73ca-bfd1-2d89e4e91af3@redhat.com>
Date:   Sat, 7 May 2022 18:40:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fbdev: efifb: Fix a use-after-free due early fb_info
 cleanup
Content-Language: en-US
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-fbdev@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Peter Jones <pjones@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>
References: <20220506132225.588379-1-javierm@redhat.com>
 <20220507162053.auo2idd5twvnxatj@ldmartin-desk2>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220507162053.auo2idd5twvnxatj@ldmartin-desk2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lucas,

On 5/7/22 18:20, Lucas De Marchi wrote:
> On Fri, May 06, 2022 at 03:22:25PM +0200, Javier Martinez Canillas wrote:
>> Commit d258d00fb9c7 ("fbdev: efifb: Cleanup fb_info in .fb_destroy rather
>> than .remove") attempted to fix a use-after-free error due driver freeing
>> the fb_info in the .remove handler instead of doing it in .fb_destroy.
>>
>> But ironically that change introduced yet another use-after-free since the
>> fb_info was still used after the free.
>>
>> This should fix for good by freeing the fb_info at the end of the handler.
>>
>> Fixes: d258d00fb9c7 ("fbdev: efifb: Cleanup fb_info in .fb_destroy rather than .remove")
> 
> are these patches going through any CI before being applied? Maybe would
> be a good idea to cc intel-gfx mailing list on these fixes to have Intel
> CI to pick them up for some tests?
>

I Cc'ed intel-gfx for this particular patch. I should had done it for the
previous patches too, but I wasn't aware that Cc'ing that list would make
it run on your CI.

I tested locally the offending patch on an EFI platform before applying it
and I don't know why it didn't fail there. Sorry all for the inconvenience.
 
> pushed to drm-misc-fixes where the previous patch was applied.
> 

Thanks.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

