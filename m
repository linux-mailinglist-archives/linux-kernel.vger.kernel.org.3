Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619BD476EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbhLPKTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:19:23 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:37704 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbhLPKTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:19:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C9ADBCE1FA5;
        Thu, 16 Dec 2021 10:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB68C36AE2;
        Thu, 16 Dec 2021 10:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639649959;
        bh=PDpeqXOT2HlE/bj1xLfwgQv6NYNI9hxiVrFqrx8ObXM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hnGXbstmJpsC+yrkeBHwWoJCqQ6ibPN+WG8e4h2IHNTva1AjdV87yP7919NGM358Q
         W7EZJahvueWw6QdVNZh81mBLAbwKWLMUT2Erv78OXm5NqPxAfwAp4KRHsGqCYihjL7
         3H9mY63CZCAi70rO7epfOr7fxdq9dpV4zHt9EIo0KjVhVMOJXcuoeDh846yNnMYmLx
         iBoN98UaQJjrO86nlcSUc/xmdX7alxUgbA3P4uSgn8y/MTuPATCBsDKkcdj/HuL1vH
         /BjZ1ccJh1ywyDyIDOl5o4amLo3J3GlP3rg7Swjm7KoCBSnPiLtzuzNpsPVCDoBOTK
         x904wYxXaDicA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Hemant Kumar <hemantk@codeaurora.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Mario Limonciello <Mario.Limonciello@amd.com>,
        Richard Hughes <hughsient@gmail.com>,
        ath11k@lists.infradead.org
Subject: Re: [RFC] bus: mhi: core: Load firmware asynchronous
References: <20211210161645.10925-1-linux@weissschuh.net>
Date:   Thu, 16 Dec 2021 12:19:10 +0200
In-Reply-To: <20211210161645.10925-1-linux@weissschuh.net> ("Thomas
        \=\?utf-8\?Q\?Wei\=C3\=9Fschuh\=22's\?\= message of "Fri, 10 Dec 2021 17:16:45
 +0100")
Message-ID: <87k0g4n97l.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Wei=C3=9Fschuh <linux@weissschuh.net> writes:

> This gives userspace the possibility to provide the firehose bootloader
> via the sysfs-firmware-API instead of having to modify the global
> firmware loadpath.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>
> ---
>
> Please note that this is not tested yet, as I don't have access to a matc=
hing
> firmware file.
> This submission is to gather general feedback from the maintainers and th=
en
> Richard will do the actual testing, while I'll do the development.
>
> This patch is should not have any impact beyond moving from request_firmw=
are()
> to request_firmware_nowait() and the involved code reshuffle.

Related to firmware loading, for ath11k I have a different kind of need
for firmware handling in MHI. Instead of providing the firmware name to
MHI and MHI subystem loading the firmware from user space, I would like
to ath11k load the firmware from user space and just provide a pointer
to the firmware data.

The long story here is that currently ath11k pci devices have two
different firmware files, amss.bin and m3.bin. amss.bin is loaded via
MHI and m3.bin via QMI. What I would like do is to create one container
file firmware-2.bin and it would contain amss.bin, m3.bin and various
meta data needed by ath11k. ath11k would then parse firmware-2.bin and
provide pointer to amss.bin data for MHI.

We already use similar firmware-2.bin file in ath10k, but of course
ath10k doesn't need MHI so this hasn't been an issue before. We need
firmware-2.bin files because of two reasons: seamless backwards
compatibility and a reliable way to provide meta data to the driver.

Thoughts about this?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
