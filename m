Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F195483DA6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiADIG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiADIGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:06:52 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D33AC061784
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 00:06:52 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id v15so59633693ljc.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 00:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OFt24hZdmLGBoCAYYI7T4sXVcct/Z/1btjjZtC3SaEk=;
        b=JHCZ1jlAjkhd6dHGLCwhkYZP51ipfK7egRYiv0m/LWibZyiBUZWF2UrS+L0ciOOD84
         DcHwR2c/sCT+nBsKci37WgxNafQ7YdifqUOvxRWw5UdE/dmVL+23yBXabTSTCLkV4CjO
         71Bukk9tt/qPLBfSYyc/W9cczGfHyfD6MzdHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFt24hZdmLGBoCAYYI7T4sXVcct/Z/1btjjZtC3SaEk=;
        b=FjGVJz3LbVBDptdaLI05jYSQlAMidVD7bjNuN3RrZJbDV6/t4U85oRm79/fvEPfuRR
         AyrVKu+HHPVZpRCpDFX+ph6iittHRbmPx+WmgEDa7kzr3WQKMUP6mlOmsnvQLxyIW+OD
         qOni+KurvhvfmGfyuTyw2h79KZ5RtheuJ8ZeNxaBef7WKLVKNfuFy20Pv38RHFw7U8L5
         U3dlpR9+PwTT8VAZWjrO6pLkUXIpZRPECgNN8M2pA+F9b2y6qtn80HSlRLDjddS/9M0o
         vaEJb4W01e3n2Y9gllYTTxvvu4GCEOXmObAIkS3p6pcenKHjU3+LR6JsCdOApNo3ne/Q
         eGLg==
X-Gm-Message-State: AOAM531IQo/K6jHJkcsLwiaBq3apyRzHK6jL52mvV9DwlXXkpRmG5HJL
        aevWZJr8XqJtCsCYIdCUvIKct3NsDa/LriMF1rokOw==
X-Google-Smtp-Source: ABdhPJyDWPb1tmSlbkoDWfLqNb8n+G5kXWkiZum/N3TQDjsU7yZm39wuLSP0bo2TErL1wUNKZBQWNuR7Metm6xYrieg=
X-Received: by 2002:a2e:2a84:: with SMTP id q126mr36158428ljq.457.1641283610448;
 Tue, 04 Jan 2022 00:06:50 -0800 (PST)
MIME-Version: 1.0
References: <20220103143712.46675-1-angelogioacchino.delregno@collabora.com> <20220103143712.46675-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220103143712.46675-2-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 4 Jan 2022 16:06:39 +0800
Message-ID: <CAGXv+5FPG=cRmDzo5P7axHuV22RA0UNBJr3KtjZ5ThYw8XVB0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: mediatek: clk-gate: Use regmap_{set/clear}_bits helpers
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 3, 2022 at 10:38 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Appropriately change calls to regmap_update_bits() with regmap_set_bits()
> and regmap_clear_bits() for improved readability.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
