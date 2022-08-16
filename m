Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B851B595434
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiHPH4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiHPH4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:56:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ED0857C9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:11:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C813D612B3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AE2C433C1;
        Tue, 16 Aug 2022 05:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660626675;
        bh=edf7dLjFEuJe/V8+O2M1QBQXMxOs1h0RiCDvty8gh9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Anka/EkUBhdowoQe9Au7gwWRehfBdWxQJwrjYHOd5OvSfIkluoQsVCaDAiNvj72xu
         CtswVGtZ/HHBNSUnmb4Mgji1MBRsAr4A/3pq6dEjt3LNRfoMR3O7iPVLQGKRhEstV0
         qkW30ceYj2TloUX05W2I+BaIadIyL5YDYemSLKP9lcRaxLiWG0Xu+Ar1FO+ebFYACq
         TTBxIZLih/Wt7jQ7RUHBbT/YKN0NB1tDnRqAPhgAuJVflNywrQGYztELLwcv/woCOK
         Y/PxLj233V3HAvPHn8jA9uel8ZpAjCnC9VBpP4Z1eDCka1P8crr5TohDdKaFfwUqK8
         SWSamsVI/J7Uw==
Date:   Tue, 16 Aug 2022 05:11:10 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: Re: [PATCH v5 2/7] platform/chrome: cros_typec_switch: Add switch
 driver
Message-ID: <Yvsm7qEiCpoYPeTS@google.com>
References: <20220815063555.1384505-1-pmalani@chromium.org>
 <20220815063555.1384505-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815063555.1384505-3-pmalani@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 06:34:19AM +0000, Prashant Malani wrote:
> Introduce a driver to configure USB Type-C mode switches and retimers
> which are controlled by the Chrome OS EC (Embedded Controller).
> This allows Type-C port drivers, as well as alternate mode drivers to
> configure their relevant mode switches and retimers according to the
> Type-C state they want to achieve.

s/Chrome OS/ChromeOS/.

> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
[...]
> +config CROS_TYPEC_SWITCH
> +	tristate "ChromeOS EC Type-C Switch Control"
> +	depends on MFD_CROS_EC_DEV && TYPEC && ACPI
> +	default MFD_CROS_EC_DEV
> +	help
> +	  If you say Y here, you get support for configuring the Chrome OS EC Type C
> +	  muxes and retimers.

s/Chrome OS/ChromeOS/.

Up to you, s/Type C/Type-C/g.

> diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
> new file mode 100644
> index 000000000000..0d319e315d57
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_typec_switch.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2022 Google LLC
> + *
> + * This driver provides the ability to configure Type C muxes and retimers which are controlled by
> + * the Chrome OS EC.
> + */

s/Chrome OS/ChromeOS/.

> +static int cros_typec_register_switches(struct cros_typec_switch_data *sdata)
> +{
> +	struct cros_typec_port *port = NULL;
> +	struct device *dev = sdata->dev;
> +	struct fwnode_handle *fwnode;
> +	struct acpi_device *adev;
> +	unsigned long long index;
> +	int ret = 0;

`port` and `ret` don't need to be initialized.

> +MODULE_DESCRIPTION("Chrome OS EC Type C Switch control");

s/Chrome OS/ChromeOS/.
