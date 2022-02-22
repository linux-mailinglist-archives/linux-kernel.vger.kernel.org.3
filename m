Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDCC4BFF7F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbiBVQ72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbiBVQ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:59:27 -0500
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5830916C4D8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:59:00 -0800 (PST)
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id B256D120966;
        Tue, 22 Feb 2022 16:58:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id DCE9720028;
        Tue, 22 Feb 2022 16:58:56 +0000 (UTC)
Message-ID: <38d356c2ea0cd9c8cec1e6377793b5c465eca889.camel@perches.com>
Subject: Re: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
From:   Joe Perches <joe@perches.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, colyli@suse.de,
        Bart Van Assche <bvanassche@acm.org>
Date:   Tue, 22 Feb 2022 08:58:56 -0800
In-Reply-To: <20220222165045.GA14168@lst.de>
References: <20220222163144.1782447-1-kbusch@kernel.org>
         <20220222163144.1782447-5-kbusch@kernel.org>
         <66a0c8210cf9e7dfcc3fa2d247de1eebd5a8acb7.camel@perches.com>
         <20220222165045.GA14168@lst.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: DCE9720028
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Stat-Signature: bk4jafjtuowkr7tuxqe1os9d7x7ekmx4
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX187kE9xU/fonTPBMMbSmL7JTFcT++IlEDc=
X-HE-Tag: 1645549136-753137
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-22 at 17:50 +0100, Christoph Hellwig wrote:
> On Tue, Feb 22, 2022 at 08:45:53AM -0800, Joe Perches wrote:
> > On Tue, 2022-02-22 at 08:31 -0800, Keith Busch wrote:
> > > Recent data integrity field enhancements allow 48-bit reference tags.
> > > Introduce a helper macro since this will be a repeated operation.
> > []
> > > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > []
> > > @@ -63,6 +63,12 @@
> > >  }					\
> > >  )
> > >  
> > > +/**
> > > + * lower_48_bits - return bits 0-47 of a number
> > > + * @n: the number we're accessing
> > > + */
> > > +#define lower_48_bits(n) ((u64)((n) & 0xffffffffffffull))
> > 
> > why not make this a static inline function?
> 
> Agreed.
> 
> > And visually, it's difficult to quickly count a repeated character to 12.
> > 
> > Perhaps:
> > 
> > static inline u64 lower_48_bits(u64 val)
> > {
> > 	return val & GENMASK_ULL(47, 0);
> > }
> 
> For anyone who has a minimum knowledge of C and hardware your version
> is an obsfucated clusterfuck, while the version Keith wrote is
> trivial to read.

Don't think so.  I've dealt with hardware and have more than once
seen defects introduced by firmware developers that can't count.

be quick, which one is it:

	0xfffffffffffULL
or
	0xffffffffffffULL
or
	0xfffffffffffffULL
or
	0xffffffffffffffULL



