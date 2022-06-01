Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48FF53AB8D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356249AbiFARI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244187AbiFARIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:08:53 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D86A5D648
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 10:08:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 46DDE68AA6; Wed,  1 Jun 2022 19:08:48 +0200 (CEST)
Date:   Wed, 1 Jun 2022 19:08:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Caroline Subramoney <Caroline.Subramoney@microsoft.com>,
        Richard Wurdack <riwurd@microsoft.com>,
        Nathan Obr <Nathan.Obr@microsoft.com>
Subject: Re: [PATCH 2/2] nvme-pci: handle persistent internal error AER
 from NVMe controller
Message-ID: <20220601170847.GA27165@lst.de>
References: <1654056747-40143-1-git-send-email-mikelley@microsoft.com> <1654056747-40143-2-git-send-email-mikelley@microsoft.com> <20220601073505.GA24875@lst.de> <PH0PR21MB302599C693F0A48F3777008ED7DF9@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB302599C693F0A48F3777008ED7DF9@PH0PR21MB3025.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 03:56:59PM +0000, Michael Kelley (LINUX) wrote:
> If there is a persistent error that does a controller reset, it looks
> like we should *not* queue async_event_work at the end of
> nvme_complete_async_event().  The controller reset will
> submit an AER on the admin queue, and so presumably
> we don't want nvme_async_event_work() to also try to submit
> another AER, which may or may not succeed depending on the
> timing of when the controller state shows LIVE again.
> Agreed?

Yes, that makes sense.  I guess we can just check the return value
from nvme_reset_ctrl and propagate this to nvme_async_event_work
and skip the rearming for that case.
