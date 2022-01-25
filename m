Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D507549BBDA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiAYTL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:11:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56543 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229606AbiAYTL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:11:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643137915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L6O4DkR4pkiSXBoigUMOsmjUeRpgHJTXKdhZ+nj+Qmo=;
        b=UgGPjdl5i9cbLUq/NMmeIF+YodUpZDJgSC9pQbZqnMGSr0wLjexYsoqfGctViu7zA2fXop
        az7+TyXDh3O1vj4CQeir0rUN7pZBNHbWAVtaMG2wffTz3QYrHc1ASsJ+zsG1KlISoqhyYj
        6JHM2Ak+OSRowOFfO8Z7AGEsJh8o7ww=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-ew84aWQQO36QZctACimoRA-1; Tue, 25 Jan 2022 14:11:54 -0500
X-MC-Unique: ew84aWQQO36QZctACimoRA-1
Received: by mail-qk1-f197.google.com with SMTP id h10-20020a05620a284a00b0047649c94bc7so15488603qkp.20
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 11:11:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=L6O4DkR4pkiSXBoigUMOsmjUeRpgHJTXKdhZ+nj+Qmo=;
        b=zqGWbjbAbwgzYuEHFsRp7bquEQk27BMi0jySftpF9inkJGCc5xBPWZWBlHP9HX+wOO
         3gS1S/xT4d9ARm3bQ338b20Wxnv6d/I56gllzqe/7ipHvBIXz+nwyEGUsR+BPabH4sRc
         +ryRxDoHXwiNNCzx448JHFXZTntnK5faDd5DTnbpGLA/tyyyZAd6ohAUDngNfBLLUNON
         3HBqxuarhpBAgG0r2juvKUFIwYKXPeX2XxQtD4ZDzA0GVWAFuEIlZ4Ca0tfOQcLi8eF2
         4F5IXCT7rTquwd+WIrBhf4z3gefIjR2oT+yfZl5CSgjq4RDfA4LxDUOPorPoMPgX+I68
         gVTQ==
X-Gm-Message-State: AOAM53143w5RmIdXv17cys/WxpAkQUu0a46gUV+DS+GvTieY3C244NtU
        wI2KNFhu35YlRvGySibjMmbab4ki0V0+ou3tl5N34RmMJv/8SKjs0QCFTP4Ex1NssVrxk1eYi5A
        7OJW2te2KeF1THEKdjMYnj01n
X-Received: by 2002:a05:6214:629:: with SMTP id a9mr20865484qvx.110.1643137913961;
        Tue, 25 Jan 2022 11:11:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzTyeEPxlKSHce5gJ4OzKH9x9AC06WyRvPSC70RRpnsuw3uVK9P/wNr8ukPE4ZiYev98vFTRA==
X-Received: by 2002:a05:6214:629:: with SMTP id a9mr20865470qvx.110.1643137913719;
        Tue, 25 Jan 2022 11:11:53 -0800 (PST)
Received: from [192.168.8.138] (pool-98-118-105-43.bstnma.ftas.verizon.net. [98.118.105.43])
        by smtp.gmail.com with ESMTPSA id d6sm775112qtb.55.2022.01.25.11.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 11:11:53 -0800 (PST)
Message-ID: <7f6be58affaeac27bd3799134abe16ceba38c9a8.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/acr: Fix undefined behavior in
 nvkm_acr_hsfw_load_bl()
From:   Lyude Paul <lyude@redhat.com>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 25 Jan 2022 14:11:51 -0500
In-Reply-To: <20220124165856.57022-1-zhou1615@umn.edu>
References: <20220124165856.57022-1-zhou1615@umn.edu>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Tue, 2022-01-25 at 00:58 +0800, Zhou Qingyang wrote:
> In nvkm_acr_hsfw_load_bl(), the return value of kmalloc() is directly
> passed to memcpy(), which could lead to undefined behavior on failure
> of kmalloc().
> 
> Fix this bug by using kmemdup() instead of kmalloc()+memcpy().
> 
> This bug was found by a static analyzer.
> 
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: 22dcda45a3d1 ("drm/nouveau/acr: implement new subdev to replace
> "secure boot"")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
> The analysis employs differential checking to identify inconsistent 
> security operations (e.g., checks or kfrees) between two code paths 
> and confirms that the inconsistent operations are not recovered in the
> current function or the callers, so they constitute bugs. 
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
>  drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> index 667fa016496e..a6ea89a5d51a 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> @@ -142,11 +142,12 @@ nvkm_acr_hsfw_load_bl(struct nvkm_acr *acr, const char
> *name, int ver,
>  
>         hsfw->imem_size = desc->code_size;
>         hsfw->imem_tag = desc->start_tag;
> -       hsfw->imem = kmalloc(desc->code_size, GFP_KERNEL);
> -       memcpy(hsfw->imem, data + desc->code_off, desc->code_size);
> -
> +       hsfw->imem = kmemdup(data + desc->code_off, desc->code_size,
> GFP_KERNEL);
>         nvkm_firmware_put(fw);
> -       return 0;
> +       if (!hsfw->imem)
> +               return -ENOMEM;
> +       else
> +               return 0;
>  }
>  
>  int

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

