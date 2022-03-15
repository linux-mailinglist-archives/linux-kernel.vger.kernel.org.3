Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3644D9B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348344AbiCOMeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348343AbiCOMeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:34:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC047F4B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647347568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ng50kpxzvtPViXgByyIi4u1+YwPTs56W0iaR9U1Up70=;
        b=if5HgabsrImU1fNYfoxHLtbogDZIBmDPGV3wpsAFsgfXds0gSSWpFbKDEbT/T/nAo1Nh+S
        16gAEqqAeaJHEDodn5unC28ugyPfyMa5qVIb857/nH6iBRqIgUYcm73nh3wyYo3tpGR1Or
        mznQ+2eVrrWdao2Hq1K69ivB2y4GAL0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-nezV7TLDMGeM4Ns3kq7Eow-1; Tue, 15 Mar 2022 08:32:47 -0400
X-MC-Unique: nezV7TLDMGeM4Ns3kq7Eow-1
Received: by mail-wm1-f72.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so1106008wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ng50kpxzvtPViXgByyIi4u1+YwPTs56W0iaR9U1Up70=;
        b=cpb+u0WuNTtsGyFzBLkadq9NYhn/QB+VL1XPguUJ/DPPRzr5hrK+H3yJJzgka4Di8D
         uofOOi++gEUWbJLfV9NaeE0rwmKn1JjzKmHiI2ZFZrKmSs2cIAUY19vcHkc/AHXyXjVx
         btiALS78dzD5qmOrKGeIXmu0T9eYKjhNhXTp0ODYye3IqaCPg6Tcst3wnVhbjm5cghsi
         d5OAMit3WzkotuzsHwlQKOxC7+NE0QQWpUVzXY8/tPhqeOCZVc835ZswOk6MTLRre7L3
         mzDwlsDc8rgnzd+koJ4VLTtsNRNw7DXhGm/vafhqh4fj1CX2dbkyYWoGyxyxbtL6T67m
         +2UA==
X-Gm-Message-State: AOAM530bpllAVl11dzJh7a/NmgETyGSoSuNeVyyBO1tFaK2+LFj8oalv
        6YHMIITuFPV6s96toq00VIO2PUvMsqpx4eDPk4TOCEackcbLpauzI+PN/qYkS+ksbAW3h9fpLAA
        ejbMj0jORrHLzDZufZHNOJS3V
X-Received: by 2002:a7b:c8d7:0:b0:389:c84c:55be with SMTP id f23-20020a7bc8d7000000b00389c84c55bemr3214923wml.135.1647347566210;
        Tue, 15 Mar 2022 05:32:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+lXekobfF9QCg8WpZMIKVPdif6vtRisJZFsCWd/H1zYb7+OeE/XTzOvT+FKqf410LGkjKjg==
X-Received: by 2002:a7b:c8d7:0:b0:389:c84c:55be with SMTP id f23-20020a7bc8d7000000b00389c84c55bemr3214909wml.135.1647347565967;
        Tue, 15 Mar 2022 05:32:45 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k10-20020adfe3ca000000b001f0329ba94csm24459727wrm.18.2022.03.15.05.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 05:32:45 -0700 (PDT)
Message-ID: <43b88d77-bcba-e6d5-b51f-56c5c8c0318c@redhat.com>
Date:   Tue, 15 Mar 2022 13:32:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/5] drm: ssd130x: Reduce temporary buffer sizes
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220315110707.628166-1-geert@linux-m68k.org>
 <20220315110707.628166-5-geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220315110707.628166-5-geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/22 12:07, Geert Uytterhoeven wrote:
> ssd130x_clear_screen() allocates a temporary buffer sized to hold one
> byte per pixel, while it only needs to hold one bit per pixel.
> 
> ssd130x_fb_blit_rect() allocates a temporary buffer sized to hold one
> byte per pixel for the whole frame buffer, while it only needs to hold
> one bit per pixel for the part that is to be updated.
> Pass dst_pitch to drm_fb_xrgb8888_to_mono_reversed(), as we have already

Just drm_fb_xrgb8888_to_mono() since you already fixed the name in patch 1/5.

> calculated it anyway.
> 
> Fixes: a61732e808672cfa ("drm: Add driver for Solomon SSD130x OLED displays")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Indeed. I haven't noticed that got the calculation wrong until you pointed out.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

