Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C844456C348
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbiGHTg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbiGHTg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:36:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4A655C953
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 12:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657308984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bp4/uJx0q3CBRP6uPPQZJlkmcVebKMMiiHAd6ojauiM=;
        b=HEqaAVOHh96SKL2Jhtrg6+zgS0ndr8SN5OhR8V3x7bfdAJijO04XTD9hiZl2Iv+zw1E8g8
        YQ7y0MTIBSHu/IbLvtx6R2Yruq2z3uC16gQ1TFyiLX8EbusMwT75gymCYSauZ+ceZL6UT1
        xUzCODqnu/iJKmrplqEy7231TRE5QGg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-S0b0PhZ4PHisdo4f-Ykv8w-1; Fri, 08 Jul 2022 15:36:23 -0400
X-MC-Unique: S0b0PhZ4PHisdo4f-Ykv8w-1
Received: by mail-ed1-f71.google.com with SMTP id z13-20020a056402274d00b004357fcdd51fso16665723edd.17
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 12:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Bp4/uJx0q3CBRP6uPPQZJlkmcVebKMMiiHAd6ojauiM=;
        b=IqAhoq/ZrKGVpeQp21yeYi9z2L70/xFK+zoKK9E/ORpb+OKy2Rh+jY5KceNC5A6acE
         UzUSHSH+npuz/bm9rD7unCCcsJ5lmC2Vl+H2EAlqS5Jhbf5LMEok1CnjO175eAtY0eqw
         IcKQGaFQqe/eWWSUjaxzIE6+JBJz+fp/WD5gGyozyzr7tVXMa3fdd1WyE2uZnfQKaV0C
         9mrLO664G6xhHCwJdiQtHyNfhp+XX2hZ1WqIP4MR7LqDPh2du5OBLQ2sDLlkt7hyHUdM
         H+JVO+DiuGks6N+EEB/x4Gw9lsI+wbi39C2n48gK++Ucv6X4NTSlJctgYazBxdkBarPT
         RxLA==
X-Gm-Message-State: AJIora/ogZUwzqHcTsmY6BRfsF4VBWCUz+KU583azgTcpHCls8xk20gF
        ZElT93XOaedtSciWolojdER3kTGoizkl3vfxrCbtsWMmiiFLHRHES6xHt2wDJv0gG2FubAy66Ax
        aI/gD18QHGneiL6zoTQGhUzu5
X-Received: by 2002:a17:906:84fa:b0:72b:3257:527b with SMTP id zp26-20020a17090684fa00b0072b3257527bmr894469ejb.477.1657308982250;
        Fri, 08 Jul 2022 12:36:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sHAlOPlSVNJxOUyi7dexo+dGkJEXRhxhmOBsygKoLu/bOnqki5Dcyoqj9A1H/3E27ZRhYkHA==
X-Received: by 2002:a17:906:84fa:b0:72b:3257:527b with SMTP id zp26-20020a17090684fa00b0072b3257527bmr894456ejb.477.1657308982085;
        Fri, 08 Jul 2022 12:36:22 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id p16-20020a05640210d000b0043a1bc2ebbcsm13332097edu.3.2022.07.08.12.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 12:36:21 -0700 (PDT)
Message-ID: <da9636ac-9455-75a6-7284-8c601d23a37e@redhat.com>
Date:   Fri, 8 Jul 2022 21:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/5] drm/modes: Command line mode selection fixes and
 improvements
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1657301107.git.geert@linux-m68k.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <cover.1657301107.git.geert@linux-m68k.org>
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

Hi Geert,

On 7/8/22 20:21, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series contains fixes and improvements for specifying video
> modes on the kernel command line.
> 
> This has been tested on ARAnyM using a work-in-progress Atari DRM driver
> (more info and related patches can be found in [1]).
> 
> Thanks for your comments!
> 
> [1] "[PATCH v3 00/10] drm: Add support for low-color frame buffer formats"
>     https://lore.kernel.org/r/cover.1657294931.git.geert@linux-m68k.org
> 
> Geert Uytterhoeven (5):
>   drm/modes: parse_cmdline: Handle empty mode name part
>   drm/modes: Extract drm_mode_parse_cmdline_named_mode()
>   drm/modes: parse_cmdline: Make mode->*specified handling more uniform
>   drm/modes: Add support for driver-specific named modes
>   drm/modes: parse_cmdline: Add support for named modes containing
>     dashes

Thanks, I have some remarks on patches 1/5 and 2/5 the rest looks
good to me. 

For 1/5 and 2/5 with my remarks addressed:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

For 3/5, 4/5 and 5/5:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> 
>  drivers/gpu/drm/drm_modes.c | 57 ++++++++++++++++++++++++++-----------
>  include/drm/drm_connector.h | 10 +++++++
>  2 files changed, 50 insertions(+), 17 deletions(-)
> 

