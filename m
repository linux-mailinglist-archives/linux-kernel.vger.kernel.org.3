Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9356573C27
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 19:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbiGMRry convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Jul 2022 13:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiGMRrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:47:52 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3705A2CDCC;
        Wed, 13 Jul 2022 10:47:51 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id y195so20572179yby.0;
        Wed, 13 Jul 2022 10:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lCOHRAC0RC29Jq281ZITE4nTto1lryncJqmBxaX77Aw=;
        b=Vxku07tcao+MgTSFdk9MJTdpHykt3zUgq8sodEnfrcAYjBBZbxClrv0UxD/SUhiVXp
         UZVIRl64nRP/2O8/fl43sqFLe2oNZdwWg29nR0EboKuwhwVDo0DCUFS3ipFLAt/Fisme
         6lhza+LJQPuB9TykjJjFGYMPYsnA/+owha4B6rZP8zRKPJoqktTV+arMHCL+ERF4qTtd
         3rqysOOmI+I+DSjGWYCcG0YyCeDoD9bs9PzmOdc2hyK8LeVaX440T+KGlR9ah3JmH2GD
         UGAnIQryWj8RvX7js43Uqc7ckX45qxSWligViQvjj2TrJuaL3ORDVjpRKp33b9RLnmH+
         hHHA==
X-Gm-Message-State: AJIora/TSAClChe9x5k2pUGBEnnjGBS9FSafXwibfn4eO6adek++V6l9
        eFm+gNuCM+8WrRjszOWjDlfJIPVSHnnT+o823n287HDyWYQ=
X-Google-Smtp-Source: AGRyM1sdU4SiAWDAcY0PHl+/RjIcSRotP6Dl1sabMHyKf4KVoUbbDQryJ/BDhKfxIRplyPbh6L4mM+oix2WtWhWaZ5k=
X-Received: by 2002:a05:6902:154f:b0:66e:e2d3:ce1 with SMTP id
 r15-20020a056902154f00b0066ee2d30ce1mr4524326ybu.365.1657734470375; Wed, 13
 Jul 2022 10:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220713084739.j4cqab6rfz22nlko@pengutronix.de>
In-Reply-To: <20220713084739.j4cqab6rfz22nlko@pengutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Jul 2022 19:47:39 +0200
Message-ID: <CAJZ5v0h4qQoo5uVBLtSFhdVBpD1tpd-SmVzV1dE0+VZMrr-eTA@mail.gmail.com>
Subject: Re: pm_runtime_resume_and_get in .remove callbacks
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 10:47 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> there is a big bunch of kernel drivers (here:
> drivers/i2c/busses/i2c-sprd.c) that have a remove callback that looks as
> follows:
>
>         static int sprd_i2c_remove(struct platform_device *pdev)
>         {
>                 struct sprd_i2c *i2c_dev = platform_get_drvdata(pdev);
>                 int ret;
>
>                 ret = pm_runtime_resume_and_get(i2c_dev->dev);
>                 if (ret < 0)
>                         return ret;
>
>                 i2c_del_adapter(&i2c_dev->adap);
>                 clk_disable_unprepare(i2c_dev->clk);
>
>                 pm_runtime_put_noidle(i2c_dev->dev);
>                 pm_runtime_disable(i2c_dev->dev);
>
>                 return 0;
>         }
>
> If pm_runtime_resume_and_get fails, the i2c adapter isn't removed, but
> as the memory backing i2c_dev goes away---it was allocated using
> devm_kzalloc in .probe()---the next i2c action will probably access
> freed memory.
>
> I'm not familiar enough with pm-runtime stuff, but wonder what
> can/should be done about that. The obvious (to me) candidates are:
>
>  - log an error if pm_runtime_resume_and_get() fails, but continue to
>    clean up
>  - don't check the return value at all
>
> What do you think?

(1) Use pm_runtime_get_sync() instead of pm_runtime_resume_and_get()
and don't check its return value,

or if that is not viable, because something really can run if and only
if the device is operational,

(2) do something like

ret = pm_runtime_resume_and_get(i2c_dev->dev);
i2c_del_adapter(&i2c_dev->adap);
if (ret >= 0)
        clk_disable_unprepare(i2c_dev->clk);

pm_runtime_put_noidle(i2c_dev->dev);
pm_runtime_disable(i2c_dev->dev);

Thanks!
