Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E3748F9D3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 00:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiAOX7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 18:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiAOX7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 18:59:38 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3492CC061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 15:59:38 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id s9so17917482oib.11
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 15:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BY0t3wChnwPpABJAzUPI2uRQxasjitbf0zoLnLuzNmM=;
        b=xELVyXalO+/z52bs31zIMVRomNZNMvebNU/EH0nbs+9Y845YgY/qW6U4CzW8ijlaYP
         mg9DCeggvHBxQ5UinnwOo8phB/k5lWUORlqCYh4uGXWHU6A+fctnXEh87NwBtWnxY+nJ
         F97BcU1laAUD6j2u/tIhTMpDO93qF/J+/sOspsgvrStamqciVxBHV5D2FjUtLmvYr4dn
         shlDqcN9uNaPVFkxImqHkD9tn5rs+yvN5dDp6TqcNabCBhIkFcUHax7vYm0bfSn2R8Ji
         HZfrCzHENBfchX1EA3yQD9iW3KRhZTlVfTTOrg7RzyRsFDonfYBVV2up1BAsDETjo+6l
         KaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BY0t3wChnwPpABJAzUPI2uRQxasjitbf0zoLnLuzNmM=;
        b=pPjkMAI52/0e6oGzUtM+5+X6cDmZnyilBJb5r/TT4C+0iBHXnBLv5dBnn7KScXSZHn
         Kvvo3w7AS09aeSrzgdqWXp1zLvLS8w2v3kwEPJLSzxEqGvuj4JSYdZlpNiEJ7+OfJFL3
         hEfuajoZgZAT+UVa6SUjk5Jzf5vttWeOM4nzO8Dji2/Tr1jiI/ZTvZ+oZLHn0Bo7DkXw
         xrWFqwfNfJEz1HkHMBvfnf7SZF5fO9natEHW1aoSGQdSiPtBWF72EfziNI27mf2RUvKy
         OodnOUQFJ0qR1vSha0QzHcv2OXb7zG3ati0b+VdiBWITwTCEHVdukPsMLyvx9FSAG13g
         6InQ==
X-Gm-Message-State: AOAM5316j1j8bOZzEAilG+jtH2AGLdc/IKp3Vkj2nPYmxAOQu96apIPr
        7TC9JS9zQIDEzeGpTWSfVY17O49CRUtWOFshM6FiREUmwBA=
X-Google-Smtp-Source: ABdhPJy/oexnFc8hU3ysnUaLWHcbDN0ylAfYaUb2qiC7xMh3/+4Bu0iKtmkB9eeU2Rgz97bTHlGyDz6kcjZ52JUrjGQ=
X-Received: by 2002:aca:5a87:: with SMTP id o129mr13134949oib.114.1642291177322;
 Sat, 15 Jan 2022 15:59:37 -0800 (PST)
MIME-Version: 1.0
References: <20220103101855.17350-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220103101855.17350-1-angelogioacchino.delregno@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jan 2022 00:59:26 +0100
Message-ID: <CACRpkdZhxEc0iFYkUJmPVc1ydDVtRd6-gqwcELyLb1ZRLe5STA@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: mediatek: pinctrl-moore: Simplify with dev_err_probe()
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sean.wang@kernel.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 3, 2022 at 11:19 AM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:

> Use the dev_err_probe() helper to simplify error handling during probe.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

This patch set seems in nice shape, sadly we missed the v5.17 merge
window but please resend it as v2 once v5.17-rc1 is out with Chen-Yu's
review tags and minor fixes folded in.

Thanks!
Linus Walleij
