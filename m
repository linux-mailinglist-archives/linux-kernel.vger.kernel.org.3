Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AEE504C95
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 08:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiDRGYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 02:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236750AbiDRGYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 02:24:43 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711341837C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 23:22:05 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id u18so16496302eda.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 23:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0p9SyM2Gw6ezgsQBgHwJlt6cnUQdSZIr2Akmm0cjIc=;
        b=Bur8D9FzAagdjm0aTmG8lxdbZQSBX+S1iB2gHK6R/tkzttSR9FtCfwBNjrIvsxJkS5
         bZdSK7WCvDEnspxJx4B0zK+YQidIQh0FdRHVycq3xBIYuelw2lrcYBA9pVFOclpqNA7Q
         o6rr6cGN0F8093vbW3/OHtdLHM81o5SRn4cKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0p9SyM2Gw6ezgsQBgHwJlt6cnUQdSZIr2Akmm0cjIc=;
        b=t89tUJdsDESSkc+6UK8X+exOD++ujaTnMCWrJdJbtnFR40VlKiNiQGhdgKbTvU+PgG
         QKbtculB1ri0z0acJTMDjCUneHrXjqTWdzxEuWroVCts5Kp+yVEj4yqRZMofI1bDwyqj
         WaFEwHGykgfzDehOjjbh3G7U2xSnxAZ0qLPq0Zbe8g8Ds0vDgUp522QPoQwimPr60SAh
         vSUxeOzoDDDTz2hmYC8kUgf+dEO1EDlwifH00RsJXBKqomUMu4sx5mSvjdI9gXAgizbS
         nMy3gdTCnqKCgn7IP0/zh71Op8nXatUaswD+VfAo3WP1xUx9zkyFncez+thsFjUJQ/PY
         tO4Q==
X-Gm-Message-State: AOAM5304YmxQwALnwQs3DWkJp9PptEftid8k1nKXETib1WUGI5klygev
        9C+zzJUxx+0HgJkZJP50oRnY9zAEMzVUdkRA
X-Google-Smtp-Source: ABdhPJxID1yOMjT4HmM7LRUgnpy+7A1YSIU0u0Armb5lUpXQITzkHiHGiYclR5OFP7XzBzMoV10M5Q==
X-Received: by 2002:a05:6402:b2c:b0:41d:7adc:e441 with SMTP id bo12-20020a0564020b2c00b0041d7adce441mr10780039edb.285.1650262923849;
        Sun, 17 Apr 2022 23:22:03 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id q2-20020a056402032200b00423d4516387sm3120604edw.75.2022.04.17.23.22.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 23:22:03 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id l3-20020a05600c1d0300b0038ff89c938bso3053909wms.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 23:22:03 -0700 (PDT)
X-Received: by 2002:a7b:cbc1:0:b0:38e:7c42:fe38 with SMTP id
 n1-20020a7bcbc1000000b0038e7c42fe38mr14247667wmi.51.1650262606781; Sun, 17
 Apr 2022 23:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220414025023.11516-1-Nick.Fan@mediatek.com> <20220414025023.11516-2-Nick.Fan@mediatek.com>
In-Reply-To: <20220414025023.11516-2-Nick.Fan@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Mon, 18 Apr 2022 14:16:10 +0800
X-Gmail-Original-Message-ID: <CAC=S1ni=pHPDAJUV2b=qWm-O26fS37wQjuL014eKoE491K6wGQ@mail.gmail.com>
Message-ID: <CAC=S1ni=pHPDAJUV2b=qWm-O26fS37wQjuL014eKoE491K6wGQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] arm64: dts: mt8192: Add node for the Mali GPU
To:     Nick Fan <Nick.Fan@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        srv_heupstream@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, wenst@chromium.org,
        alyssa.rosenzweig@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 10:53 AM Nick Fan <Nick.Fan@mediatek.com> wrote:
>
> Add a basic GPU node for mt8192.
>
> Signed-off-by: Nick Fan <Nick.Fan@mediatek.com>

Reviewed-by: Fei Shao <fshao@chromium.org>
