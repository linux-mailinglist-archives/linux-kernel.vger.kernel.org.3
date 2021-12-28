Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDFD48092C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 13:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhL1Mnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 07:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhL1Mng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 07:43:36 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4FCC061574;
        Tue, 28 Dec 2021 04:43:35 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n2BpE-0004Xr-2K; Tue, 28 Dec 2021 13:43:32 +0100
Message-ID: <d9f53ef1-c15b-0f32-0233-88ff1b33a490@leemhuis.info>
Date:   Tue, 28 Dec 2021 13:43:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] Bluetooth: Apply initial command workaround for more
 Intel chips
Content-Language: en-BS
To:     linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>, linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Fernando Ramos <greenfoo@u92.eu>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Takashi Iwai <tiwai@suse.de>
References: <20211202162256.31837-1-tiwai@suse.de>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20211202162256.31837-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1640695415;7ddd0cbf;
X-HE-SMSGID: 1n2BpE-0004Xr-2K
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

Hey bluetooth maintainers, what's the status here? It looks like the
issue was discussed quite a bit, but then nothing happened anymore. Or
am I missing something?

Other users seem to still run into the issue, see for example this report:
https://lore.kernel.org/all/b0f6f66b-28aa-9d43-0aab-e6887ee0fda8@logobject.ch/

For the rest of the mail:

[TLDR: I'm adding this regression to regzbot, the Linux kernel
regression tracking bot; most text you find below is compiled from a few
templates paragraphs some of you might have seen already.]

On 02.12.21 17:22, Takashi Iwai wrote:
> It seems that a few more Intel chips require the workaround for the
> broken initial command.  At least, per openSUSE Bugzilla reports,
> 8087:0a2a and 8087:0026 need BTUSB_INTEL_BROKEN_INITIAL_NCMD flag.
> 
> Fixes: 83f2dafe2a62 ("Bluetooth: btintel: Refactoring setup routine for legacy ROM sku")
> Buglink: https://bugzilla.opensuse.org/show_bug.cgi?id=1193124
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> ---
>  drivers/bluetooth/btusb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 75c83768c257..b26989b2df23 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -359,14 +359,16 @@ static const struct usb_device_id blacklist_table[] = {
>  
>  	/* Intel Bluetooth devices */
>  	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_COMBINED },
> -	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_COMBINED },
> +	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_COMBINED |
> +						     BTUSB_INTEL_BROKEN_INITIAL_NCMD },
>  	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_COMBINED },
>  	{ USB_DEVICE(0x8087, 0x0032), .driver_info = BTUSB_INTEL_COMBINED },
>  	{ USB_DEVICE(0x8087, 0x0033), .driver_info = BTUSB_INTEL_COMBINED },
>  	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
>  	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
>  						     BTUSB_INTEL_BROKEN_INITIAL_NCMD },
> -	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED },
> +	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED |
> +						     BTUSB_INTEL_BROKEN_INITIAL_NCMD },
>  	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_COMBINED },
>  	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED },
>  	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_COMBINED },

Adding the regression mailing list to the list of recipients, as it
should be in the loop for all regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

To be sure this issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced 83f2dafe2a62
#regzbot title bluetooth: more Intel chips require the workaround for
the broken initial command
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215167
#regzbot link: https://bugzilla.opensuse.org/show_bug.cgi?id=1193124
#regzbot ignore-activity

Reminder: when fixing the issue, please add a 'Link:' tag with the URL
to the report (the parent of this mail) using the kernel.org redirector,
as explained in 'Documentation/process/submitting-patches.rst'. Regzbot
then will automatically mark the regression as resolved once the fix
lands in the appropriate tree. For more details about regzbot see footer.

Sending this to everyone that got the initial report, to make all aware
of the tracking. I also hope that messages like this motivate people to
directly get at least the regression mailing list and ideally even
regzbot involved when dealing with regressions, as messages like this
wouldn't be needed then.

Don't worry, I'll send further messages wrt to this regression just to
the lists (with a tag in the subject so people can filter them away), as
long as they are intended just for regzbot. With a bit of luck no such
messages will be needed anyway.

Ciao, Thorsten (wearing his 'Linux kernel regression tracker' hat)

P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
on my table. I can only look briefly into most of them. Unfortunately
therefore I sometimes will get things wrong or miss something important.
I hope that's not the case here; if you think it is, don't hesitate to
tell me about it in a public reply, that's in everyone's interest.

BTW, I have no personal interest in this issue, which is tracked using
regzbot, my Linux kernel regression tracking bot
(https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
this mail to get things rolling again and hence don't need to be CC on
all further activities wrt to this regression.

---
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and/or the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
tell #regzbot about it in the report, as that will ensure the regression
gets on the radar of regzbot and the regression tracker. That's in your
interest, as they will make sure the report won't fall through the
cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include a 'Link:' tag to the report in the commit message, as explained
in Documentation/process/submitting-patches.rst
That aspect was recently was made more explicit in commit 1f57bd42b77c:
https://git.kernel.org/linus/1f57bd42b77c
