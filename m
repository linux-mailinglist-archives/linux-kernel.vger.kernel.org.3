Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B5E5154BA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 21:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbiD2Tl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 15:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbiD2Tlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:41:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E375CE114
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651261115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RRnqrZ5q9hLwmm3bRLQsIsvIf5Pjk0qeqlvtwwtHCyY=;
        b=HXpfas1CkoxN2BEZTWtdRRET/ICqc2iJ8RfNJSEtQrZb2eHMxkBcDY9H4Uly3PIRN8lYda
        tgSGvVf/xZjA0m7204gblox7wXDmFRWRnx1DfJWtbWbIDIfgy7vsQdMFn+x7r25LvwKITn
        mrQs3MfrOZhMtlirPPa/0m0jXgz2UUU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-HmS45UzKPQeuxBz4JS698Q-1; Fri, 29 Apr 2022 15:38:34 -0400
X-MC-Unique: HmS45UzKPQeuxBz4JS698Q-1
Received: by mail-qt1-f199.google.com with SMTP id n4-20020ac85b44000000b002f3940d55eeso1944052qtw.19
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=RRnqrZ5q9hLwmm3bRLQsIsvIf5Pjk0qeqlvtwwtHCyY=;
        b=WYD7Fmu0fECiwpXpFKMTCC3LSeVR3ftLDLR4pEJxRFYKn2VtOhswOxH//zC+kIXgir
         6DvMRzLM2AR+gHwgOUG4700FMDMeG/3sS1iFlshvSJk5sD7ZwKiOaN+4hhoA7IF5hcfn
         5DMWYeaUN+LG08Npf31ZbwA2ox03tD0QrNXgXgaot+v+3TzZoy8PGYvPouUwWniYf52p
         zCOaos33kVmkv1MCSm0IXwpD4SFSsqPVVjGxQw0xIOIgiaQTcVWMFDuO5gb2gN36Tvqb
         7Si3hHyN3WcKJxqFrZOCwhzMh2zm8uQPxdvCRQax31dKi3KghOkjVwsCCiul/Y1Z2z6V
         k70A==
X-Gm-Message-State: AOAM531j6GwSZKAQ8lfl9sCUSc+g5vNj05qLKPsv7vNIvESTD0jOi7K8
        Lfen3mFPUn4/s9SiIemTSXNiUIX85fwm5Vq0cRqd7AWXjDsOCpnjtRDg9DXfGGggCNZKb+QQXh9
        HZInKyJAab+vUXOKZK192g0xZ
X-Received: by 2002:a05:620a:4591:b0:69f:6dfe:fd0e with SMTP id bp17-20020a05620a459100b0069f6dfefd0emr533996qkb.724.1651261113282;
        Fri, 29 Apr 2022 12:38:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzvpTuihk+7r9mupR+7j1In7Ensxviuu8Omgt416FUHuMAFpt/XdDBc0YeMc2lCqNb9b70ag==
X-Received: by 2002:a05:620a:4591:b0:69f:6dfe:fd0e with SMTP id bp17-20020a05620a459100b0069f6dfefd0emr533983qkb.724.1651261113089;
        Fri, 29 Apr 2022 12:38:33 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id k16-20020ac84790000000b002f39b99f6c1sm53375qtq.91.2022.04.29.12.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 12:38:32 -0700 (PDT)
Message-ID: <baf0a304698c7136c95c3fbb13c90529a51b9e06.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: simplify the return expression of
 nouveau_debugfs_init()
From:   Lyude Paul <lyude@redhat.com>
To:     cgel.zte@gmail.com, bskeggs@redhat.com
Cc:     kherbst@redhat.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Date:   Fri, 29 Apr 2022 15:38:31 -0400
In-Reply-To: <20220429090309.3853003-1-chi.minghao@zte.com.cn>
References: <20220429090309.3853003-1-chi.minghao@zte.com.cn>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc-next in a bit

(Kind of impressed that a bot managed to catch this, considering the route
from here to the code capable of returning < 0 or 0 was definitely not
obvious)

On Fri, 2022-04-29 at 09:03 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Simplify the return expression.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/gpu/drm/nouveau/nouveau_debugfs.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> index 1cbe01048b93..76b621f99916 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> @@ -255,19 +255,13 @@ nouveau_drm_debugfs_init(struct drm_minor *minor)
>  int
>  nouveau_debugfs_init(struct nouveau_drm *drm)
>  {
> -       int ret;
> -
>         drm->debugfs = kzalloc(sizeof(*drm->debugfs), GFP_KERNEL);
>         if (!drm->debugfs)
>                 return -ENOMEM;
>  
> -       ret = nvif_object_ctor(&drm->client.device.object, "debugfsCtrl", 0,
> +       return nvif_object_ctor(&drm->client.device.object, "debugfsCtrl",
> 0,
>                                NVIF_CLASS_CONTROL, NULL, 0,
>                                &drm->debugfs->ctrl);
> -       if (ret)
> -               return ret;
> -
> -       return 0;
>  }
>  
>  void

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

