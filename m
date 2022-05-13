Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BCB525A09
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 05:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376711AbiEMDYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 23:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347229AbiEMDYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 23:24:42 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB9128FEB3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 20:24:41 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w24so8447482edx.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 20:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dsUfqE+Asp1gNUkJYB0COTXKbzgCWxG3zxsJ5TkJHqU=;
        b=AFPRfp+LmQIDkPXMKr02tf0SObEzYQ9vjFxnrPp/pI7us+kD0uO22lsQPf+kEah98i
         JIrxehfF4eXsHUeE6eJHZZfStVWALFfBwoz0rniInbdBCZn834Cj3q+x4Rof2PES77Pz
         7Cn/vnjdT3dB0amG/DWEQYycMmqlaSRCcwO3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsUfqE+Asp1gNUkJYB0COTXKbzgCWxG3zxsJ5TkJHqU=;
        b=Z7CYU3/8MY5TLORGELELh6KhJIMvmhD47ecsR97hRqSMCJww15VNYcKGQOgJz/u2t3
         ufVxKUcVNnjKwajtPzguIySd3jltRLO8oW6SSdFO359xj8L7N9RR+XpwOe0m4O6OavYd
         NKjsvzDLq87PLf0bfaLnhwmR5aRhYnd/zQYKsgl4o7a80GKteDA8i+L51lLDvpRUGzhN
         v4amXuHVFLEvx7qpp3XmqSvZgBOtNy1nRglt9L/NdsVl3yFFhMNNw7x80nA6BkmtsMXJ
         H5O1FwI1wd5HT8JvFvRqY1tIU5DsDNujezbQZ9mcW5e/sJO2Li5L+Z6bZCeAJM9GIDX4
         zozw==
X-Gm-Message-State: AOAM530aECkMiPYJ7mOPttON8p/fChUSzuQ6uolhTj7k6DNEvym7eN9a
        tXJ8PYPU4Lgt9icbvuAwnUAKCia354QLciarhKXLIA==
X-Google-Smtp-Source: ABdhPJyemQEQJ87mCvmVJk9JNFNVUXVKoddMhChDbRfTDCX1kw/pVm0m1xb0vuVB4JDhcv8QsmzONfgYGd3OsK04Qlw=
X-Received: by 2002:a05:6402:34d6:b0:427:cc9d:a130 with SMTP id
 w22-20020a05640234d600b00427cc9da130mr38203722edc.356.1652412279705; Thu, 12
 May 2022 20:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220510104804.544597-6-wenst@chromium.org> <20220512144924.4114-1-miles.chen@mediatek.com>
In-Reply-To: <20220512144924.4114-1-miles.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 13 May 2022 11:24:28 +0800
Message-ID: <CAGXv+5Fipb2Sjypv8ayRbHqNfiLxtaFXatM-vMRtX2UNFzZ-3g@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] clk: mediatek: mt27xx: Replace 'struct clk' with
 'struct clk_hw'
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, rex-bc.chen@mediatek.com, sboyd@kernel.org
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

On Thu, May 12, 2022 at 10:49 PM Miles Chen <miles.chen@mediatek.com> wrote:
>
> >  static int clk_mt2701_bdp_probe(struct platform_device *pdev)
> >  {
> > -     struct clk_onecell_data *clk_data;
> > +     struct clk_hw_onecell_data *clk_data;
> >       int r;
> >       struct device_node *node = pdev->dev.of_node;
> >
> > @@ -110,7 +110,7 @@ static int clk_mt2701_bdp_probe(struct platform_device *pdev)
> >       mtk_clk_register_gates(node, bdp_clks, ARRAY_SIZE(bdp_clks),
> >                                               clk_data);
> >
> > -     r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> > +     r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
>
> We have of_clk_add_provider() and of_clk_add_hw_provider() the same time,
> so we can convert of_clk_add_provider to of_clk_add_hw_provider by 2xxx, 6xxx, 8xxx,
> without introducing build breaks.
>
> However, there is no mtk_alloc_hw_clk_data() for mtk_alloc_clk_data() in [1]. (03/11 in this series).
> For bisectability, patch 3~8 should be one patch, or we should have mtk_alloc_hw_clk_data()
> to help us?

As mentioned in the cover letter, the patch is split between the manually
edited parts and the coccinelle converted parts. This should help with
review, especially trying to identify which part of the coccinelle scripts
failed. The split also reduces the size of each patch so that they don't
get blocked.

I opted not to add additional APIs, as we would just be removing them at
the end, and that just results in even more code churn.


ChenYu

> [1] https://lore.kernel.org/lkml/20220510104804.544597-4-wenst@chromium.org/
