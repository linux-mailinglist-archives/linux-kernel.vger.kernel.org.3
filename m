Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAE457A9F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 00:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbiGSWmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 18:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbiGSWmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 18:42:01 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284145071F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:42:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id tk8so18551286ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1v88GEiD0LQIbnFj2jGBP7QMVI4Ye70Um7rX2tcudFs=;
        b=DSV9XrUjnSb4DLR1xhP0mrXjZVDOmdJuwxvFM2IOkqN4GRaSRkynMCnsWBMdrITuMn
         iukDW9Rs/o4k+BPgEmjKYDO2oQagJqq9y4IBe5Smpi+ZlBxF+PBdpFBhhl5KNA/kgnrt
         34gkoMp7ZkYhXP1emnQ2sphjIIu6H7msQ0iSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1v88GEiD0LQIbnFj2jGBP7QMVI4Ye70Um7rX2tcudFs=;
        b=glg9w+bwmpTJ6jhieUDtoBbJPpZ4M2xhPDB63HvDGISSk1B0ch5p49tK2a7sErqI/V
         2mbAch0soTOk468mwVMTlsSvlm3mUhHcmCn6rXzZS2Sg6ZlS6JmJSB7zuerqcQXfaPGE
         vc8xHR4a4EFMa4+zCpBpTVRJS+21dZGm60LuTeq5KSC9+pQ/nr95WmDDgx3RrVcCahlO
         DPfIpEHpYiSW0g56BYW6nQAmJW7SMoQmUhNTDtC96MItRrc5mGsaBgf+pV1NNeJMuFTE
         p2z2MfdxeBVPOSoEdGnZuTbquw8ElSdNGDsxeOao377vj2YBKfU+f89fT/2xfEoVjVRi
         5RMQ==
X-Gm-Message-State: AJIora91/WG6gxKzzlxUP1GX4QuLYw2Pm+Yj/oUSyrnmrov4p85Z3FNW
        pn6/XHKZjz+pl959Xj3jVbIpSbXAF/XMyA2YGng=
X-Google-Smtp-Source: AGRyM1tZFtc+svXTM6AOGyiqcT0jRzGXGcrkoFs8MpyMMFNvPVF50ldZqrAd3ik11kmAmwARO64W7w==
X-Received: by 2002:a17:907:86a6:b0:72e:e524:17f5 with SMTP id qa38-20020a17090786a600b0072ee52417f5mr25526740ejc.444.1658270518554;
        Tue, 19 Jul 2022 15:41:58 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id l12-20020a50d6cc000000b0043b240ce57bsm11429338edj.82.2022.07.19.15.41.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 15:41:57 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id a5so23649917wrx.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:41:56 -0700 (PDT)
X-Received: by 2002:a05:6000:2c9:b0:21d:bd7d:3af6 with SMTP id
 o9-20020a05600002c900b0021dbd7d3af6mr27860158wry.405.1658270516096; Tue, 19
 Jul 2022 15:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220719203857.1488831-1-nfraprado@collabora.com> <20220719203857.1488831-3-nfraprado@collabora.com>
In-Reply-To: <20220719203857.1488831-3-nfraprado@collabora.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 19 Jul 2022 15:41:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=URVf6kDm9A8OsFqmy7tdsNsoDTBvfUy8aT=kfzofyDtA@mail.gmail.com>
Message-ID: <CAD=FV=URVf6kDm9A8OsFqmy7tdsNsoDTBvfUy8aT=kfzofyDtA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/panel-edp: Add panel entry for B120XAN01.0
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 19, 2022 at 1:39 PM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Add panel identification entry for the AUO B120XAN01.0 (product ID:
> 0x1062) panel.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 675d793d925e..152e00eb846f 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1879,6 +1879,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B11=
6XAK01"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116X=
AN06.1"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133U=
AN01.0"),
> +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x1062, &delay_200_500_e50, "B120X=
AN01.0"),

 * Sort first by vendor, then by product ID.

0x1062 sorts at the top of the AUO panels, not at the bottom.

-Doug
