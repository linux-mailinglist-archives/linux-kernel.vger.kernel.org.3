Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6D64842C5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiADNvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiADNvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:51:09 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402BEC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 05:51:09 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id i6so21113884pla.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 05:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pl4XAHEQ/8O2Ge142ei3ws2XQwiYzzkkZ4WgI00Q9A4=;
        b=jlYmyfhRBHeHp6eVn6FUzPaLbZ9Xp5/dsF8cd+jeZTgGUF7zk5bWqLqeDyeSqciDPi
         DTMbVXTClm52Cyxapjym+leYK70NB5kb5nc1waQf8KNHrdRsS2P9ATMPoarbzHFlR2Ba
         a0Zd9jlDypWm176VENklhdkJ+G96ilc7MKe/8/ZQFDBIAGafHJBuM/zvQVn9blvw55hR
         7oTBfA4VHlak50Ntn6rO2Xipn8yADehXm+Ydbyt/CvxAjTK/ZiqIFbRbPjHodMtd2jLQ
         YNSf0WfaYNAs8j10/ouO9NV1pG5JCeFPiiqV2u5jNrnj8GRTKDDNFEMeLxqFjMNxZeRE
         FI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pl4XAHEQ/8O2Ge142ei3ws2XQwiYzzkkZ4WgI00Q9A4=;
        b=1YKq0zIVKilsmPJKj0m4GITpg9XOpG28ELH40EMWz4zjeNUQ0kZNDrnknakU6zyPxk
         p7GfdWX1+4ed+61l6zKmC2CgItl5Hk3l88RLxhK6bIcEjWxnjuPEGLDPgUewcjDxEKob
         b0r62HcNszNgO1PfF/8wp3iHvJB64eUO4bYzWIgamPNps5kAUjbLN8aOrklJe1n6Fddb
         +Lobi8JvG2lg1wllYBhsNykawpsGY0UM8kNc1+UK1heHMQfW8an2a3TEEw7EBl1VVVGT
         cOus4+pbD6PKUuhm/v5mL7TzXXMm8SMyQTWTbGFYjL61p58cJsvmfKhJkySYx94LRuik
         odgg==
X-Gm-Message-State: AOAM532ZJfLv8SsoPc9nYXYWS/YWZgWRNzGNe0oPhCqFV81C5soInPsJ
        H3Uto59+++5zYoKXJR/PcQgGGTg5+o3CgfJeRe0uBw==
X-Google-Smtp-Source: ABdhPJyRNJLYqv9dxj24ku2jZwDQnxxy2JHRkOhHG8QLRhakAedD18kPErE+JMSrY6BI5h8aYq6g9Nc+mhfZNJrfa9k=
X-Received: by 2002:a17:90a:a6d:: with SMTP id o100mr61646660pjo.179.1641304268801;
 Tue, 04 Jan 2022 05:51:08 -0800 (PST)
MIME-Version: 1.0
References: <20211110220050.2854-1-jirivanek1@gmail.com> <CAG3jFyvB-Dzd9YDJ7FrAC5avobL7Wfk-91E-DVeYWwfNcQLiLg@mail.gmail.com>
 <CAGWqDJ5ZKJ0skLnhfhC0cbzNnSo7HLY7Cqr2ZhOcb_YiHNsA1A@mail.gmail.com>
In-Reply-To: <CAGWqDJ5ZKJ0skLnhfhC0cbzNnSo7HLY7Cqr2ZhOcb_YiHNsA1A@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 4 Jan 2022 14:50:57 +0100
Message-ID: <CAG3jFyt1nvtkDC2r3wc+3ky_VxtZ7s4Rto_+kMg6J_x1=QpO-Q@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge/tc358775: Fix for dual-link LVDS
To:     Vinay Simha B N <simhavcs@gmail.com>
Cc:     Jiri Vanek <jirivanek1@gmail.com>,
        Zheng Bin <zhengbin13@huawei.com>,
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

Jiri: Are you able to test this patch?

Vinay: Could you supply a R-b tag, if you feel that it is warranted?

On Tue, 14 Dec 2021 at 09:13, Vinay Simha B N <simhavcs@gmail.com> wrote:
>
> Robert,
> I do not have the hardware to test this feature. Sorry for the late response.
>
> On Thu, Nov 18, 2021 at 8:20 PM Robert Foss <robert.foss@linaro.org> wrote:
>>
>> + Zhen & Vinay
>>
>> This patch looks good in itself, but I would like to see a tested by
>> tag. At the very least testing for regression in single-link LVDS but
>> ideally some third party verification of this patch.
>>
>> On Wed, 10 Nov 2021 at 23:01, Jiri Vanek <jirivanek1@gmail.com> wrote:
>> >
>> > Fixed wrong register shift for single/dual link LVDS output.
>> >
>> > Signed-off-by: Jiri Vanek <jirivanek1@gmail.com>
>> > ---
>> >  drivers/gpu/drm/bridge/tc358775.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
>> > index 2272adcc5b4a..1d6ec1baeff2 100644
>> > --- a/drivers/gpu/drm/bridge/tc358775.c
>> > +++ b/drivers/gpu/drm/bridge/tc358775.c
>> > @@ -241,7 +241,7 @@ static inline u32 TC358775_LVCFG_PCLKDIV(uint32_t val)
>> >  }
>> >
>> >  #define TC358775_LVCFG_LVDLINK__MASK                         0x00000002
>> > -#define TC358775_LVCFG_LVDLINK__SHIFT                        0
>> > +#define TC358775_LVCFG_LVDLINK__SHIFT                        1
>> >  static inline u32 TC358775_LVCFG_LVDLINK(uint32_t val)
>> >  {
>> >         return ((val) << TC358775_LVCFG_LVDLINK__SHIFT) &
>> > --
>> > 2.30.2
>> >
>
>
>
> --
> regards,
> vinaysimha
