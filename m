Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD3B588460
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbiHBWiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbiHBWhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:37:52 -0400
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7D217AA1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 15:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2671; q=dns/txt; s=iport;
  t=1659479871; x=1660689471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pKOnt7OBLC0Sl5DxaQljA8KzE5uazBS88utyntub/94=;
  b=T/0olTYMBocamuzarv239CBUCc348lWE6wE5vSXDGzHs6JU7CkaBRvWS
   gBPbP3gTk94gvsqpbjnyzhU7kcpRbrzh6/v41vcLWRg0xK/OnUiZ8yhOq
   b/l3g1sXZqLIs4eGiFmU3Cjugm90xYmTLJo4u6JbMi1fsmhGcvfPC7Rkc
   8=;
X-IronPort-AV: E=Sophos;i="5.91,230,1647302400"; 
   d="scan'208";a="782774020"
Received: from rcdn-core-2.cisco.com ([173.37.93.153])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 02 Aug 2022 22:37:50 +0000
Received: from zorba (sjc-vpn6-436.cisco.com [10.21.121.180])
        by rcdn-core-2.cisco.com (8.15.2/8.15.2) with ESMTPS id 272Mblld013996
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Aug 2022 22:37:49 GMT
Date:   Tue, 2 Aug 2022 15:37:47 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        George Cherian <george.cherian@marvell.com>,
        sgoutham@marvell.com, "BOBBY Liu (bobbliu)" <bobbliu@cisco.com>,
        xe-linux-external@cisco.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq: allow selection of number of sparse irqs
Message-ID: <20220802223747.GX821407@zorba>
References: <20220728030420.2279713-1-danielwa@cisco.com>
 <980a561ed87c5530aab2e2b067074862@kernel.org>
 <20220729182156.GS821407@zorba>
 <87wnbuc45y.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnbuc45y.wl-maz@kernel.org>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.21.121.180, sjc-vpn6-436.cisco.com
X-Outbound-Node: rcdn-core-2.cisco.com
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 10:59:05AM +0100, Marc Zyngier wrote:
> > 
> > Marvell submitted a similar change, but non-selectable, about a
> > month ago.
> 
> Which wasn't really acceptable either.
> 
> > 
> > The limitation prevents Cisco and Marvell hardware from
> > functioning. I don't think we're well versed enough on the generic
> > irq system to implement what your suggesting, even if we did Thomas
> > would not likely accept it.
> 
> I don't think you can speak for Thomas here. In my experience of
> working with him, he's in general much more inclined to look at a
> scalable, long term solution than at a point hack. Specially given
> that we already use xarrays for MSIs.
 
Your welcome make the attempt yourself, if you believe in it.

> > Your suggestion is more of a long term solution vs. our short term
> > solution.
> 
> Exactly. Experience shows that short term hacks are almost always a
> bad idea and result in something that isn't maintainable.

Thomas introduced the "hack" in c1ee626 in 2011.

It's more of a question of if someone has the time an and/or inclination to make the changes
your requesting.

Marvell and Cisco only require to increase the size and keep the status quo, and
nothing is wrong with that.

> > I'm not wedded to any solution, we just need to relieve
> > the limitation so our hardware starts working. I would imagine other
> > companies have this issue, but I don't know which ones currently.
> 
> This architecture has been in the wild for the best part of 10 years,
> in Linux for 8 years, and nobody so far screamed because of this
> perceived limitation. It would help if you described exactly what
> breaks in your system, because just saying "give me more" is not
> exactly helping (there are other limitations in the GICv3 ITS driver
> that may bite you anyway).

We need more irq lines because we have a lot of devices.. I suppose it's
possible there's some defect in the kernel which eats up or wastes irq lines,
but I don't think so. We have devices which use a lot of irq lines.

> > I would rather to use an upstream solution verses holding the
> > patches privately.  I would suggest if this limitation would not be
> > overcome for 3-4 releases the short term solution should be
> > acceptable over that time frame to be replaced by something else
> > after that.
> 
> If you want to have an impact on the features being merged in the
> upstream kernel, a good start would be to take feedback on board.

We did that.. I updated the patch from Marvell's original to allow it to be
selectable, this was requested by someone on this list.


Daniel
