Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41295568F42
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbiGFQem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbiGFQek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:34:40 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1121C1581C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 09:34:39 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id ABB1E68BEB; Wed,  6 Jul 2022 18:34:34 +0200 (CEST)
Date:   Wed, 6 Jul 2022 18:34:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, John Garry <john.garry@huawei.com>,
        axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Fix nvme_setup_command metadata trace event for
 cdw10
Message-ID: <20220706163434.GA2222@lst.de>
References: <1657095398-114310-1-git-send-email-john.garry@huawei.com> <YsW0orMaDFfrHbx+@kbusch-mbp.dhcp.thefacebook.com> <20220706161825.GA1962@lst.de> <YsW3oXcCe6/y6iRb@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsW3oXcCe6/y6iRb@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 10:26:09AM -0600, Keith Busch wrote:
> On Wed, Jul 06, 2022 at 06:18:25PM +0200, Christoph Hellwig wrote:
> > On Wed, Jul 06, 2022 at 10:13:22AM -0600, Keith Busch wrote:
> > > Did you test what the trace looks like afte this? We're losing valuable trace
> > > data here. The field is supposed to get CDW's 10 - 15, so that's 24 bytes. I
> > > don't know why it cares that the address of the field being read is only 4
> > > bytes; we want everything that comes after it too.
> > 
> > Because accesses should not spawn boundaries of members in structs unless
> > copying the entire struct.  If we want to trace the various fields we
> > need to individually assign them.
> > 
> > Anyway, I'm dropping this patch from nvme-5.19 for now to let the
> > discussion conclude.
> 
> How about this instead?

Maybe a better option would be to use struct_group().
