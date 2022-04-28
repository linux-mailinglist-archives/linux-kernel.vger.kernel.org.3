Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13828513732
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348530AbiD1OsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348517AbiD1OsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:48:05 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E606D3BF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:44:49 -0700 (PDT)
Date:   Thu, 28 Apr 2022 16:44:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1651157087;
        bh=1g8VE7azqFzzy065FworAEOOCfsdqNZvcvV19NCfaYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hmP6z0TnAhqP4V6qWw0EaMSba/ZbdeMGOnIcJerhHOgpwd+2rlft+wbi0T2B+zQ3f
         n0zyrr3suOZpW+PvJICdGGK0apKO0bpWTmNiXQdtJ9KCO7lWqnkKqOruGx0iQ2ymbe
         ortsdVhugui2YrCf1EN1N0sDQ+HQ7dQ/SAUO4oi4=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: fix host memory buffer allocation size
Message-ID: <5060d75e-46c0-4d29-a334-62c7e9714fa7@t-8ch.de>
References: <20220428101922.14216-1-linux@weissschuh.net>
 <20220428143603.GA20460@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220428143603.GA20460@lst.de>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-28 16:36+0200, Christoph Hellwig wrote:
> On Thu, Apr 28, 2022 at 12:19:22PM +0200, Thomas Weißschuh wrote:
> > We want to allocate the smallest possible amount of buffers with the
> > largest possible size (1 buffer of size "hmpre").
> > 
> > Previously we were allocating as many buffers as possible of the smallest
> > possible size.
> > This also lead to "hmpre" to not be satisifed as not enough buffer slots
> > where available.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > 
> > Also discussed at https://lore.kernel.org/linux-nvme/f94565db-f217-4a56-83c3-c6429807185c@t-8ch.de/
> > 
> >  drivers/nvme/host/pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 3aacf1c0d5a5..0546523cc20b 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2090,7 +2090,7 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
> >  
> >  static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
> >  {
> > -	u64 min_chunk = min_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PAGES);
> > +	u64 min_chunk = max_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PAGES);
> 
> preferred is based on the HMPRE field in the spec, which documents the
> preffered size.  So the max here would not make ny sense at all.

Is the current code supposed to reach HMPRE? It does not for me.

The code tries to allocate memory for HMPRE in chunks.
The best allocation would be to allocate one chunk for all of HMPRE.
If this fails we half the chunk size on each iteration and try again.

On my hardware we start with a chunk_size of 4MiB and just allocate
8 (hmmaxd) * 4 = 32 MiB which is worse than 1 * 200MiB.

What am I missing?
