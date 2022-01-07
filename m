Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64733487A8B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348301AbiAGQjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240148AbiAGQjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:39:45 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF8FC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 08:39:44 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 200so5883194pgg.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 08:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YJyOALamxRFMJcn4o1a34k+J+D9h1hzsUTCMkOSszJ8=;
        b=NVMcCWu8NYWRB/wm9VgzmwpVvnKv3PpnyuzqMgbKtmK2KX/l0s8YqHoowVqA1Vlsu9
         vyVx+xv5W+kYUZKQz+adZl+yKmcI0SlDKkMsPygGV1CyVTTEis3pCmAC6DIDj+Ti5BLi
         95Xx/NEHjxaruM9WF8cUkhTKE3aQk43ijen1QgvMk4otbL7al3YJVw0L+j64Ce0VYn7g
         H91FMVsklLWfbfcr3x+lXGbkqY0toMVzpLOZdy3LpoeieOgQrRY3rhftPKPAUsvcq3g4
         g53qaJ+Vo2uHng1lxfgZPWPXKpahzuoVvZ7WirO5ca7Ffz4gG23uzqr5akCb2apMdoLe
         rcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJyOALamxRFMJcn4o1a34k+J+D9h1hzsUTCMkOSszJ8=;
        b=QfVeWDjWP0Pp9Jo9Lq6AADiWe4NMXDU7Cc2VMqwNZVCuOGPxMH1YZ34XDEshUG5USF
         ygrOtfEMrykrbrO5dy25tBWlYmDFGyyMqbj7vl0mJSeDuNwwSBPFqgM+5jO4btjl/Bhv
         FhrO4C3qOurqIPPr1Noy7yyaa2ten9vg2B+5kDS4iZHvVEMMWCfqTC9r8BpkXnKP6N35
         eg8V5dBjlwZlJyE3/2JPeugwqxSVSSvKRxkGD3PkUPDY5kkTjfWfe0ZGE5KOYND19Pa6
         wi5sfay0+4rHq5DYVWO27WPc+oA/8TzS3oo/vIbRHNrQj/GlIjY9eqBtB2SfpdQzSxNO
         LAjA==
X-Gm-Message-State: AOAM530l2/4BRCYPKeXizhlVnd8S2wUzymMDGMxd9tCPqkBeJTMEeTRT
        nnpTr8JUX0L/L8OmPcDiQzC5uUA0fq98VnfYMTYVHw==
X-Google-Smtp-Source: ABdhPJwFNRCSr0/dPoK8wSlj1H2T5uIMWR0N4+GVlprTJ6WDuON1qW34quodUCBvOQ/VjzEH4Ib34wSCpNcyoA7J6WQ=
X-Received: by 2002:a62:d044:0:b0:4ba:6f3b:ab08 with SMTP id
 p65-20020a62d044000000b004ba6f3bab08mr65661363pfg.29.1641573584363; Fri, 07
 Jan 2022 08:39:44 -0800 (PST)
MIME-Version: 1.0
References: <20211110220050.2854-1-jirivanek1@gmail.com> <20220106190027.1498-1-jirivanek1@gmail.com>
 <CAGWqDJ6T6EGNjoc2qfNHLMdcuwcnJArF7a7sToRXJ90Zs57E_A@mail.gmail.com>
In-Reply-To: <CAGWqDJ6T6EGNjoc2qfNHLMdcuwcnJArF7a7sToRXJ90Zs57E_A@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 7 Jan 2022 17:39:33 +0100
Message-ID: <CAG3jFyuWtQ4Zr1RhHjjzjOavzt7T2_z9bHVZJ2vDXCjSEuWztA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge/tc358775: Fix for dual-link LVDS
To:     Vinay Simha B N <simhavcs@gmail.com>
Cc:     Jiri Vanek <jirivanek1@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2022 at 20:22, Vinay Simha B N <simhavcs@gmail.com> wrote:
>
> Reviewed-by: Vinay Simha BN <simhavcs@gmail.com>
>
> Jiri Vanek,
> Could you please share the part number or datasheet of the dual-link LVDS display/panel used.
>
>
> On Fri, Jan 7, 2022 at 12:30 AM Jiri Vanek <jirivanek1@gmail.com> wrote:
>>
>> Fixed wrong register shift for single/dual link LVDS output.
>>
>> Tested-by: Jiri Vanek <jirivanek1@gmail.com>
>> Signed-off-by: Jiri Vanek <jirivanek1@gmail.com>
>>
>> ---
>> v1:
>> * Initial version
>>
>> v2:
>> * Tested-by tag added
>>
>> ---
>>  drivers/gpu/drm/bridge/tc358775.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
>> index 2272adcc5b4a..1d6ec1baeff2 100644
>> --- a/drivers/gpu/drm/bridge/tc358775.c
>> +++ b/drivers/gpu/drm/bridge/tc358775.c
>> @@ -241,7 +241,7 @@ static inline u32 TC358775_LVCFG_PCLKDIV(uint32_t val)
>>  }
>>
>>  #define TC358775_LVCFG_LVDLINK__MASK                         0x00000002
>> -#define TC358775_LVCFG_LVDLINK__SHIFT                        0
>> +#define TC358775_LVCFG_LVDLINK__SHIFT                        1
>>  static inline u32 TC358775_LVCFG_LVDLINK(uint32_t val)
>>  {
>>         return ((val) << TC358775_LVCFG_LVDLINK__SHIFT) &
>> --

Applied to drm-misc-next
