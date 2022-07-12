Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3CD571C54
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiGLOYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiGLOYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:24:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D49A22AC59
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657635851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VpPPaMxB6IyUiSQjmMliZXXQEteaEEZHAD8jA7VrypY=;
        b=i6t6yrBxiFdOYw6fruXik5k0nW9rNbFQnMFXVHfMqREWTWJyhLGMtlwSoxNPjDGSvpAlNx
        LQPLWchIaBWPWIjzvhP5m/hoekJGgKu+SPxCRVegFEG58cmKvNKmos0nvez0ZngzASyvw8
        vWvLS4Q98pEMlFZHF+mAU+uCoBWv/7Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-IRUw2ZErPouZbEwDuOG3qA-1; Tue, 12 Jul 2022 10:24:09 -0400
X-MC-Unique: IRUw2ZErPouZbEwDuOG3qA-1
Received: by mail-ed1-f69.google.com with SMTP id m13-20020a056402430d00b0043ac2f27d83so6013888edc.20
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=VpPPaMxB6IyUiSQjmMliZXXQEteaEEZHAD8jA7VrypY=;
        b=JdA0EqHrCLHeJi5m3vXewnemYUBw0oyWoL+RCghTAUl61IFS0Qw3jn3rJs4zCVQrVX
         GX8Cgwyqn31bggb23DV56aIL89eF6+9Rs2PIlXYP1fcaEUn3BwbhJ/3iAlbyLdqycrQI
         TDwB0GLwvRRVWmlWpTRgWbcKGf/gSvPIKoP3dqmX4T1o3KDHV19CrMMUUMrhxxtjT5Ta
         3Yf/xxN3bId7grTmN3eMdrG0KAAsEfPC0BIeiBY+9lnFS033j4m3wEAMItv9Ct6NN4K1
         Tb8fPynHyve1aVi2OXgfAdAipeSzusPH3qvYrG3JdfrO/9gTpn04gKkIzPX+nZFS6Efd
         ix1w==
X-Gm-Message-State: AJIora8WYmUpTLym5H0EG5PkpNs98if/wF8PSqqPatJb1G3jdzldq74v
        8fTxeyIqqlhRpQH5WTEAb1fDG2kmxwCgenE6BJcVbdiG7BdSzxQu/QhXK/Iy4fMqywuk9474G4E
        3D/hFjWF9hYhdfN0RVPyj5QJl
X-Received: by 2002:a05:6402:27c8:b0:43a:f392:8fdd with SMTP id c8-20020a05640227c800b0043af3928fddmr2611176ede.328.1657635848768;
        Tue, 12 Jul 2022 07:24:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v4wQpjcVWwljO59+q92/Dr3RNmAg0cRGxfNUMtLSU00uxqRapRz78u14FG7PWyFrp5JBx+DQ==
X-Received: by 2002:a05:6402:27c8:b0:43a:f392:8fdd with SMTP id c8-20020a05640227c800b0043af3928fddmr2611156ede.328.1657635848623;
        Tue, 12 Jul 2022 07:24:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b40:2ee8:642:1aff:fe31:a15c? ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id g4-20020a1709067c4400b00726abf9cd8esm3794533ejp.125.2022.07.12.07.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 07:24:08 -0700 (PDT)
Message-ID: <1c0cbab1-f920-3565-f326-189cbac56da0@redhat.com>
Date:   Tue, 12 Jul 2022 16:24:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/10] drm: use idr_init_base() over idr_init() if
 applicable
Content-Language: en-US
To:     airlied@linux.ie, daniel@ffwll.ch, christian.koenig@amd.com,
        emma@anholt.net,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220701185303.284082-1-dakr@redhat.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20220701185303.284082-1-dakr@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 7/1/22 20:52, dakr@redhat.com wrote:
> From: Danilo Krummrich <dakr@redhat.com>
> 
> This patch series initializes IDRs with idr_init_base(&idr, 1) rather than
> idr_init(&idr) in case for the particular IDR no IDs < 1 are ever requested -
> this avoids unnecessary tree walks.
>
Guess this would go through drm-misc too?

- Danilo

> Danilo Krummrich (10):
>    drm/amdgpu: use idr_init_base() to initialize mgr->ctx_handles
>    drm/amdgpu: use idr_init_base() to initialize fpriv->bo_list_handles
>    drm: use idr_init_base() to initialize master->magic_map
>    drm: use idr_init_base() to initialize master->lessee_idr
>    drm: use idr_init_base() to initialize mode_config.object_idr
>    drm: use idr_init_base() to initialize mode_config.tile_idr
>    drm/sis: use idr_init_base() to initialize dev_priv->object_idr
>    drm/v3d: use idr_init_base() to initialize v3d_priv->perfmon.idr
>    drm/via: use idr_init_base() to initialize dev_priv->object_idr
>    drm/todo: remove task for idr_init_base()
> 
>   Documentation/gpu/todo.rst              | 12 ------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  2 +-
>   drivers/gpu/drm/drm_auth.c              |  4 ++--
>   drivers/gpu/drm/drm_mode_config.c       |  4 ++--
>   drivers/gpu/drm/sis/sis_drv.c           |  2 +-
>   drivers/gpu/drm/v3d/v3d_perfmon.c       |  2 +-
>   drivers/gpu/drm/via/via_map.c           |  2 +-
>   8 files changed, 9 insertions(+), 21 deletions(-)
> 

