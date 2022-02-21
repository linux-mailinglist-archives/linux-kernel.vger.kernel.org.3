Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90814BE8FD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354859AbiBUKgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:36:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355196AbiBUKgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:36:01 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8274AD7D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:58:23 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2d6d0cb5da4so76765257b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2eHktmmt0PkDk6CLraSoVlcsRan7jcJUGHnpRXDCQ04=;
        b=H7/UrUOdRbce8sQw2RpFzn7uMvbVVdDt0g3qOad21EwoGC+Ad83x4dQFUzNpD1uWoE
         jcFM2i4O3BSz6X/IcOg1pZ/1HhX+iFLloQs0Tn0GMaYilDBKWgjI+4UrU9p6GpQbZy6h
         h8BVNFlrqQsZNlBg5wd9UhjQMMisuAe4IF23k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2eHktmmt0PkDk6CLraSoVlcsRan7jcJUGHnpRXDCQ04=;
        b=mp9B1v2Y0/G3/fpXVlk+B5k7gsdXat1tkz+VwYRZ6165KODUxYAfaewQvangfeLvNV
         xFzxJXRvosgYm5L/j/Nj2ZEZDE+6/ILXbItxLuJ0yQDv/BXPTSuAudLlxBuRFVfwaGta
         TF6mnV3yq01LRJr5rCKefODBJFuw7FHlM7Q/q33j6ih5BYlj8jA03CXQGz3Vo5CDjsaZ
         FgDPgwmql7aTOe2ECe6C+8kyM3Oby2A+bsHhzBBQoYiiUAOQ5LZlDAmqrm8DQt0HqA3R
         GiP+ZKp/D107A/Pf+1IsIjlyRmacR7mjrrrNry3iw7y3MSLPfqB29ExgArvALHhOnhnH
         bPwQ==
X-Gm-Message-State: AOAM5302tHEpiPLhO5Ux2Wq+bCQiWUuVTyRBRlvTV7PriiQfoedzzZhz
        exzOioUkGpptrU5wG42A0ms3QYR1/qBtf7DII8zlag==
X-Google-Smtp-Source: ABdhPJzWDVfTXmYwYk7yxLYvEuw00wYztgloZbX0vxTDnjc2/iQC2gsSGREss62vQj9jqvxQSfLcrGRXd4Sj0X1WK5s=
X-Received: by 2002:a0d:d613:0:b0:2d6:227e:1a10 with SMTP id
 y19-20020a0dd613000000b002d6227e1a10mr18998317ywd.21.1645437502779; Mon, 21
 Feb 2022 01:58:22 -0800 (PST)
MIME-Version: 1.0
References: <20220210141931.291712-1-angelogioacchino.delregno@collabora.com> <20220210141931.291712-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220210141931.291712-6-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 21 Feb 2022 17:58:11 +0800
Message-ID: <CAGXv+5H0OkMk=1MZH3jCFSZbauJmEcgFADfDXDPf2r1wrp8wCw@mail.gmail.com>
Subject: Re: [PATCH 5/5] pinctrl: mediatek: common-v1: Commonize
 spec_ies_smt_set callback
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sean.wang@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 10:21 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> All of the MediaTek pinctrl drivers registering with pinctrl-mtk-common
> that are offering a .spec_ies_smt_set() callback are declaring their
> own function which is doing exactly the same on all drivers: calling
> mtk_pconf_spec_set_ies_smt_range() with their struct and a simple check.
>
> Commonize this callback by adding the ies and smt structure pointers
> to struct mtk_pinctrl_devdata and changing the callback signature to
> take it.
>
> Removing the callback and checking for the existence of the spec_smt
> and/or spec_ies data would allow us to staticize the function
> mtk_pconf_spec_set_ies_smt_range(), but this solution was avoided as
> to keep flexibility, as some SoCs may need to perform a very different
> operation compared to what this commonized function is doing.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
