Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B0048422E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiADNPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiADNPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:15:36 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074C0C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 05:15:36 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id w7so26535016plp.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 05:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqezZ2/HwBTxC4hfR4A8RkBTbm8B6r0iUtltdIvH/WQ=;
        b=n9vUynbb8WtN3nKr5kWYjBzh+WgPXoa+P6IcyfUpAuTpSHbMUrXe0LIOxP+zdrMu68
         v91Oju61Sasm4GvcArbOIeqTyCee/MgcMHAEgqSVAMqXEjtBi3sv7nepJhZRcnxlLff5
         us3AjvOqLXNgB50BMvLBFzvwksiTlgzxt2obP7ws5Wry6L7Yarx6hUVpIubxUVCnuhWy
         qVUhaS4/gBUVPzyCwrf/5HISXpIBNnyyq2tpnsSieEjZoHboFhnvVYqCFQRSKnxu1FSc
         cRTTkgDAhnDVydoeIjTmHH4bRSURkapmLJEMX+/awUlNqBcL3TnvbKGvfTm8ljuB7UUM
         of9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqezZ2/HwBTxC4hfR4A8RkBTbm8B6r0iUtltdIvH/WQ=;
        b=ckfGiWey7JRi6dZxMKEBnhELPjvmG+jdFtFIdLRe0XaSKRGuKeSK6HOQKLPqeyu+q8
         DoRfwvt4pG/y6nLMSXPxBKlXrVKDEjkm3beCJW11LYIMDPqqqVWSs/JXP/GRrK+NiHwg
         dZebuxma/YuYPeVUA7IRtGxsUT7C4CtbKba21lQbtoHcPB96aEUKoQVUCyrHoz3DhNiO
         4UJ4DBePaga2ksYWvfMFr2kkEbDJAoluGWWYbRAwxJr9E46B16VZIMrAL7X28FqvP717
         oxEWh88Y8kwWkNfLlT6KYUrXJgTnNKfr9saih4lxSFs3Ag4gEWj+XLm5liLHf9iD1DlS
         07gQ==
X-Gm-Message-State: AOAM533QBu8j2mFV/u1zgM83UuwvFalFpwO4spLzJgH4d7IdiNSmOpzs
        EceSpLg2SSkfT7ijGQVVq2vJeuhyz8SVzXKo7Td1Qw==
X-Google-Smtp-Source: ABdhPJwBv4TI88plhh0uLEzERDifwkhBbzcd2m8wdyy43ozibmpOQUpu4tWNpVRhrCCQ4xr1uzjLfYtgN5gxlZrwymI=
X-Received: by 2002:a17:902:c40f:b0:148:f2e0:3f6e with SMTP id
 k15-20020a170902c40f00b00148f2e03f6emr48706008plk.65.1641302135468; Tue, 04
 Jan 2022 05:15:35 -0800 (PST)
MIME-Version: 1.0
References: <20211227092522.21755-1-linmq006@gmail.com> <CAG3jFytHBizw_kxbjgRkv0WcxJE1LsKhO7X98fDGSqCzh2kafA@mail.gmail.com>
In-Reply-To: <CAG3jFytHBizw_kxbjgRkv0WcxJE1LsKhO7X98fDGSqCzh2kafA@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 4 Jan 2022 14:15:24 +0100
Message-ID: <CAG3jFyu6LKh=oFierfztVhcy4u3pFPec3SwQErkQYtEyaFdCnw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: Fix free wrong object in sii8620_init_rcp_input_dev
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maciej Purski <m.purski@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next
