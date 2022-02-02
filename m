Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B054A6D05
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 09:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245014AbiBBIit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 03:38:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33633 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234614AbiBBIis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643791121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=162v2xzxQ3u4een4KbGtcbrsH49dUuDX0sFGI3OoKaM=;
        b=hvlJWCLz014lHSnbOrHUfr2E1LFtE4KKNIozv6wMKZhtuwKwcUjaY1Qul7KBqF01Ns1p5F
        yUu61ogr0+gzkR8WMVtRpSRrXpyeJFxsaj2J9xcIsI2DN/LPbAhESPdYD6mqTf8QVZFxRX
        9WY4c51hU5/11tpkQjXl18LCOh2XG14=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-LOnTCEuOPYKGrPsQHYN3bw-1; Wed, 02 Feb 2022 03:38:40 -0500
X-MC-Unique: LOnTCEuOPYKGrPsQHYN3bw-1
Received: by mail-ed1-f69.google.com with SMTP id w23-20020a50d797000000b00406d33c039dso10024497edi.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 00:38:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=162v2xzxQ3u4een4KbGtcbrsH49dUuDX0sFGI3OoKaM=;
        b=EsWffnPFYNK2Ll/+6SsT9PDGYVslyzelpMrFavM2MMWKnIABAl2N4z4M89jh3Welg3
         AzcVPkOlzTQsa+tCcunSiy/gU2Zsu9NlPMvlCLyLyQ9Ije3mBfhuwTK7M5oJTdAArm/x
         SSDiFT8b+AFy4J0c18zYXZF0nq23wZYLLQ1gCkCbSSyvsoWTEX9+BmFw+XpI6Y6fnxH9
         cZJDsi4oRs9nUNoNfw44i0CjdIXAP2ZathadUeckpveUoiiB0hP7shzHJJDjc4pIpL2d
         oKjvThCTQwnKrDrWDjK9dWF+qXa0j/Ao8Af2Y5Fz63fF2zq6uQoFidKSnT9gOI+bIbwm
         m0pA==
X-Gm-Message-State: AOAM531TJJ6X9RuR/lUb1J3zO7vN5sXXSpO8SHaStRl8CD8m6J+t2DN+
        o3i5AKLppwXNEres6jzpsl1QtM5IVKbeLzL1gLe6j0ShmujCzldcuYh1Z2ptDaMNBNyFoFMkeAJ
        2HRQE3hGUkACGCMJTuPIwggLq
X-Received: by 2002:a17:906:2758:: with SMTP id a24mr23315050ejd.433.1643791119156;
        Wed, 02 Feb 2022 00:38:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEdyJNA8q1uNmHWvFYEP/YNkKz8zxzVGxoUKfJxYwDg29nVRSAIrzftsT2br720j5xsvp4tQ==
X-Received: by 2002:a17:906:2758:: with SMTP id a24mr23315040ejd.433.1643791119012;
        Wed, 02 Feb 2022 00:38:39 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id lf16sm15322042ejc.25.2022.02.02.00.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 00:38:38 -0800 (PST)
Message-ID: <f50d5044-7192-bdb3-7ca9-7217ed311787@redhat.com>
Date:   Wed, 2 Feb 2022 09:38:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: linux-next: build warning after merge of the drm tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220202150201.290c7d3d@canb.auug.org.au>
 <20220202150320.3e9bdd62@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220202150320.3e9bdd62@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/2/22 05:03, Stephen Rothwell wrote:
> Hi all,
> 
> On Wed, 2 Feb 2022 15:02:01 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> After merging the drm tree, today's linux-next build (htmldocs) produced
>> this warning:
>>
>> drivers/gpu/drm/drm_privacy_screen.c:X: warning: Function parameter or member 'data' not described in 'drm_privacy_screen_register'
> 
> Actually:
> 
> drivers/gpu/drm/drm_privacy_screen.c:392: warning: Function parameter or member 'data' not described in 'drm_privacy_screen_register'

Thank you for reporting this, I will prepare a patch fixing this.

Regards,

Hans

