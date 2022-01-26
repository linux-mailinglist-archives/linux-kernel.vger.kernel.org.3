Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A196549C39D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbiAZGc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235735AbiAZGc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:32:27 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51C7C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:32:26 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b9so12033524lfq.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Fp0FDcVRsgytVsA7uNX5zoyCtUC6cKgLis3XSwsG5s=;
        b=UziTMq+oHkcZf+CdPOSw2KO/pOYI3Twx0yT9IW+NWuMOMzDd8Akz9Sw2sGscNpSR2p
         HwaT0NarR0CjRTa0/eWoMgXHFzGM8L4WQTDkBtSRrrZxuvrkYEXrXDxgBJZGaeBaS3kk
         OvefczNUlofpexf2zs/cVl9Y4bPEsYdLFlenA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Fp0FDcVRsgytVsA7uNX5zoyCtUC6cKgLis3XSwsG5s=;
        b=xp5H9TzbfPknwnNq2r2BxXmfwdsZykBfeByCsJ4tCrfpXCtISDjoWRqTwzH9nLfCxa
         sSGKAPjfJ/hCgxG4ebPqs1Ws2ZprO3OglpYaOH3/kKsi+5fw1hujpjlhwlQSuBrGNMGp
         9LoskKE+wy97ePRa5+aRORQwzHIloETR+91Gti9T+TtjPcdj6sZhxNAkENkvFaCukP9I
         YLfogobMgXvGYYYiFwkONf09WuwCMpryhnf1stHVwHCEBqaxiovJxjSDrEjqRkW3A0wy
         K8QklLoXJxKo/U+XtOEc98pdxUA07KJ3DHYfMi93VZKopOwSKJAm1NphKVtznJ+YN/ml
         pnjw==
X-Gm-Message-State: AOAM531ZC0IoYF3QoL1ZKUEtvuDU5oLjrkWxr+yvyne/FudPUpvsYadX
        nFwtOPpifUuXua5NW6OWMWdjo5bmXiZIqOzlqmZsxzoNUsg=
X-Google-Smtp-Source: ABdhPJx40YsLE/Af6Gf5BM4H114Rgjjk09TTo52LNX6eIVjv6VNOTFi3Xv0rf3/gzUCwHkvPEbT+sz+5kTZR5ZrtXBk=
X-Received: by 2002:a05:6512:3b14:: with SMTP id f20mr6679603lfv.670.1643178745160;
 Tue, 25 Jan 2022 22:32:25 -0800 (PST)
MIME-Version: 1.0
References: <20220122091731.283592-12-wenst@chromium.org> <20220125173836.14548-1-miles.chen@mediatek.com>
In-Reply-To: <20220125173836.14548-1-miles.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 26 Jan 2022 14:32:14 +0800
Message-ID: <CAGXv+5GmtbUZdy+0d5igvJrSZSb16ed8=m1YVZCLC0OV1aeXBA@mail.gmail.com>
Subject: Re: [PATCH 11/31] clk: mediatek: mux: Clean up included headers
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     chun-jie.chen@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 1:38 AM Miles Chen <miles.chen@mediatek.com> wrote:
>
> > Some included headers aren't actually used anywhere, while other headers
> > with the declaration of functions and structures aren't directly
> > included.
> >
> > Get rid of the unused ones, and add the ones that should be included
> > directly.
> >
> > On the header side, replace headers that are included purely for data
> > structure definitions with forward declarations. This decreases the
> > amount of preprocessing and compilation effort required for each
> > inclusion.
>
> Is this inspired by [1]?
> [1] https://lore.kernel.org/lkml/YdIfz+LMewetSaEB@gmail.com/

Yes and no.

When clk-mtk.h was removed from the included headers, many headers had
to be added. Also, clk-mux.h did not include any headers, so if it were
to be used by itself, it probably would not compile.

Using forward declarations for the data structures instead of including the
header files inspired in part by that series though.

ChenYu
