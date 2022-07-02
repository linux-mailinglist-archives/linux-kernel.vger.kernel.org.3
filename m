Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5DE563F33
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 11:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiGBJN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 05:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBJNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 05:13:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68E0A1BE84
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 02:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656753229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFmB2k60UuW2i0Ht+Cef4lERIPyUH6lPw9UpjnL8iPw=;
        b=fbCs6xAzDo7QK0mclRDMD9mvYxhDyPs3rUEgSWsaynScs9xKypPMayk/5bb+ACsyRiLOOt
        gWYdj1NIo8rVet5FTzO4reM68ulsAd7Tf37kw8wfZcmngZLqQgGp9Id3wcMSvZRM9XUIgw
        wzaSIve85cafHsLbu20IvfqgPEjn26U=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-GuqRE6fnO0-z4TXd0c8xiA-1; Sat, 02 Jul 2022 05:13:47 -0400
X-MC-Unique: GuqRE6fnO0-z4TXd0c8xiA-1
Received: by mail-ej1-f70.google.com with SMTP id go10-20020a1709070d8a00b00722e8ee15b4so1249384ejc.22
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 02:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wFmB2k60UuW2i0Ht+Cef4lERIPyUH6lPw9UpjnL8iPw=;
        b=BwonoC9fHpuKk2JcGn20PHjH9Rk87/a/ILG8ZNVJNvOLot4z4rc96tjiK5ZDuk3Sx0
         I1EdEiO9GcrV9i1C4i1OYqyiKjtlBZDp5TFnizn1bvSFopYlBn+/1ar8D7SOSPebPOYx
         c+T8PtInJKX68cfCelVP6xaLXNNLv44wsCO0vY/TzFbr1Tkqjdoa1xwWF2Yil1dnrhcS
         sj1JCshCB6FXW7gyuEfPTDs3Zj0ywnQgZnWMudOFZquez3kSGeELIljuDrqoxNQTNBud
         SeJug4BNcFXfIlShS23EZ+jDeHjL/ziWH4THslTyE3J/kjpZ2ozUxUvjZrYlKRNP2x9J
         nuoA==
X-Gm-Message-State: AJIora89rmHkCPQ8wGPERRJ+6YAP/f98goC/xcwiJnrXtWkstqfMMm0R
        MWB66Hg1j6RP06gTpUck5Twfu1VSXSDouEnH9beZcUfOpguRnpNr2iJbJg1lvwEeheyXW/2F91x
        A8Mc8Td/Oj8s7VTS8kpGUZNpo
X-Received: by 2002:a17:906:af12:b0:722:f9f0:cb75 with SMTP id lx18-20020a170906af1200b00722f9f0cb75mr18376894ejb.643.1656753226474;
        Sat, 02 Jul 2022 02:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tzOdQ1+rNU4RL6J1uNPu/GPGrF4Z+Slx9/SINFUrbq42gOmhP98HTwRwIETyi1VTR+i837DA==
X-Received: by 2002:a17:906:af12:b0:722:f9f0:cb75 with SMTP id lx18-20020a170906af1200b00722f9f0cb75mr18376888ejb.643.1656753226290;
        Sat, 02 Jul 2022 02:13:46 -0700 (PDT)
Received: from [192.168.43.127] ([109.38.147.70])
        by smtp.gmail.com with ESMTPSA id w14-20020a056402128e00b004356894a3f8sm16463809edv.89.2022.07.02.02.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 02:13:45 -0700 (PDT)
Message-ID: <226acf2e-19a3-6ece-c353-793eb6995549@redhat.com>
Date:   Sat, 2 Jul 2022 11:13:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/4] platform/surface: Add support for tablet mode switch
 via Surface Aggregator Module
Content-Language: en-US
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220624183642.910893-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220624183642.910893-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/24/22 20:36, Maximilian Luz wrote:
> This series adds a driver providing a tablet mode switch on the Surface
> Pro 8, Surface Pro X, and Surface Laptop Studio.
> 
> These devices provide posture information via subsystems of the Surface
> Aggregator Module (SAM; embedded controller). While the specific
> subsystems used for the Pro and Laptop models differ, large parts of the
> respective subsystem drivers would be equal. Therefore, we essentially
> provide a generic framework for tablet-mode switches via the Surface
> Aggregator module and use that to implement specific support for the KIP
> and POS subsystems used on the aforementioned devices.
> 
> In addition, this series first introduces some helper macros for
> synchronous stack-allocated SAM requests used in the subsequent patches,
> extending the already existing ones.
> 
> Further, this series adds the respective firmware nodes to the Surface
> Aggregator Registry.

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> 
> Maximilian Luz (4):
>   platform/surface: aggregator: Add helper macros for requests with
>     argument and return value
>   platform/surface: Add KIP/POS tablet-mode switch driver
>   platform/surface: aggregator_registry: Add support for tablet mode
>     switch on Surface Pro 8
>   platform/surface: aggregator_registry: Add support for tablet mode
>     switch on Surface Laptop Studio
> 
>  .../sysfs-bus-surface_aggregator-tabletsw     |  57 ++
>  MAINTAINERS                                   |   6 +
>  drivers/platform/surface/Kconfig              |  23 +
>  drivers/platform/surface/Makefile             |   1 +
>  .../surface/surface_aggregator_registry.c     |  15 +-
>  .../surface/surface_aggregator_tabletsw.c     | 533 ++++++++++++++++++
>  include/linux/surface_aggregator/controller.h | 125 ++++
>  include/linux/surface_aggregator/device.h     |  36 ++
>  8 files changed, 795 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-surface_aggregator-tabletsw
>  create mode 100644 drivers/platform/surface/surface_aggregator_tabletsw.c
> 

