Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC714C4007
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbiBYIYn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Feb 2022 03:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbiBYIYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:24:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FE81FE559
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:24:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nNVtY-0006L4-NW; Fri, 25 Feb 2022 09:24:08 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nNVtY-001AiB-MJ; Fri, 25 Feb 2022 09:24:07 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nNVtX-0001te-9i; Fri, 25 Feb 2022 09:24:07 +0100
Message-ID: <50231574be4a848d3ef735f0e7cd96344514919f.camel@pengutronix.de>
Subject: Re: [PATCH] reset: ACPI reset support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com
Date:   Fri, 25 Feb 2022 09:24:07 +0100
In-Reply-To: <1643970842-2364-1-git-send-email-kyarlagadda@nvidia.com>
References: <1643970842-2364-1-git-send-email-kyarlagadda@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

On Fr, 2022-02-04 at 16:04 +0530, Krishna Yarlagadda wrote:
> Some of the IO devices like I2C or SPI require reset at runtime to
> recover from an error condition without changing the power state of
> the system. Added check for ACPI handle and a call to method '__RST'
> if supported. Devices using device tree method are unaffected by
> this.
> 
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  drivers/reset/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 61e6888..e4fb533 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -12,6 +12,7 @@
>  #include <linux/kref.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/acpi.h>
>  #include <linux/reset.h>
>  #include <linux/reset-controller.h>
>  #include <linux/slab.h>
> @@ -1107,6 +1108,11 @@ int __device_reset(struct device *dev, bool optional)

Could you add a sentence to the kerneldoc description above this, for
example "For ACPI devices this calls the _RST method"?

>         struct reset_control *rstc;
>         int ret;
>  
> +       acpi_handle handle = ACPI_HANDLE(dev);
> +
> +       if (handle)

What does acpi_evaluate_object() do if the _RST method is not present?
I think we have to check

		if (!acpi_has_method(handle, "_RST"))
			return optional ? 0 : -ENOENT;

here.

> +               return acpi_evaluate_object(handle, "_RST", NULL, NULL);

acpi_evaluate_object() returns acpi_status, so that should probably be
something like:

		status = acpi_evaluate_object(handle, "_RST", NULL, NULL);
		if (ACPI_FAILURE(status))
			return -EIO;

> +
>         rstc = __reset_control_get(dev, NULL, 0, 0, optional, true);
>         if (IS_ERR(rstc))
>                 return PTR_ERR(rstc);

regards
Philipp
