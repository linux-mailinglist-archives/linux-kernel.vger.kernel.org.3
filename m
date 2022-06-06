Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724C453E21B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiFFGwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 02:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiFFGvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 02:51:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9ECD9EBF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 23:51:07 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6555868AA6; Mon,  6 Jun 2022 08:51:03 +0200 (CEST)
Date:   Mon, 6 Jun 2022 08:51:02 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Caroline Subramoney <Caroline.Subramoney@microsoft.com>,
        Richard Wurdack <riwurd@microsoft.com>,
        Nathan Obr <Nathan.Obr@microsoft.com>
Subject: Re: [PATCH v2 2/2] nvme: handle persistent internal error AER from
 NVMe controller
Message-ID: <20220606065102.GA2551@lst.de>
References: <1654278961-81423-1-git-send-email-mikelley@microsoft.com> <1654278961-81423-2-git-send-email-mikelley@microsoft.com> <Yppfm5n41NEcrRlU@kbusch-mbp.dhcp.thefacebook.com> <PH0PR21MB3025781A702070304BB8A282D7A09@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB3025781A702070304BB8A282D7A09@PH0PR21MB3025.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2022 at 02:28:11PM +0000, Michael Kelley (LINUX) wrote:
> > driver's irq handler. The other transports block on register reads, though, so
> > they can't call this from an atomic context. The TCP context looks safe, but
> > I'm not sure about RDMA or FC.
> 
> Good point.  But even if the RDMA and FC contexts are safe,

For RDMA this is typically called from softirq context, so it is indeed
not save.

> if a
> persistent error is reported, the controller is already in trouble and
> may not respond to a request to retrieve the CSTS anyway.  Perhaps
> we should just trust the AER error report and not bother checking
> CSTS to decide whether to do the reset.  We can still check ctrl->state
> and skip the reset if there's already one in progress.

Yes, that might be a better option.
