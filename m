Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E7E4C5A4A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 10:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiB0Jmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 04:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiB0Jmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 04:42:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387454130C
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 01:42:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3FBA60BB9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 09:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224CCC340EF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 09:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645954924;
        bh=uj1Pj/eliIRdIKDBsXyzCsYCI51mSIr4KYzn8O17m6g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gT7GD5tdAFX5pb4EbgCAnXXkqjAiMnHnINCyb85q+pK60XuTEsL6+Nn+1YtdnBhik
         PVwCbT20R/kHw7blds44jL1g4dpzQwBUvv45QgnvRGoa9DtEU3f5UaaQPaQdNFm0Qi
         sHRPqYaHUyUZd4MKk0hlqjkbC1w5MevGV6UZTXMI8bHNsSpVk3cYq2xFz/MCsCPhoE
         CQhlrPzSADZ0f7T35Hbisdcmn6m9MtG5Cmz7PqxIVKxeS1ExnND735GBN6mYNln5hB
         BkrIjd3Ia902S5hxdZMJ10wa3W5mjcPtNYPbeVL4Ngc7JH9Y3gpNJ1uR5D/BHQ6Rqn
         zvCTmfhTPi9zQ==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2d66f95f1d1so77934647b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 01:42:04 -0800 (PST)
X-Gm-Message-State: AOAM531Spha7ttcF7Gs6PqqJHWa9K3Bcb/nH3xQIjsI54LnetbL/kEmE
        WFk+sXfHUFoS//q3sknLIZspROt+m0gc6H48FQ8=
X-Google-Smtp-Source: ABdhPJwMp1A3TVFF/EuZlPrzjjhn91qHv+udmugHL/UM81i7lxGd4ib9f/XUOFuo+H5UBdv3copireXZGZgrT/sbLO0=
X-Received: by 2002:a81:301:0:b0:2d7:3774:a50b with SMTP id
 1-20020a810301000000b002d73774a50bmr15677827ywd.206.1645954923209; Sun, 27
 Feb 2022 01:42:03 -0800 (PST)
MIME-Version: 1.0
References: <20220224065805.3305407-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20220224065805.3305407-1-jiasheng@iscas.ac.cn>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 27 Feb 2022 11:41:36 +0200
X-Gmail-Original-Message-ID: <CAFCwf13dFDbkRer6uESKdWjpdt1QbMvDVV0989e1+FHXais_6Q@mail.gmail.com>
Message-ID: <CAFCwf13dFDbkRer6uESKdWjpdt1QbMvDVV0989e1+FHXais_6Q@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Add check for pci_enable_device
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yuri Nudelman <ynudelman@habana.ai>,
        Ofir Bitton <obitton@habana.ai>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 8:58 AM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> As the potential failure of the pci_enable_device(),
> it should be better to check the return value and return
> error if fails.
>
> Fixes: 70b2f993ea4a ("habanalabs: create common folder")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/misc/habanalabs/common/debugfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
> index fc084ee5106e..09001fd9db85 100644
> --- a/drivers/misc/habanalabs/common/debugfs.c
> +++ b/drivers/misc/habanalabs/common/debugfs.c
> @@ -890,6 +890,8 @@ static ssize_t hl_set_power_state(struct file *f, const char __user *buf,
>                 pci_set_power_state(hdev->pdev, PCI_D0);
>                 pci_restore_state(hdev->pdev);
>                 rc = pci_enable_device(hdev->pdev);
> +               if (rc < 0)
> +                       return rc;
>         } else if (value == 2) {
>                 pci_save_state(hdev->pdev);
>                 pci_disable_device(hdev->pdev);
> --
> 2.25.1
>
This patch is:
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Applied to -next.
Thanks,
Oded
