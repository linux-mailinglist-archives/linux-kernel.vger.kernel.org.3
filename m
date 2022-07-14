Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B20575520
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240768AbiGNSfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbiGNSfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:35:00 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C45501A9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:34:45 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id n74so4710514yba.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r2vNRfBJ3k/SniyJoasurozlpFDg+J65S7N92c82Jac=;
        b=VhN4BOIaEHeNfY6ol0AG0nEsCkiEG69L+edPbcaovC7tA4jbOtHNJTiojY3rKA0OIM
         tk9ZtM8/2Sn8V/z+EHrIQSyKBP6JBrzSAtzuNK6mwBsW+lyaSJLFEqq4neJR7DUnMvqE
         xHJGYOsD5mZ4SDv/sjWwxhOEOadcwjtXMTIw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r2vNRfBJ3k/SniyJoasurozlpFDg+J65S7N92c82Jac=;
        b=SrFYSqJoDX1MxJ4GBHP7VLDquap2AHFHTdFvaifiPJdzDJ6D754GeEAf+hjU+SghV3
         L/7nHVZEf4mfg3rk0BHcA1iIQyF2DWn2REEf72hER/BUSD3Fjq/d0ictlJWU3ilCv1sc
         2zU8WHvW3PleTfYeTraXLJdPDoceeVkrpEqTK85Ngd9RY3HXSR++1EV7rsMG7PPVSZ2c
         cckJBWGeMGs30VFWDD4TG5mptMn5gGNs0nm/piXfdJubsmfMLOy0l0HEix7meD+sVwy0
         MZmYMgLL+e37JRVfbgCeCf6kWmCf0LC9fIrRcI1wKtGdZbe8iTlBuhVO4b+gILPKHb/8
         d0bA==
X-Gm-Message-State: AJIora950AjTXXb785Aw5IFvnmH3Sx4E1Hq/PhVRMDgv16bRWusQXNSp
        Pax8kb9HwvTOs2IcTcc5D/O8TBbN6aFl9nZOT/5M70lAeJFELg==
X-Google-Smtp-Source: AGRyM1vu1mJde4dzHKRV1qdbRPbiWhsA/mhClcjqlNc90eFXQrhPaUM4623lGVAPjXis1neIK3rBQ8d5VtkOTs8aZ1s=
X-Received: by 2002:a25:dc52:0:b0:66e:ef32:6316 with SMTP id
 y79-20020a25dc52000000b0066eef326316mr10542679ybe.197.1657823685134; Thu, 14
 Jul 2022 11:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220706205136.v2.1.Ic7a7c81f880ab31533652e0928aa6e687bb268b5@changeid>
In-Reply-To: <20220706205136.v2.1.Ic7a7c81f880ab31533652e0928aa6e687bb268b5@changeid>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 14 Jul 2022 11:34:34 -0700
Message-ID: <CACeCKadV=k5J1ZSG+p8M5iBnX5nXrn-XnK62Nq_op2kJ68+-9w@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec: Send host event for prepare/complete
To:     Tim Van Patten <timvp@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, rrangel@chromium.org,
        robbarnes@google.com, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Tim,

On Wed, Jul 6, 2022 at 7:51 PM Tim Van Patten <timvp@google.com> wrote:
>
> Update cros_ec_lpc_pm_ops to call cros_ec_lpc_suspend() during PM
> .prepare() and cros_ec_lpc_resume() during .complete. This allows the
> EC to log entry/exit of AP's suspend/resume more accurately.
>
> Signed-off-by: Tim Van Patten <timvp@google.com>
> ---
>
> Changes in v2:
> - Include cros_ec_resume() return value in dev_info() output.
> - Guard setting .prepare/.complete with #ifdef CONFIG_PM_SLEEP.
>
>  drivers/platform/chrome/cros_ec_lpc.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index 7677ab3c0ead9..ce49fbc4ed2e1 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -534,19 +534,27 @@ static int cros_ec_lpc_suspend(struct device *dev)
>  {
>         struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
>
> +       dev_info(dev, "Prepare EC suspend\n");

This patch is doing 2 things:
1. Changing the timing of cros_ec_lpc_suspend()/resume() invocation.
2. Adding print logs for these callbacks.

Whether 2.) is necessary is already being discussed, so I won't
comment on that, but it sounds
like this should be 2 different patches.

Also, please explain what is wrong with "Previously, those events were sent when
suspend/resume were already in progress." IOW, what issue is this
solving, besides
better ordering of EC logs.

BR,

-Prashant
