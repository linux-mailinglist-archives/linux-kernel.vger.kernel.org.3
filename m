Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D9D5232F3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242400AbiEKMTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241951AbiEKMT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:19:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A6E68F83;
        Wed, 11 May 2022 05:19:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1D1CB82153;
        Wed, 11 May 2022 12:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CBEC340F2;
        Wed, 11 May 2022 12:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652271555;
        bh=Fjm4AfHTC6kU6/6xhslVpnGbq5WyxAJ/0p2mGfcQWQs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dI8nHfktYwihT60Q3fiVVp9vZvUoayzvEP3HLDdwiTSPfDe0W+MsukymZqsR4Kd2j
         PCwodjXXBErP4o57wwbtpgMST/ycE9NN6ce+KKZM0b/CM7ov+ufHIDT4GdmY5k5bbP
         ND9+ZJmhaMZeCA4Y/KsO3exAO+Kzpycyoa+tLo7DAUAFOf1qv+B8CJqMMQBOS1CJ7K
         5sWjOQxUgfK91zbxzcO3d3tV62B2YLcTPGd09Scr18/507m/X3/qwmhspsvK3f5SYt
         MJtoD3ycIANo2dBljx/s/OkvfLzqC7FSwOOzjYYB9AqxuOUPOH31JnFY+l2mWjWgD+
         gWUB2HEBycm6g==
Received: by mail-wm1-f44.google.com with SMTP id r188-20020a1c44c5000000b003946c466c17so462477wma.4;
        Wed, 11 May 2022 05:19:15 -0700 (PDT)
X-Gm-Message-State: AOAM533hE49q25FzwYhhkIHDAv/fhor7lgehThDx5eMy8VPd9fKPe7Ie
        9HcLyPLOKYLEijuvDwj3NKu8i8DnHhp7km9Mvb4=
X-Google-Smtp-Source: ABdhPJzyVGRVS3f9RZC9vyM7pHDuzQgoTcjJcNnavzvLkUp3eQkqnwavyZ2cqLGpUK+B3lUA9FIEiurqeaJ8ZoB5Bq8=
X-Received: by 2002:a05:600c:382:b0:394:6172:59dc with SMTP id
 w2-20020a05600c038200b00394617259dcmr4543642wmd.120.1652271553566; Wed, 11
 May 2022 05:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220510114852.1719018-1-zheyuma97@gmail.com>
In-Reply-To: <20220510114852.1719018-1-zheyuma97@gmail.com>
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
Date:   Wed, 11 May 2022 14:18:57 +0200
X-Gmail-Original-Message-ID: <CAPybu_2NCEmjVi2FZC+dPePkfZJQG9QT5qc=cRdHY4tHPEkVDg@mail.gmail.com>
Message-ID: <CAPybu_2NCEmjVi2FZC+dPePkfZJQG9QT5qc=cRdHY4tHPEkVDg@mail.gmail.com>
Subject: Re: [PATCH] media: imx214: Fix the error handling in imx214_probe()
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zheyu

Do you have seen this issue in a real hardware?  The device enters
idle state unconditionally after power_on during probe.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/i2c/imx214.c#n1008




On Tue, May 10, 2022 at 1:49 PM Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> The driver should disable regulators when fails to probe.
>
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  drivers/media/i2c/imx214.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
> index 83c1737abeec..61eeaefd4298 100644
> --- a/drivers/media/i2c/imx214.c
> +++ b/drivers/media/i2c/imx214.c
> @@ -1076,6 +1076,7 @@ static int imx214_probe(struct i2c_client *client)
>         mutex_destroy(&imx214->mutex);
>         v4l2_ctrl_handler_free(&imx214->ctrls);
>         pm_runtime_disable(imx214->dev);
> +       regulator_bulk_disable(IMX214_NUM_SUPPLIES, imx214->supplies);
>
>         return ret;
>  }
> --
> 2.25.1
>
