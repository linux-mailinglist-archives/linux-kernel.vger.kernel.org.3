Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F035849E484
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242316AbiA0OVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiA0OVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:21:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA961C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:21:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 507F1B822B2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 14:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2603FC340ED
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 14:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643293309;
        bh=WCMicAv3m6+CZEJhY0E/ZNuhdvOx+mnIiD563lWYSKA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DRVGMFErQez4uI09aLW6MW8vJ+nmNOerjljTHckS3hsk7gLkS4Zgen4nLH1sRJzUx
         wYiQsLJZVfcfEdJ6SZQ+H1vPUxpvVqERDeYW/bnWhEmd59MBrCdsrfQ84uiqtWFLPJ
         08eE0gqxDdNEPbv8BGGA7DhCjIKy+vUg0WjQmRZYtTnJNBa0C3Mq7oOKBeSMR91OcJ
         By0YEZKDTe+T2dcoc0sC9o9fhA1R5XuMjusE11hoL6UKkXIPnRpVmWYFzvoeFGSzyy
         DKkm5fv6xnG4O3b3af3yuc3DzW2PMUKQJPTuN6URw3U9s85mzvhvcxSAIKq+ymJeL2
         CnYGRw5FV9+YQ==
Received: by mail-ej1-f45.google.com with SMTP id me13so6084837ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:21:49 -0800 (PST)
X-Gm-Message-State: AOAM530XjqZxe/N4aZHdbD/AE+BUKq4WX5Ph8y0XLSHhynXgTQxDWYWj
        WeG6QPW1x94JDlSfNoJu1K+LI7Rgugr1wssAMg==
X-Google-Smtp-Source: ABdhPJwFg/nUdUKG/TbORCFUzxiSuRPD7bTzwO4yGRI8Q2uUhc1xeIXTx6N8LN470HA2InvvqGNR0zScKmTCxw059Qw=
X-Received: by 2002:a17:907:a089:: with SMTP id hu9mr3168116ejc.680.1643293307414;
 Thu, 27 Jan 2022 06:21:47 -0800 (PST)
MIME-Version: 1.0
References: <20220104095954.10313-1-angelogioacchino.delregno@collabora.com>
 <CAMty3ZAojTyw3H8VprH9aiyTyWjeL8oqPxNNr=J33_5FrcUj9Q@mail.gmail.com> <4b46b8ce-7300-ef42-eb17-efd87ebdf773@collabora.com>
In-Reply-To: <4b46b8ce-7300-ef42-eb17-efd87ebdf773@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 27 Jan 2022 22:21:35 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-FZ_pCpvZyNOcEMHOk1k5re51uGYY1jCxNxQuu7CQ-5A@mail.gmail.com>
Message-ID: <CAAOTY_-FZ_pCpvZyNOcEMHOk1k5re51uGYY1jCxNxQuu7CQ-5A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: mtk_dsi: Avoid EPROBE_DEFER loop with
 external bridge
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        andrzej.hajda@intel.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Angelo:

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=96=
=BC
2022=E5=B9=B41=E6=9C=8827=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:3=
2=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Il 12/01/22 08:09, Jagan Teki ha scritto:
> > On Tue, Jan 4, 2022 at 3:30 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> DRM bridge drivers are now attaching their DSI device at probe time,
> >> which requires us to register our DSI host in order to let the bridge
> >> to probe: this recently started producing an endless -EPROBE_DEFER
> >> loop on some machines that are using external bridges, like the
> >> parade-ps8640, found on the ACER Chromebook R13.
> >>
> >> Now that the DSI hosts/devices probe sequence is documented, we can
> >> do adjustments to the mtk_dsi driver as to both fix now and make sure
> >> to avoid this situation in the future: for this, following what is
> >> documented in drm_bridge.c, move the mtk_dsi component_add() to the
> >> mtk_dsi_ops.attach callback and delete it in the detach callback;
> >> keeping in mind that we are registering a drm_bridge for our DSI,
> >> which is only used/attached if the DSI Host is bound, it wouldn't
> >> make sense to keep adding our bridge at probe time (as it would
> >> be useless to have it if mtk_dsi_ops.attach() fails!), so also move
> >> that one to the dsi host attach function (and remove it in detach).
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@c=
ollabora.com>
> >> Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
> >> ---
> >
> > Eventually I've observed similar issue on other Component based DSI
> > controllers, hence
> >
> > Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
> >
>
> Hello dri-devel,
> can you please pick this patch?
>
> All MediaTek platforms are broken in v5.17 without this one.

Please add Fixes tag [1] to this patch.

[1] https://www.kernel.org/doc/html/v5.16/process/submitting-patches.html

Regards,
Chun-Kuang.

>
> Thanks,
> Angelo
