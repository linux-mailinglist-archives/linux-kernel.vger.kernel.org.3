Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AE7542A0F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiFHIzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiFHIyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:54:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA9D939451F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654676113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jz5q+YjZAkyfToJ2c95DtkbkAjaLs7+ZTPGj5+BkvEk=;
        b=ENrxtfRhZHEt+cwT86vF7O1tDcqRdpf+nVMcmMC5SP3fU8okjpVHy38/n0SZnd4emZZ5Rt
        x6faVPzlRJl/6ipmfcutryiwfkhKtEnFNqMMZqhXlS3B2ghD1TuVBSfgOwxx0MkPbd+rMd
        6AAOL3WWRd+MmAK8D8enbMfN3Hr4b08=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-mJDt-iO9MeSZGSG50pPOMQ-1; Wed, 08 Jun 2022 04:15:10 -0400
X-MC-Unique: mJDt-iO9MeSZGSG50pPOMQ-1
Received: by mail-lf1-f69.google.com with SMTP id u7-20020a05651206c700b00479723664a9so1545097lff.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 01:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jz5q+YjZAkyfToJ2c95DtkbkAjaLs7+ZTPGj5+BkvEk=;
        b=BKgghVK8SJvPQjB89FFpbl3jvxulWG2c/VlFqgLR4zjcjUIjz3LLVeynl1PV3GXlih
         Y1End7EIF17oZIMbEAL+pMu/ZR31CvJqsIwZ3YxIn0T0pc99/FsEXWQTzVu37ZoD2E3y
         JpnJ/5Y+PT8w/8oW+Lh/1U18rAnFT0S6lBSW5pFgcUyEi370yqHF39uc0jsNUsskmwo8
         iSmYK7NU0sBzd6BLbqa+ijtNvnHKn39o0JcAyQiqRNfOv8GkxZ1kpnso1PIWp0sq9XDN
         PdYp5zGLrCIcAULd3nAej7TQpSSKzqzSya99PRqZ3ZKbH1g201Rn6Qs/oHuOSYkNuuOH
         ijug==
X-Gm-Message-State: AOAM532+Ua0gMvHlkTgHX8RwikuoteGXwoe/GDhH7gksHjWT/pPJNX0r
        j+CS+Yxvh349++KSTADhLbEj2MIqiWZeZcEV8NKYN0Ri/qaZ+gnCA/D/pQGhOTynsDN8Zad0fUp
        MDgw1IuzqH/0u5gwphavjTSKEUzkkTiiXJnIov0Pb
X-Received: by 2002:a05:6512:5cc:b0:47a:bf7:f1ab with SMTP id o12-20020a05651205cc00b0047a0bf7f1abmr521610lfo.397.1654676108375;
        Wed, 08 Jun 2022 01:15:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyY1+iIQeufl0PI6M0pxOr2OD+lyDsrI90C2L8v6cQJkrGmLHN5yVXtHbpPbGCBoud3azvKXHalfitf8gmL8hg=
X-Received: by 2002:a05:6512:5cc:b0:47a:bf7:f1ab with SMTP id
 o12-20020a05651205cc00b0047a0bf7f1abmr521603lfo.397.1654676108211; Wed, 08
 Jun 2022 01:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220604143858.16073-1-wangxiang@cdjrlc.com>
In-Reply-To: <20220604143858.16073-1-wangxiang@cdjrlc.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 8 Jun 2022 16:14:57 +0800
Message-ID: <CACGkMEsL513A2Wq2y9GS0yF-FB85gEqJABAULUAjF0aQb0Fmmw@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix syntax errors in comments
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 4, 2022 at 10:40 PM Xiang wangx <wangxiang@cdjrlc.com> wrote:
>
> Delete the redundant word 'is'.
>
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index dcca782c698e..3569c782c8a0 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -105,7 +105,7 @@ struct mlx5_vdpa_virtqueue {
>
>         /* Resources for implementing the notification channel from the device
>          * to the driver. fwqp is the firmware end of an RC connection; the
> -        * other end is vqqp used by the driver. cq is is where completions are
> +        * other end is vqqp used by the driver. cq is where completions are
>          * reported.
>          */
>         struct mlx5_vdpa_cq cq;
> --
> 2.36.1
>

