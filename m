Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6AF531BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiEWTwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiEWTwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:52:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAAB45FF3C
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653335536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KOYC9iIBfV1vzZrPUZwk0oyKY1xPZWZ/ayniepgLDTs=;
        b=eT6/ydLrLnAZFrKlyEznc9q50dQ8RlJKkQfWSefyKc2pAd2k0cOWbH1oBdubGMkP9V5cFa
        /NyhBTYaa3SrXWVhDNwNBvM93S/kFTfYuOEdFiDpFZBGHvV5iSJOclh11B/J24AuhogFIi
        MZk7TW8qly7k+yqObieG9jXDpG1Bjg0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-kHmINoTfNL-PBmC3uymk_g-1; Mon, 23 May 2022 15:52:15 -0400
X-MC-Unique: kHmINoTfNL-PBmC3uymk_g-1
Received: by mail-qk1-f197.google.com with SMTP id g3-20020a05620a108300b006a329bc4da3so10625281qkk.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=KOYC9iIBfV1vzZrPUZwk0oyKY1xPZWZ/ayniepgLDTs=;
        b=Nw23biRnCldHKE9lxsK9avpNoBrCcYy3Sf8krTtdUyl9jD8mnuFRyydKCQPlewDFCa
         Dh9n2O7CZhXhjKpGUVX5Y6wdnUdkjuXJJl1epiMlU1tSKQfpma9TM1ktAGS5GtNWZigv
         YMUrZ7Yim3POD1TuTfp90ZHXmDjZfNQIqiknO+XAZF9kNDK9EYV7pX1/O1BfQCvy2F7V
         lMqufehiun1pqn+oyqHPZ9lNsaQ/bfzF3JLH/qNWR7KaEr8OCN0TFr2H+zpqjL2mFg2P
         aqfn0Z2SmoeAJg9uctK7MWGuaQwkhCol4Khbq5KI79IhG2Y6dh5vNVDhh7Pc95XUb0Tx
         6GFA==
X-Gm-Message-State: AOAM531eTFZx/7M9mvyrazJBEriZ0PmxyHqy6SaHkp8OdA7CvkNLa9tW
        rmyXir2xgv9L06lm+O+AKgGcrZJnju/g+jQY3I7cAHdl71+yuRo8rkG/MlcwGuErMzypFmN9Yt7
        Ma825aE2KJ4wbu8+dIeyktxC4
X-Received: by 2002:a37:6650:0:b0:6a3:5fb9:7ff7 with SMTP id a77-20020a376650000000b006a35fb97ff7mr8582258qkc.90.1653335535109;
        Mon, 23 May 2022 12:52:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgZ4upgTLufDFLOHGMjBcNkvM4E+LvXn+UyvlAfFfBcrNLQCi/YNJUO8bUY6aCMfrUg56p0w==
X-Received: by 2002:a37:6650:0:b0:6a3:5fb9:7ff7 with SMTP id a77-20020a376650000000b006a35fb97ff7mr8582253qkc.90.1653335534913;
        Mon, 23 May 2022 12:52:14 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id v128-20020a372f86000000b006a33009158esm4838303qkh.119.2022.05.23.12.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 12:52:12 -0700 (PDT)
Message-ID: <70daebd6d65b34f5ab85f0286df9a539b5c62146.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/mmu: fix typo in comment
From:   Lyude Paul <lyude@redhat.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 23 May 2022 15:52:11 -0400
In-Reply-To: <20220521111145.81697-57-Julia.Lawall@inria.fr>
References: <20220521111145.81697-57-Julia.Lawall@inria.fr>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will fix that double space after the punctuation while I'm at it as well, and
will push to the appropriate branch in a little bit. Thanks!

On Sat, 2022-05-21 at 13:11 +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> index 8bf00b396ec1..8b11dfa0998d 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> @@ -280,7 +280,7 @@ nvkm_vmm_unref_ptes(struct nvkm_vmm_iter *it, bool pfn,
> u32 ptei, u32 ptes)
>         if (desc->type == SPT && (pgt->refs[0] || pgt->refs[1]))
>                 nvkm_vmm_unref_sptes(it, pgt, desc, ptei, ptes);
>  
> -       /* PT no longer neeed?  Destroy it. */
> +       /* PT no longer needed?  Destroy it. */
>         if (!pgt->refs[type]) {
>                 it->lvl++;
>                 TRA(it, "%s empty", nvkm_vmm_desc_type(desc));
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

