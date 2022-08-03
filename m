Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B8058920A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237615AbiHCSG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbiHCSGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:06:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEC44491C8
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 11:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659550013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rh/D//LpX2EQSZeExryw0yfWU5X+yGvodAZfXC00FRk=;
        b=Ulrh6H41Y/U5woryt2wWSjl+QNkcIJ844XUKDhlULo0J9+tmvkWvpjh+aXa2Mvh6H3XhEp
        iOB483qdoy1GC56g58gt5JSJ17Jk8w0Lt48GwNirADESCXmGsT62zNGR1/4nbq4RH52jLw
        NNYcp9bTl9oFAnQca5l/PDkbs30g09k=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-WkxZuoy4Peiwx6GJp5GYmw-1; Wed, 03 Aug 2022 14:06:51 -0400
X-MC-Unique: WkxZuoy4Peiwx6GJp5GYmw-1
Received: by mail-qk1-f198.google.com with SMTP id m8-20020a05620a24c800b006b5d8eb23efso14117668qkn.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 11:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=Rh/D//LpX2EQSZeExryw0yfWU5X+yGvodAZfXC00FRk=;
        b=ReS8mcSJ/ARJdIKY0uuqDRW2RNlAV1tW+Y7mR2rL7bsJTpQxEv2PFkLLUYC2tS/6Mp
         rJSVA+KT2P1Q8Fdm3OuLruGiudOHGveucGwz9zs9EhakCCNNPcchKQT0y39Ps4FnYgwm
         xsIyHBZ2+o8TEVmuO6f4kloiDsXYrvsddKypnB9tkQ4LHQE6/z2/9wxGV/zSDBvO6yUx
         hWa6H87cNfHqx3iieixFAEWog22A4OWgfPQrA+7j9QXbwZ3C/CZDK1KEaaUFnA4FyFB3
         y253dTBzujwRv6M0FgoyIlyWov0daN6JW87jZJiumLZftQPEFD0sVRr8WN2hO69SYJUg
         29vw==
X-Gm-Message-State: AJIora9CwS2t6CzHTMxPP7CkDGz9bQ+HdzYfdGBWaCzpF06t77G/afyM
        cVUJ5y8RU8VS3Wz40hwVNEG3Z0Gu4QdlXwRp8x4DFU3s0sw/4Zov4YM9Cs0+EH5mIfw5N9rMOPx
        E3PWnkGDWew2jx5D/dVZER2sX
X-Received: by 2002:a05:620a:28cf:b0:6b5:e32f:febb with SMTP id l15-20020a05620a28cf00b006b5e32ffebbmr18518177qkp.258.1659550011426;
        Wed, 03 Aug 2022 11:06:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v1wP4M+hCDHMvv7zAVXU8ZZsm0m0Hr8gMyZl3KqH9ZCDJtIXmNHrJmFeE8kKzevcYazksmzg==
X-Received: by 2002:a05:620a:28cf:b0:6b5:e32f:febb with SMTP id l15-20020a05620a28cf00b006b5e32ffebbmr18518161qkp.258.1659550011181;
        Wed, 03 Aug 2022 11:06:51 -0700 (PDT)
Received: from [192.168.8.138] (pool-100-0-245-4.bstnma.fios.verizon.net. [100.0.245.4])
        by smtp.gmail.com with ESMTPSA id g1-20020a05620a40c100b006b55036fd3fsm13720397qko.70.2022.08.03.11.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 11:06:50 -0700 (PDT)
Message-ID: <4fd72edfab4cfb6e8ca9731f1087c2209299bdd2.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: recognise GA103
From:   Lyude Paul <lyude@redhat.com>
To:     Karol Herbst <kherbst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     nouveau@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        stable@vger.kernel.org
Date:   Wed, 03 Aug 2022 14:06:49 -0400
In-Reply-To: <20220803142745.2679510-1-kherbst@redhat.com>
References: <20220803142745.2679510-1-kherbst@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Wed, 2022-08-03 at 16:27 +0200, Karol Herbst wrote:
> Appears to be ok with general GA10x code.
> 
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> Cc: <stable@vger.kernel.org> # v5.15+
> ---
>  .../gpu/drm/nouveau/nvkm/engine/device/base.c | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
> index 62efbd0f3846..b7246b146e51 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
> @@ -2605,6 +2605,27 @@ nv172_chipset = {
>         .fifo     = { 0x00000001, ga102_fifo_new },
>  };
>  
> +static const struct nvkm_device_chip
> +nv173_chipset = {
> +       .name = "GA103",
> +       .bar      = { 0x00000001, tu102_bar_new },
> +       .bios     = { 0x00000001, nvkm_bios_new },
> +       .devinit  = { 0x00000001, ga100_devinit_new },
> +       .fb       = { 0x00000001, ga102_fb_new },
> +       .gpio     = { 0x00000001, ga102_gpio_new },
> +       .i2c      = { 0x00000001, gm200_i2c_new },
> +       .imem     = { 0x00000001, nv50_instmem_new },
> +       .mc       = { 0x00000001, ga100_mc_new },
> +       .mmu      = { 0x00000001, tu102_mmu_new },
> +       .pci      = { 0x00000001, gp100_pci_new },
> +       .privring = { 0x00000001, gm200_privring_new },
> +       .timer    = { 0x00000001, gk20a_timer_new },
> +       .top      = { 0x00000001, ga100_top_new },
> +       .disp     = { 0x00000001, ga102_disp_new },
> +       .dma      = { 0x00000001, gv100_dma_new },
> +       .fifo     = { 0x00000001, ga102_fifo_new },
> +};
> +
>  static const struct nvkm_device_chip
>  nv174_chipset = {
>         .name = "GA104",
> @@ -3092,6 +3113,7 @@ nvkm_device_ctor(const struct nvkm_device_func *func,
>                 case 0x167: device->chip = &nv167_chipset; break;
>                 case 0x168: device->chip = &nv168_chipset; break;
>                 case 0x172: device->chip = &nv172_chipset; break;
> +               case 0x173: device->chip = &nv173_chipset; break;
>                 case 0x174: device->chip = &nv174_chipset; break;
>                 case 0x176: device->chip = &nv176_chipset; break;
>                 case 0x177: device->chip = &nv177_chipset; break;

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

