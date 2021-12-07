Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A24746B801
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhLGJyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbhLGJyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:54:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7D7C0698CC;
        Tue,  7 Dec 2021 01:51:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5830CCE1A2A;
        Tue,  7 Dec 2021 09:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0365AC341C1;
        Tue,  7 Dec 2021 09:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638870667;
        bh=t0UaL5ptrXo0DEWrnydiPDnfduthGVFkCZnCDXLVv54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x6kq6j8zv0tB+CddNhxmP62n1huZ8A22s0Mpld4jQzw9LJ5VG8qjkSQ2hFkKMXgdA
         PCC18DHlCTINQPrkhWYXheeeQfMRH7kSx+GETTJE0O+TFOnnmABhRk69vkCYdnI1gf
         ErCKwgAPOGycirNbsTMxCab+GWVlICwSA3mQkxxo=
Date:   Tue, 7 Dec 2021 10:51:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Huijin Park <huijin.park@samsung.com>,
        Yue Hu <huyue2@yulong.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Christian =?iso-8859-1?Q?L=F6hle?= <CLoehle@hyperstone.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: core: Add support for the eMMC RTC feature in
 mmc_ops
Message-ID: <Ya8uiOq3MGGKRB5n@kroah.com>
References: <20211205191009.32454-1-nishadkamdar@gmail.com>
 <DM6PR04MB657527FCF325EA9760032DA5FC6E9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <20211207093009.GA11794@nishad>
 <DM6PR04MB6575BF4FC2DE49885D0EEDF0FC6E9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <20211207094304.GA11969@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207094304.GA11969@nishad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 03:13:08PM +0530, Nishad Kamdar wrote:
> On Tue, Dec 07, 2021 at 09:33:46AM +0000, Avri Altman wrote:
> > > On Tue, Dec 07, 2021 at 08:28:42AM +0000, Avri Altman wrote:
> > > >
> > > > > This patch adds support to set the RTC information in the eMMC
> > > > > device. This is based on the JEDEC specification.
> > > > >
> > > > > There is no way however, to read the RTC time from the device. Hence
> > > > > we rely on the response of the CMD49 to confirm the completion of
> > > > > the operation.
> > > > >
> > > > > This patch has been tested successfully with the ioctl interface.
> > > > > This patch has also been tested suceessfully with all the three
> > > > > RTC_INFO_TYPEs.
> > > > If this is triggered from user-space via ioctl anyway, Why do we need
> > > > this command to be implemented in the kernel?
> > > > Why not just add this to mmc-utils?
> > > >
> > > > Thanks,
> > > > Avri
> > > As per the spec, B51: Section 6.6.35:
> > > Providing RTC info may be useful for internal maintainance operations.
> > > And the host should send it on the following events:
> > > - power-up
> > > - wake-up
> > > - Periodically
> > > Hence IMO, the Kernel would be the right place of peforming this operation.
> > But your patch doesn't do that, is it?
> >
> Yes, That's because this operation may be device specific. In order to know when
> to call this function may require eMMC firmware info.
> This patch only adds support so that if the info is made available
> in the future, a separate patch can be added to introduce the calling mechanism.

We do not add code that is not actually used in the kernel tree.

Please submit a user of this new function, otherwise there is no need
for it at all.

thanks,

greg k-h
