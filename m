Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634B556ADB0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbiGGVdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbiGGVdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 197EF3335F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 14:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657229579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AgSzWSDbGjhzoFk42SsVA9TRs/p1ehj7SbLA+QBY5xE=;
        b=QYozDFih20YAUv0em9ZSiyYk++29HYRbA59sUZ3yWQgkifKqz6Ogmn6jyGZDCzTJhmZy5w
        JcPWhf0TViSKd/VxCeatIMOkuh+oeEqHzX8X3D0OdJTcqcXsmhOWYAsq7FUnH1UHVBOtfe
        OWNJLMoMFzH/ZoFVUjX+pKDjR7bxSsc=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-n1KOvG5TOWSyXBCs1UuERQ-1; Thu, 07 Jul 2022 17:32:57 -0400
X-MC-Unique: n1KOvG5TOWSyXBCs1UuERQ-1
Received: by mail-io1-f71.google.com with SMTP id k19-20020a6b4013000000b00678eb404d59so814971ioa.15
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 14:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=AgSzWSDbGjhzoFk42SsVA9TRs/p1ehj7SbLA+QBY5xE=;
        b=7ox+atllqChksEazifQIrSNWJZcAJm6V8KnBq/mV2Pzjl7zd/8V400KvsLerAuPqy5
         rIz58isNWDA2xu6BIG7SHCXLgut0XBFJ4y9CFZOwGtN/nXQYFLZnDeCBaUdn3vrvVX5j
         YmmaIX65SYhwSZ40jQcTXvmvfWYXxsx8lKiYG8YRlmbmKPw2KedeTBU3VJ9Te5jNQrAR
         WjccGRKckQq6aHL56isxNnLGcd9j/qZ7XNvu7VbsyQUUDqhJ/Rw/e6xhzPLSWziUSAtL
         TxD4OXjzyOTdFvYGrfvxPooa2AvJfHAvLPOtgeVI0Esq2x7k6VxBJXtYwmY0OsJws8nN
         ov2w==
X-Gm-Message-State: AJIora+SzGN9yo7JuUZBE+IceDVgOweT15Zty1yhtDgCC4Zegj2477ms
        UlQh+H7ERSTMlCzyw3xptAahpYhaNM9GUGDdjKnZkaZfeGkhNjrm2I1fd6iN35hyFjl/OcqIKSY
        7qloGTsETTuTBhrjmuqyVJSJd
X-Received: by 2002:a05:6602:27cd:b0:669:3d8d:4d77 with SMTP id l13-20020a05660227cd00b006693d8d4d77mr83536ios.216.1657229569985;
        Thu, 07 Jul 2022 14:32:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tg2gPxDcSD3Zl8LYAqqK1uXEOcMwrfIdH93nrGqcskQfyjnsBJL74W73KB+ULdOtM2GF25kg==
X-Received: by 2002:a05:6602:27cd:b0:669:3d8d:4d77 with SMTP id l13-20020a05660227cd00b006693d8d4d77mr83529ios.216.1657229569809;
        Thu, 07 Jul 2022 14:32:49 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id y22-20020a056638229600b00339e2f0a9bfsm793307jas.13.2022.07.07.14.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 14:32:49 -0700 (PDT)
Date:   Thu, 7 Jul 2022 15:32:46 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bo Liu <liubo03@inspur.com>
Cc:     <cohuck@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio/pci: fix the wrong word
Message-ID: <20220707153246.48b26a68.alex.williamson@redhat.com>
In-Reply-To: <20220704023649.3913-1-liubo03@inspur.com>
References: <20220704023649.3913-1-liubo03@inspur.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jul 2022 22:36:49 -0400
Bo Liu <liubo03@inspur.com> wrote:

> This patch fixes a wrong word in comment.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  drivers/vfio/pci/vfio_pci_config.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 9343f597182d..97e5ade6efb3 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1728,7 +1728,7 @@ int vfio_config_init(struct vfio_pci_core_device *vdev)
>  	/*
>  	 * Config space, caps and ecaps are all dword aligned, so we could
>  	 * use one byte per dword to record the type.  However, there are
> -	 * no requiremenst on the length of a capability, so the gap between
> +	 * no requirements on the length of a capability, so the gap between
>  	 * capabilities needs byte granularity.
>  	 */
>  	map = kmalloc(pdev->cfg_size, GFP_KERNEL);

Applied to vfio next branch for v5.20.  Thanks,

Alex

