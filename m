Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A8B545C22
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 08:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346409AbiFJGO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 02:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbiFJGOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 02:14:55 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C87922ABFE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 23:14:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4293467373; Fri, 10 Jun 2022 08:14:50 +0200 (CEST)
Date:   Fri, 10 Jun 2022 08:14:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "R, Monish Kumar" <monish.kumar.r@intel.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "alan.adamson@oracle.com" <alan.adamson@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>,
        Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        "Rao, Abhijeet" <abhijeet.rao@intel.com>
Subject: Re: 2 second nvme initialization delay regression in 5.18 [Was:
 Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests]
Message-ID: <20220610061449.GD24331@lst.de>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com> <Ykyf5Zuz1W8yHhNY@zx2c4.com> <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com> <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com> <SA2PR11MB5115DCE45778910C96813CA1C3A79@SA2PR11MB5115.namprd11.prod.outlook.com> <YqG/pybFg0P5yQ9a@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqG/pybFg0P5yQ9a@zx2c4.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 11:38:47AM +0200, Jason A. Donenfeld wrote:
> FWIW, all of that should have been in the commit message. Also, "based
> on analysis" - what analysis exactly? I have no way of thinking more
> about the issue at hand other than, "Monish said things are like this in
> a lab".

Please calm down a bit.  His report is at least as good as your new
report here..

> In any case, I believe the 970 ID predates that of the X5, and

Huh?

The 970 seems to actually be very slightly newer than the X5.  What
I suspect is that they actually are the same m.2 SSD or at least a
very similar one and Samsung decided to ship it in the thunderbolt
attached versions first.  Maybe one of the Samsung folks here can
confirm.

That leaves us with two plausible theories:

 - the problems could be due to an earlier firmware version or
   ASIC stepping
 - the problems are due to the thunderbolt attachment

Monish and Jason, can you please send me the output of nvme id-ctrl
/dev/nvmeX (where /dev/nvmeX is the actual device number)?

Monish, can you check if you are using the latest available firmware
and if not update it and check if you still need the quirks.


> destroying battery on those laptops and introducing boot time delays
> isn't really okay. So let's just revert this until somebody can work out
> better how to differentiate drives that need a quirk from drives that
> don't need a quirk.

While I'd really like to fix those issue, they are less severe than
not being able to use a device at all.  And just as a reminder: if you
want to get anything please be nice to people and try work with them
productively.
