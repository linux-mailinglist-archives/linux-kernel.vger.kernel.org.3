Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855D9552488
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 21:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245485AbiFTTWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 15:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244220AbiFTTWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 15:22:16 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA28F1BE8D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 12:22:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id f16so9648409pjj.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 12:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oOBgCs1oKhLX6l+6YjA7JxDMiSGGwf3k7mwAD0yAsos=;
        b=kc/aTUcgZD/czsu+1K0bcaLwII+rWCUf5wZ5/rEMKMmca0T4gM3SJEVMJHr5JSQdFX
         Ijfxe/NxNEu2UriAJr1D9GOV9XK+qBoLoE0A/saDgeUUUlvO8IKPDZY6weONcSbnLwK4
         mpGke3ZjLN8UW8P/TeUcsz5wLMjUTdkdfP8A5lpsapBKS1aZnVq0wARbZ9uNLnHs87cr
         0i9Mh6ZCfd6MbSqZ/uBJbizAon1HvZzr7ESR6ai4OqWb9sj190jG/S5d7EnNmw/ZOJP6
         qliUdPvmmYT2CvTiv/XppHmxd4eLenZsJeMyM/o27VgWBwUw84RmcG1VvHHX6oLCfhCP
         TNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oOBgCs1oKhLX6l+6YjA7JxDMiSGGwf3k7mwAD0yAsos=;
        b=t/bxgPtgieeUiqtC2sur91CYSsW1ffiFSYfFBz1JReVCuKnJUydxtSevzfd/D5tAbo
         VBzG/FAjnf1o5lgbF8g23En1f7DRzPNDUgLUquYmUQQdt45R4Y7sWqv5iOGMl8apxgZb
         21DPePb/B8SOtgxC07feF1SlCLaCHSMgsuW6Ocyhi2jFMtRLRBGugOV0FOR3Uk+tDuPX
         ZbklYGq02AUntatAvI/faasSLnvoQJX8SWV8+d35KPKsUuiqQfzEn1iQQF3gyJipp4Fk
         AkWhCVjnpK4AJ9m2uSqF2oJ7SooxJTsPg95nUXc588FpQkySERkomtefZlpmGG3NuZ0r
         pvxA==
X-Gm-Message-State: AJIora/pufXBG6wRVvxwW5oOPvPCpy/d/4i8k0GCoAbiQgW5C1Ymufje
        mPBYV7EIFXLfzY4GJ86LwfW5mUVrlIipoRWr3Gzt8w==
X-Google-Smtp-Source: AGRyM1sy1C9FMV0zpCSDUtmmHsqLSolD8o7U+F/Leb9Gs2gN2IUQE3JC9/w2aYnz7jxPghxjLhdaHpZNmUzG61SfAi0=
X-Received: by 2002:a17:90a:cc7:b0:1ea:3993:78f9 with SMTP id
 7-20020a17090a0cc700b001ea399378f9mr39409700pjt.179.1655752935449; Mon, 20
 Jun 2022 12:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220611141421.718743-1-victor.liu@nxp.com> <YqsRcUsdZzcwqplJ@valkosipuli.retiisi.eu>
In-Reply-To: <YqsRcUsdZzcwqplJ@valkosipuli.retiisi.eu>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 20 Jun 2022 21:22:04 +0200
Message-ID: <CAG3jFyv-AQU4M1JBPtcZ1gNsrDs8MSBuaOX5_VB29BtC1jmscA@mail.gmail.com>
Subject: Re: [PATCH v9 00/14] Add some DRM bridge drivers support for
 i.MX8qm/qxp SoCs
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        andrzej.hajda@intel.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, lee.jones@linaro.org,
        mchehab@kernel.org, marcel.ziswiler@toradex.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 at 13:18, Sakari Ailus <sakari.ailus@iki.fi> wrote:
>
> On Sat, Jun 11, 2022 at 10:14:07PM +0800, Liu Ying wrote:
> > Patch 1/14 and 2/14 add bus formats used by pixel combiner.
>
> Thanks!
>
> For these:
>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Applied to drm-misc-next.
