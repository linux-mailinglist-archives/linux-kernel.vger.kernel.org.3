Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6544D10C1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344516AbiCHHNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344514AbiCHHN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:13:29 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E803630C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 23:12:32 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AA5B668AFE; Tue,  8 Mar 2022 08:12:27 +0100 (CET)
Date:   Tue, 8 Mar 2022 08:12:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mingbao Sun <sunmingbao@tom.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
        libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH 2/2] nvme-tcp: support specifying the congestion-control
Message-ID: <20220308071227.GB24575@lst.de>
References: <20220304092754.2721-1-sunmingbao@tom.com> <20220304092754.2721-3-sunmingbao@tom.com> <20220304162032.GA12250@lst.de> <20220305150915.00006b44@tom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305150915.00006b44@tom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 03:09:15PM +0800, Mingbao Sun wrote:
> Well, actually I did have thought whether the calling of network API
> here is proper. Since I did find that there is no call to APIs of
> PCI/RDMA/TCP in fabrics.c.

Yes - for a good reason.  Without networking support your patch won't
even compile (both the host and target side).

> But I hope the following could make a defense for it:
> 
> Anyway, we need to validate the tcp_congestion passed in from
> user-space, right?

Do we?  It seems like no one else really calls this routine to verify
things.  In fact it has no modular users at all in the current tree.

> The role of nvmf_parse_options is similar to that of
> drivers/nvme/target/configfs.c from the target side.
> And both of them can not avoid handling specific options of the
> sub-classes (e.g., NVMF_OPT_HDR_DIGEST, NVMF_OPT_TOS, NVMF_OPT_KATO).

NVMF_OPT_KATO is completely generic, but yes, there other two are
transport specific.  None of them calls out into other modules
that would need dependecies, though.

I'm also a little concerned that no other in kernel user like iSCSI,
NBD or NFS has any code like this.
