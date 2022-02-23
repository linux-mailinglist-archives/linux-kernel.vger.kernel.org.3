Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4114C105C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbiBWKgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiBWKgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:36:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4C5E674D5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 02:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645612538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LDFE/AF6OilKvh3iUFfF77vBEgChW2LE7G/cxAjECQA=;
        b=RNte1gAG5aIKXEtcIOU0zFA3gqOY4v1R1r75NjK6q1xjPaOOCALFdvCNWokXLDVXNbWMK1
        Pb1eN/gdSmCXZ6vS+dzKkYzuUBdtw9CzxP7T3+TnNTe4m5vPUSMx+VFcLyx49R6Ik/lZh2
        jtjJDrfaNe5wagi3FGtOR0GQyWKg8MM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-pjvzQh8wPe-GvArkraKxiQ-1; Wed, 23 Feb 2022 05:35:37 -0500
X-MC-Unique: pjvzQh8wPe-GvArkraKxiQ-1
Received: by mail-ed1-f72.google.com with SMTP id g5-20020a056402090500b0040f28e1da47so13420032edz.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 02:35:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LDFE/AF6OilKvh3iUFfF77vBEgChW2LE7G/cxAjECQA=;
        b=34kJ0eaBRus/iYJXpjt0uuV56ir7ZZCGmlSJXkWmH1sBCP4F0sJaX+6U4+j3XFQXMl
         itMJUDsyo+cPU4XNzpcoAVouGhyltmaw9NZWspaspu4cUPN0ycNqHetE8vMoPERJzM6E
         mE85AGXdWOfmQ0wnWSw95gZFTtxqDPVTGut99rwdc4dDVQNGwRz2XeZv59cxPqhVn+0s
         sWlBXfY8cj7U1uOhu1s0zFcPBIMTLZfBm/0AylmztsCXK7QOdX1OHZA+/xO2/hGPJncg
         sFquunH8iXuirI+jZMNwTliYZHPDb24tfaWVcSvJPWKG0t9QbH8WqYcycnMc6A8iyIv4
         cgmg==
X-Gm-Message-State: AOAM533Md6BB3lSqPAIEgSYIFXKh88esF4XKO4Yopbobvn68/l04QWve
        57jOTGtyxrzqBixIU2ihbv3b15WpBiBOJu8TEMtNKocWY8gjbcqlZaCXuLR0gTnPkkvtNdf36yR
        4Q4B8siXxGdmWSeBbbo4fI63v
X-Received: by 2002:a50:fe89:0:b0:410:f1f7:4983 with SMTP id d9-20020a50fe89000000b00410f1f74983mr31170061edt.135.1645612536217;
        Wed, 23 Feb 2022 02:35:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPgScTaLJhrUGTiHpKOmNfbzSl9lCT3D3psNpt5HqC/tAVtK76GduhrSr5H+1T53k8FJS9qw==
X-Received: by 2002:a50:fe89:0:b0:410:f1f7:4983 with SMTP id d9-20020a50fe89000000b00410f1f74983mr31170047edt.135.1645612536024;
        Wed, 23 Feb 2022 02:35:36 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id f22sm11757437edf.95.2022.02.23.02.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 02:35:35 -0800 (PST)
Message-ID: <a5346dfb-2943-ac02-5dc3-59ab25eae17a@redhat.com>
Date:   Wed, 23 Feb 2022 11:35:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [pdx86-platform-drivers-x86:review-hans 40/40] ERROR: modpost:
 "battery_hook_register" [drivers/platform/x86/lg-laptop.ko] undefined!
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Matan Ziv-Av <matan@svgalib.org>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <202202231609.ZQpgFUIn-lkp@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <202202231609.ZQpgFUIn-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/23/22 09:44, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git review-hans
> head:   7e45710a8a56896d7af5c5ff4ed7cfb18573791b
> commit: 7e45710a8a56896d7af5c5ff4ed7cfb18573791b [40/40] lg-laptop: Move setting of battery charge limit to common location
> config: x86_64-randconfig-r035-20220221 (https://download.01.org/0day-ci/archive/20220223/202202231609.ZQpgFUIn-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=7e45710a8a56896d7af5c5ff4ed7cfb18573791b
>         git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
>         git fetch --no-tags pdx86-platform-drivers-x86 review-hans
>         git checkout 7e45710a8a56896d7af5c5ff4ed7cfb18573791b
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> ERROR: modpost: "battery_hook_register" [drivers/platform/x86/lg-laptop.ko] undefined!
>>> ERROR: modpost: "battery_hook_unregister" [drivers/platform/x86/lg-laptop.ko] undefined!

Ah yes, config LG_LAPTOP needs a depends on ACPI_BATTERY now.

I've squashed a fix for this into the original commit in my review-hans branch.

Regards,

Hans

