Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7068D475C25
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244107AbhLOPrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:47:11 -0500
Received: from netrider.rowland.org ([192.131.102.5]:59315 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S237960AbhLOPrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:47:05 -0500
Received: (qmail 784296 invoked by uid 1000); 15 Dec 2021 10:47:04 -0500
Date:   Wed, 15 Dec 2021 10:47:04 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@linux.intel.com,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Rajat Jain <rajatja@google.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: hub: Add delay for SuperSpeed hub resume to let
 links transit to U0
Message-ID: <YboN+GmeyeoypV1D@rowland.harvard.edu>
References: <20211215120108.336597-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215120108.336597-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 08:01:06PM +0800, Kai-Heng Feng wrote:
> When a new USB device gets plugged to nested hubs, the affected hub,
> which connects to usb 2-1.4-port2, doesn't report there's any change,
> hence the nested hubs go back to runtime suspend like nothing happened:
> [  281.032951] usb usb2: usb wakeup-resume
> [  281.032959] usb usb2: usb auto-resume
> [  281.032974] hub 2-0:1.0: hub_resume
> [  281.033011] usb usb2-port1: status 0263 change 0000
> [  281.033077] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
> [  281.049797] usb 2-1: usb wakeup-resume
> [  281.069800] usb 2-1: Waited 0ms for CONNECT
> [  281.069810] usb 2-1: finish resume
> [  281.070026] hub 2-1:1.0: hub_resume
> [  281.070250] usb 2-1-port4: status 0203 change 0000
> [  281.070272] usb usb2-port1: resume, status 0
> [  281.070282] hub 2-1:1.0: state 7 ports 4 chg 0010 evt 0000
> [  281.089813] usb 2-1.4: usb wakeup-resume
> [  281.109792] usb 2-1.4: Waited 0ms for CONNECT
> [  281.109801] usb 2-1.4: finish resume
> [  281.109991] hub 2-1.4:1.0: hub_resume
> [  281.110147] usb 2-1.4-port2: status 0263 change 0000
> [  281.110234] usb 2-1-port4: resume, status 0
> [  281.110239] usb 2-1-port4: status 0203, change 0000, 10.0 Gb/s
> [  281.110266] hub 2-1.4:1.0: state 7 ports 4 chg 0000 evt 0000
> [  281.110426] hub 2-1.4:1.0: hub_suspend
> [  281.110565] usb 2-1.4: usb auto-suspend, wakeup 1
> [  281.130998] hub 2-1:1.0: hub_suspend
> [  281.137788] usb 2-1: usb auto-suspend, wakeup 1
> [  281.142935] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
> [  281.177828] usb 2-1: usb wakeup-resume
> [  281.197839] usb 2-1: Waited 0ms for CONNECT
> [  281.197850] usb 2-1: finish resume
> [  281.197984] hub 2-1:1.0: hub_resume
> [  281.198203] usb 2-1-port4: status 0203 change 0000
> [  281.198228] usb usb2-port1: resume, status 0
> [  281.198237] hub 2-1:1.0: state 7 ports 4 chg 0010 evt 0000
> [  281.217835] usb 2-1.4: usb wakeup-resume
> [  281.237834] usb 2-1.4: Waited 0ms for CONNECT
> [  281.237845] usb 2-1.4: finish resume
> [  281.237990] hub 2-1.4:1.0: hub_resume
> [  281.238067] usb 2-1.4-port2: status 0263 change 0000
> [  281.238148] usb 2-1-port4: resume, status 0
> [  281.238152] usb 2-1-port4: status 0203, change 0000, 10.0 Gb/s
> [  281.238166] hub 2-1.4:1.0: state 7 ports 4 chg 0000 evt 0000
> [  281.238385] hub 2-1.4:1.0: hub_suspend
> [  281.238523] usb 2-1.4: usb auto-suspend, wakeup 1
> [  281.258076] hub 2-1:1.0: hub_suspend
> [  281.265744] usb 2-1: usb auto-suspend, wakeup 1
> [  281.285976] hub 2-0:1.0: hub_suspend
> [  281.285988] usb usb2: bus auto-suspend, wakeup 1
> 
> USB 3.2 spec, 9.2.5.4 "Changing Function Suspend State" says that "If
> the link is in a non-U0 state, then the device must transition the link
> to U0 prior to sending the remote wake message", but the hub only
> transits the link to U0 after signaling remote wakeup.
> 
> So be more forgiving and use a 20ms delay to let the link transit to U0
> for remote wakeup.
> 
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  - Add a small delay instead of waking up all hubs.
> 
>  drivers/usb/core/hub.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 00070a8a65079..576fdf2c9f3c8 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -1110,7 +1110,10 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
>  		} else {
>  			hub_power_on(hub, true);
>  		}
> -	}
> +	/* Give some time on remote wakeup to let links to transit to U0 */
> +	} else if (hub_is_superspeed(hub->hdev))
> +		msleep(20);

Where did the 20-ms number come from?  Is it mentioned in the spec as 
the time required for a port to switch from U3 to U0?

Alan Stern
