Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B844DB196
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343910AbiCPNg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243280AbiCPNg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:36:27 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204044705C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:35:13 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id h126so4487413ybc.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WNRIm2snhOLrjHDrRT45Al18e6yX+6IjtBw2hvIFtuc=;
        b=bl6xXHfUk0jza37f3JJNngv7+hb+rNkTVteG8qFGpuWSZHFNpW4/ck2144lMbppgke
         VedQEh+UgY27QEqhYUahKxZl39G0PAUbDtvPwRPCvG2MDO02K9a0KFdCt+8/lRSGUOHd
         lzT7xMJd3npkRtbQq5icH4pCvllCLjPtlpTzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNRIm2snhOLrjHDrRT45Al18e6yX+6IjtBw2hvIFtuc=;
        b=KhnIFl/BaO74HxDo7r1uJGfT3KngxUZlVqpQ5v0Q59cS3h5GLlaDiK9QgpSTgL2o/P
         GxkkQfnnQ4DYWs9PlxT5y5cMFFhP5JoJUBUaBmRnFRcC1Yd3P1w6I8J8V+sMOQC4rtwu
         LEJ8k3pxdaJkXYFtU6IlX1i6L6cje6uYJ7uuv4Y/G/ECf6+DSAlMHEvMtcD2ro+jU4Bv
         OXgfTVsXe5LQj3EnsEk/CBtZm7SQCSLcYk6TefpA25JbIjIV0SYMJOo/B3VuXF1ccjkO
         LIhgmRM4+OJvatxver6dDICrilHm/PZS+B4+HLulJwQmK5ByAxDWLLWsuOJ/fQoAHl+u
         qtdw==
X-Gm-Message-State: AOAM530eHr5nJ3OSaqpe6uSfuDu+YQ1jm3cm6VGH7DHocZom1eEPx6UQ
        FARS0D3nm/jCpmQlhqTJ+i1PNpvmgm87S63S60H8lA==
X-Google-Smtp-Source: ABdhPJzBoD2Jj2tGf6FiQyu4qnE17Z74AigshCqdfSdH9Nn6dOvJw3Guj90WJtvPBJPDHtGui5i1uCXGBcxMlWg7L7k=
X-Received: by 2002:a25:3403:0:b0:628:a2e4:ae8a with SMTP id
 b3-20020a253403000000b00628a2e4ae8amr27494313yba.219.1647437712360; Wed, 16
 Mar 2022 06:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220218145437.18563-1-granquet@baylibre.com> <20220218145437.18563-19-granquet@baylibre.com>
In-Reply-To: <20220218145437.18563-19-granquet@baylibre.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 16 Mar 2022 21:35:01 +0800
Message-ID: <CAGXv+5GfiVhK1cvgjnnxHxHnL7rQnUyQJD93d9NHNmT+txfgcg@mail.gmail.com>
Subject: Re: [PATCH v8 18/19] drm/mediatek: change the aux retries times when
 receiving AUX_DEFER
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, matthias.bgg@gmail.com,
        chunfeng.yun@mediatek.com, kishon@ti.com, vkoul@kernel.org,
        deller@gmx.de, ck.hu@mediatek.com, jitao.shi@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 11:15 PM Guillaume Ranquet
<granquet@baylibre.com> wrote:
>
> From: Jitao Shi <jitao.shi@mediatek.com>
>
> DP 1.4a Section 2.8.7.1.5.6.1:
> A DP Source device shall retry at least seven times upon receiving
> AUX_DEFER before giving up the AUX transaction.
>
> Aux should retry to send msg whether how many bytes.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
