Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F0E4D42B9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240425AbiCJIjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiCJIjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:39:15 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C69131F50
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:38:15 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DEB3468AFE; Thu, 10 Mar 2022 09:38:11 +0100 (CET)
Date:   Thu, 10 Mar 2022 09:38:11 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mingbao Sun <sunmingbao@tom.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
        libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 1/2] nvmet-tcp: support specifying the
 congestion-control
Message-ID: <20220310083811.GA26953@lst.de>
References: <20220309053711.2561-1-sunmingbao@tom.com> <20220309061541.GB31316@lst.de> <20220309175203.00006ee2@tom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220309175203.00006ee2@tom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 05:52:03PM +0800, Mingbao Sun wrote:
> On Wed, 9 Mar 2022 07:15:41 +0100
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > On Wed, Mar 09, 2022 at 01:37:11PM +0800, Mingbao Sun wrote:
> > > +		if (port->nport->tcp_congestion) {
> > > +			icsk_new = inet_csk(newsock->sk);
> > > +			if (icsk_new->icsk_ca_ops != icsk->icsk_ca_ops) {
> > > +				pr_warn("congestion abnormal: expected %s, actual %s.\n",
> > > +					icsk->icsk_ca_ops->name,
> > > +					icsk_new->icsk_ca_ops->name);
> > > +			}
> > > +		}  
> > 
> > What is the point of having this code?
> 
> Well, this could happen in certain circumstances.
> Take the result from my test as an example:
> 
>     - The congestion of the listening socket of the target was set to
>       ‘dctcp’.
> 
>     - But the congestion of the socket of the host side was set to
>       ‘cubic’.
> 
>     - Then the congestion of the socket of the new connection at the
>       target side would automatically be altered to ‘dctcp-reno’.
> 
> In case tcp_congestion was explicitly set for the target, it can be
> supposed that the user attaches great importance to performance.
> So we’d better make the users aware that the system is not working
> in the way they expect. 

A warning message really seems very severe for a condition like this.
Maybe the better interface is a way to figure out which congestion
control algorithm is in use by reading a sysfs file.
