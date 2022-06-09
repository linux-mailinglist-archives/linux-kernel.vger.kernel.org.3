Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C845447C1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240752AbiFIJjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242775AbiFIJjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:39:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444B73A724
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:38:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E50D2B82C94
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 09:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CE7C34114;
        Thu,  9 Jun 2022 09:38:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KWO6SD/+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654767533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XLQ8mMO0hzeJi8rzxsf9luStKEDEI8Zafy1QgR2AB2A=;
        b=KWO6SD/+lFHS9/dt8B1qD6KGi1uc18TwUSdHr8x8fDXwydBzf8WzB7SrX2t2wQPHZ7u2ig
        AwGmSU7A2YIpKbZTIRhmrT/3mDj0D/9tuVIaUYdc8zhps4iSGZJu9jUPR+h8IrTQYzwMxl
        vU6uRNynWcY3WJIJnd5zo7rUxOPcgHc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d6f35694 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 9 Jun 2022 09:38:53 +0000 (UTC)
Date:   Thu, 9 Jun 2022 11:38:47 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "R, Monish Kumar" <monish.kumar.r@intel.com>
Cc:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "alan.adamson@oracle.com" <alan.adamson@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>,
        Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        "Rao, Abhijeet" <abhijeet.rao@intel.com>
Subject: Re: 2 second nvme initialization delay regression in 5.18 [Was: Re:
 [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
 observed during blktests]
Message-ID: <YqG/pybFg0P5yQ9a@zx2c4.com>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <Ykyf5Zuz1W8yHhNY@zx2c4.com>
 <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com>
 <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com>
 <SA2PR11MB5115DCE45778910C96813CA1C3A79@SA2PR11MB5115.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SA2PR11MB5115DCE45778910C96813CA1C3A79@SA2PR11MB5115.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Monish,

On Thu, Jun 09, 2022 at 09:32:02AM +0000, R, Monish Kumar wrote:
> Hi Jason,
> 
> I would like to provide justification for this Samsung X5 SSD fix added.
> We were facing SSD enumeration issue after cold / warm reboot with device 
> connected ends up with probe failures.
> 
> When I debug on this issue, I could find that this device was not enumerating 
> once the system got booted. Moreover, we were facing this enumeration issue
> specific to this device. 
> 
> Based on analysis, due to deep power state of the device fails to enumerate.
> So, added the following quirks as a workaround fixe and it helps to enumerate the device after cold/warm reboot. If new Samsung X5 SSD's are working fine as expected, we can remove those 
> fix. 

FWIW, all of that should have been in the commit message. Also, "based
on analysis" - what analysis exactly? I have no way of thinking more
about the issue at hand other than, "Monish said things are like this in
a lab".

In any case, I believe the 970 ID predates that of the X5, and
destroying battery on those laptops and introducing boot time delays
isn't really okay. So let's just revert this until somebody can work out
better how to differentiate drives that need a quirk from drives that
don't need a quirk.

I sent this in: https://lore.kernel.org/lkml/20220609084051.4445-1-Jason@zx2c4.com/

Jason
