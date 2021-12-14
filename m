Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A49C473D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 07:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhLNGca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 01:32:30 -0500
Received: from todd.t-8ch.de ([159.69.126.157]:46969 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231148AbhLNGc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 01:32:29 -0500
Date:   Tue, 14 Dec 2021 07:32:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1639463546;
        bh=hXNmItZsiKD0JSzD3KLOMTWJ0jfOkfqH2sC/iJs9ifQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aVzPSGvhvMtDzpZu8H+5eMmlIaQMiZ6jwn54ESTR8wnz5CWXaXVh2zu6lEwYx4DyO
         ThvFjIP8z06A3xU/pqfxu7vYsMRr004taJ5ooPRRrnF6pFe+Qy6ks30idZXa6yUH9z
         +133zoqds57ZIix5p5EEwjI35QuLXXnBNyUFEtAw=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Hemant Kumar <hemantk@codeaurora.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Mario Limonciello <Mario.Limonciello@amd.com>,
        Richard Hughes <hughsient@gmail.com>
Subject: Re: [RFC] bus: mhi: core: Load firmware asynchronous
Message-ID: <02e32c9d-79d2-4237-bb6b-8bd27029e7a9@t-8ch.de>
References: <20211210161645.10925-1-linux@weissschuh.net>
 <403e93df-5b3c-acb3-2b65-df9a7834a9c5@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <403e93df-5b3c-acb3-2b65-df9a7834a9c5@codeaurora.org>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-13 16:07-0800, Hemant Kumar wrote:
> On 12/10/2021 8:16 AM, Thomas Weißschuh wrote:
> > This gives userspace the possibility to provide the firehose bootloader
> > via the sysfs-firmware-API instead of having to modify the global
> > firmware loadpath.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > 
> > ---
> > 
> > Please note that this is not tested yet, as I don't have access to a matching
> > firmware file.
> > This submission is to gather general feedback from the maintainers and then
> > Richard will do the actual testing, while I'll do the development.
> > 
> > This patch is should not have any impact beyond moving from request_firmware()
> > to request_firmware_nowait() and the involved code reshuffle.
> what are we achieving by moving to async ver of the firmware load ? MHI boot
> flow can not do anything until BHI load is over. Is the intention eventually
> to enable firmware fallback mechanism  and manually load the firmware ?

The goal is to provide the firehose bootloader (qcom/prog_firehose_sdx24.mbn)
via the firmware fallback mechanism when upgrading the firmware on the device
via the firehose protocol.

This bootloader firmware is not part of linux-firmware but provided as part of
each firmware update package, so it is not installed statically on the system.

I will extend the commit message with this information.

PS: The current patch is missing 'return' after calls to
'mhi_fw_load_finish()', this will be corrected in v2.
