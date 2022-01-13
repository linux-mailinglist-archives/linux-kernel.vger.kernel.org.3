Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B4048DB6B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiAMQMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiAMQMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:12:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE98C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:12:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C310B82306
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 16:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21243C36AE9;
        Thu, 13 Jan 2022 16:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642090326;
        bh=SQFiun4HMi3NoKxRPK5MZUTzjs+vR/1xr6gxlZEfcKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bFzsTSTeZHzrmob/gtWHRtKQ8UUKLFK3QhJzrCCCo87Zz0D9RAFCpxOaMUkGkOZP1
         WKqCVxKQZx+/RjUUn55+061YOfSKuWYxc0EUdULTKGevPvbUfFT3EbUGZtCufTWW1e
         bm3XiEs0/j3wdaM1Fe75dlP4Uxyzgesa9GdLf3lGFcso+PRS2PocXg0F6m6h9H2/+v
         GZdL1DH4jFXxrUEUCsSHcoFzvqLFOCOVpEuq4XCy2ZMt0nkoDZOw09657wEw5SkJTS
         9ebD/uWEWQ35wKVPjQQehN9gO6LgntQESc1yS/XY6PoN01heFwPT1hQFH0CHt2QwH/
         ywwbaVNJqIixA==
Date:   Thu, 13 Jan 2022 08:12:04 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@fb.com, sagi@grimberg.me,
        Rajat Jain <rajatja@google.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Mark external NVMe devices as removable
Message-ID: <20220113161204.GA3230285@dhcp-10-100-145-180.wdc.com>
References: <20220112013154.1210480-1-kai.heng.feng@canonical.com>
 <20220112071659.GA4502@lst.de>
 <CAAd53p4+WjhPM6VKZOZKQ4WcgNWjR7Eh_7Kjs1HZ_wiKov6Ctw@mail.gmail.com>
 <20220112140304.GA27446@lst.de>
 <CAAd53p5Qo3+-sXMLLPxe3ckY4ySxRvaLZkv=0zgKc=EVun9uYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p5Qo3+-sXMLLPxe3ckY4ySxRvaLZkv=0zgKc=EVun9uYg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 02:39:02PM +0800, Kai-Heng Feng wrote:
> On Wed, Jan 12, 2022 at 10:03 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Jan 12, 2022 at 08:50:33PM +0800, Kai-Heng Feng wrote:
> > > USB thumb drives also use this flag, so I am not sure why it's not
> > > applicable to NVMe?
> >
> > They shouldn't report this flag and might need fixing.
> 
> So what should we do? Introduce a different flag but with identical
> usage for external USB and NVMe storages?

What's the user visible result with this flag set? Does some rule
automatically mount a 'removable' block device's filesystem partitions
to something like /media/?
