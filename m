Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818895524C5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 21:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245659AbiFTTns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 15:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245092AbiFTTnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 15:43:47 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6881CFE7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 12:43:46 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e63so9617870pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 12:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PzT5BLDkdhOQNSy5zzuFU3a+r6aXrK7pxM/avNB16y4=;
        b=tjH/onhKKhU+kX3Pqg8Ksn+d/SN1sKS3QOFOOpz1EViEMY5II1O2Lu39tObzWxcQQ6
         Msol/v5oV55kz0s6ca7JN5/r/gLH5fXOp7XkzG4WsU/4qZEA0fuEFGzagUrnnzY0vpU9
         1hb83rmaUGhwnuY20HgwM2pJBs5lDepokjNPPp2fJSkmbzAjGfODPP6cKN0xOcLoeNTB
         kamd8+ap5ihsWjZpGylJ+oe06r6E3xN9lVUhbFbIKjydBTL5IQWJYgfI+7OJUadpytjq
         2vRGxdoo4nemBtbtxG3pOi9x2vist7RjZsY7kbtL7fByIy5ltTt4a7LjCmC5+BHR85nk
         xgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PzT5BLDkdhOQNSy5zzuFU3a+r6aXrK7pxM/avNB16y4=;
        b=qAWa8/h+AftbJaTiktD3SDKdtXgPWqkqEsOUzBx97aWXhgp778J8HzG/4CD+Tlj1uX
         aKfkfD0Leh7Tc2WuCeL418H6f8bHlzRAzhu7GYnh62Ht4NH3oknMBQJZSinEzBpUExsS
         2eSsL/ZzDD8NTHV3AL1nnVd3RLZj75RXnna9z7aVxcWFPlyXbItU7wXNBEM1+BW//syZ
         5KTs7zomLm7c5e7ZVDpT9fqdErntS28oC2XVmksvy0Ht6Y0mEBKD+LY4EpHcpewpz93P
         Wf3SwcjgrIDQaAWm0eGpl1AemZTARGSgJIbiN3XOmK7sqwfzHYQkXajtdBL2Bur+5/CU
         ROJw==
X-Gm-Message-State: AJIora/sopKbQRXsx1SNDWGlZkYvJK+b98NuVyRoDT2D5yqqEWZyyfjr
        PPGEsSEtlS51xxrlqtXLh8b7CO3mMctok27zqYdxHw==
X-Google-Smtp-Source: AGRyM1vu02wE9Ha7pCyZAUWeI5M0PutLotSWD0Ave5kjcj/jl7vlY1BwnQ5lVcOmr+ANJbA/gzPNIbqCogRUKDAmXv8=
X-Received: by 2002:a63:dd56:0:b0:405:34ac:9bc9 with SMTP id
 g22-20020a63dd56000000b0040534ac9bc9mr23080773pgj.324.1655754226276; Mon, 20
 Jun 2022 12:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220615222221.1501-1-jirivanek1@gmail.com>
In-Reply-To: <20220615222221.1501-1-jirivanek1@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 20 Jun 2022 21:43:35 +0200
Message-ID: <CAG3jFyuL6EwvPNqy3QndwHtHVJei4fHNr85-pAbaycLhBCf4ig@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fixes for TC358775 DSI to LVDS bridge
To:     Jiri Vanek <jirivanek1@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Vinay Simha B N <simhavcs@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 at 00:25, Jiri Vanek <jirivanek1@gmail.com> wrote:
>
> This patchset fixes two bugs in the driver for TC358775 DSI to LVDS bridge.
>
> Jiri Vanek (2):
>   drm/bridge/tc358775: Return before displaying inappropriate error
>     message
>   drm/bridge/tc358775: Fix DSI clock division for vsync delay
>     calculation
>
>  drivers/gpu/drm/bridge/tc358775.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Applied to drm-misc-next.
