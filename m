Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C7D4D3000
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbiCINey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiCINew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:34:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FE4413CA0C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646832833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IOaaETwHyO6EXDP09qs4E16KNNpKkz6jydXWMB+nH2Q=;
        b=HM8d45OWCLZMG0sY2Crud5FiGlM7f5d0X2lGyPAtQt6LBSoWbk4PemWJj5cupKtaOhLhEe
        uMGEhVgdi5O1IU8rMuBknwE49OMiHWMOeW7VmFQw7nxEa8EbRgcysxy2KDzFj+BQ06L9ji
        neKPdQBi3slbOY+mnwKl0xChK/uK/Mg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-X8wghp-WOtCKn0RzEy-ejg-1; Wed, 09 Mar 2022 08:33:52 -0500
X-MC-Unique: X8wghp-WOtCKn0RzEy-ejg-1
Received: by mail-wm1-f70.google.com with SMTP id o21-20020a05600c511500b003818c4b98b5so822093wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 05:33:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IOaaETwHyO6EXDP09qs4E16KNNpKkz6jydXWMB+nH2Q=;
        b=RaBh85LCc2E1a6g0BNTTbXoW/s60kq1mzyktVl2qwbJJqd1A9uA64sPcwuVLcruzUE
         fpHpN/w8KU2sWkCRU1W+3ayxYn4KZuw7UMJXUcyckZ4xh1jF+CkteXTN0JJ3XnInuxwO
         f0zDtWCmJy6yYiyUuNf2c4RUW49J/44iNh/tlyrtxuJ6R00lNF4Qe2+86rMEEaXsfSYy
         Pkq9mwycVRZlv0+Tlb5CnQzOsRYXtlO4b3LwHBIdSXZXCpB1KLEzr1rfHRHpDoKgxruK
         hyXMuw/D+wTqFWMq571/+drrScDvW0ErPurdkJTlWACny/rgRn46IpG9BDR1//g7ctqG
         XaJQ==
X-Gm-Message-State: AOAM530GHwysGvtbn7pyhCH+9ZrE0uZlyr4lzOlfDcpgyA/gTrCArBr3
        IvFpItNshc5Twt+IakOAa69RVxc51DiiiIr0XegTfL2nMIGJpjLAgXu1YnqdtRlBx0Xq8XvGOud
        OghMzAkGcZV7xttnSlwf3eyV6
X-Received: by 2002:a05:6000:18a4:b0:203:63e9:3e52 with SMTP id b4-20020a05600018a400b0020363e93e52mr7208811wri.192.1646832830936;
        Wed, 09 Mar 2022 05:33:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw39VeeJL2sLF2yNLhIAAzipl//IMHBr51izsAjQZj6VqCMsVOEfSQoR8CT5v/PXd09VKNfrg==
X-Received: by 2002:a05:6000:18a4:b0:203:63e9:3e52 with SMTP id b4-20020a05600018a400b0020363e93e52mr7208790wri.192.1646832830663;
        Wed, 09 Mar 2022 05:33:50 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k14-20020a5d518e000000b002019c7402aasm1732693wrv.25.2022.03.09.05.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 05:33:42 -0800 (PST)
Message-ID: <88ae42f3-8e56-75e9-b1c0-abefe3496a8d@redhat.com>
Date:   Wed, 9 Mar 2022 14:33:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 RFC 08/10] drm/fourcc: Document that single-channel
 "red" can be any color
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1646683502.git.geert@linux-m68k.org>
 <585dc03acb4016bba910e7d15fec3ef4f0aec5b0.1646683502.git.geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <585dc03acb4016bba910e7d15fec3ef4f0aec5b0.1646683502.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/22 21:52, Geert Uytterhoeven wrote:
> Traditionally, the first channel has been called the "red" channel, but
> the fourcc values for single-channel "red" formats can also be used for
> other light-on-dark displays, like grayscale.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Yes, I learned that "Red" actually meant just a color channel
that may not be red in one of the thread about fourcc formats.

So I agree that would be good to have a comment about this.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

