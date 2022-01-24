Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2344E498D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 20:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242634AbiAXTbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 14:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346876AbiAXTXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 14:23:25 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A703C061348
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:11:01 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id a18so14785678ilq.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Hb93v/cG3xs7a91RJePhFR111coG45/XiAqaJtoOXg=;
        b=dekshM3r0iZqRnweN0cD1KEJ/ymwv3d8zD/lK38pye/d6XexTA41QPH7eF7J5ydIuP
         T+vohEUegraekD/fwapCJeRUIjZm0tUtukdNQMo4cg6MypLPrzRTcMH+JFN8qkid4b7c
         Fh307MemSL7Jm9rjOaMJSBJKqt2OAxti9p2cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Hb93v/cG3xs7a91RJePhFR111coG45/XiAqaJtoOXg=;
        b=c+ysLtVJ6nfO8tZQ08Ghdk2fD+VhAt37nxiDiKktRIf0GNW7V4541gCDa7e05rQYiJ
         omyeF4qKbIYQYBgfPKGtwl+6ZqyjA9aU71aszYS2wA0Cxph1HYyRZO5rccf9Ax6TRHI/
         uslBsYTJS27PTarEOxk1MDsQjWbxL9jfaLL9wcyQb+qDQGKFsJvSYAAeCui+6PJNjUQS
         jMdPG45H7j6krZlvwHezy2kRh/DxFrzHKY+0jEYUbnhkSPXy85LzKyBYYEUe0izBfRk3
         rFhuorv/zVBGVyEulDN6wqCL3ajIDXiN57MEacjy9+Rei4XmQpQMKFg6vsHJfeTxU7xw
         gsQw==
X-Gm-Message-State: AOAM530S//9DIpZ9I01B3lqVQS/pg50FilmbnZJjcW5kbzmO3qtdCSbH
        jyVVJQnWuw/neKdPlzg86CZC+goaovt6+g==
X-Google-Smtp-Source: ABdhPJxASd5se2u1AqEk8tk+uZriphJSm2N0sua8b8k2guVozOoJw3qoMof49KUC0+Ptw0kjbloAwA==
X-Received: by 2002:a05:6e02:1c4c:: with SMTP id d12mr9397233ilg.241.1643051460411;
        Mon, 24 Jan 2022 11:11:00 -0800 (PST)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id p11sm7217112iov.38.2022.01.24.11.10.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 11:10:59 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id q204so6226473iod.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:10:59 -0800 (PST)
X-Received: by 2002:a02:c726:: with SMTP id h6mr2352523jao.207.1643051459292;
 Mon, 24 Jan 2022 11:10:59 -0800 (PST)
MIME-Version: 1.0
References: <1643048114-2996-1-git-send-email-quic_sbillaka@quicinc.com> <1643048114-2996-3-git-send-email-quic_sbillaka@quicinc.com>
In-Reply-To: <1643048114-2996-3-git-send-email-quic_sbillaka@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Jan 2022 11:10:48 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XLzCc-M6CMYOMMZ6cj+RMdwi4Uwsde=2s5V2pMWj_QTA@mail.gmail.com>
Message-ID: <CAD=FV=XLzCc-M6CMYOMMZ6cj+RMdwi4Uwsde=2s5V2pMWj_QTA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/panel-edp: Add sharp panel support for sc7280
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, quic_kalyant@quicinc.com,
        quic_abhinavk@quicinc.com, quic_khsieh@quicinc.com,
        quic_mkrishn@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 24, 2022 at 10:16 AM Sankeerth Billakanti
<quic_sbillaka@quicinc.com> wrote:
>
> Add eDP panel support for sc7280 CRD platform.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index 176ef0c..bb2e346 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1605,6 +1605,14 @@ static const struct panel_desc sharp_lq123p1jx31 = {
>         },
>  };
>
> +static const struct panel_desc sharp_lq140m1jw46 = {
> +       .bpc = 8,
> +       .size = {
> +               .width = 309,
> +               .height = 173,
> +       },

Where are your delays? I very much doubt that they are all 0.

I guess you're also not putting timings in here and you're relying on
these coming from the EDID? My own preference would be:

1. If you are relying on a reliable way to read the EDID of the panel
then you shouldn't even need to add anything to this section of the
file. You should use the "edp-panel" compatible string and then add an
entry to the "edp_panels" structure.

2. If you want to support folks that don't have a reliable way to read
the EDID then you can add things here, but you should add a mode.


> +};
> +
>  static const struct drm_display_mode starry_kr122ea0sra_mode = {
>         .clock = 147000,
>         .hdisplay = 1920,
> @@ -1719,6 +1727,9 @@ static const struct of_device_id platform_of_match[] = {
>                 .compatible = "sharp,lq123p1jx31",
>                 .data = &sharp_lq123p1jx31,
>         }, {
> +               .compatible = "sharp_lq140m1jw46",
> +               .data = &sharp_lq140m1jw46,

Two problems:

1. You should use a ",", not a "_" to separate the vendor from the model.

2. You need to post device tree bindings for this.


NOTE: if instead your eDP controller supports DP AUX bus then you
don't need to add to this table at all and you don't need to add
bindings. Instead, you'd add your EDID panel ID to the "edp_panels"
structure.
