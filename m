Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372EF550B2F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 16:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbiFSO1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 10:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiFSO1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 10:27:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80CFBDF0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655648827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xoLgRCYGtVkzjW93PvWX07m9n9Jojzja1sjm0GTmypQ=;
        b=Xzj7JBj7YimnXd6c5yGr63zUfUaUsi1f/OeZsRlhOIrp7OzqFTpyPJL/8UEnnn4HUBooLA
        Zoe0c1cfSalJJauYhUU4Vu1X88mOM+ksLTA2Bzg/j9FX3C4bJ9SHbO2TTOT91lDFRXFI9e
        NcWhwIsTAmMcOXcQ3jxktij3LMjqYr0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-VShiC7uZPOSMp6h28gTORw-1; Sun, 19 Jun 2022 10:27:06 -0400
X-MC-Unique: VShiC7uZPOSMp6h28gTORw-1
Received: by mail-wm1-f72.google.com with SMTP id ay28-20020a05600c1e1c00b0039c5cbe76c1so5499002wmb.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 07:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xoLgRCYGtVkzjW93PvWX07m9n9Jojzja1sjm0GTmypQ=;
        b=ho7aYM++3WDhLXTCQXCS2opnlkEaxcLup7fAMX0ICgc1nPCCHcPv+omCuIFP9+uw+R
         o526MklD5OGEGhh+8d7UD7/oYGRnKfUl0Z2yo+8J4FmlGXWWwTgs0v6qQ4uBu4P+5tnX
         u0gvsaujRhyfndBZz3V+xDPdh+d0+lUFmX4hkb64lfThqwHjWqF2wxvPw0zS27is2v5I
         ksR9yieg5DiIKMRTHujkSlskJ3QR/0rLztYuXcFxvGuC4zWjnSZl82LzrqXhyPbKJK01
         j5Cvj2IvSruYVK+R1wJK+K7ojCD3D+Qv9HrJ8RBCSdyszANE0KLft3+hgAiWDp2tgsTc
         2Fjw==
X-Gm-Message-State: AJIora9RGT6zajxkp06wplE0ni3OF9gX9w5xPKO0JAsm0jvI7NDyHecP
        +HQKO4ZyJhwCALVIPBuWK9yUQKhRBfVnNBdZHqg6cDPFEjCIr+SzW8Ni4tMs+LQJoRPBA7QwE+O
        A3SXC/Vz+3BNLzIiqy6tV3k+Y
X-Received: by 2002:adf:e710:0:b0:21b:8af6:d5bc with SMTP id c16-20020adfe710000000b0021b8af6d5bcmr3398576wrm.278.1655648824918;
        Sun, 19 Jun 2022 07:27:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t+As4JLV5NWMWt6DAKnOmE88ii8QUGPm1hNF6tWX65VasbcejQXyzs16QNo8EyGTHvs+0MXg==
X-Received: by 2002:adf:e710:0:b0:21b:8af6:d5bc with SMTP id c16-20020adfe710000000b0021b8af6d5bcmr3398559wrm.278.1655648824649;
        Sun, 19 Jun 2022 07:27:04 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d9-20020a056000114900b0021b8dd05f45sm1186901wrx.55.2022.06.19.07.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 07:27:04 -0700 (PDT)
Message-ID: <5eabd169-b8a0-fb8f-d70b-4495d3790f05@redhat.com>
Date:   Sun, 19 Jun 2022 16:27:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [DRM/hisilicon/hibmc] kernel robot reports build errors,
 patch(es) available but not merged
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Xinliang Liu <xinliang.liu@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        John Stultz <jstultz@google.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        RongrongZou <zourongrong@huawei.com>
References: <9a0ed0bb-34c7-bacb-16a8-fdb158535ab2@infradead.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <9a0ed0bb-34c7-bacb-16a8-fdb158535ab2@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Randy,

On 6/19/22 00:49, Randy Dunlap wrote:
> 
> kernel robot reports today:
> 
> * riscv64-linux-ld: ttm_bo_vm.c:undefined reference to `vmf_insert_pfn_prot'
>   https://lore.kernel.org/lkml/202206190651.smtms3Ay-lkp@intel.com/T/#u
> 
> * ttm_bo_vm.c:undefined reference to `vmf_insert_pfn_prot'
>   https://lore.kernel.org/lkml/202206190523.0Ar6yQF7-lkp@intel.com/T/#u
> 
> 
> and earlier:
> 
> * ld.lld: error: undefined symbol: vmf_insert_pfn_prot
> https://lore.kernel.org/lkml/202203281125.Jp08egXu-lkp@intel.com/
> 
> * ttm_bo_vm.c:undefined reference to `vmf_insert_pfn_prot'
> https://lore.kernel.org/lkml/202204081648.gV63Gt0t-lkp@intel.com/
> 
> 
> I sent a patch for this on 2022-04-08 and again on 2022-05-30 (UTC).
> 
> https://lore.kernel.org/all/20220409030504.16089-1-rdunlap@infradead.org/
> https://lore.kernel.org/all/20220531025557.29593-1-rdunlap@infradead.org/
> 
> Neither one has been applied or even had a comment.  :(
> 

Sorry that these fell into the cracks. Thanks for the patch, I think the
change is correct but gave some comments about the Fixes: tag and commit
description. There's no need to resend though, I can do it when pushing.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

