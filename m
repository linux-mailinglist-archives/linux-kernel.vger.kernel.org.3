Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2110551396A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349303AbiD1QM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiD1QM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:12:27 -0400
X-Greylist: delayed 20983 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Apr 2022 09:09:12 PDT
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FB64A3E0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:09:12 -0700 (PDT)
Date:   Thu, 28 Apr 2022 18:09:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1651162151;
        bh=EFIxJKLXRND1+RqQt43Rt2lySMTfl9maJOfaKECS52E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LSPywKfczIqIU5RFrDA+zcwxNzF9vfVLeaZAoggwkKgC/w8NPn92Igcqvupp4iLVl
         3zvapYjzdZ8PtOY/FeJDohJxFgYpaemZV+7c27hwuw4jXfx+bcdcqR1TQvyrdp3C2D
         uw2VnGKYlScHzfH2D1JmOs1tnB92ZTE6vHTr3Xpk=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: fix host memory buffer allocation size
Message-ID: <676c02ef-4bbc-43f3-b3e6-27a7d353f974@t-8ch.de>
References: <20220428101922.14216-1-linux@weissschuh.net>
 <20220428143603.GA20460@lst.de>
 <5060d75e-46c0-4d29-a334-62c7e9714fa7@t-8ch.de>
 <20220428150644.GA22685@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220428150644.GA22685@lst.de>
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

On 2022-04-28 17:06+0200, Christoph Hellwig wrote:
> On Thu, Apr 28, 2022 at 04:44:47PM +0200, Thomas Weißschuh wrote:
> > Is the current code supposed to reach HMPRE? It does not for me.
> > 
> > The code tries to allocate memory for HMPRE in chunks.
> > The best allocation would be to allocate one chunk for all of HMPRE.
> > If this fails we half the chunk size on each iteration and try again.
> > 
> > On my hardware we start with a chunk_size of 4MiB and just allocate
> > 8 (hmmaxd) * 4 = 32 MiB which is worse than 1 * 200MiB.
> 
> And that is because the hardware only has a limited set of descriptors.

Wouldn't it make more sense then to allocate as much memory as possible for
each descriptor that is available?

The comment in nvme_alloc_host_mem() tries to "start big".
But it actually starts with at most 4MiB.

And on devices that have hmminds > 4MiB the loop condition will never succeed
at all and HMB will not be used.
My fairly boring hardware already is at a hmminds of 3.3MiB.

> Is there any real problem you are fixing with this?  Do you actually
> see a performance difference on a relevant workload?

I don't have a concrete problem or performance issue.
During some debugging I stumbled in my kernel logs upon
"nvme nvme0: allocated 32 MiB host memory buffer"
and investigated why it was so low.
