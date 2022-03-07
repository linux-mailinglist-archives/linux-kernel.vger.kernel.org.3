Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9A84D083A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240809AbiCGUTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbiCGUTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:19:17 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91975237DC;
        Mon,  7 Mar 2022 12:18:22 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id w7so18529699ioj.5;
        Mon, 07 Mar 2022 12:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5l3UAGfn2yojhkDVEl66TcaHwe8kO2LQUshlIpeT5is=;
        b=Fbvb4NJoKsDaGHUnPT6NY+keUsrq9nA2L9Tkoi0NX+mqk7OZnF7pQgXzdtK1zmvsNh
         Vztv8HvKsBLZu4rsZSpsa6GUEFEcd6QZXfSTyG99H5OLRyWR6smiPEg7Ytr5EbWjkDMq
         vWWvz9etDW9t//sqfDGwPL9z6jC5rYw/gdcex7QHRmDTZR3SMFV8Hrb/zi57p+fw0d3U
         DmPLBPDfdpE4PbGxljm35ZPN4vw3LZJBnA1elVGQk0Ls0AyjL5nmMoBfcZ/Ml51QVEB0
         1YYRX/2Hu65EvvMAZiNdzC2Jy6/6CghxUAlyfdLTUOM51cN9K31aXKG0qpqV8TvUcx3L
         TjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5l3UAGfn2yojhkDVEl66TcaHwe8kO2LQUshlIpeT5is=;
        b=DY1n1JSN2uWyBD0U8eelf+1XuihjkicRDIYDWiJczirfIlf07cnRM/WZbAZG2K4l9e
         QoI9KFhAHDQ+kJpWcYIBUyuTxZAoE6kOi28+s6xy0ZyBV3QZTsDiFSRlUmn0imdrqsyv
         VBWpbY4XFe3piKiIbaPv5nhhfpXG1kuEM9qsHFKycajf+inOcilLK8Q1aV4PPwFkmL2I
         X3FI101fi8ABYUVWSXQwQ+maDdLYlCJeFu+Wblrjg2MPepvyeG+7Yu5SUy5x0C9tfmrk
         ijg47GhoGcLtcPMBR+O7ZsAiZo7XvmYZq+508BWV1a8gbp0f1CmSJkQZFygyYyaHVMQl
         APgQ==
X-Gm-Message-State: AOAM530t8jMFiKnXG53KExHyEqbQt0osUBHHmqxCQdx92Qn57BHVIXuI
        MW4aCOyuD3C/ngCNrMoJkRoq781ZgcwVmcHvrs1yNctKEHk=
X-Google-Smtp-Source: ABdhPJyVaxmi9dXXo9xF0Q+2ESHuVOitLHtzcSM/qhFhY3mc/JOqOk1c9NrIpAMbesSLO4rhNTVuFEe/+Z+cRUUYvLQ=
X-Received: by 2002:a02:cd82:0:b0:317:d38c:eda8 with SMTP id
 l2-20020a02cd82000000b00317d38ceda8mr1500309jap.82.1646684302064; Mon, 07 Mar
 2022 12:18:22 -0800 (PST)
MIME-Version: 1.0
References: <20220302022522.1789588-1-peng.fan@oss.nxp.com> <20220302022522.1789588-5-peng.fan@oss.nxp.com>
In-Reply-To: <20220302022522.1789588-5-peng.fan@oss.nxp.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 7 Mar 2022 14:18:11 -0600
Message-ID: <CABb+yY0-fkRX7W2ju2C4HbrceM0pd-E8pAF53nABpuXZrd3XNg@mail.gmail.com>
Subject: Re: [PATCH V6 4/5] mailbox: imx: support dual interrupts
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        ", Sascha Hauer" <kernel@pengutronix.de>, festevam@gmail.com,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 1, 2022 at 8:23 PM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> i.MX93 S401 MU support two interrupts: tx empty and rx full.
>
>  - Introduce a new flag IMX_MU_V2_IRQ for the dual interrupt case
>  - Update author and Copyright
>
Copyright update is fair.
However, I am not sure adding an extra interrupt warrants
co-authorship, otherwise people submit far bigger changes to drivers.
And you didn't even CC the original author Oleksij Rempel. At least
please seek his ACK.

> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index 03699843a6fd..4bc59a6cad20 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
....
>
> +/* Please not change TX & RX */
>  enum imx_mu_chan_type {
>         IMX_MU_TYPE_TX,         /* Tx */
>         IMX_MU_TYPE_RX,         /* Rx */
>
You want to hard-code the values to make it clearer
      IMX_MU_TYPE_TX = 0,
      IMX_MU_TYPE_RX = 1,


> @@ -536,7 +539,8 @@ static int imx_mu_startup(struct mbox_chan *chan)
>  {
>         struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
>         struct imx_mu_con_priv *cp = chan->con_priv;
> -       unsigned long irq_flag = IRQF_SHARED;
> +       unsigned long irq_flag = 0;
> +       int irq;
>         int ret;
>
>         pm_runtime_get_sync(priv->dev);
> @@ -551,11 +555,16 @@ static int imx_mu_startup(struct mbox_chan *chan)
>         if (!priv->dev->pm_domain)
>                 irq_flag |= IRQF_NO_SUSPEND;
>
> -       ret = request_irq(priv->irq[0], imx_mu_isr, irq_flag,
> -                         cp->irq_desc, chan);
> +       if (priv->dcfg->type & IMX_MU_V2_IRQ) {
> +               irq = priv->irq[cp->type];
> +       } else {
> +               irq = priv->irq[0];
>
Please use some verbose define instead of the magic 0.

Thanks.
