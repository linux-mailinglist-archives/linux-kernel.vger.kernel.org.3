Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4426E5456B2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbiFIVoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiFIVoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:44:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 163AC65D39
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654811060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B1pdgF7AnLu0fVQCtydwApAx3WZNtJh5bsvpbPEg0J0=;
        b=eS6SQpz+ywcjgd0sAI/vvEs9NWMWx9wXBpp80hz9vMvuJuRk8hfr8301T5ZfjmOubltLYv
        piL8dgK11d04i958czQRnfjpe8qFa6iidTGjfrxkCP+7YzLdB6zMX4OeAoIh+lz8ntZSiw
        16vGo2FNkBYAPP41uuPQznrSLDJmo3o=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-eKP6F1qsOAuRPoxSU0KLSA-1; Thu, 09 Jun 2022 17:44:19 -0400
X-MC-Unique: eKP6F1qsOAuRPoxSU0KLSA-1
Received: by mail-il1-f197.google.com with SMTP id y18-20020a927d12000000b002d3dd2a5d53so17759413ilc.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 14:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=B1pdgF7AnLu0fVQCtydwApAx3WZNtJh5bsvpbPEg0J0=;
        b=A7vuoGyEdacE2jCysOA07oCObzrb+8oEWXjbX2NjzNyudfj6DxjET2vazTgr6/Cio5
         kFA8pHVeCOc0W2f4L6aHtnY6ggUNc+SeK1hANWaGXn00P3fHRVMOvSOOeLMPD9PlFW89
         YwRFdIQb8m1bIC94JgdZEOrQFi80vtLBiQz017lLsGhosn1f/f0Jbc71mc8izlfhf6Yl
         pVFbyK/izYdaLN7B5mci4JvprLK0ge6S0eVIsEuU5PUimHDRlYLbBZ37c+6TrkjHr/0U
         2gsM8E81g80H03E6aFAcg8wokovb+sFBbYsq9DknJzK//Z+YS/9OStbM2tl68FeBywwW
         e78w==
X-Gm-Message-State: AOAM533CuGEvL2yxhO9eNE2nKwymWY/wJeJTzKmlMbox64R+0f4dLNCj
        1oqYHnOpgpYk57KNOH2tn2VQsgZGEZn40sVSRXSzwqprgjxup7lnmIYu08zehQu8D3GaWffGBla
        UexZQzkuvqHLw5Ms3nz6ISYM6
X-Received: by 2002:a05:6e02:1e09:b0:2d1:97ca:a241 with SMTP id g9-20020a056e021e0900b002d197caa241mr23122508ila.238.1654811059001;
        Thu, 09 Jun 2022 14:44:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDscdO/W1/4no+7jY69FGERgzQXiRmYHQK/m9EuLA1t1bvx3ksqGSpUr0meCCLPhXF9woEYQ==
X-Received: by 2002:a05:6e02:1e09:b0:2d1:97ca:a241 with SMTP id g9-20020a056e021e0900b002d197caa241mr23122496ila.238.1654811058769;
        Thu, 09 Jun 2022 14:44:18 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id n29-20020a02711d000000b00331a94f2b04sm5740155jac.105.2022.06.09.14.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 14:44:18 -0700 (PDT)
Date:   Thu, 9 Jun 2022 15:44:16 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     kvm@vger.kernel.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laszlo Ersek <lersek@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 2/2] vfio/pci: Remove console drivers
Message-ID: <20220609154416.676b1068.alex.williamson@redhat.com>
In-Reply-To: <20220609154102.5cb1d3ca.alex.williamson@redhat.com>
References: <165453797543.3592816.6381793341352595461.stgit@omen>
        <165453800875.3592816.12944011921352366695.stgit@omen>
        <0c45183c-cdb8-4578-e346-bc4855be038f@suse.de>
        <20220608080432.45282f0b.alex.williamson@redhat.com>
        <01c74525-38b7-1e00-51ba-7cd793439f03@suse.de>
        <20220609154102.5cb1d3ca.alex.williamson@redhat.com>
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

On Thu, 9 Jun 2022 15:41:02 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Thu, 9 Jun 2022 11:13:22 +0200
> Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > 
> > Please have a look at the attached patch. It moves the aperture helpers 
> > to a location common to the various possible users (DRM, fbdev, vfio). 
> > The DRM interfaces remain untouched for now.  The patch should provide 
> > what you need in vfio and also serve our future use cases for graphics 
> > drivers. If possible, please create your patch on top of it.  
> 
> Looks good to me, this of course makes the vfio change quite trivial.
> One change I'd request:
> 
> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> index 40c50fa2dd70..7f3c44e1538b 100644
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -10,6 +10,7 @@ config VGA_CONSOLE
>  	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC &&  !SUPERH && \
>  		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
>  		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !S390 && !UML
> +	select APERTURE_HELPERS if (DRM || FB || VFIO_PCI)
>  	default y
>  	help
>  	  Saying Y here will allow you to use Linux in text mode through a
> 
> This should be VFIO_PCI_CORE.  Thanks,

Also, whatever tree this lands in, I'd appreciate a topic branch being
made available so I can more easily get the vfio change in on the same
release.  Thanks,

Alex

