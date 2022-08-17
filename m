Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA1959784A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbiHQUxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbiHQUxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:53:44 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334107C1D9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:53:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id f22so19014428edc.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1+XpTLI/st3pL/UMVfxVdHTTNl/6n7HQUGF319MI0IU=;
        b=LWeIFvQ972maQf3/948nGROrQ/uqLY39NILux/YX/yij//DDfJOUkG1nQJ6gmz+gTm
         mt6Z7RHYlgh9kTtp86QGSAGzgewxTFuJcYWCfkzx6O30xI56V2DXKKKABUkTg/s+s5IO
         K4V+NvtxkPE4rvxL0bRx0Z/HcIaJaqrN3Qad8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1+XpTLI/st3pL/UMVfxVdHTTNl/6n7HQUGF319MI0IU=;
        b=dkLhnejYS28lSk8FiZqQcyvT+wce776Zn5v/37jHs6f5oTAFmeFzEBDn0M3EHi4ZzR
         ktyaNu9q01BucEvg4TnVH63j0Wxu99i7U3UgpdJxWYhb9fraplb9VPrP6jw1/ksBLecN
         tqUvjsaTZMqe6ZABrcn3nVrh9z4ZNOfVkjHCiF+NR3OKuJoleDtSRZMW9qpoyCjss/jY
         KFIfRLgu/3gsNyPzUXHPHJu+9F26t2gX2oH2kO6KTUySY/Win3IpLGJMOnt4G2eXmAuz
         M6IyhiZ2gpX3fkurY6Y4pFup2y74OP18dcPvXdm/Q4RTdJhnvauLTC930LAvJLMpZ873
         DGoQ==
X-Gm-Message-State: ACgBeo20BAfSsyB+PjFUXx9cq9MzRmZGRxIZ2FBUET+ztiVmapUCUEu7
        MYqLpjil9VsrZ14AbK5YyYXTG9z+Cv/Wymlj
X-Google-Smtp-Source: AA6agR5ATZF+6WaChOs+A01JtJMksVG35HaXQVcUY5PKUeCpEVY3VFXWvrcpcbJ7mJxIrm0oxbCX9A==
X-Received: by 2002:a05:6402:1f02:b0:445:f674:eac0 with SMTP id b2-20020a0564021f0200b00445f674eac0mr1640021edb.370.1660769621496;
        Wed, 17 Aug 2022 13:53:41 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id ca18-20020aa7cd72000000b00445e037345csm1939016edb.14.2022.08.17.13.53.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 13:53:37 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id k16so2323297wrx.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:53:37 -0700 (PDT)
X-Received: by 2002:a05:6000:1541:b0:222:cf65:18d7 with SMTP id
 1-20020a056000154100b00222cf6518d7mr14840607wry.659.1660769616735; Wed, 17
 Aug 2022 13:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220816064231.60473-1-zhangzekun11@huawei.com>
In-Reply-To: <20220816064231.60473-1-zhangzekun11@huawei.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 Aug 2022 13:53:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xxp=YJcweeuzQqkzVoC-uuXgbTREqJTu0RphB4X6B4DQ@mail.gmail.com>
Message-ID: <CAD=FV=Xxp=YJcweeuzQqkzVoC-uuXgbTREqJTu0RphB4X6B4DQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm/bridge: Add missing clk_disable_unprepare() in analogix_dp_resume()
To:     Zhang Zekun <zhangzekun11@huawei.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Brian Norris <briannorris@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, xuqiang36@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 15, 2022 at 11:45 PM Zhang Zekun <zhangzekun11@huawei.com> wrote:
>
> Add the missing clk_disable_unprepare() before return from
> analogix_dp_resume() in the error handling case.
>
> Fixes: 211f276ed3d9 ("drm: bridge: analogix/dp: add panel prepare/unprepare in suspend/resume time")
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'll snooze this and check back in approx 1 week. If someone else
hasn't already applied it I'll plan to apply it to drm-misc-fixes.

-Doug
