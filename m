Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E154CDA47
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbiCDRZT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Mar 2022 12:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiCDRZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:25:16 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BB5715A21F;
        Fri,  4 Mar 2022 09:24:27 -0800 (PST)
Received: from smtpclient.apple (p5b3d2910.dip0.t-ipconnect.de [91.61.41.16])
        by mail.holtmann.org (Postfix) with ESMTPSA id D5A44CECCF;
        Fri,  4 Mar 2022 18:24:26 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] Bluetooth: btrtl: Fix incorrect bin loading by
 MODULE_FIRMWARE
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220228085316.26856-1-tangmeng@uniontech.com>
Date:   Fri, 4 Mar 2022 18:24:26 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <0CF67627-7F23-43B8-A815-B6158D6F9B8F@holtmann.org>
References: <20220228085316.26856-1-tangmeng@uniontech.com>
To:     Meng Tang <tangmeng@uniontech.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Meng,

> In brctl, there are some problems which are as follows:
> 1. The bin name of MODULE_FIRMWARE is incorrect or the bin does not
> exist.
> 2. The bin used in ic_id_table have not added MODULE_FIRMWARE
> declarations.
> 3. Sorting confusion.
> 
> Thus, modify incorrect bin names and delete some non-existing bin
> names, add MODULE_FIRMWARE for bins that used in ic_id_table and
> sort by MODULE_FIRMWARE(ctl_bt/*.bin).
> 
> Signed-off-by: Meng Tang <tangmeng@uniontech.com>
> ---
> drivers/bluetooth/btrtl.c | 37 +++++++++++++++++++------------------
> 1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index c2030f7e25b4..e34b0a29f230 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -88,14 +88,14 @@ static const struct id_table ic_id_table[] = {
> 	  .config_needed = true,
> 	  .has_rom_version = true,
> 	  .fw_name  = "rtl_bt/rtl8723bs_fw.bin",
> -	  .cfg_name = "rtl_bt/rtl8723bs_config" },
> +	  .cfg_name = "rtl_bt/rtl8723bs_config-OBDA8723" },
> 
> 	/* 8723B */
> 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb, 0x6, HCI_USB),
> 	  .config_needed = false,
> 	  .has_rom_version = true,
> 	  .fw_name  = "rtl_bt/rtl8723b_fw.bin",
> -	  .cfg_name = "rtl_bt/rtl8723b_config" },
> +	  .cfg_name = NULL },
> 
> 	/* 8723D */
> 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_USB),
> @@ -104,19 +104,12 @@ static const struct id_table ic_id_table[] = {
> 	  .fw_name  = "rtl_bt/rtl8723d_fw.bin",
> 	  .cfg_name = "rtl_bt/rtl8723d_config" },
> 
> -	/* 8723DS */
> -	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_UART),
> -	  .config_needed = true,
> -	  .has_rom_version = true,
> -	  .fw_name  = "rtl_bt/rtl8723ds_fw.bin",
> -	  .cfg_name = "rtl_bt/rtl8723ds_config" },
> -
> 	/* 8821A */
> 	{ IC_INFO(RTL_ROM_LMP_8821A, 0xa, 0x6, HCI_USB),
> 	  .config_needed = false,
> 	  .has_rom_version = true,
> 	  .fw_name  = "rtl_bt/rtl8821a_fw.bin",
> -	  .cfg_name = "rtl_bt/rtl8821a_config" },
> +	  .cfg_name = NULL },
> 
> 	/* 8821C */
> 	{ IC_INFO(RTL_ROM_LMP_8821A, 0xc, 0x8, HCI_USB),
> @@ -131,7 +124,7 @@ static const struct id_table ic_id_table[] = {
> 	  .config_needed = false,
> 	  .has_rom_version = true,
> 	  .fw_name  = "rtl_bt/rtl8761a_fw.bin",
> -	  .cfg_name = "rtl_bt/rtl8761a_config" },
> +	  .cfg_name = NULL },
> 
> 	/* 8761B */
> 	{ IC_INFO(RTL_ROM_LMP_8761A, 0xb, 0xa, HCI_UART),
> @@ -922,15 +915,23 @@ MODULE_LICENSE("GPL");
> MODULE_FIRMWARE("rtl_bt/rtl8723a_fw.bin");
> MODULE_FIRMWARE("rtl_bt/rtl8723b_fw.bin");
> MODULE_FIRMWARE("rtl_bt/rtl8723b_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8723bs_config-OBDA8723.bin");
> MODULE_FIRMWARE("rtl_bt/rtl8723bs_fw.bin");
> -MODULE_FIRMWARE("rtl_bt/rtl8723bs_config.bin");
> -MODULE_FIRMWARE("rtl_bt/rtl8723ds_fw.bin");
> -MODULE_FIRMWARE("rtl_bt/rtl8723ds_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8723d_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8723d_fw.bin");
> MODULE_FIRMWARE("rtl_bt/rtl8761a_fw.bin");
> -MODULE_FIRMWARE("rtl_bt/rtl8761a_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8761b_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8761b_fw.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8761bu_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8761bu_fw.bin");
> MODULE_FIRMWARE("rtl_bt/rtl8821a_fw.bin");
> -MODULE_FIRMWARE("rtl_bt/rtl8821a_config.bin");
> -MODULE_FIRMWARE("rtl_bt/rtl8822b_fw.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8821c_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8821c_fw.bin");
> MODULE_FIRMWARE("rtl_bt/rtl8822b_config.bin");
> -MODULE_FIRMWARE("rtl_bt/rtl8852au_fw.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8822b_fw.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8822cs_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8822cs_fw.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8822cu_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8822cu_fw.bin");
> MODULE_FIRMWARE("rtl_bt/rtl8852au_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8852au_fw.bin");

simply put no. I have no idea what you are doing. The commit message description is indecipherable to me. This looks like 4 independent things mashed together.

Regards

Marcel

