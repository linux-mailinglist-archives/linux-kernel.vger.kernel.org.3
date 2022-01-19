Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE5E493EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356329AbiASRGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356327AbiASRFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:05:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4224CC061401;
        Wed, 19 Jan 2022 09:05:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7672615E1;
        Wed, 19 Jan 2022 17:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4727CC36AE3;
        Wed, 19 Jan 2022 17:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642611947;
        bh=KKlzc8c5w+fq1k4uKo5Qwf+gm47vjQ8VvRXIbggWzbM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tH9EpPZohuwPlNyLgUQaSh2/TW27U3dWzvT8E96QQ1O49ak8F6oMNPCIpNqEW6u1n
         dno4NiQcqiNnwkUnBF8/tvCcMhP66hUVF6RTYDKU3v+8xqFAi8TdtN6XL/ylAhlILt
         TnhUxgAWojwpxC/Dsfb4F/dviiWsXf/JdBPpji4ZWgxzZnRX9ueGnepCyDIe4pFs4l
         NmSxMUQXXy/74/u9/yf4iVff4NeZELpdPSjjyWb9omwGSxu4DWdRPzdnqQD4rnrxEi
         +yH1RrQB2RDDQPNYjPeFFlwst1/afn2F3oy/VExs437dhiu5qbqGw5hJ5WFF/2A3FN
         5ggoBNeKHDe3g==
Received: by mail-ed1-f43.google.com with SMTP id 30so15475680edv.3;
        Wed, 19 Jan 2022 09:05:47 -0800 (PST)
X-Gm-Message-State: AOAM533VzpG2cBvqTJzXCLsyNOCL/bc4xL42w2XGQVXyvreW8gjchzBU
        RGzVEcw/o4b5rWn3G0iT2GMz1jMFgUL1MTkNwg==
X-Google-Smtp-Source: ABdhPJzBgPPIvP9HvnVg4dyNMmI5ujybpyr1kYU14iE13zheGQ3O2xg88wkrkwxTCk6RnznZtYMkYbIeJD0Kzr0Ph78=
X-Received: by 2002:a17:906:7801:: with SMTP id u1mr8446002ejm.82.1642611945572;
 Wed, 19 Jan 2022 09:05:45 -0800 (PST)
MIME-Version: 1.0
References: <20220118194857.26546-1-julianmarcusschroeder@gmail.com>
In-Reply-To: <20220118194857.26546-1-julianmarcusschroeder@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 19 Jan 2022 11:05:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ4MqMYNiKNF_3rkbnR0CE9GhV-jzbxKn2jeJBvPGibLA@mail.gmail.com>
Message-ID: <CAL_JsqJ4MqMYNiKNF_3rkbnR0CE9GhV-jzbxKn2jeJBvPGibLA@mail.gmail.com>
Subject: Re: [PATCH] fix serdev bind/unbind
To:     julian schroeder <julianmarcusschroeder@gmail.com>
Cc:     bhanumaiya@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Johan

On Tue, Jan 18, 2022 at 1:47 PM julian schroeder
<julianmarcusschroeder@gmail.com> wrote:
>
> On some chromebooks, the serdev is used to communicate with
> an embedded controller. When the controller is updated, the
> regular ttyS* is needed. Therefore unbind/bind needs to work
> to be able to switch between the two modes without having to
> reboot. In the case of ACPI enabled platforms, the underlying
> serial device is marked as enumerated but this is not cleared
> upon remove (unbind). In this state it can not be bound as
> serdev.

'fix' implies this was supposed to work and doesn't, but unbind/bind
was never a feature of serdev. Or more specifically, switching between
serdev and tty was not a feature. There have been some attempts to add
that. I suspect it is more than a 4 line change based on those, but
maybe I'm wrong.

For your usecase, how does a given piece of h/w that needs and/or
provides kernel support continue to work when the driver is unbound.
Are you leaving any power controls that the serdev driver configured
enabled so that the tty happens to keep working? What happens to
interfaces the EC provides? The kernel doesn't deal with resources
going away too well. I have to wonder if the existing serdev EC driver
should learn to handle the 'update mode' itself or provide some sort
of raw/passthru mode to userspace. A TTY, while standard, brings a lot
of complexities.

> Signed-off-by: julian schroeder <julianmarcusschroeder@gmail.com>
> ---
>  drivers/tty/serdev/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 92e3433276f8..668fa570bc07 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -138,7 +138,11 @@ EXPORT_SYMBOL_GPL(serdev_device_add);
>  void serdev_device_remove(struct serdev_device *serdev)
>  {
>         struct serdev_controller *ctrl = serdev->ctrl;
> +       struct acpi_device *adev;
>
> +       adev = ACPI_COMPANION(&serdev->dev);
> +       if (adev)
> +               acpi_device_clear_enumerated(adev);
>         device_unregister(&serdev->dev);
>         ctrl->serdev = NULL;
>  }
> --
> 2.20.1
>
