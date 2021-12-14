Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B8B474E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 00:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbhLNX2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 18:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhLNX2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 18:28:17 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FC2C061574;
        Tue, 14 Dec 2021 15:28:16 -0800 (PST)
Date:   Wed, 15 Dec 2021 00:28:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1639524493;
        bh=px2nFIrkc6EXmcu4jcTAUXb6pMFO2r05xDq53egOoME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EAU4pwjLaQmMoR5/v19+wcHmzW5KAqg+VzG1JV6RhGhb/EdwkqG9RxJ9cYhnakaPU
         D2r0VayD3Vbkmif7SYS2UZOXOQ3DgGQyVn6dJj++QnGo1QnLnOyJWP644ug67CPu1s
         Kxsq8wQ9+CtibJ6iwR3FUNh29X0l54fpD/rY4uYY=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Hemant Kumar <hemantk@codeaurora.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Mario Limonciello <Mario.Limonciello@amd.com>,
        Richard Hughes <hughsient@gmail.com>,
        Ivan Mikhanchuk <ivan.mikhanchuk@quectel.com>,
        Aleksander Morgado <aleksander@aleksander.es>
Subject: Re: [RFC] bus: mhi: core: Load firmware asynchronous
Message-ID: <ee87c8a5-e95b-4a32-ac9d-c68b64348f6e@t-8ch.de>
References: <20211210161645.10925-1-linux@weissschuh.net>
 <403e93df-5b3c-acb3-2b65-df9a7834a9c5@codeaurora.org>
 <02e32c9d-79d2-4237-bb6b-8bd27029e7a9@t-8ch.de>
 <6c805ecd-4542-5533-7852-ecd9cea27955@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c805ecd-4542-5533-7852-ecd9cea27955@codeaurora.org>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-14 14:55-0800, Hemant Kumar wrote:
> On 12/13/2021 10:32 PM, Thomas Weißschuh wrote:
> > On 2021-12-13 16:07-0800, Hemant Kumar wrote:
> > > On 12/10/2021 8:16 AM, Thomas Weißschuh wrote:
> > > > This gives userspace the possibility to provide the firehose bootloader
> > > > via the sysfs-firmware-API instead of having to modify the global
> > > > firmware loadpath.
> > > > 
> > > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > > 
> > > > ---
> > > > 
> > > > Please note that this is not tested yet, as I don't have access to a matching
> > > > firmware file.
> > > > This submission is to gather general feedback from the maintainers and then
> > > > Richard will do the actual testing, while I'll do the development.
> > > > 
> > > > This patch is should not have any impact beyond moving from request_firmware()
> > > > to request_firmware_nowait() and the involved code reshuffle.
> > > what are we achieving by moving to async ver of the firmware load ? MHI boot
> > > flow can not do anything until BHI load is over. Is the intention eventually
> > > to enable firmware fallback mechanism  and manually load the firmware ?
> > 
> > The goal is to provide the firehose bootloader (qcom/prog_firehose_sdx24.mbn)
> > via the firmware fallback mechanism when upgrading the firmware on the device
> > via the firehose protocol.
> > 
> > This bootloader firmware is not part of linux-firmware but provided as part of
> > each firmware update package, so it is not installed statically on the system.
> > 
> > I will extend the commit message with this information.
> 
> For my understanding i have follow up question. As per the kernel doc
> https://www.kernel.org/doc/html/latest/driver-api/firmware/fallback-mechanisms.html

I'll try to answer, but please be aware that I have no previous experience with
the firmware fallback mechanism and can not test this patch.

At this point in time I'm also hoping more for a general confirmation about
using *some* fallback mechanism for MHI, so Richard and Ivan can test the patch
(before it is committed) and then we can figure out exactly which of the
fallback mechanisms fits best with feedback from them.

> If CONFIG_FW_LOADER_USER_HELPER enabled but
> CONFIG_FW_LOADER_USER_HELPER_FALLBACK is disabled, only the custom fallback
> mechanism is available and for the request_firmware_nowait() call.
> 
> Custom fall back mechanism says
> Users of the request_firmware_nowait() call have yet another option
> available at their disposal: rely on the sysfs fallback mechanism but
> request that no kobject uevents be issued to userspace. Original logic
> behind this was that utilities other than udev might be required to lookup
> firmware in non-traditional paths
> 
> Your patch is passing uevent flag as true which means you are relying on
> uevent to be issued to userspace. How do you plan to update the firmware
> path ? Alternatively firmware class provides a module param to specify the
> firmware path /sys/module/firmware_class/parameters/path.

Emitting the uevent would allow the firmware update tool
(fwupd, https://github.com/fwupd/fwupd) to monitor uevents and recognize when
the device is ready to receive the firmware and then trigger the upload.
If I see it correctly uevent=0 and uevent=1 do the same things except uevent=1
also publishes the uevent.

Modifying /sys/module/firmware_class/parameters/path is what currently is being
done.
But modifying the global firmware load path has the potential for the following
issues:

* While the global firmware load path is modified to a custom location any
  load_firmware() call from other devices will fail because the new path does
  not have the normal linux-firmware.
* If the tool modifying crashes while before restoring the original load path
  all further load_firmware()-calls will also fail.

> > 
> > PS: The current patch is missing 'return' after calls to
> > 'mhi_fw_load_finish()', this will be corrected in v2.

Another point:

For sdx55 and sdx65 there is not only an edl firmware specified but also a
firmware for normal operation.
This firmware is not part of linux-firmware.
Currently the firmware load would fail and put the modem into an error
condition (I think?).
With this patch there would be a timeout before that error state is reached.

I know that some people have the SDX55 running with Linux but I'm now wondering
where they are getting the firmware "qcom/sdx55m/sbl1.mbn" from.

Thomas
