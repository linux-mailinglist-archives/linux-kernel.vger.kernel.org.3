Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A7F4B8D07
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbiBPP5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:57:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbiBPP5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:57:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C171C4559;
        Wed, 16 Feb 2022 07:57:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CFFF61A36;
        Wed, 16 Feb 2022 15:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD04CC004E1;
        Wed, 16 Feb 2022 15:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645027050;
        bh=F7BEhMtK4iDsUC93r2qBodSmV7qfHEB3vRaLBoZcFA0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=saLzETKioEFbmf25qsCbYWzy/DIXPMLWEd80Heei8SOp2RgIVKKoJWzHQX6bAPtGt
         o2hONnLufPnW9rGTHgL3xVDTEkNDRQXu0v3WIzWvpXipwLUWidAfZoe/9PxQ/SDRuG
         YLhApu4OPpmujEqlDdMQLXxL8F9uymsBMH8Lj3nT122x9tfgJB9qIC3DAIKLBuKKaG
         A8AWV1cuPEhqiqzlI5erRVBIqe2viS0PZW3pFjhdeKTrBjyQ4gb0rTsg6ERc78TdOH
         L79oBx7CbeWE/CU1SiSc+O9d38rekVm6iET14acrkG5sPYSHXpbRy6376R3sDuZAB7
         SwKIFzI2xa/0g==
Date:   Wed, 16 Feb 2022 16:57:26 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Aditya Garg <gargaditya08@live.com>
cc:     "alexhenrie24@gmail.com" <alexhenrie24@gmail.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "paul@mrarm.io" <paul@mrarm.io>, Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [PATCH v3 3/3] HID: apple: Add fn mapping for MacBook Pros with
 Touch Bar
In-Reply-To: <B17D84D1-F91C-4CF0-A931-C19D0278E329@live.com>
Message-ID: <nycvar.YFH.7.76.2202161656480.11721@cbobk.fhfr.pm>
References: <67E7EA8B-CF21-4794-B7B4-96873EE70EF6@live.com> <1088ECFE-B356-4731-AC8A-09A4421DD7D1@live.com> <D0C26284-966C-4581-BE37-78A6B0B367BB@live.com> <9981348D-0D48-4613-A46E-03E9A1897E59@live.com> <B17D84D1-F91C-4CF0-A931-C19D0278E329@live.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2022, Aditya Garg wrote:

> From: Aditya Garg <gargaditya08@live.com>
> 
> This patch adds the Fn mapping for keyboards on certain T2 Macs.
> 
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
> v2 :- Use better approach to map fn keys
> v3 :- Use BIT(10) for APPLE_BACKLIGHT_CTL since 0x0200 (BIT (9)) has been used.
>  drivers/hid/hid-apple.c | 62 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index 658d79375..5448e5a66 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -142,6 +142,51 @@ static const struct apple_key_translation macbookair_fn_keys[] = {
>  	{ }
>  };
>  
> +static const struct apple_key_translation macbookpro_no_esc_fn_keys[] = {
> +	{ KEY_BACKSPACE, KEY_DELETE },
> +	{ KEY_ENTER,	KEY_INSERT },
> +	{ KEY_GRAVE,	KEY_ESC },
> +	{ KEY_1,	KEY_F1 },
> +	{ KEY_2,	KEY_F2 },
> +	{ KEY_3,	KEY_F3 },
> +	{ KEY_4,	KEY_F4 },
> +	{ KEY_5,	KEY_F5 },
> +	{ KEY_6,	KEY_F6 },
> +	{ KEY_7,	KEY_F7 },
> +	{ KEY_8,	KEY_F8 },
> +	{ KEY_9,	KEY_F9 },
> +	{ KEY_0,	KEY_F10 },
> +	{ KEY_MINUS,	KEY_F11 },
> +	{ KEY_EQUAL,	KEY_F12 },
> +	{ KEY_UP,	KEY_PAGEUP },
> +	{ KEY_DOWN,	KEY_PAGEDOWN },
> +	{ KEY_LEFT,	KEY_HOME },
> +	{ KEY_RIGHT,	KEY_END },
> +	{ }
> +};
> +
> +static const struct apple_key_translation macbookpro_dedicated_esc_fn_keys[] = {
> +	{ KEY_BACKSPACE, KEY_DELETE },
> +	{ KEY_ENTER,	KEY_INSERT },
> +	{ KEY_1,	KEY_F1 },
> +	{ KEY_2,	KEY_F2 },
> +	{ KEY_3,	KEY_F3 },
> +	{ KEY_4,	KEY_F4 },
> +	{ KEY_5,	KEY_F5 },
> +	{ KEY_6,	KEY_F6 },
> +	{ KEY_7,	KEY_F7 },
> +	{ KEY_8,	KEY_F8 },
> +	{ KEY_9,	KEY_F9 },
> +	{ KEY_0,	KEY_F10 },
> +	{ KEY_MINUS,	KEY_F11 },
> +	{ KEY_EQUAL,	KEY_F12 },
> +	{ KEY_UP,	KEY_PAGEUP },
> +	{ KEY_DOWN,	KEY_PAGEDOWN },
> +	{ KEY_LEFT,	KEY_HOME },
> +	{ KEY_RIGHT,	KEY_END },
> +	{ }
> +};
> +
>  static const struct apple_key_translation apple_fn_keys[] = {
>  	{ KEY_BACKSPACE, KEY_DELETE },
>  	{ KEY_ENTER,	KEY_INSERT },
> @@ -269,6 +314,17 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
>  		    hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021 ||
>  		    hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021)
>  			table = apple2021_fn_keys;
> +		else if (hid->product == USB_DEVICE_ID_APPLE_WELLSPRINGT2_J132 ||
> +			 hid->product == USB_DEVICE_ID_APPLE_WELLSPRINGT2_J680 ||
> +			 hid->product == USB_DEVICE_ID_APPLE_WELLSPRINGT2_J213)
> +				table = macbookpro_no_esc_fn_keys;
> +		else if (hid->product == USB_DEVICE_ID_APPLE_WELLSPRINGT2_J214K ||
> +			 hid->product == USB_DEVICE_ID_APPLE_WELLSPRINGT2_J223 ||
> +			 hid->product == USB_DEVICE_ID_APPLE_WELLSPRINGT2_J152F)
> +				table = macbookpro_dedicated_esc_fn_keys;
> +		else if (hid->product == USB_DEVICE_ID_APPLE_WELLSPRINGT2_J140K ||
> +			 hid->product == USB_DEVICE_ID_APPLE_WELLSPRINGT2_J230K)
> +				table = apple_fn_keys;
>  		else if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI &&
>  				hid->product <= USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS)
>  			table = macbookair_fn_keys;
> @@ -480,6 +536,12 @@ static void apple_setup_input(struct input_dev *input)
>  	set_bit(KEY_NUMLOCK, input->keybit);
>  
>  	/* Enable all needed keys */
> +	for (trans = macbookpro_no_esc_fn_keys; trans->from; trans++)
> +		set_bit(trans->to, input->keybit);
> +
> +	for (trans = macbookpro_dedicated_esc_fn_keys; trans->from; trans++)
> +		set_bit(trans->to, input->keybit);
> +

This needed to be rebased on top of earlier José's refactoring of the 
mapping setup patches; I've done that and pushed the whole series to 
for-5.18/apple

Thanks,

-- 
Jiri Kosina
SUSE Labs

