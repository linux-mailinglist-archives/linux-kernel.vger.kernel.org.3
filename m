Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71703563F4A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 11:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiGBJlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 05:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBJlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 05:41:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F55CB4BB
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 02:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656754870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EbUcjl37U9ZI5oLem8qgJPAQgmdyWCyCszoWhSDvio0=;
        b=CxaxaNWQAfPwGx+01iLl/KErBdsNnZ5LLF7okecnSG9Y25JajMbpvln4Ps0D6t712EUF8l
        cTkQWLVQPRpqNS/IHNHOR/c8+u3uzQg0yO/peg1JvloNL2dFTnXYneuWu0UcxCF41sE9wt
        JL8qSMdyum9gJwSyfRexa6p2T7PltE0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-WJNp9kExOY-dw_odKZ5lpg-1; Sat, 02 Jul 2022 05:41:09 -0400
X-MC-Unique: WJNp9kExOY-dw_odKZ5lpg-1
Received: by mail-ed1-f70.google.com with SMTP id c20-20020a05640227d400b004369cf00c6bso3418325ede.22
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 02:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EbUcjl37U9ZI5oLem8qgJPAQgmdyWCyCszoWhSDvio0=;
        b=U7y9hckrOiT2kwKVMCQQqPbuQcj5uCtO3HQ7TUFVOh3C/FLUFGduCC6VEpC2I5XO0F
         OvA2B7bxRJERLUruE46Mitn0X6/9hi6Kns2gU16mk/nklE4nKFf4I8x1myb79jEUYBqQ
         Lw0kA/dD6IIq7BtBIhAJB2E3WPcyQwdMaFbEXfbTcOjSPhDRTe5LsZ7KT5C8iVetTH6g
         TUD8jeitP2TWPyGBKNm1MOzRe37T1CjIzJ/dx0OhmJlOodQtSbHsPpj2MTfZ2MNZHd/S
         U4UmjoIsLt0zwf4lvLDl4XMiAeiFz2S4GHnDRi4vzmGJJEE3CdoN+EyYsG9Nza9S5vCK
         laOg==
X-Gm-Message-State: AJIora8GiFa4QOZw5yTm6vWD95VAZsQGg++KMXrZmDkzBIYIizA7wGP3
        BtjifbmPJ02P11Rdo+r95huGHp8HSjID8KH38u326ZP1Yv4Ds2/g0d9l2Tn9eTesxqbuAS9N5h6
        YCPhwFklZsJB9Z65dToFqiyRa
X-Received: by 2002:a17:907:1dc6:b0:72a:5e9a:91be with SMTP id og6-20020a1709071dc600b0072a5e9a91bemr13345191ejc.730.1656754867653;
        Sat, 02 Jul 2022 02:41:07 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vy+ZptcZ/qo+F2ZEOOawo6gU0JWHUnczjYlCP6J5rlgkyPXET7RulfZIUqwqQ3kZ3IWdEwAA==
X-Received: by 2002:a17:907:1dc6:b0:72a:5e9a:91be with SMTP id og6-20020a1709071dc600b0072a5e9a91bemr13345178ejc.730.1656754867476;
        Sat, 02 Jul 2022 02:41:07 -0700 (PDT)
Received: from [192.168.43.127] ([109.38.147.70])
        by smtp.gmail.com with ESMTPSA id p4-20020a056402154400b0042dcac2afc6sm16571865edx.72.2022.07.02.02.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 02:41:06 -0700 (PDT)
Message-ID: <a3b35758-2279-34d9-9b4b-6cb837618918@redhat.com>
Date:   Sat, 2 Jul 2022 11:40:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/3] platform/surface: Move Surface Aggregator client hubs
 to their own modules
Content-Language: en-US
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220624205800.1355621-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220624205800.1355621-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/24/22 22:57, Maximilian Luz wrote:
> This series moves the Surface Aggregator client device hubs from the
> Surface Aggregator registry to their own modules. While, at the moment,
> client device hubs are exclusively instantiated by the registry platform
> hub driver, this will change in the future. In particular, with the
> introduction of DT/OF support, which is required for the Surface Pro X.
> Therefore, this series also slightly restructures the functions used for
> software-node-based device instantiation, essentially acting as
> preparation for that.
> 
> In addition, this series follows-up "platform/surface: aggregator: Add
> support for client hot-removal" and further removes some code
> duplication by consolidating more parts of the hub drivers. While at it,
> also ensure proper handling of firmware node lifetimes and update the
> copyright year of various files.

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
> Maximilian Luz (3):
>   platform/surface: aggregator: Move device registry helper functions to
>     core module
>   platform/surface: aggregator: Move subsystem hub drivers to their own
>     module
>   platform/surface: Update copyright year of various drivers
> 
>  MAINTAINERS                                   |   6 +
>  drivers/platform/surface/Kconfig              |  35 +-
>  drivers/platform/surface/Makefile             |   1 +
>  drivers/platform/surface/aggregator/Kconfig   |   2 +-
>  drivers/platform/surface/aggregator/Makefile  |   2 +-
>  drivers/platform/surface/aggregator/bus.c     | 151 +++++-
>  drivers/platform/surface/aggregator/bus.h     |   2 +-
>  .../platform/surface/aggregator/controller.c  |   2 +-
>  .../platform/surface/aggregator/controller.h  |   2 +-
>  drivers/platform/surface/aggregator/core.c    |   2 +-
>  .../platform/surface/aggregator/ssh_msgb.h    |   2 +-
>  .../surface/aggregator/ssh_packet_layer.c     |   2 +-
>  .../surface/aggregator/ssh_packet_layer.h     |   2 +-
>  .../platform/surface/aggregator/ssh_parser.c  |   2 +-
>  .../platform/surface/aggregator/ssh_parser.h  |   2 +-
>  .../surface/aggregator/ssh_request_layer.c    |   2 +-
>  .../surface/aggregator/ssh_request_layer.h    |   2 +-
>  drivers/platform/surface/aggregator/trace.h   |   2 +-
>  .../platform/surface/surface_acpi_notify.c    |   2 +-
>  .../surface/surface_aggregator_cdev.c         |   2 +-
>  .../platform/surface/surface_aggregator_hub.c | 371 +++++++++++++++
>  .../surface/surface_aggregator_registry.c     | 446 +-----------------
>  drivers/platform/surface/surface_dtx.c        |   2 +-
>  drivers/platform/surface/surface_gpe.c        |   2 +-
>  drivers/platform/surface/surface_hotplug.c    |   2 +-
>  .../surface/surface_platform_profile.c        |   2 +-
>  include/linux/surface_aggregator/device.h     |  52 ++
>  27 files changed, 618 insertions(+), 484 deletions(-)
>  create mode 100644 drivers/platform/surface/surface_aggregator_hub.c
> 

