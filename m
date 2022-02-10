Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414534B0DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 13:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241725AbiBJMuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 07:50:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbiBJMuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:50:17 -0500
X-Greylist: delayed 455 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 04:50:18 PST
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5522925C7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:50:18 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 88BB3C80082;
        Thu, 10 Feb 2022 13:42:41 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id wgvB-zJ5M1dL; Thu, 10 Feb 2022 13:42:41 +0100 (CET)
Received: from [192.168.176.116] (host-88-217-226-44.customer.m-online.net [88.217.226.44])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id F2393C80080;
        Thu, 10 Feb 2022 13:42:40 +0100 (CET)
Message-ID: <dc7e56bb-e7a0-1694-36bb-4e4d0d2dbc17@tuxedocomputers.com>
Date:   Thu, 10 Feb 2022 13:42:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] input/i8042: Add quirk table to disable aux port on
 Clevo NS70MU
Content-Language: en-US
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     dmitry.torokhov@gmail.com, tiwai@suse.com, mpdesouza@suse.com,
        arnd@arndb.de, samuel@cavoj.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220118115532.33011-1-wse@tuxedocomputers.com>
In-Reply-To: <20220118115532.33011-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> At least one modern Clevo barebone has the touchpad connected both via PS/2
> and i2c interface. This causes a race condition between the psmouse and
> i2c-hid driver. Since the full capability if the touchpad is available via
> the i2c interface and the device has no external PS/2 port, it is save to
> just ignore all ps2 mouses here to avoid this issue.
>
> The know affected device is the Clevo NS70MU.
>
> This patch adds a new i8042_dmi_noaux_table with the dmi strings of the
> affected device of different revisions. The table is then evaluated like
> the other quirk tables in the i8042 driver.
>
> This is revision 2 as I got aware that there are yet another 2 dmi string
> combinations identifying the same device.
Please let me know if a patch like this could be accepted or if the i8042 quirk tables are in a freeze state and issues
like this should be fixed another way now?
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/input/serio/i8042-x86ia64io.h | 54 +++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 148a7c5fd0e2..e39d3d840a31 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -1013,6 +1013,57 @@ static const struct dmi_system_id i8042_dmi_probe_defer_table[] __initconst = {
>  	{ }
>  };
>  
> +static const struct dmi_system_id i8042_dmi_noaux_table[] __initconst = {
> +	/*
> +	 * At least one modern Clevo barebone has the touchpad connected
> +	 * both via PS/2 and i2c interface. This causes a race condition
> +	 * between the psmouse and i2c-hid driver. Since the full
> +	 * capability if the touchpad is available via the i2c interface
> +	 * and the device has no external PS/2 port, it is save to just
> +	 * ignore all ps2 mouses here to avoid this issue.
> +	 * The know affected device is the
> +	 * TUXEDO InfinityBook S17 Gen6 / Clevo NS70MU which comes with
> +	 * one of the 6 different dmi string combinations below.
> +	 */
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{ }
> +};
> +
>  #endif /* CONFIG_X86 */
>  
>  #ifdef CONFIG_PNP
> @@ -1336,6 +1387,9 @@ static int __init i8042_platform_init(void)
>  	if (dmi_check_system(i8042_dmi_probe_defer_table))
>  		i8042_probe_defer = true;
>  
> +	if (dmi_check_system(i8042_dmi_noaux_table))
> +		i8042_noaux = true;
> +
>  	/*
>  	 * A20 was already enabled during early kernel init. But some buggy
>  	 * BIOSes (in MSI Laptops) require A20 to be enabled using 8042 to
