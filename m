Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8C15137C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348802AbiD1PKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348803AbiD1PKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:10:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E8C2982F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:06:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C4C5368AFE; Thu, 28 Apr 2022 17:06:45 +0200 (CEST)
Date:   Thu, 28 Apr 2022 17:06:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: fix host memory buffer allocation size
Message-ID: <20220428150644.GA22685@lst.de>
References: <20220428101922.14216-1-linux@weissschuh.net> <20220428143603.GA20460@lst.de> <5060d75e-46c0-4d29-a334-62c7e9714fa7@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5060d75e-46c0-4d29-a334-62c7e9714fa7@t-8ch.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 04:44:47PM +0200, Thomas Weißschuh wrote:
> Is the current code supposed to reach HMPRE? It does not for me.
> 
> The code tries to allocate memory for HMPRE in chunks.
> The best allocation would be to allocate one chunk for all of HMPRE.
> If this fails we half the chunk size on each iteration and try again.
> 
> On my hardware we start with a chunk_size of 4MiB and just allocate
> 8 (hmmaxd) * 4 = 32 MiB which is worse than 1 * 200MiB.

And that is because the hardware only has a limited set of descriptors.

Is there any real problem you are fixing with this?  Do you actually
see a performance difference on a relevant workload?
