Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7249E505E02
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 20:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347423AbiDRSnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 14:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiDRSnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:43:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 610D52E0A6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 11:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650307268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VuGc/WdeVJI1eBiXvGHukz2whIa4wWjXqnrLuB6HMKY=;
        b=U9uR7Kza2JFL2DWOti/2ZUcSc6uwtKgzucySpDOUbIwrpzkm1xASGwi6tNqcJP09SjnDBG
        oipqg8xxkNv2A3qwAebg2H4WHzwbBT3jI7jVy4hTPLt2+LditRldr1ykVLjKVBJ31T1YTj
        y5Uf2h40b7eov9JEBGYDarwcD7qklTQ=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-zfHJ2p90Mi-xQa6qKJYMbg-1; Mon, 18 Apr 2022 14:41:05 -0400
X-MC-Unique: zfHJ2p90Mi-xQa6qKJYMbg-1
Received: by mail-vs1-f71.google.com with SMTP id i190-20020a6722c7000000b00320cf551813so1759589vsi.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 11:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=VuGc/WdeVJI1eBiXvGHukz2whIa4wWjXqnrLuB6HMKY=;
        b=TeWi/O08g+/od6t0+48dtpMcc4tR2PES0rn8jD9qchgU53kFC9Cg1EGR//TSWcHXHi
         m2UVDPF20exw/ilACYOPyiL3zpbtbPB1wh5g/gA0gvpJdidK57IIBcRDcL0wGZffNwz2
         Qu2KI6lCfcu0xYgb7XF6XSRDfYO6yuW1XOQlZO5CRds1EX6e2AqUqGLRW72u3T0Hljla
         K9BtoY6X3sR4HfFt402uyelFn748Mk2IWfRS1ciHKNXH5cEn7FcsyQBTdHOJIYNeaJgP
         j91KARE9/C13OgwPA3J5y6ksnRhuHZPuKjnxJC0xRoSKXx5ipA/bVyuBFFdfK4j7mMDX
         Htvg==
X-Gm-Message-State: AOAM532jzOU7alSnl9jwEX7ukwY9VnfJpoan+mE85JdlVgpiTT4amQl6
        GzIR/XUt3fse3tkyIOd1hNU9WJ0tmsnJP8MNdw7qFtF12YPo4TRAR2FoOWNMCAcHlCo1GshMpZB
        zcUgyp9VGpTAiqJeihYids/6y
X-Received: by 2002:a1f:14c2:0:b0:345:3e0f:81b1 with SMTP id 185-20020a1f14c2000000b003453e0f81b1mr3190542vku.2.1650307264770;
        Mon, 18 Apr 2022 11:41:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEjhYF2Aoq1MDzFFiHfewXPAu8UoNo+RuC8SC8/8YCVnNVsfULVrP7+ysF7haG+Vsfh9D7ig==
X-Received: by 2002:a1f:14c2:0:b0:345:3e0f:81b1 with SMTP id 185-20020a1f14c2000000b003453e0f81b1mr3190533vku.2.1650307264525;
        Mon, 18 Apr 2022 11:41:04 -0700 (PDT)
Received: from [192.168.8.138] (pool-71-126-244-162.bstnma.fios.verizon.net. [71.126.244.162])
        by smtp.gmail.com with ESMTPSA id t66-20020a1f2d45000000b00348da3c51bbsm1605500vkt.13.2022.04.18.11.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 11:41:03 -0700 (PDT)
Message-ID: <bc995a702bfa0c0efa83792a0d5c46bfe1ff0a4b.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: change base917c_format from global to
 static
From:   Lyude Paul <lyude@redhat.com>
To:     Tom Rix <trix@redhat.com>, bskeggs@redhat.com, kherbst@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Apr 2022 14:41:02 -0400
In-Reply-To: <20220418141842.296386-1-trix@redhat.com>
References: <20220418141842.296386-1-trix@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push this to the appropriate branch in a little bit

On Mon, 2022-04-18 at 10:18 -0400, Tom Rix wrote:
> Smatch reports this issue
> base917c.c:26:1: warning: symbol 'base917c_format'
>   was not declared. Should it be static?
> 
> base917c_format is only used in base917.c.  Single
> file variables should not be global so change
> base917c_format's storage-class specifier to static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/base917c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/base917c.c
> b/drivers/gpu/drm/nouveau/dispnv50/base917c.c
> index a1baed4fe0e9..ca260509a4f1 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/base917c.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/base917c.c
> @@ -22,7 +22,7 @@
>  #include "base.h"
>  #include "atom.h"
>  
> -const u32
> +static const u32
>  base917c_format[] = {
>         DRM_FORMAT_C8,
>         DRM_FORMAT_XRGB8888,

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

