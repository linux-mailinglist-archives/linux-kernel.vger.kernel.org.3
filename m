Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C513545696
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbiFIVlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiFIVlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:41:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D11163FBCB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654810867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+0dAgKBzfPuu/Qpg4c3Cqr8k4N4HCUwtJu4hqNYeV2g=;
        b=SxOCVmx1m/PsjO4TP5h1JL7b6OfXAKQkdMoxjeVcxhsyOB+tPRUBfNoSmsi3SehTZEOMXe
        Sm83E/hCKzD9e1+lXnEMlCa/95Pz78D2bJnRKL0UEz9KZKnTzm/90BOG9CkFXLx1eEEX6n
        +eWsnr3z0pWf46idXX1wITg6yJCgups=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-cw9-IdbVOIyhM6TdVaCzHA-1; Thu, 09 Jun 2022 17:41:06 -0400
X-MC-Unique: cw9-IdbVOIyhM6TdVaCzHA-1
Received: by mail-il1-f200.google.com with SMTP id j5-20020a922005000000b002d1c2659644so18444625ile.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 14:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=+0dAgKBzfPuu/Qpg4c3Cqr8k4N4HCUwtJu4hqNYeV2g=;
        b=yLUg3YoSHY8LHVyQlwY7RrOLTj8fSsG9dQwM9/Rv68KA1TxrL73rejaTirL7qD2G0O
         r0XOtC5XAaNqNvf3Iew0iAQ3TFI0jGO0R/qCbKHJfHDtW06per2bvM5H37IZNPz7/jpD
         sYIBqq1ylCvjiAHut357bPm23xrtmE6x5M46KxPH7uqH3xhe0HTQuSA4QnnNimYXegNE
         uiuT5510zXIp2IxtDHn73g+XjpnAbLDhzOo/5BAK2m+7CJYSJPROjdESLQGLLmZX6mrn
         Usubm4r0e2jHlHKAk9KfloCX6bd9+3ZuWQIIxuRCmyXeMb5vADTliL8aZTfom+ntK3p+
         yPYg==
X-Gm-Message-State: AOAM533FwX//CStO4i7tREuJWQ5eI3DrzRM0i1d8t9Vlpo8xYlVKSBi9
        fP89Qi6D+uO7DAXYXRIe0aM9ZdQREzol4CYPrS64sB0D4naTLBNJnlQ4xvD3m+Zv+0v5gyEu5X0
        VIVpGHuter5wQukgvdtgcnxtl
X-Received: by 2002:a05:6638:dd3:b0:331:d98c:9a67 with SMTP id m19-20020a0566380dd300b00331d98c9a67mr7194725jaj.47.1654810866035;
        Thu, 09 Jun 2022 14:41:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLYxbzXLY+uqvkGUeuaM8Esk3FhbYDeZwBAuNSC8NN4cjxlecj6CnbA+l3i4GOPufnvI4knw==
X-Received: by 2002:a05:6638:dd3:b0:331:d98c:9a67 with SMTP id m19-20020a0566380dd300b00331d98c9a67mr7194664jaj.47.1654810864338;
        Thu, 09 Jun 2022 14:41:04 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id a18-20020a6b6d12000000b0066938e02579sm7583703iod.38.2022.06.09.14.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 14:41:03 -0700 (PDT)
Date:   Thu, 9 Jun 2022 15:41:02 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     kvm@vger.kernel.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laszlo Ersek <lersek@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 2/2] vfio/pci: Remove console drivers
Message-ID: <20220609154102.5cb1d3ca.alex.williamson@redhat.com>
In-Reply-To: <01c74525-38b7-1e00-51ba-7cd793439f03@suse.de>
References: <165453797543.3592816.6381793341352595461.stgit@omen>
        <165453800875.3592816.12944011921352366695.stgit@omen>
        <0c45183c-cdb8-4578-e346-bc4855be038f@suse.de>
        <20220608080432.45282f0b.alex.williamson@redhat.com>
        <01c74525-38b7-1e00-51ba-7cd793439f03@suse.de>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 11:13:22 +0200
Thomas Zimmermann <tzimmermann@suse.de> wrote:
> 
> Please have a look at the attached patch. It moves the aperture helpers 
> to a location common to the various possible users (DRM, fbdev, vfio). 
> The DRM interfaces remain untouched for now.  The patch should provide 
> what you need in vfio and also serve our future use cases for graphics 
> drivers. If possible, please create your patch on top of it.

Looks good to me, this of course makes the vfio change quite trivial.
One change I'd request:

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 40c50fa2dd70..7f3c44e1538b 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -10,6 +10,7 @@ config VGA_CONSOLE
 	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC &&  !SUPERH && \
 		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
 		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !S390 && !UML
+	select APERTURE_HELPERS if (DRM || FB || VFIO_PCI)
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a

This should be VFIO_PCI_CORE.  Thanks,

Alex

