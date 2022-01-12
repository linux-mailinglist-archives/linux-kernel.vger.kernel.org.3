Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88B248BED8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348352AbiALHKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbiALHJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:09:59 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210DEC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 23:09:59 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u21so6044111edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 23:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e4STGP8nx6rQ3ZHW8wIeGVs8uIWas7TIWKM1+FpYezU=;
        b=ZmTrP16zO40yngw5STTmjokex1CAtMdhbY5IbDWg95ESmBDwfuvdEC5gZIC0XLHbQq
         bfgwrEmfLj0d2IQI54C+C1JAlyj78bMJJummud0FLcJbPrE4Zl6LsbpBMwjyVE6xfuR3
         K6g3L5I6zaIlVB2Ra+IYGW+ZsHGdG81aLKjPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e4STGP8nx6rQ3ZHW8wIeGVs8uIWas7TIWKM1+FpYezU=;
        b=mCS4n3jQeEuK1o/nhnfT/hhay6bg6lA4mp/Zc/5n3WcFodnLXb3m6lgbUQf/gZCKSB
         2etnh5j+M53BP81+cOZ8J6zBBWdpcRhgmhS08waI3e5VPZq7CmfuXe/hltR76CPz+C/B
         dg9Rx6TbR7dOfr6rCceN/pPWP4LPhIS7CSHHp0FMvHr+hryhh8rCD772qTNosNwXxOsu
         EVzKNaF1RaFuhqHNkGNwgGj3Evoybw/cldYY478C6MJdeXhBNL2e2qXtuztlNoGSunTe
         +4rEwIVXUWIdFIY8NwsrZM8jbwk3Pj6aIsZZnNYLS5+EOiOc+5Naw8Otg5rq94VXA44l
         6ALg==
X-Gm-Message-State: AOAM530N+8TNwBMkntwNYe83DirpZ1LTDc7r9n4KfF8MH8tFyNv+PmCq
        nwUGTYLViP+g70TOEfoQYU0cvE4OSKbY5YPLkRzAew==
X-Google-Smtp-Source: ABdhPJyn8pZbZiDsgDpS9epZmGHtoPwtrHVrQnpxg/IvMYAfsCnSw98pwWo/FbDisciefPKFkzl0TWCxn/Uv0enkwI4=
X-Received: by 2002:a17:907:3d8e:: with SMTP id he14mr6365432ejc.167.1641971397535;
 Tue, 11 Jan 2022 23:09:57 -0800 (PST)
MIME-Version: 1.0
References: <20220104095954.10313-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220104095954.10313-1-angelogioacchino.delregno@collabora.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 12 Jan 2022 12:39:46 +0530
Message-ID: <CAMty3ZAojTyw3H8VprH9aiyTyWjeL8oqPxNNr=J33_5FrcUj9Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: mtk_dsi: Avoid EPROBE_DEFER loop with
 external bridge
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, chunkuang.hu@kernel.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        andrzej.hajda@intel.com, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 3:30 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> DRM bridge drivers are now attaching their DSI device at probe time,
> which requires us to register our DSI host in order to let the bridge
> to probe: this recently started producing an endless -EPROBE_DEFER
> loop on some machines that are using external bridges, like the
> parade-ps8640, found on the ACER Chromebook R13.
>
> Now that the DSI hosts/devices probe sequence is documented, we can
> do adjustments to the mtk_dsi driver as to both fix now and make sure
> to avoid this situation in the future: for this, following what is
> documented in drm_bridge.c, move the mtk_dsi component_add() to the
> mtk_dsi_ops.attach callback and delete it in the detach callback;
> keeping in mind that we are registering a drm_bridge for our DSI,
> which is only used/attached if the DSI Host is bound, it wouldn't
> make sense to keep adding our bridge at probe time (as it would
> be useless to have it if mtk_dsi_ops.attach() fails!), so also move
> that one to the dsi host attach function (and remove it in detach).
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
> ---

Eventually I've observed similar issue on other Component based DSI
controllers, hence

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
