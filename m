Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9C5465D7B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 05:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355543AbhLBEpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238988AbhLBEpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:45:45 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9326C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 20:42:23 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id r138so25780533pgr.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 20:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QPV306Cl1hLkT1aLm/ztTcGSxnCGdiyQM9JvOmh+VBI=;
        b=E13BrctyEiJmk8QUej4+qBU++tdSGEmKsrgPFCfx4zr+AVn8a28NmmgnY75romMi89
         U7ILmdqSDi4IqU1FQskq+DfQT48XCLWbZJLMOpXKWLcwy2RD/8q48vl9tFE+2fXPsZVR
         +ZI+StjehXpNDVvQ5L0pIKJzXtyXOPfQ4mivaLwcwCFo1KCxzlZAizfhCRjTso+t4G+L
         wJgw60wiDhYBTdWf9RshLHW31L2CmL6O4QuDIZMQeurga3UCgV1R1Yyffw6RafTgFsrC
         Vo2cHqAgDqh1KK0SqqfwDrOZ9Uix5RsQYB+cLuVHGj1NDgJE3P7oVXFxcHf73VIjQ65p
         T/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QPV306Cl1hLkT1aLm/ztTcGSxnCGdiyQM9JvOmh+VBI=;
        b=nZuOWVlnK/WGOwPjcOu1oS14dHGcbWikeYVN0ZAGdJbyaL/eFM/acvYLqSve9OtgSs
         b6QHUu7/4pZ7/lrOHTAUy7IOew+uqPYFf0K1k3hAdgjCtSYdFzH1Tnd2O1m4BZDBXxay
         +Bhgh44iCVEDwlimqJgCPnOo8y4jE8DV1j6ZqtRCp7y/iu6Z7H7WW5wSmaH3U8E6vZVN
         +22g6i+zcMgl7Mfih2dqQJhxU+O+PQVEcwrWW3pXbWTBM9ezPlNY5YFB5QAF5mDeIsQl
         n7p9eCtv4PSnjL+iEge/f9vHoqL1DCp/+0CHKuP0g3QKpPk9DYZTfc21PFSLXZdYJJUH
         3hVw==
X-Gm-Message-State: AOAM532aysx3M1T0kRgwuT3AZ8+Gt6lwqkkxLHlFMpkTH0hD+SvJAR78
        1yFN4NG3td09zeSAJzI+NyA6pw==
X-Google-Smtp-Source: ABdhPJyChYJegnkY59sNvTlcAnuBxHuEZK8rD2ydV4fBqk/D+T3tW0FLAm3x803r/bwHx62jIBYF4g==
X-Received: by 2002:a63:d17:: with SMTP id c23mr7912840pgl.207.1638420143063;
        Wed, 01 Dec 2021 20:42:23 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:ce4d:ddd8:41f4:d987])
        by smtp.gmail.com with ESMTPSA id p43sm1426664pfw.4.2021.12.01.20.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 20:42:22 -0800 (PST)
Date:   Thu, 2 Dec 2021 12:42:18 +0800
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
Subject: Re: [PATCH v9 3/3] mailbox: mediatek: add support for adsp mailbox
 controller
Message-ID: <YahOqtgkkj+HmlJ3@google.com>
References: <20211201075604.27864-1-allen-kh.cheng@mediatek.com>
 <20211201075604.27864-4-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201075604.27864-4-allen-kh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 03:56:04PM +0800, allen-kh.cheng wrote:
> diff --git a/drivers/mailbox/mtk-adsp-mailbox.c b/drivers/mailbox/mtk-adsp-mailbox.c
[...]
> +static const struct mbox_chan_ops adsp_mbox_chan_ops = {
> +	.send_data	= mtk_adsp_mbox_send_data,
> +	.startup	= mtk_adsp_mbox_startup,
> +	.shutdown	= mtk_adsp_mbox_shutdown,
> +	.last_tx_done	= mtk_adsp_mbox_last_tx_done,
> +};

To be consistent, s/adsp_mbox_chan_ops/mtk_adsp_mbox_chan_ops/.

With that,
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
