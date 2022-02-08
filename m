Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0CB4AE4A3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240403AbiBHWfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386329AbiBHUJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 15:09:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82F60C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 12:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644350961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I3/8UwtTiLaHjDIsw5ToTGGU9VaJhcJtecxqfQCO+Kg=;
        b=E1dQBbkrtUDbVwISoUl0RLNImuuiSrzaSnxvSn3I3awcmPwNPyg3S2hwTbaPsl1h5W9qc5
        85eOds5djgpWZrUMek338uxDyNImSzYVPKMw6EY1+j23+leiosSENPjj3bLFh+6TBEmMC0
        XqvpZm2cWyuuiLjfRr6YjJLkwCCpMXY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-P0WKLpGEOLemn0qd87L29A-1; Tue, 08 Feb 2022 15:09:18 -0500
X-MC-Unique: P0WKLpGEOLemn0qd87L29A-1
Received: by mail-qk1-f200.google.com with SMTP id bj2-20020a05620a190200b005084968bb24so8093619qkb.23
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 12:09:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=I3/8UwtTiLaHjDIsw5ToTGGU9VaJhcJtecxqfQCO+Kg=;
        b=ceFrSWczA3GbFg2a6npnWP7i8suOn3QcJS3rSWJoi80d5GzivmwnT7YIQ2+LRf3R6y
         FEb/Bdg4P8QmXPO+LKve1+6vSO5RlL/O1pRMkr3q4qHh6yxi7CWAFeykeOVLVF1ssISk
         Cm/WM6gsDd6NFmGyg0KFqctcFleXufEyrWCAr7Rug54eTvgl7LKzoW3NEgPqY4PqO7as
         3RkBaNilvuU6VZVng8ydcQwylwP8FhXCl0wjaaXnlQX+eSyTgelZswcE0mPL6Awevmyy
         mi1OHQOVqEQJSMJzAdkOC8QxcupxPh6XAkji1RREmLtCLvH2OnNIB2rYBGdNgh/lHcgq
         Dvqg==
X-Gm-Message-State: AOAM533d8AmBqOlVV266zVcBvIVE6NGKVb1wHR/rfR2pA97DFfsECJbt
        2m/J9Qjpe8Ra1+mJ1XDROKhEuraRUmgz1dNGqkNv0Hx2VjFkF+tgOZI1lGOTYeN/eO7xhSIH4+w
        5HjJ9uuzQwiL+202fUY63FWXR
X-Received: by 2002:a05:6214:4111:: with SMTP id kc17mr4417586qvb.61.1644350957409;
        Tue, 08 Feb 2022 12:09:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsREE/wlVXhB/X8tBjZ+cErEBHMvIYU1EUljfRg7HUFF85vJYIMBgalTBx0/F2MZWG8LFj8g==
X-Received: by 2002:a05:6214:4111:: with SMTP id kc17mr4417571qvb.61.1644350957203;
        Tue, 08 Feb 2022 12:09:17 -0800 (PST)
Received: from [192.168.8.138] (pool-96-230-100-15.bstnma.fios.verizon.net. [96.230.100.15])
        by smtp.gmail.com with ESMTPSA id p70sm7253061qka.62.2022.02.08.12.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 12:09:16 -0800 (PST)
Message-ID: <58cc03e21bdf8665f402c7eb9beed557f19a4be2.camel@redhat.com>
Subject: Re: [PATCH][next] nouveau/svm: Use struct_size() helper in
 nouveau_pfns_map()
From:   Lyude Paul <lyude@redhat.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Tue, 08 Feb 2022 15:09:04 -0500
In-Reply-To: <20220207233923.GA524723@embeddedor>
References: <20220207233923.GA524723@embeddedor>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push this to drm-misc-next, thanks!

On Mon, 2022-02-07 at 17:39 -0600, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worse scenario, could lead to heap overflows.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/gpu/drm/nouveau/nouveau_svm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c
> b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index 266809e511e2..46a5a1016e37 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -925,8 +925,8 @@ nouveau_pfns_map(struct nouveau_svmm *svmm, struct
> mm_struct *mm,
>  
>         mutex_lock(&svmm->mutex);
>  
> -       ret = nvif_object_ioctl(&svmm->vmm->vmm.object, args, sizeof(*args)
> +
> -                               npages * sizeof(args->p.phys[0]), NULL);
> +       ret = nvif_object_ioctl(&svmm->vmm->vmm.object, args,
> +                               struct_size(args, p.phys, npages), NULL);
>  
>         mutex_unlock(&svmm->mutex);
>  }

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

