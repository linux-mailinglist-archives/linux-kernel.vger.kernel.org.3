Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6AB5189E9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbiECQcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbiECQb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:31:57 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729663CFDA
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:28:24 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id y2so31957321ybi.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 09:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OioOkp+daVjcm8WittR1Tk/UQnINHvqB9L6l895CXcU=;
        b=f1y/Ry6FhhCoj1O6PNJ4u5oIsObhMzvEvN+EpK/DPgP920QWICa8XWxxM25XxlWXdv
         obO4g6HLcH9ipII7mEKHk9PRypuAKrviNfo558KwuHEF8fBitw+prwaFnLfwUa+1nhIH
         /P21JCHt8jb7Swm3CCCtQhFK7/V68tTG4IlpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OioOkp+daVjcm8WittR1Tk/UQnINHvqB9L6l895CXcU=;
        b=U5pHK9P+VBTMaeMu3V+tTbC05k5uK0kt/tQ8RI1i+bdaTAjXfECwGNjQAF5F8xMz4Y
         q4uGOFOPWztq+wosa93Y0oZb/rkv8dgkRd8Pk3rg09OtP4q9RQUThAf1jdSWVVZX3VZi
         9O7lN5NaLqrF41lPatx0R2dgggO8qB0ZtqLQaYcx4dD3cyZ+8p6FlMfdzqYiJmO+s9ht
         iJOPktcZ9TPvtt+F8o7ku7mkQIsiNivhPhVioXZCLsyU0opcxmwz/vYxVE5boZgJ+8ur
         zw9wkF04zIBff7DCEg0IwwDJVj6vVEzvy+R2uPtGHjuOXQOesePGezcB+YlytdzNl6a1
         yVSQ==
X-Gm-Message-State: AOAM532HEliBvAADRyBE71hcqqynwXS2goWzxjt6u74+jIC6Xhm0uQNB
        7ZYcjjPd9xXEz4y/yaDecT9JjO9E5O8h/YzdPlIpcA==
X-Google-Smtp-Source: ABdhPJxFCzQne8oT1CxNLdigS5RxYgArTKd3K7idnnn5ydcbSbJ7D8zB9paqLbN4J1UhMNtOHiclj9HdbDT1+FIkJcs=
X-Received: by 2002:a25:4c2:0:b0:648:6a77:5da0 with SMTP id
 185-20020a2504c2000000b006486a775da0mr13553377ybe.203.1651595303696; Tue, 03
 May 2022 09:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220419081246.2546159-1-wenst@chromium.org>
In-Reply-To: <20220419081246.2546159-1-wenst@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 4 May 2022 00:28:12 +0800
Message-ID: <CAGXv+5FSscb0F2VBMbSOHRneksZi-WSFTeFATDkY_JHoY=my+A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] clk: mediatek: Move to struct clk_hw provider APIs
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-kernel@vger.kernel.org, Miles Chen <miles.chen@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Apr 19, 2022 at 4:12 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> Hi everyone,
>
> This is part 2 of my proposed MediaTek clk driver cleanup work [1].
>
> Part 2 involves moving the whole MediaTek clk driver library from the
> old `struct clk` provider API to the new `struct clk_hw` provider API.
>
> Parts of this series were done with coccinelle scripts, while others
> were done by hand. To facilitate review, these parts are currently split
> into different patches. As a result however, this series is not fully
> bisectable. Later on, the related parts should be squashed together.
>
> Patch 1 and 2 are minor cleanups around code that is touched by later
> patches.

[...]

> Chen-Yu Tsai (7):
>   clk: mediatek: Make mtk_clk_register_composite() static
>   clk: mediatek: apmixed: Drop error message from clk_register() failure

Could you take a quick look at the first two patches and pick them up?
They are unrelated cleanups that touch the same code sections as the
other patches in this series, and thus were included.


Thanks
ChenYu
