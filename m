Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CCA47A8C4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhLTLd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbhLTLd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:33:57 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2B1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 03:33:56 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id kd9so8969719qvb.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 03:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ib8Kih7Amxg/C5PLNgANyvS2G85OvDYw3t1xVRH3hC0=;
        b=fL/aSdMNkssqWy7s78XDEPpbq5/3gelPx7ScrqzppvAuEuv6t3M1100HL3mSlULtlc
         F0sqn8hZBz+MeV5zbPLtQsnn2/zCaRWlNiWr4jYM+VtQZosYPLkns1sOIjBoxq9U+OIM
         6TLjvsncy7mC8VlDJrHii60N/Y+8wSt2w9QMqHPTXu8WARntQLRB9tJkpRL9rnUg1Ha/
         M/yWagu/XXLk4qPSRcJq6xvBwLDJ/p5YlJ7W5TjFuhp10d6yN1kgglPkajbLtOdSMGSC
         Td3oLutGk8eFoyfSp19rSW89JF2b+UNJnJ7FXq2vRIRGXXp1cX6vNs+Ew0JfFERfgFnz
         h+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ib8Kih7Amxg/C5PLNgANyvS2G85OvDYw3t1xVRH3hC0=;
        b=dNtKM6WxzLwBNMieTetgP0sBUSsEp55XP99NIxADKr05sj2e1ORAOhjO7xlnEeaMMH
         OrBVgooQuzNoVbDBDmAkKG6CvvPEsHndYfiDzH0tHLnrI4Dp8gopToPWGTRtkVo8OYPD
         jwt7VJFva7fcik6A53lbRpkVGlh9YJs9hmYKiLbfubZFvk1k2MKLuEmGznkuRYnckidh
         3OJ0rSGzG7wShQAttxRhsn5L4AJZkzECrWyDidNDPOvsMwCl/3gP5ukn/VA0BPeX4XQQ
         g8nH1DPF6ejW1zPkSTeeyt67X+vINx9fJCe5ddbUXEMamGf9KBN1hTZKxr/VTRCS2Mux
         1NmQ==
X-Gm-Message-State: AOAM533yRrFllweGfRvyI0RkaWCwwDYyGXXM6WZiMkVrdwxJoy+Krr4R
        KRO+rv6WvZe39mCJBnjEWJVkIkwa2oR6El+HbFk=
X-Google-Smtp-Source: ABdhPJxSwutSaVWp5ud4GYuWiIEhgPAAhF+uWzhLUzOnca4ez90/D72CI2qIraVw90NXzlcabzgkeg1U4D0UIxUBJA8=
X-Received: by 2002:a05:6214:2622:: with SMTP id gv2mr12310705qvb.128.1640000036192;
 Mon, 20 Dec 2021 03:33:56 -0800 (PST)
MIME-Version: 1.0
References: <SL2PR06MB3082D6C1C65786A1E8DD0397BD709@SL2PR06MB3082.apcprd06.prod.outlook.com>
In-Reply-To: <SL2PR06MB3082D6C1C65786A1E8DD0397BD709@SL2PR06MB3082.apcprd06.prod.outlook.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Mon, 20 Dec 2021 19:33:45 +0800
Message-ID: <CAA+D8APDEhri4RKfjwSe-pM_xGKV+Oc6JVJUPFBqU8T+VH5K8A@mail.gmail.com>
Subject: Re: [PATCH] sound: fsl: add missing put_device() call in imx_hdmi_probe()
To:     =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 5:58 PM =E7=8E=8B=E6=93=8E <wangqing@vivo.com> wrote=
:
>
>
> >> From: Wang Qing <wangqing@vivo.com>
> >>
> >> of_find_device_by_node() takes a reference to the embedded struct devi=
ce
> >> which needs to be dropped when error return.
> >
> >...
> >
> >>        data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> >>        if (!data) {
> >> +             put_device(&cpu_pdev->dev);
> >
> >If it's of_find_device_by_node() you need an of_node_put() since you're
> >dropping a reference on the OF node.
> >
>
> Label fail will drop a reference on the OF node.
> Also, put_device() is called later except this branch,
> we just need to add put_device() here.
>
I agree with you. But could you please add the info in this
commit that
the commit:
f670b274f7f6 ASoC: imx-hdmi: add put_device() after of_find_device_by_node(=
)
is partially fixing the original issue, so we still need this fix.

Best regards
Wang Shengjiu
