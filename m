Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16324C0307
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiBVUcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiBVUcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:32:01 -0500
Received: from relay.hostedemail.com (relay.hostedemail.com [64.99.140.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3307D1C906
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:31:34 -0800 (PST)
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 3921423112;
        Tue, 22 Feb 2022 20:31:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 212BE3E;
        Tue, 22 Feb 2022 20:31:31 +0000 (UTC)
Message-ID: <eef8db106e310e20faff4563580fa0eeb064d17b.camel@perches.com>
Subject: Re: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
From:   Joe Perches <joe@perches.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "colyli@suse.de" <colyli@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Date:   Tue, 22 Feb 2022 12:31:30 -0800
In-Reply-To: <65fd7d9525b443fcbb15468176fca16a@AcuMS.aculab.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
         <20220222163144.1782447-5-kbusch@kernel.org>
         <66a0c8210cf9e7dfcc3fa2d247de1eebd5a8acb7.camel@perches.com>
         <20220222165045.GA14168@lst.de>
         <20220222165613.GB1497257@dhcp-10-100-145-180.wdc.com>
         <603f9243bb9e1c4c50aaec83a527266b48ab9e20.camel@perches.com>
         <65fd7d9525b443fcbb15468176fca16a@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Stat-Signature: j6sb6dyjbjkt7oik85ducwufi81y7epk
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 212BE3E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19EtqwWf6kiHllY/BwsW7Y4xiMn/fz+NUI=
X-HE-Tag: 1645561891-809749
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-22 at 20:09 +0000, David Laight wrote:
> From: Joe Perches
> > Sent: 22 February 2022 18:43
> > 
> > On Tue, 2022-02-22 at 08:56 -0800, Keith Busch wrote:
> > > On Tue, Feb 22, 2022 at 05:50:45PM +0100, Christoph Hellwig wrote:
> > > > On Tue, Feb 22, 2022 at 08:45:53AM -0800, Joe Perches wrote:
> > > > > On Tue, 2022-02-22 at 08:31 -0800, Keith Busch wrote:
> > > > > > +/ *
> > > > > > + * lower_48_bits - return bits 0-47 of a number
> > > > > > + * @n: the number we're accessing
> > > > > > + */
> > > > > > +#define lower_48_bits(n) ((u64)((n) & 0xffffffffffffull))
> > > > > 
> > > > > why not make this a static inline function?
> > > > 
> > > > Agreed.
> > > 
> > > Sure, that sounds good to me. I only did it this way to match the
> > > existing local convention, but I personally prefer the inline function
> > > too.
> > 
> > The existing convention is used there to allow the compiler to
> > avoid warnings and unnecessary conversions of a u32 to a u64 when
> > shifting by 32 or more bits.
> > 
> > If it's possible to be used with an architecture dependent typedef
> > like dma_addr_t, then perhaps it's reasonable to do something like:
> > 
> > #define lower_48_bits(val)					\
> > ({								\
> > 	typeof(val) high = lower_16_bits(upper_32_bits(val));	\
> > 	typeof(val) low = lower_32_bits(val);			\
> > 								\
> > 	(high << 16 << 16) | low;				\
> > })
> > 
> > and have the compiler have the return value be an appropriate type.
> 
> The compiler could make a real pigs breakfast of that.

Both gcc and clang optimize it just fine.

btw: to return the same type the last line should be:

	(typeof(val))((high << 16 << 16) | low);

otherwise the return is sizeof(int) if typeof(val) is not u64

> Oh, did you look for GENMASK([^,]*,[ 0]*) ?

No, why?  I did look for 47, 0 though.

But it's pretty common really.

$ git grep -P 'GENMASK(?:_ULL)?\s*\(\s*\d+\s*,\s*0\s*\)' | wc -l
6233

> I'd only use something GENMASK() for bit ranges.
> Even then it is often easier to just write the value in hex.

Mostly it's the count of the repeated f that's difficult to
quickly verify visually.

> I think the only time I've written anything like that recently
> (last 30 years) was for some hardware registers when the documentation
> user 'bit 1' for the most significant bit.

Luckily the hardware I've had to deal with never did that.
Not even the least significant bit too.


