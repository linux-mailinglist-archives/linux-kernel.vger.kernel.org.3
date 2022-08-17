Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA28059780C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241960AbiHQUee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241945AbiHQUeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:34:31 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE089FA87
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:34:30 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id c185so16564746oia.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Nyn8W0wCSba81gwjrclnwSz99SrDsKvUVdhDOsWRPXk=;
        b=StSfMjgG4+KNVbI5LW+rlwJS16aCF27eduJjDxqU6ksj8M0vXSPNQHVIJn4hW9piKt
         A/Jqz2lUEl9i5BEdwyvpFckZggIWJzy7NFhkCTXL7HK5AXYtkaxErFB+FqURcXE+GQH6
         gv0JCCjhmmfYVD1k83bJ1D2wW+vkIW5Q+agfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Nyn8W0wCSba81gwjrclnwSz99SrDsKvUVdhDOsWRPXk=;
        b=k5pO8Swl6pWW2LOEqDtUVKgVqZrAlhFw3kW0uHM4eHcu9cfLzriGhOVrx8XD2sMS/g
         th8aTrmktrNeANwMj99ki3DBalQcctASqgsgBpHAU0R1ExYYmpYtLLAj4e50uRT/wRDf
         xg2NtBgRwhANFBeKukpOaBghJFHlEn/Sg86jLt+18OOUQKJHfQL2nsWV9oaXXtOXceaw
         8ru2L/MbZhInMi/q24zC+CpErma3NEN8mFQaXcqjj30bHlfWeK03Yim7JsNH+6OEGYNd
         khA2XiOzw9ZdzpUgHd24BSNR+RpFE1nPzDkjsR6jQ8wey6u1NoHCPoHfoE1sPcgafxe7
         uV2g==
X-Gm-Message-State: ACgBeo0xxOHhGDJsTZN1OftKed+2zT8ZcDCYMzcr061Ko/f2CIQgvMHJ
        b0euQuRv258lOGWPuHx95ULNofdepL55fw==
X-Google-Smtp-Source: AA6agR7uAgA1VUsb2D2D+XYSe7vo4WXYJULgxSXFANZmgj4RcPHOjaa0B6ezAwHlo42SG9J4SPGNjQ==
X-Received: by 2002:aca:f1a:0:b0:343:d5c:7e80 with SMTP id 26-20020aca0f1a000000b003430d5c7e80mr2320086oip.284.1660768469601;
        Wed, 17 Aug 2022 13:34:29 -0700 (PDT)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com. [209.85.160.49])
        by smtp.gmail.com with ESMTPSA id r23-20020acaa817000000b003357568e39fsm3183100oie.57.2022.08.17.13.34.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 13:34:28 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-11c4d7d4683so3286823fac.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:34:28 -0700 (PDT)
X-Received: by 2002:a05:6870:d0d4:b0:10d:4a2:2c0e with SMTP id
 k20-20020a056870d0d400b0010d04a22c0emr2720148oaa.232.1660768467647; Wed, 17
 Aug 2022 13:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220816064231.60473-1-zhangzekun11@huawei.com>
In-Reply-To: <20220816064231.60473-1-zhangzekun11@huawei.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 17 Aug 2022 13:34:13 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMGbJSJ2PC_4_2HL_01hO2aDoiWyxmosvtOze43aaeWpw@mail.gmail.com>
Message-ID: <CA+ASDXMGbJSJ2PC_4_2HL_01hO2aDoiWyxmosvtOze43aaeWpw@mail.gmail.com>
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
        Doug Anderson <dianders@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        xuqiang36@huawei.com
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

On Mon, Aug 15, 2022 at 11:46 PM Zhang Zekun <zhangzekun11@huawei.com> wrote:
>
> Add the missing clk_disable_unprepare() before return from
> analogix_dp_resume() in the error handling case.
>
> Fixes: 211f276ed3d9 ("drm: bridge: analogix/dp: add panel prepare/unprepare in suspend/resume time")
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>

Reviewed-by: Brian Norris <briannorris@chromium.org>
