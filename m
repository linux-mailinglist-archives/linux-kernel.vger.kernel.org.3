Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC034A324A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 23:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353320AbiA2WFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 17:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353381AbiA2WF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 17:05:28 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACA9C061753;
        Sat, 29 Jan 2022 14:05:04 -0800 (PST)
Date:   Sat, 29 Jan 2022 23:04:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1643493900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n4D+U5HlMhytxF2oWJ6akeJdqZUw/giBlQQtt02lSdo=;
        b=KoDi8BGMdKHj/IZ8Kam0jq/XfIKb1SjwVNTrk094cQArFm14cIEJ7sv5KPNPTn47neg/g9
        ygizzb4Bssk54esqzhIcofiPW0yL2ZiKQzJsKOhVX9jkiMjpKtnzPLfXTWW/Nj5M82xVNz
        vWgVIqkPag04UKdTQhw9vdwp26FUoDE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Richard Leitner <richard.leitner@linux.dev>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     linuxfancy@googlegroups.com,
        Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: usb251xb: add boost-up property support
Message-ID: <YfW6B4LANy11X5TQ@ltleri2>
References: <20220128181713.96856-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128181713.96856-1-tomm.merciai@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM. Please feel free to add

Reviewed-by: Richard Leitner <richard.leitner@linux.dev>

On Fri, Jan 28, 2022 at 07:17:13PM +0100, Tommaso Merciai wrote:
> Add support for boost-up register of usb251xb hub.
> boost-up property control USB electrical drive strength
> This register can be set:
> 
>  - Normal mode -> 0x00
>  - Low         -> 0x01
>  - Medium      -> 0x10
>  - High        -> 0x11
> 
> (Normal Default)
> 
> References:
>  - http://www.mouser.com/catalog/specsheets/2514.pdf p29
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---
> Changes since v1:
>  - Fix patch as suggested by RLeitner
> 
> Changes since v2:
>  - Fix commit body as suggested by Shtylyov
>  - Fix commit msg
>  - Fix patch as suggested by RLeitner and Shtylyov
> 
>  drivers/usb/misc/usb251xb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
> index 507deef1f709..04c4e3fed094 100644
> --- a/drivers/usb/misc/usb251xb.c
> +++ b/drivers/usb/misc/usb251xb.c
> @@ -543,6 +543,9 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
>  	if (of_property_read_u16_array(np, "language-id", &hub->lang_id, 1))
>  		hub->lang_id = USB251XB_DEF_LANGUAGE_ID;
>  
> +	if (of_property_read_u8(np, "boost-up", &hub->boost_up))
> +		hub->boost_up = USB251XB_DEF_BOOST_UP;
> +
>  	cproperty_char = of_get_property(np, "manufacturer", NULL);
>  	strlcpy(str, cproperty_char ? : USB251XB_DEF_MANUFACTURER_STRING,
>  		sizeof(str));
> @@ -584,7 +587,6 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
>  	 * may be as soon as needed.
>  	 */
>  	hub->bat_charge_en = USB251XB_DEF_BATTERY_CHARGING_ENABLE;
> -	hub->boost_up = USB251XB_DEF_BOOST_UP;
>  	hub->boost_57 = USB251XB_DEF_BOOST_57;
>  	hub->boost_14 = USB251XB_DEF_BOOST_14;
>  	hub->port_map12 = USB251XB_DEF_PORT_MAP_12;
> -- 
> 2.25.1
> 
