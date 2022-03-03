Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BD24CC89B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiCCWJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiCCWJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:09:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E77FD3CFC5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 14:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646345344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dHndtgAkVUzdtahs5WkJJ2KEe50Gx7ThnVYvI1YkAUQ=;
        b=Q0Bspg268mfjJH75W4n8C8Cp7sKlroH8aa05k3ZIpSGWgDISPMzaXJtJ+EpKv/jaira6j+
        B70FUTh0wm1E87gx4J6YquT5HwUTzMUwaf2TDeK9XHzqopLTqJoTZe2TsiIh2LTyvrm7PV
        9pQZxYboG/qGCcvmVnGaXd8uktoN4Bk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-aG1rjZsCNOSLwWR_CWCFUw-1; Thu, 03 Mar 2022 17:09:03 -0500
X-MC-Unique: aG1rjZsCNOSLwWR_CWCFUw-1
Received: by mail-qv1-f69.google.com with SMTP id t18-20020a0cb712000000b004350812c194so5331968qvd.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 14:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=dHndtgAkVUzdtahs5WkJJ2KEe50Gx7ThnVYvI1YkAUQ=;
        b=6zH5rJ05nip/eKDSNDBH9Ln4tc/Xp8gbtPesWbAzylKzjxpSLZC1hENsnRORRjvHyW
         BYjMymZE/6TPHhouf+SiWnf10j2WP6O065mQtkudEL+cImhIGI79YuJReMqodBSg3UZj
         AVY9BhpvqECtBKwEEOX+CXWlE1IjgSaYWkivf71OIoRUCVK3+tQDMzTGP2MR3ZdSOKse
         ALZjp9swCaDqFHRypFkqU9dQ3JkmPREmmRebopz7jF0mTEkvaOBJS4RqHiEdazkBXsCw
         Wro9bctAlu5+E04L7YzLTjRt7AnOqjPwQUmMsjizXIsK2cxj7vCg7CNbDefgqwpSNRUc
         rilA==
X-Gm-Message-State: AOAM533z3ZQT23aBJiXyxu0gz3rKLF+tJNOaTKKlLYNxySWDyZQKN3TY
        fAV0ouFrfcM0oXTBqcmnnVBVzNixUgLakla2XZCYxkhpcqfAeFUJP1c38OJkjaHBGudwm0E7aD9
        evUZOOip9uXqe8rXqlbaNNtSU
X-Received: by 2002:a05:6214:1d01:b0:432:563a:6c93 with SMTP id e1-20020a0562141d0100b00432563a6c93mr26030209qvd.78.1646345343411;
        Thu, 03 Mar 2022 14:09:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/u0YAGXDJF1O4GLxwEGzadFGB3RX3Sn4fRB/wh30fqC35fZhpdisvZXayVY4Cans0UAawBw==
X-Received: by 2002:a05:6214:1d01:b0:432:563a:6c93 with SMTP id e1-20020a0562141d0100b00432563a6c93mr26030186qvd.78.1646345343139;
        Thu, 03 Mar 2022 14:09:03 -0800 (PST)
Received: from [192.168.8.138] (pool-96-230-100-15.bstnma.fios.verizon.net. [96.230.100.15])
        by smtp.gmail.com with ESMTPSA id a8-20020a05622a064800b002dd4f1eccc3sm2367464qtb.35.2022.03.03.14.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 14:09:02 -0800 (PST)
Message-ID: <8896a29384e5ad10ee91453da8069821130c1e62.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/instmem: fix uninitialized_var.cocci warning
From:   Lyude Paul <lyude@redhat.com>
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 03 Mar 2022 17:09:00 -0500
In-Reply-To: <20220228142352.18006-1-guozhengkui@vivo.com>
References: <20220228142352.18006-1-guozhengkui@vivo.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push this to the appropriate drm-misc repository in just a little bit

On Mon, 2022-02-28 at 22:23 +0800, Guo Zhengkui wrote:
> Fix following coccicheck warning:
> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:316:11-12:
> WARNING this kind of initialization is deprecated.
> 
> `void *map = map` has the same form of
> uninitialized_var() macro. I remove the redundant assignement. It has
> been tested with gcc (Debian 8.3.0-6) 8.3.0.
> 
> The patch which removed uninitialized_var() is:
> https://lore.kernel.org/all/20121028102007.GA7547@gmail.com/
> And there is very few "/* GCC */" comments in the Linux kernel code now.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
> index 96aca0edfa3c..c51bac76174c 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
> @@ -313,7 +313,7 @@ nv50_instobj_dtor(struct nvkm_memory *memory)
>         struct nv50_instobj *iobj = nv50_instobj(memory);
>         struct nvkm_instmem *imem = &iobj->imem->base;
>         struct nvkm_vma *bar;
> -       void *map = map;
> +       void *map;
>  
>         mutex_lock(&imem->mutex);
>         if (likely(iobj->lru.next))

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

