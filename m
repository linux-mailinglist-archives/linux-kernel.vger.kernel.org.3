Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740454842A6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiADNjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiADNjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:39:17 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351FEC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 05:39:17 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so35696305pjf.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 05:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqezZ2/HwBTxC4hfR4A8RkBTbm8B6r0iUtltdIvH/WQ=;
        b=Spb99MNnUWNfoRD9S/I/T0lbsxERyN+nho8GZl3ZDXDzDRSIav+MmsreSY+xrIIM7K
         2B4RuVB1FPNovuY9h2yfFHl2C1im8TKcm7i15p+Zx/NtbfKaOM0wOw/hE9gqcS7nsVK8
         TmKnX/vLnS+OD9+/MbrZqTeIY1thlSPoL7q1+HEsGpU/8XdZEGoD/CT86cGm8uIAMrTW
         Xdip8YielnZC4A98vEAe/1LQD7heu4XXSsoMAHfrb87LKmM4Bfv+N11hbxq7Ba2N6J5Y
         4aTScot3pVKiF+5zNoWmJfxZ878hawf+aZ1irt9vMSnpn/pCWpeJUfg3z5WEHF967cNI
         tJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqezZ2/HwBTxC4hfR4A8RkBTbm8B6r0iUtltdIvH/WQ=;
        b=mUCY9+Pg3a+t+PEIiWOIsQwN1+h4ZNpn9m1CssIkFEsvUmz93pymbq7HvUARiZ1sch
         dI/U630BeJwJyt4XxxPVt2oxWmQ2fcO1qs4oPdcVGx8RqaflXSlnVNCGEOj4R1ACYMyV
         VIx19UzIiiJqettA41boIc7/WdUI0cMOKgyAHMK6pvRxE40KEP8Z7lM3m6natZXmHLfp
         I7bEH9fbqhUq0KDcP2Ik7EAPJPkuAlML1/yNQPlCAPuWhT+6fQGH3kiR2bivWsAs9q00
         aZGDthD9OdwYs4GvvODt23fueJNDaO3CIywoqw3gqpboJlAbQaGcQPdGCChv0RSJNn3A
         gUrg==
X-Gm-Message-State: AOAM530+29GGcowMvLx3MVLuqlfX4k8kH1kaDKqEaGCX3t1J9ysB5ZYz
        509Xd7qKxMVJTMPN4UIQWlHKjKVyRmG7/mVNwONFqQ==
X-Google-Smtp-Source: ABdhPJxBX2L2LUeGUOYQ7W28MienpyMZUn6kUm2DXZieJErY/vwm5O6dOGpdWxhVKsztFBo7qkfsa6vuxb9xYUvUACY=
X-Received: by 2002:a17:90b:4c89:: with SMTP id my9mr58418361pjb.152.1641303556701;
 Tue, 04 Jan 2022 05:39:16 -0800 (PST)
MIME-Version: 1.0
References: <20211119015804.3824027-1-xji@analogixsemi.com> <CAG3jFytg88mWgA24ce4CbPKDA7HDdXOjC=AVxYrhv1c0Z5GTPA@mail.gmail.com>
In-Reply-To: <CAG3jFytg88mWgA24ce4CbPKDA7HDdXOjC=AVxYrhv1c0Z5GTPA@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 4 Jan 2022 14:39:05 +0100
Message-ID: <CAG3jFyuqgRP-xcH4DS-TQ_5+-kRnErkqh67cn2-J_hiOaFC9wQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: anx7625: Check GPIO description to avoid crash
To:     Xin Ji <xji@analogixsemi.com>
Cc:     narmstrong@baylibre.com, dan.carpenter@oracle.com,
        laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        sam@ravnborg.org, pihsun@chromium.org, tzungbi@google.com,
        maxime@cerno.tech, drinkcat@google.com, hsinyi@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        bliang@analogixsemi.com, qwen@analogixsemi.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next
