Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251395776F8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 17:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiGQPSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 11:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiGQPSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 11:18:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DF0657F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 08:17:59 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id z23so17186740eju.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 08:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJR2pz5CzsavtDacFuSIaaVs87hAtxkbL+dp9OXq/Us=;
        b=Tm1WAhdHtfxNQXcLR0JOGRN2TifbCh/zqSZ752fSKLSUVphPrepLHTLwP6Ay+PAagd
         iDClDs2uJyTFNy0BewXJ0NF87k84wKffI86gKbDdsnE2DgdCVWz4DthZeDm47uZnzXbU
         ysFgo+EZGe7uPJ2fv9SSZrjhn2N5kaO3DfncQ9C1XFvJG6OLtkuuEmXeS8OG8lWKX16+
         gpW5nL1iBZD4BRJKdJq+eGJx415GUxQ5FPBXo3Rk9h4BVictoLuZvCv/dhOGNLgdvFKR
         474z33m+HSC0Xhh/44BNh+H7gGMlEgwn+Q1ujY/4BR2tWl+3v4uYSaHfJ9ivBcYJ9zjQ
         +8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJR2pz5CzsavtDacFuSIaaVs87hAtxkbL+dp9OXq/Us=;
        b=2ue5Dhn0szm68I8AH74vEYtbzewfSoUpxo1hZQp5kJbUPbVriBU0ipuzqFbMrcVA+S
         9z22yk+r5WnIgB967fUiTuYvJyZjjnwdfqDzd3ltbrMuIeGonvwfoIq+A8KVAvqlBq5E
         CObG0UD/KjH0hkZ7Yho7tWKvpfnv5GzmllucAwg7lcdD6Umfjc5qdowapdEX2c9ymKxa
         lC/t9bzsUHWHmi36ubwHlpMLcAdzAeC00SBJQPTmitiMBiM+K4HfEi1iVGXe7kw6g5yM
         /y8kWoeo+Cq25WYgCbC3ZuWl88hP9ecF7kOTOV1LyoN5QnQwWn9PVX+KrBF9d3jFx1P1
         SX4w==
X-Gm-Message-State: AJIora8egdAtezK+df3TxprzJ/sJOUpQNqUn0lSJsg3XrLOAKJ8H4QhX
        8f/VUaYRzyNd6Cds8tjwkvYXIE4ektpW8xcMGFQ=
X-Google-Smtp-Source: AGRyM1svey08BXIwiUlXlq8kvPzwyUA5MD5DyAG88EHJtbOsw73SPJCXEo6vAtMX5T1B41zjuotZ1L8ficUtVgTb7GU=
X-Received: by 2002:a17:907:2722:b0:72b:735a:d3b4 with SMTP id
 d2-20020a170907272200b0072b735ad3b4mr21825574ejl.363.1658071077855; Sun, 17
 Jul 2022 08:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220714121215.22931-1-wbartczak@marvell.com> <20220714121215.22931-3-wbartczak@marvell.com>
In-Reply-To: <20220714121215.22931-3-wbartczak@marvell.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sun, 17 Jul 2022 10:17:46 -0500
Message-ID: <CABb+yY1fO-QPZ_YNsvHxnrhZ5+8NGa6yoZUPkvjihVaiRJcTnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mailbox: mvl_mhu: Add support for Marvell Message
 Handling Unit
To:     Wojciech Bartczak <wbartczak@marvell.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wbartczak@gmail.com, Piyush Malgujar <pmalgujar@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 7:13 AM Wojciech Bartczak <wbartczak@marvell.com> wrote:

...
> +config MVL_MHU
> +       tristate "Marvell MHU Mailbox" if ARM_SCMI_PROTOCOL
> +       depends on OF && ARM64
You want to make it depend on your ARCH or COMPILE_TEST

....
> diff --git a/drivers/mailbox/mvl_mhu.c b/drivers/mailbox/mvl_mhu.c
> @@ -0,0 +1,473 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Marvell Message Handling Unit driver
This doesn't seem to be related to ARM-MHU. Please consider calling it
something else.

...
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pci.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/acpi.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/spinlock.h>
> +
please consider dropping unnecessary includes

...
> +/*
> + * Doorbell-Register: XCP(0..1)_DEV(0..7)_XCP_MBOX
> + * Communication data from devices to XCP. When written, sets
> + * XCP(0..1)_DEV(0..7)_XCP_MBOX.
> + * PS: it doesn't matter what is written into this register,
> + * Attempting to writing 'anything' would cause an interrupt
> + * to the target!
> + */
> +
> +#define DONT_CARE_DATA                 0xFF
likely only one platform-specific bit needs to be set. you may want to
get that from dt/client ?

....
> +#define XCPX_DEVY_XCP_MBOX_OFFSET      0x000E1000
> +#define XCP_TO_DEV_XCP_MBOX(xcp_core, device_id) \
> +       (XCPX_DEVY_XCP_MBOX_OFFSET | \
> +       ((uint64_t)(xcp_core) << 36) | \
> +       ((uint64_t)(device_id) << 4))
> +
> +/* AP0-to-SCP doorbell */
> +#define AP0_TO_SCP_MBOX         XCP_TO_DEV_XCP_MBOX(SCP_INDEX, DEV_AP0)
> +
> +/*  Register offset: Enable interrupt from SCP to AP */
> +#define XCP0_XCP_DEV0_MBOX_RINT_ENA_W1S        0x000D1C40
> +#define XCP0_XCP_DEV1_MBOX_RINT_ENA_W1S        0x000D1C50
> +#define XCP0_XCP_DEV2_MBOX_RINT_ENA_W1S        0x000D1C60
> +#define XCP0_XCP_DEV3_MBOX_RINT_ENA_W1S        0x000D1C70
maybe use more compact defines?

....
> +
> +#define MHU_CHANNEL_INDEX(mhu, chan) (chan - &mhu->chan[0])
this is unused

....
> +
> +/* Secures static data processed in the irq handler */
> +DEFINE_SPINLOCK(mhu_irq_spinlock);
Please move this in 'struct mhu'

...
> +static irqreturn_t mhu_rx_interrupt_thread(int irq, void *p)
> +{
> +       struct mhu *mhu = (struct mhu *)p;
> +       struct int_src_data_s *data = (struct int_src_data_s *)mhu->payload;
> +       u64 val, scmi_tx_cnt;
> +
> +       /*
> +        * Local copy of event counters. A mismatch of received
> +        * count value and the local copy means additional events
> +        * are being flagged that needs to be attended by AP
> +        */
> +       static u64 event_counter[INDEX_INT_SRC_NONE] = {0};
Please move this in 'struct mhu'

....
> +static bool mhu_last_tx_done(struct mbox_chan *chan)
> +{
> +       struct mhu *mhu = chan->con_priv;
> +       u64 status;
> +
> +       status = ioread64(mhu->base + XCPX_XCP_DEVY_MBOX_RINT(0, 2));
> +       pr_debug("last_tx_done status: %#llx\n", status);
please use dev_XXX instead of pr_debug, here and elsewhere

thanks
