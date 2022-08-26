Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0A75A248F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343945AbiHZJgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343927AbiHZJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:36:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349ED8A1D4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661506594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d4/Ci/khIJqvY1ZTEwT9xKh84mAJli5YDL8Ohl8+57g=;
        b=dcA1BUE2uESzx6z0tQZLZWE8sPXBWHaKChpfKnVYqK/tDCmKl0wwFK/00zsWaxe13Wt97H
        RNJRByvjQ0Z8/uM5Nk7oRQRKUunfXzKnWBDt8TWhhoHWYLAIZGc3F2qSPfbRIUV0COj8B6
        UTDhyKQZCTXVOrfWmgF3aDnkljZFud4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-100-Iu8XUSh3OTS3lPzHwc5twA-1; Fri, 26 Aug 2022 05:36:32 -0400
X-MC-Unique: Iu8XUSh3OTS3lPzHwc5twA-1
Received: by mail-ej1-f72.google.com with SMTP id hp36-20020a1709073e2400b0073d6bee146aso414134ejc.20
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=d4/Ci/khIJqvY1ZTEwT9xKh84mAJli5YDL8Ohl8+57g=;
        b=XkVvAGZrfEARfMyCoopqMdLPGxw40RuPeUoVdGxZsZkRyOtdU7FrSI9fRStSa/tNor
         j3LtEa/4vOIT8FB0NV+JPlop/RlbqPFi3lZPNYE6yx/YsF2cXCWHRBA7BqBjB71EuvfT
         MPeSx7Q2/CGvKfWXPiKByaip1CRTx4jvxiSbyUEFZpYnT8do1T0Sf1pJfiAEpRydSO5B
         M8u6n6r8LB7cQxU2tbQVrB1PFeA2Vm5BVEMF/T57DKZzIq6poxQwUenSNnq2el1JJJrZ
         8YvMxXjkQ0UHq/Ac0Z7ZesFzyMhYg9kw9q9BNmvSDyPXukYwC1kwp1KuUTqzbd8mQvVF
         8skA==
X-Gm-Message-State: ACgBeo01gBqu4joU2GjFs1z3iZ/cGAo15fI9ZAVbpmV6plKtmbFejXuP
        ZDcGRN4a6O2Q6B80WZ++hsXYPrlAmWbmzfWlQzjP0nj3KsGraH/T0NwuP9gBtupi3rfccJtpOym
        lUvFzQsRworEMiT6dfsVPvFlf
X-Received: by 2002:a17:907:c0d:b0:730:a85d:8300 with SMTP id ga13-20020a1709070c0d00b00730a85d8300mr4971731ejc.558.1661506591612;
        Fri, 26 Aug 2022 02:36:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5kxGZb3ZhrTbQ0gfMwjXjGnkLWP/526iVnTkZAjGN/4PMhWRlwvzmS6Ghf8S7K237BNvp91Q==
X-Received: by 2002:a17:907:c0d:b0:730:a85d:8300 with SMTP id ga13-20020a1709070c0d00b00730a85d8300mr4971719ejc.558.1661506591396;
        Fri, 26 Aug 2022 02:36:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id b7-20020aa7c907000000b004478e9ab2c5sm984570edt.69.2022.08.26.02.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 02:36:30 -0700 (PDT)
Message-ID: <9ad59946-a061-92ca-8f9d-af2068abc1f6@redhat.com>
Date:   Fri, 26 Aug 2022 11:36:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 0/2] asus-wmi: Modify fn+f5 and support GPU fan
Content-Language: en-US
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220826004210.356534-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220826004210.356534-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/26/22 02:42, Luke D. Jones wrote:
> Some TUF laptops have both fan_boost and thermal_throttle, and some in that
> group may not actually have an effect on one or the other - this patch series
> adjusts behaviour to try both. There doesn't appear to be any consistency
> to check for so far.
> 
> Some laptops can also control the GPU fan between auto and boost.
> 
> Changelog:
> - V2
> + Rebase on review-hans
> 
> Luke D. Jones (2):
>   asus-wmi: Modify behaviour of Fn+F5 fan key
>   asus-wmi: Support the GPU fan on TUF laptops

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

