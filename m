Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1B251752B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386351AbiEBQ6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242965AbiEBQ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:58:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 837C12C8
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 09:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651510514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xIzcVGz7jvv3xeuZxkzYe3VCF5DB6mpSZGaw7yGILbk=;
        b=SDtSlUc13IxTk2d2uTpkbrEQb/AR1rEp0VgyNjrMKfMcEiyDlCtE+CyXywytNhHzm+klds
        MisVw+JGvj128/KoQIwEr+PMcuKp9u6W3E6Kwden5jQCyujWR7MLkLJQw9egWYhqhUpKCt
        0Ebtdxi7axwZGY4J0aXvWLAEx2TDTRE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-E6SKIEb-MjKlWtU_CdckhA-1; Mon, 02 May 2022 12:55:13 -0400
X-MC-Unique: E6SKIEb-MjKlWtU_CdckhA-1
Received: by mail-wr1-f70.google.com with SMTP id j21-20020adfa555000000b0020adb9ac14fso5488252wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 09:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xIzcVGz7jvv3xeuZxkzYe3VCF5DB6mpSZGaw7yGILbk=;
        b=6Wet0Z0Lr1u8qdxZJI5lnrKtbbAdS5INLqQ14bKH/2WACXyVRHVcrh2GE2Q7pn+Zrv
         J1LeNq2BeAEwL6fJ2DeVtNdFD5owa8FHKEiVnnl/Qe59H5+9zkpvn421zv9JPa7QPbQa
         BS6nbZonBja/lrMBIvCqP9pBhGpaaDrUMk5Dbsk2XlA0WExzp+gt170W7S+xPFI7N624
         RP2FDS0FugIT6O0kt0QZNem4kVL5s3KgK9PpM7xzRSws63UHNX0bem2t5fpeNr9iCItV
         c1rJENxkK+jSTxWxmY/EKSwwBD6aceEsPS0qNhzxzv7Wtetmg4chSrVHPc0i643XdsxM
         XUkw==
X-Gm-Message-State: AOAM533GsVrbDRru2nY/DGroiV1HhrBUdrqQcg2W8K94Jebmh2HXQ29V
        hLRq2ZX73VbwmLPZXYYk2U+ok3oNHnlbOsNHCfY47rzWgBnlDGw1inVptKNAM+nb3jyD39+nng5
        bf28hyJtWuXYksYasEQ5DNznn
X-Received: by 2002:a05:600c:220e:b0:394:2695:ce9b with SMTP id z14-20020a05600c220e00b003942695ce9bmr63526wml.64.1651510512505;
        Mon, 02 May 2022 09:55:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXHCdnrBQZAdylY92wBiX6hj/7UIQj39kbqjBAbaznjJ5J3GoSPQN7nxolvY6RoRBArA57Pw==
X-Received: by 2002:a05:600c:220e:b0:394:2695:ce9b with SMTP id z14-20020a05600c220e00b003942695ce9bmr63506wml.64.1651510512248;
        Mon, 02 May 2022 09:55:12 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q29-20020adfb19d000000b0020c5253d8e9sm7222672wra.53.2022.05.02.09.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 09:55:11 -0700 (PDT)
Message-ID: <5dd80287-1b09-d02c-9f67-5a0bb0a4566c@redhat.com>
Date:   Mon, 2 May 2022 18:55:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/3] drm: Remove superfluous arg when calling to
 drm_fbdev_generic_setup()
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20220502153900.408522-1-javierm@redhat.com>
 <20220502153900.408522-2-javierm@redhat.com>
 <YnABjdpGC166yIY7@pendragon.ideasonboard.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YnABjdpGC166yIY7@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Laurent,

On 5/2/22 18:06, Laurent Pinchart wrote:
> Hi Javier,
> 
> Thank you for the patch.
> 
> On Mon, May 02, 2022 at 05:38:58PM +0200, Javier Martinez Canillas wrote:
>> The drm_fbdev_generic_setup() function already sets the preferred bits per
>> pixel for the device to dev->mode_config.preferred_depth, if preferred_bpp
>> value is zero.
>>
>> Passing the same value to the function is unnecessary. Let's cleanup that
>> in the two drivers that do it.
> 
> This looks fine, so
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> but why do we have two different mechanisms to set the preferred depth ?
> Could we get all drivers to set dev->mode_config.preferred_depth and

Yes, that's the plan and the reason why when we were discussing with Thomas
about how to pass this option to the FB helper layer, we agreed on reusing
the @preferred_bpp parameter rather than adding a third parameter to
drm_fbdev_generic_setup(). Since in the future drivers shouldn't pass that
information to the FB helper and just get it from the default mode config.

But doing that would require more auditing to all drivers and it could add
regressions while patches 1/2 and 2/2 in this series shouldn't cause any
behavioral changes.

> drop the depth option to drm_fbdev_generic_setup() ? There's a FIXME
> comment in drm_fbdev_generic_setup() that could be related.
>

A FIXME makes sense, I'll add that to when posting a v3.
 Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

