Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C0F483D3A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 08:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbiADHwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 02:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiADHwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:52:44 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17777C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 23:52:44 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id h2so69358507lfv.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 23:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+ZiY6IkcBRjtAxU1nAyJ1fPfCkxiGNTSP08edC/EcQ=;
        b=BNvys0x2/vXxzmavJQNBxAzMHyClqYXQeAkuW2nJDxevmDjxG5lN8RRDgnKOxV39Jo
         y+2PNlqnHQzUS8oErZ6UoWWwIqtNaqN7Ofon1U+nFKIby4A4RRdK+bJmZ51dFiKSL31b
         xpu5QwFJ7s6KFUV7awhqMxZGtGQNWVX66A03c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+ZiY6IkcBRjtAxU1nAyJ1fPfCkxiGNTSP08edC/EcQ=;
        b=fyW32Z9UVtpavtZGKVX4muuo6NPzA7lhTPfBgqIlal+Z3Dwexqi74mJEfyZcxiqSbF
         aoS3EhT7IE7RpjKE2Qhi5AzbNtrfzZXLURMf7vvk37duc7PiO19ZuYFa0BC2f8oPT0YS
         nJWtL66SxnlwKkQz+nank5GOYyO2dKYPLLy0r9LuNhN5qxnvJfOwxEDEjmVqRjkX7A0l
         L21yy2AGdpu1yY8m/DDof71lH7/MROXZIgIfBM81eFbgbUbgJOytXYHQT/yyiZKx6csC
         4HsquF6a/B9waxYq0hZ+83Fo/b0RFFGG3FZthXCYQL3n8pGliRllUQU9y2lSAOv772dL
         Gjeg==
X-Gm-Message-State: AOAM530jkBdZE0maim9dpdI/L0Sb6OfJDn8wzuYWUdw40gwbCswyQR+e
        vdLWLM8AjBK0P8+0++RrNSt2qMv561Z4/Jwqq+iqYQ==
X-Google-Smtp-Source: ABdhPJwvhKWuzdV52kSDSeheXXWRNnZjCsdHKDUDU7mBKaCvcXcXmZ3ie06zTYAu2zIfqnXzLeAAfRbz+zv8z4Ac7Pk=
X-Received: by 2002:a05:6512:1320:: with SMTP id x32mr43433548lfu.597.1641282762440;
 Mon, 03 Jan 2022 23:52:42 -0800 (PST)
MIME-Version: 1.0
References: <20220103101855.17350-1-angelogioacchino.delregno@collabora.com> <20220103101855.17350-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220103101855.17350-3-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 4 Jan 2022 15:52:31 +0800
Message-ID: <CAGXv+5EEU4Kg4pgGBsAgN4TFBc8X-Euar9aMzM_0it3chGasKQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] pinctrl: mediatek: pinctrl-mtk-common: Simplify with dev_err_probe()
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

Hi,

On Mon, Jan 3, 2022 at 6:19 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Use the dev_err_probe() helper to simplify error handling during probe.

You should mention the additional comment you added, and the error message
you fixed up.

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
