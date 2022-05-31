Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C51539691
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344901AbiEaSwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbiEaSwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3BA1D132
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654023120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sZAMyRELxB7F9um/lFWtV+zzG8SAX14QHBVnpeIBNDs=;
        b=Me/kolUCFohOO9SmbEx6FrJHiuvpZzq2YaV0ks44Mdh2QX9sb81kIVZXnN129t4yTEu62V
        aXgkNfWy14+Qsb0Rxo2OLQRbcuMmEP9KV6lF9zNH3Xn9RKhLxZdSvAnWVFDvs5tY/P07xo
        azAphis5lPmGIW8x9GXQGOiLnsANNfw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-qiVU_UTEO3CWJs0iVIyqxw-1; Tue, 31 May 2022 14:51:59 -0400
X-MC-Unique: qiVU_UTEO3CWJs0iVIyqxw-1
Received: by mail-qv1-f71.google.com with SMTP id dg8-20020a056214084800b004645cecc145so2359661qvb.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=sZAMyRELxB7F9um/lFWtV+zzG8SAX14QHBVnpeIBNDs=;
        b=HActzN+2GgxjaMbgI7WBmELauCzrudfRf667mZuqvcFHjhIVbDTyCTx5Au/8SBteWL
         tkfkOjH2A79/PmIeq/KVZrolTIHzeF+A2jMQ0QMaoFVfPtWa0GPt91QgEfK3BVjEsR8N
         Z0E207XOfPEHiEyabxOHMg66US/itH80/BIrlfz0lPGNuSrukRfNALZIDpC40cPBSRK0
         WgCWnCJAY2A3u+jgtvGdPwj5n8xbjHE2ELlBX1G+OuG8p97mo35nN42kRtmgqyiAXrWV
         IxkPyiKqd0ffiaqI4/UKukUMUX0vp08ES2X3Of25DXph6KQNV9j7bgfTnlB1HOyNgvrS
         wOyg==
X-Gm-Message-State: AOAM533X6zIo7wXEdHLP92+K6Lm9C52xiLUMozuSjDGz50lHv++ZSbVO
        lsOGFcSrBXuqJekmWy+S1qbMaPxkU1SOA+L4P2MZt/t+4vkShbU4qTLSebQzGMRf2FniskmUDrq
        VxqQhZxmX3eXt2XmvvKvYPRAf
X-Received: by 2002:a05:6214:629:b0:45b:c82:e5f2 with SMTP id a9-20020a056214062900b0045b0c82e5f2mr51162981qvx.89.1654023118859;
        Tue, 31 May 2022 11:51:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzodGyqn8Bmz6b43p2yNc0fAAzKr06KKy5cRAHwm0CUS2cAXLIS7Tt/3JKcEHC+x2wOBUDH4A==
X-Received: by 2002:a05:6214:629:b0:45b:c82:e5f2 with SMTP id a9-20020a056214062900b0045b0c82e5f2mr51162963qvx.89.1654023118669;
        Tue, 31 May 2022 11:51:58 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id q11-20020a37a70b000000b0069fc13ce211sm9787136qke.66.2022.05.31.11.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 11:51:58 -0700 (PDT)
Message-ID: <ffaf5842daad97fb6c9a522551b7d00aac86c306.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/fifo/gv100-: set gv100_fifo_runlist
 storage-class to static
From:   Lyude Paul <lyude@redhat.com>
To:     Tom Rix <trix@redhat.com>, bskeggs@redhat.com, kherbst@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 31 May 2022 14:51:57 -0400
In-Reply-To: <20220528141836.4155970-1-trix@redhat.com>
References: <20220528141836.4155970-1-trix@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to the appropriate branch in a moment

On Sat, 2022-05-28 at 10:18 -0400, Tom Rix wrote:
> sparse reports
> drivers/gpu/drm/nouveau/nvkm/engine/fifo/gv100.c:56:1: warning: symbol
> 'gv100_fifo_runlist' was not declared. Should it be static?
> 
> gv100_fifo_runlist is only used in gv100.c, so change it to static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/fifo/gv100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gv100.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gv100.c
> index 70e16a91ac12..faf0fe9f704c 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gv100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gv100.c
> @@ -52,7 +52,7 @@ gv100_fifo_runlist_cgrp(struct nvkm_fifo_cgrp *cgrp,
>         nvkm_wo32(memory, offset + 0xc, 0x00000000);
>  }
>  
> -const struct gk104_fifo_runlist_func
> +static const struct gk104_fifo_runlist_func
>  gv100_fifo_runlist = {
>         .size = 16,
>         .cgrp = gv100_fifo_runlist_cgrp,

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

