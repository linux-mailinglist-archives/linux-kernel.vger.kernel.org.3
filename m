Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA58483D24
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 08:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbiADHov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 02:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiADHou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:44:50 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3E2C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 23:44:49 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id u13so79752919lff.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 23:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CsNGkAuTfXI5FN0re853yKsBlp1/TfiDupH7mdPtEH8=;
        b=iLIudQiTyfDFYG/CACSF02mgQWXC5aLYLwa9g/2H8JEsh1VrCJl6nDz50rIl4zqHUl
         ygOBrnzXzegoATZ+ELlPM94rvvsajU+fBFw8V3JabDkMleG7XsvJhIQea9k8oTFFlpo5
         Yi7VDCdnDnzPtsRb7amOK0sV+skf1qsFsSKWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CsNGkAuTfXI5FN0re853yKsBlp1/TfiDupH7mdPtEH8=;
        b=3nJNgL/b/OM2m2aGGEETUctt+Q3JV/TIe6Q153yjlIP9uzwbQkJOWkc5JMkBmYNc3H
         +7fZRy+55VJ6E9JFRTJ53VtjZ9K1+DTS5eINlEskGqAiTF4Bh5tgAwQs1F52fV0e8g0R
         RLlR3DwUE2Qf5MsOWZnwNX5t9k7mn1Esw1mXCREXa0Asq5LTkOHHm90/eKmZCSbI9A7Z
         nTkdm6l9Er+pIhYalEltpt0IFp+wuSeW7nGs+9SIFaQE3nZI/4ZJi8hZeZWDSSA/1cfk
         Xni2W715IOxMFka0cZIteczEdCTV5qMopRoVM5bICYmenVRhry3U3+96vDuomyL9FQCx
         GAlw==
X-Gm-Message-State: AOAM533bNmyPGr/XdZnrRFjk5vGlSvBDqaYwwhmjIzgEpic7O21x2J2u
        NvREXUtSckn3H8aTVWUEAyNY0W8KJGNrkByXM6p9oA==
X-Google-Smtp-Source: ABdhPJw0YC6U4HEb98OAFpcmS4FVKcETi99MHEMDu4r06NwCCTOcXAZuz1wxcQjSjFJ4W/qnp4p37ec5ZL2rrahOJEo=
X-Received: by 2002:a05:6512:e9a:: with SMTP id bi26mr41350197lfb.371.1641282288318;
 Mon, 03 Jan 2022 23:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20220103101855.17350-1-angelogioacchino.delregno@collabora.com> <20220103101855.17350-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220103101855.17350-2-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 4 Jan 2022 15:44:36 +0800
Message-ID: <CAGXv+5EONgNiQDk0eOVSnVG_U6_=XSpDWADt73x2=tZPt1gL7Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: mediatek: pinctrl-paris: Simplify with dev_err_probe()
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sean.wang@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 3, 2022 at 6:19 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Use the dev_err_probe() helper to simplify error handling during probe.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
