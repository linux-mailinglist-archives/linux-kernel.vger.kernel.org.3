Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5CF465BB9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 02:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348016AbhLBBgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 20:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344294AbhLBBgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 20:36:31 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D271C061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 17:33:09 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso37844931otf.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 17:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=St7ZlQ5TKkMMGBhEXGVrQT8uIhISmmCTPfgODmJFYt4=;
        b=sBbWN38dYj4IwcUfUvDgNjWKR06ar7bK7pmch8Muh4vIrMyc2z7LQfugwQQUMCHCad
         Yuf7cR60DBLWsvGiEaqQ8t8CugUur3jqwlWbooPi3+lDjox4Ld8v9rFiA+wtZBAqP9Nm
         /FEQAGe8+ql4lb8/SS8vFIuRhxdljR+3nthE1rLXxONzgIO6HDlZhWhQw+H9J6n+MJJy
         MpM8MkUpHG5unW0jq6HF8fevjt/N+WMm+sfbqyBS2iDLQRvb1i2lWrhPi79HS6Q7HXs5
         g8732ofx22RhpcE+gT0sKdo5aQuPplz/WUKtQomd5sobq1NkFFp/YubpI9y0pH8aGSBl
         Kahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=St7ZlQ5TKkMMGBhEXGVrQT8uIhISmmCTPfgODmJFYt4=;
        b=P5Wtnse91K4+/gT13Ie2TlIsb6vbdktMjyfLXyiwUt+vE9CGk3YQQI1l9bPLK50XvT
         AGq3YuL54YGaQ7L7PJJfRVq5m4rM/fRr1ivQQr0e2t5/EIFqYxLcG82uR/8hlo/D6h2s
         nW4LxMoeL8cHhjojPcLvJiOrzEMSxJf7ohpvDlen1EYHL1Kigf02HuANchCj01/EAf17
         HuKqlqE76eqDxRb0ukkv9ejbBh+YaK/29PooLVHNW24cUIANgSvsWC/qYvhGSLreOs3u
         dogwLuE68m3L6W+Kn7fDWxdvJo2NX6niZgVllv03HUu7r3b9TLnIbAyB06eP1WxYdP0O
         vw8A==
X-Gm-Message-State: AOAM5328GbD0JMrR10p5yW3v+/okepyjJBXLci6y+phOb9yU7+d8cPti
        YHLh87cvU6qBYsBas3nO8+c0So/i+OyIJXqvN5LvkemecKg=
X-Google-Smtp-Source: ABdhPJyud5/Vg+fpTaCK3dlNFqfobGtRMpGiSf/MMruh0S47buCuK0W37hJGSFfz7QDNDKM2gCydOdU4cRNJc7Uv0g4=
X-Received: by 2002:a9d:74d0:: with SMTP id a16mr8755400otl.237.1638408789028;
 Wed, 01 Dec 2021 17:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20211127140750.GA24002@kili>
In-Reply-To: <20211127140750.GA24002@kili>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 2 Dec 2021 02:32:57 +0100
Message-ID: <CACRpkda9aKS+54aRa92xe-cfbvpkdOAkpUptGzWgDCuc67aL=Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: uninitialized variable in mtk_pctrl_show_one_pin()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 3:08 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The "try_all_type" variable is not set if (hw->soc->pull_type) is false
> leading to the following Smatch warning:
>
>     drivers/pinctrl/mediatek/pinctrl-paris.c:599 mtk_pctrl_show_one_pin()
>     error: uninitialized symbol 'try_all_type'.
>
> Fixes: fb34a9ae383a ("pinctrl: mediatek: support rsel feature")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch applied.

Yours,
Linus Walleij
