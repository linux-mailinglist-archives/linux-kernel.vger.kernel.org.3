Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93F74BFF3D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbiBVQvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiBVQvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:51:15 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D2716AA45;
        Tue, 22 Feb 2022 08:50:50 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A920368B05; Tue, 22 Feb 2022 17:50:45 +0100 (CET)
Date:   Tue, 22 Feb 2022 17:50:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Joe Perches <joe@perches.com>
Cc:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk,
        hch@lst.de, martin.petersen@oracle.com, colyli@suse.de,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
Message-ID: <20220222165045.GA14168@lst.de>
References: <20220222163144.1782447-1-kbusch@kernel.org> <20220222163144.1782447-5-kbusch@kernel.org> <66a0c8210cf9e7dfcc3fa2d247de1eebd5a8acb7.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66a0c8210cf9e7dfcc3fa2d247de1eebd5a8acb7.camel@perches.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 08:45:53AM -0800, Joe Perches wrote:
> On Tue, 2022-02-22 at 08:31 -0800, Keith Busch wrote:
> > Recent data integrity field enhancements allow 48-bit reference tags.
> > Introduce a helper macro since this will be a repeated operation.
> []
> > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> []
> > @@ -63,6 +63,12 @@
> >  }					\
> >  )
> >  
> > +/**
> > + * lower_48_bits - return bits 0-47 of a number
> > + * @n: the number we're accessing
> > + */
> > +#define lower_48_bits(n) ((u64)((n) & 0xffffffffffffull))
> 
> why not make this a static inline function?

Agreed.

> And visually, it's difficult to quickly count a repeated character to 12.
> 
> Perhaps:
> 
> static inline u64 lower_48_bits(u64 val)
> {
> 	return val & GENMASK_ULL(47, 0);
> }

For anyone who has a minimum knowledge of C and hardware your version
is an obsfucated clusterfuck, while the version Keith wrote is trivial
to read.
