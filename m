Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA9C460F3A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 08:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbhK2HRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 02:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237146AbhK2HPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 02:15:36 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF940C0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 23:12:17 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gt5so11995518pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 23:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XOVClEjHy2YCmmxBNWZViUvkZtP1AdWZ7jyiRVXX/3Q=;
        b=Sjv5tuU3YefSTVzJGdWEKxum4VaFMKb5gxi04NlC81VNM6HCAfuQLXGCZMvt83jl0B
         095duvMeJkcxy6vpoByoMGLUVgoALS4C9E4mvfyeJgpTr3CfyPC4V7mK292GP9L41NYJ
         J1CNIFmMyGbSsvEgUUarFrLyxv/z3D2jvMJymtJP4B69F5Wk8evpoEVg26aowPzBqPlx
         a0DrZ20URASj+2Zc/cFzyir3b2v8oA8iqJawkdIqTcKILSNUyaRrejfS+HJdInNrbrdC
         bxhXHDSafZMIAajFSMvxtE6S/cK9ykm51ZAsZ7ufCBS7XPoE+jfqT7dr2UCXUTuiQ8qv
         7WfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XOVClEjHy2YCmmxBNWZViUvkZtP1AdWZ7jyiRVXX/3Q=;
        b=GTd1/i6m+kVXi00VgVIpw34frg0U4xJInLaTRTLgUoHs1Jdwdcwu2gjur3HRYIDhH3
         OkMPwqC7CI73S+v+Eq3brhDSciDEf5Cy37t3GOcJiQ0cqjKkg21yWbxFemYmACIYWefu
         wlo2CG/nN/7hrWb4Ieho03hWqJeeYCfEfxh+JLN0kKcdAbjw7tS0halmWtUEGXQIAwXI
         WisFuhc5l8rTTUokkMxBMmSwDJ1DprBjRJPQeih3cL9qyM+KAEmxKqK4Mhkx+/f+PxV2
         pz0S1Z/NIrFwKquv1aTLGYNx/7699RdkPjNE4rPzJQCd6W5oHnBhs/PfJnoauBJUw6sA
         /Naw==
X-Gm-Message-State: AOAM530nIM1Ur2qTphEegcN/56Jl86fzbE67cbb0LvCfjQ6xDk7zc2Yh
        o5Zr+crP7cOREJArXrPOr7HcEQ==
X-Google-Smtp-Source: ABdhPJwOh28YXHGKAJUi7kIV5rLOOLWW21lh5L1/C7V9rKaGzWrMqT4TrSV/3iTvTifnRN+wFK+7vg==
X-Received: by 2002:a17:90b:1643:: with SMTP id il3mr35457906pjb.182.1638169937067;
        Sun, 28 Nov 2021 23:12:17 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:3807:fdf3:5573:47d6])
        by smtp.gmail.com with ESMTPSA id nv12sm13818886pjb.49.2021.11.28.23.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 23:12:16 -0800 (PST)
Date:   Mon, 29 Nov 2021 15:12:12 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        cujomalainey@google.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v7 3/3] mailbox: mediatek: add support for adsp mailbox
 controller
Message-ID: <YaR9TN7Aad5DYCg1@google.com>
References: <20211129063954.1616-1-allen-kh.cheng@mediatek.com>
 <20211129063954.1616-4-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129063954.1616-4-allen-kh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 02:39:54PM +0800, allen-kh.cheng wrote:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> This patch is to for MediaTek ADSP IPC mailbox controller driver
> It is used to send short messages between processors with adsp
> 
> Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
> Reviewed-by: AngeloGioacchino Del Regno<angelogioacchino.delregno@collabora.com>
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>

Please double check again if you use the R-b tags correctly.  I have provided my R-b tag before but have some more minor comments below.

With the minor comments:
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>

> diff --git a/drivers/mailbox/mtk-adsp-mailbox.c b/drivers/mailbox/mtk-adsp-mailbox.c
[...]
> +static const struct mbox_chan_ops adsp_mbox_chan_ops = {
> +	.send_data	= mtk_adsp_mbox_send_data,
> +	.startup	= mtk_adsp_mbox_startup,
> +	.shutdown	= mtk_adsp_mbox_shutdown,
> +	.last_tx_done	= mtk_adsp_mbox_last_tx_done,
> +};

Rename adsp_mbox_chan_ops to mtk_adsp_mbox_chan_ops looks better to me.
