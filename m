Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392305846F1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiG1UR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiG1UR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:17:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50C0A76EBA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659039445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A6u4ZQlbvoh48fBsQdaHBjhOh58DQBN7dDe6CmLd1i8=;
        b=gt4Z3hgVAZoMppCIU2osNL8eXPm30UC6Ex+G7emYQlq4gZCt6iZTj//Pe5kGJ5oMKOB3Do
        AI6EmkqxlhaQD58R4bBEDu+z1IfSZNWE1ZmuWBrrwPmzmVVUbW6YQFUo/O8N9W7p7eackZ
        As+9mQeTezVytfk8YCb7G7Fpe11zRdY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-Pp_aLg9EOvC2UcTgOeOVFw-1; Thu, 28 Jul 2022 16:17:17 -0400
X-MC-Unique: Pp_aLg9EOvC2UcTgOeOVFw-1
Received: by mail-qv1-f70.google.com with SMTP id f8-20020a056214076800b0047421aaa4c0so2018116qvz.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=A6u4ZQlbvoh48fBsQdaHBjhOh58DQBN7dDe6CmLd1i8=;
        b=Rs9+hjnNK4xaXuCrXOAODp/RrYus+chNrEGRHpj+MvDnxYC50HLdz2VWiR04lG6zwh
         Wwx9IdfXyiKGDURKqRhvVtY+6b8dvGPVaY/tU2Ai4D9yPdRj6enqxazR7j1Ix7v+LbpI
         LtFXe5UNA2FR8DuefCXBJB7xw0hLGgCaYNDGthN44xmOEUbB98c1k4MDtWMaj7+CofGv
         QTjrlRvaLFaM9pbIFXeGz70o01PRb9giyr1f7hzhw7UQ6OJpo+o9yhIaptsn6KVMJ+F3
         F8uiIsuGSE2f+q27iK8EKfs6JvJOOhUzBbMad0r9sS4HdnIZWjGnNDxsbCUMR2JA5oKO
         SuVA==
X-Gm-Message-State: AJIora9pi9P8SlEAw29U+hNZa3vgadvDi+LM1qF5LutxdHm7VGZsxOyK
        iJHyMj8itoGfMkg5VeY/4bcf+/I0oHZZn4IjpQo2azZa46unam03Mv67BlTawLfH81GT0mHpGO+
        yrr+82f/BJnfJQEf5rjZQgA8O
X-Received: by 2002:a05:620a:3707:b0:6b5:e205:81c7 with SMTP id de7-20020a05620a370700b006b5e20581c7mr454884qkb.754.1659039436931;
        Thu, 28 Jul 2022 13:17:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vOtsnFMeB+47s+JEBfSL51sNWIhYCgzWGrde48yH7YXwWO1SbAs5TDZJ3n/JREYKaXerZ2MQ==
X-Received: by 2002:a05:620a:3707:b0:6b5:e205:81c7 with SMTP id de7-20020a05620a370700b006b5e20581c7mr454869qkb.754.1659039436693;
        Thu, 28 Jul 2022 13:17:16 -0700 (PDT)
Received: from [192.168.8.138] (pool-100-0-245-4.bstnma.fios.verizon.net. [100.0.245.4])
        by smtp.gmail.com with ESMTPSA id j18-20020a05620a289200b006a693e46d5csm1338993qkp.11.2022.07.28.13.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 13:17:16 -0700 (PDT)
Message-ID: <63f7fdefca924ac5d192a5f617ea41cf266ba756.camel@redhat.com>
Subject: Re: [PATCH] nouveau/svm: Fix to migrate all requested pages
From:   Lyude Paul <lyude@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>, bskeggs@redhat.com,
        rcampbell@nvidia.com
Cc:     kherbst@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, jhubbard@nvidia.com
Date:   Thu, 28 Jul 2022 16:17:14 -0400
In-Reply-To: <20220720062745.960701-1-apopple@nvidia.com>
References: <20220720062745.960701-1-apopple@nvidia.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, in the future if it's taking a while for a review to come back feel free
to just send a poke on the thread for the patch you submitted, I do my best to
keep up with all of the patches coming in. But there's a lot of email that I
get so every now and then one slips through the cracks.

Anyway, this patch looks good to me:

Reviewed-by: Lyude Paul <lyude@redhat.com>

I will push it to the appropriate branch in a little bit

On Wed, 2022-07-20 at 16:27 +1000, Alistair Popple wrote:
> Users may request that pages from an OpenCL SVM allocation be migrated
> to the GPU with clEnqueueSVMMigrateMem(). In Nouveau this will call into
> nouveau_dmem_migrate_vma() to do the migration. If the total range to be
> migrated exceeds SG_MAX_SINGLE_ALLOC the pages will be migrated in
> chunks of size SG_MAX_SINGLE_ALLOC. However a typo in updating the
> starting address means that only the first chunk will get migrated.
> 
> Fix the calculation so that the entire range will get migrated if
> possible.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Fixes: e3d8b0890469 ("drm/nouveau/svm: map pages after migration")
> ---
>  drivers/gpu/drm/nouveau/nouveau_dmem.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index 7ba66ad68a8a..16356611b5b9 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -680,7 +680,11 @@ nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
>                 goto out_free_dma;
>  
>         for (i = 0; i < npages; i += max) {
> -               args.end = start + (max << PAGE_SHIFT);
> +               if (args.start + (max << PAGE_SHIFT) > end)
> +                       args.end = end;
> +               else
> +                       args.end = args.start + (max << PAGE_SHIFT);
> +
>                 ret = migrate_vma_setup(&args);
>                 if (ret)
>                         goto out_free_pfns;

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

