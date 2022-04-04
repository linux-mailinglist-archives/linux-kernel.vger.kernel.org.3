Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A914F1EA8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242423AbiDDWEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379205AbiDDQnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:43:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F28F35256
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649090515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3+kz6I7pZcPAimiB8rQ2Jr3SdDzFgYoJ+V2mHrMniJg=;
        b=XAqaE1jvXNaqFzmCMVx0kp1WfLhFR4Q06JJ/AjQrRbeOFe1wrPoQ38DU7T8q2XPnBdILSd
        gM8PSFqCsgaAsEf5X1ra2X0GRAMLO6/WqS3qyplYYdGsboeDzk8YMtmKZlMBrg1cyjpD3A
        nqjd3bGnTjREw6hNHCd6Uht6EPs9Vkc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-x8wqMrIgODGueqkltvEd4g-1; Mon, 04 Apr 2022 12:41:54 -0400
X-MC-Unique: x8wqMrIgODGueqkltvEd4g-1
Received: by mail-wm1-f71.google.com with SMTP id z16-20020a05600c0a1000b0038bebbd8548so7154410wmp.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 09:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3+kz6I7pZcPAimiB8rQ2Jr3SdDzFgYoJ+V2mHrMniJg=;
        b=hCGSNe9L9d6vNN4HePuMCBOGZ2OGZY0vuCgo0/4Uhu9qJoH95YKP02QeEWoYbjIGZq
         CslYBC2uZ9LDn74vSrhp3XoKGNbOsBcvQVsjaaklU5i1gtnqB4Nqw9QpuLR2p+GRFW9F
         QyCBVSJSVrPjjJ1mkIx3EwO+LnwFCb5ZpJQznrnkpJaxk0lZTPQWg7FuVFG4MJVIomLS
         7zjiKwzyZMaLS/hWtEvm3IxqWL1SWsU2sSvnqtIgJ8qdxQAJrv3GibFnAW8IncwR2gSL
         dBg3ErxFTdOB+J2rY1lzNMQxbbeDPa+yOhzoDPksNHVdUMJgOR87VifRVDarbsDvjr/U
         p0SA==
X-Gm-Message-State: AOAM530r9P6E3M7Ut7jdQsxyhUvPKpvmltLbN+PeOD7YZK/uQ3DLSero
        cyyudX+QPhhWK1S0x8E0oUdDXYbb9+B3sxMUlwve18Lz74of767IbJdVAxVi615DuQjtbslZnzP
        HtDnRv21yCCDj4dt3k7lZwr5R
X-Received: by 2002:a05:6000:1862:b0:204:e417:9cf8 with SMTP id d2-20020a056000186200b00204e4179cf8mr440306wri.593.1649090513079;
        Mon, 04 Apr 2022 09:41:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXgci/ibeaKSvR6+nnoR/49t/2UDaGcl0TznmfMjMts0usoK/oXTo+u2Q1uulF0rg7yFs3hA==
X-Received: by 2002:a05:6000:1862:b0:204:e417:9cf8 with SMTP id d2-20020a056000186200b00204e4179cf8mr440289wri.593.1649090512856;
        Mon, 04 Apr 2022 09:41:52 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e13-20020a05600c4e4d00b0038e44e316c1sm32402wmq.6.2022.04.04.09.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 09:41:52 -0700 (PDT)
Message-ID: <4e53008a-c758-90dd-251e-f1668c52b10b@redhat.com>
Date:   Mon, 4 Apr 2022 18:41:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 4/4] drm: ssd130x: Add support for SINO WEALTH SH1106
Content-Language: en-US
To:     wens@kernel.org, Javier Martinez Canillas <javier@dowhile0.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20220330190846.13997-1-wens@kernel.org>
 <20220330190846.13997-5-wens@kernel.org>
 <CABxcv=nLQdz9bVrfqw1MaKREh0uRBvc4wX14AORETaDJAin-Fw@mail.gmail.com>
 <CAGb2v66P+5Tj7BgUJCayWjB6UZhQ5wSFdX=RcwRqX4bYw3UOBg@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAGb2v66P+5Tj7BgUJCayWjB6UZhQ5wSFdX=RcwRqX4bYw3UOBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 18:35, Chen-Yu Tsai wrote:
> On Fri, Apr 1, 2022 at 6:10 PM Javier Martinez Canillas
> <javier@dowhile0.org> wrote:

[snip]

>>
>> I wonder if we should also list SH1106 in the
>> drivers/gpu/drm/solomon/Kconfig file so people can find it ?
> 
> I can add it to the help text if that helps?
>

No strong opinion really, it was an honest question.
 
> Recently someone mentioned that users are more likely to find drivers
> via compatible strings though. And I believe there's also a tool in-tree
> that finds all drivers given a device tree.
> 

Yeah I guess so. Looking at existing DTS and drivers' device tables is
certainly what I personally do when searching it a device is supported.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

