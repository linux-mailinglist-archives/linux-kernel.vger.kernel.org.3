Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0932B4E5CF1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 02:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346548AbiCXBwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 21:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237924AbiCXBwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 21:52:43 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Mar 2022 18:51:12 PDT
Received: from emcscan.emc.com.tw (emcscan.emc.com.tw [192.72.220.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B7B98A321
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:51:11 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.56,253,1539619200"; 
   d="scan'208";a="45166566"
Received: from unknown (HELO webmail.emc.com.tw) ([192.168.10.1])
  by emcscan.emc.com.tw with ESMTP; 24 Mar 2022 09:50:08 +0800
Received: from 192.168.10.23
        by webmail.emc.com.tw with MailAudit ESMTP Server V5.0(162304:0:AUTH_RELAY)
        (envelope-from <josh.chen@emc.com.tw>); Thu, 24 Mar 2022 09:50:07 +0800 (CST)
Received: from 192.168.33.25
        by webmail.emc.com.tw with Mail2000 ESMTP Server V7.00(149257:1:AUTH_RELAY)
        (envelope-from <josh.chen@emc.com.tw>); Thu, 24 Mar 2022 09:50:04 +0800 (CST)
From:   "Josh.Chen" <josh.chen@emc.com.tw>
To:     "'Jingle.Wu'" <jingle.wu@emc.com.tw>,
        "'Dmitry Torokhov'" <dmitry.torokhov@gmail.com>,
        "'Dave.Wang'" <dave.wang@emc.com.tw>
Cc:     <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <phoenix@emc.com.tw>,
        "'jingle.wu'" <jingle.wu@elan.corp-partner.google.com>
References: <20200904024231.26812-1-jingle.wu@emc.com.tw> <YjtYgoBvytgQu/pn@google.com> <003801d83f1c$5485aaf0$fd9100d0$@emc.com.tw>
In-Reply-To: <003801d83f1c$5485aaf0$fd9100d0$@emc.com.tw>
Subject: RE: [PATCH] Input: trackpoint - Add Suspend mode for Elan TrackPoint
Date:   Thu, 24 Mar 2022 09:50:04 +0800
Message-ID: <004901d83f21$7b7f7190$727e54b0$@emc.com.tw>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJfVPMV28kzFK9Xn/kbQgF+j86QZQIzXcXHAqWD5y+rmM4xQA==
Content-Language: zh-tw
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

When the trackpoint device receives this command,

it enters the power saving mode (power consumption <400uA),

the trackpoint would be woken up after touching it.


This patch was tested on 5.4, do we have to test it again on 5.10?

Thanks,
Josh

-----Original Message-----
From: Jingle.Wu [mailto:jingle.wu@emc.com.tw] 
Sent: Thursday, March 24, 2022 9:13 AM
To: 'Dmitry Torokhov'; 'Dave.Wang'; 'Josh.Chen'
Cc: linux-kernel@vger.kernel.org; linux-input@vger.kernel.org;
phoenix@emc.com.tw; 'jingle.wu'
Subject: RE: [PATCH] Input: trackpoint - Add Suspend mode for Elan
TrackPoint

Loop Josh, Dave.

-----Original Message-----
From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
Sent: Thursday, March 24, 2022 1:28 AM
To: jingle.wu <jingle.wu@emc.com.tw>
Cc: linux-kernel@vger.kernel.org; linux-input@vger.kernel.org;
phoenix@emc.com.tw; jingle.wu <jingle.wu@elan.corp-partner.google.com>
Subject: Re: [PATCH] Input: trackpoint - Add Suspend mode for Elan
TrackPoint

Hi Jingle,

On Fri, Sep 04, 2020 at 10:42:31AM +0800, jingle.wu wrote:
> From: "jingle.wu" <jingle.wu@elan.corp-partner.google.com>
> 
> Add suspend command for elan trackpoint

Could you please elaborate what this mode does to the trackpint?

Also, your signed-off-by is missing.

> ---
>  drivers/input/mouse/trackpoint.c | 16 ++++++++++++++++ 
> drivers/input/mouse/trackpoint.h |  1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/input/mouse/trackpoint.c
> b/drivers/input/mouse/trackpoint.c
> index 3eefee2ee2a1..b3cba973a4eb 100644
> --- a/drivers/input/mouse/trackpoint.c
> +++ b/drivers/input/mouse/trackpoint.c
> @@ -389,6 +389,20 @@ static int trackpoint_reconnect(struct psmouse
*psmouse)
>  	return 0;
>  }
>  
> +static void trackpoint_cleanup(struct psmouse *psmouse) {
> +	struct trackpoint_data *tp = psmouse->private;
> +	u8 param[3] = { TP_TOGGLE, TP_TOGGLE_BURST, TP_TOGGLE_ELAN_SLEEP };
> +
> +	if (tp->variant_id == TP_VARIANT_ELAN) {
> +		if (ps2_command(&psmouse->ps2dev, param,

I'd combine the 2 "ifs".

> +				MAKE_PS2_CMD(3, 0, TP_COMMAND))) {
> +			psmouse_err(psmouse,

psmouse_warn() since it is not a hard error.

> +				    "failed to suspend trackpont.\n");

I'd say "failed to suspend Elan trackpont\n".

> +		}
> +	}
> +}
> +
>  int trackpoint_detect(struct psmouse *psmouse, bool set_properties) {
>  	struct ps2dev *ps2dev = &psmouse->ps2dev; @@ -421,6 +435,8 @@ int 
> trackpoint_detect(struct psmouse *psmouse, bool set_properties)
>  	psmouse->reconnect = trackpoint_reconnect;
>  	psmouse->disconnect = trackpoint_disconnect;
>  
> +	psmouse->cleanup = trackpoint_cleanup;
> +
>  	if (variant_id != TP_VARIANT_IBM) {
>  		/* Newer variants do not support extended button query. */
>  		button_info = 0x33;
> diff --git a/drivers/input/mouse/trackpoint.h
> b/drivers/input/mouse/trackpoint.h
> index 5cb93ed26085..c7fa75452976 100644
> --- a/drivers/input/mouse/trackpoint.h
> +++ b/drivers/input/mouse/trackpoint.h
> @@ -107,6 +107,7 @@
>  #define TP_TOGGLE_EXT_TAG	0x22	/* Bit 3 of the first packet coming
from the
>  					   external device will be forced to
1 */
>  #define TP_MASK_EXT_TAG			0x04
> +#define TP_TOGGLE_ELAN_SLEEP	0x8

It seems to me that TP_TOGGLE_ELAN_SLEEP is a bit in TP_TOGGLE_BURST
subcommand, so it is better to move it next to TP_MASK_BURST and call it
TP_MASK_ELAN_SLEEP to match the rest.

Thanks.

--
Dmitry

