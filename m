Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A294C4D18
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiBYR7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiBYR7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:59:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97121C65C8;
        Fri, 25 Feb 2022 09:59:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4855E61E09;
        Fri, 25 Feb 2022 17:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0965C340E7;
        Fri, 25 Feb 2022 17:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645811946;
        bh=tqc87Jy4ydsthmHNaKwH8I98BKpZjOMSiFRz9wHyYgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kFKp/oDX2779xseQ5UvOePNjeNUSgFLuUU5hKUewA+RYdKtMOqBNiDyBWzdthk6UN
         YzXFA6KqQ/ufXCaSrEkdfVgAGviykqebdaMckEyqVxpmCkxAmD9NDlwmk0Sv8DXF7c
         Bpxjd3w8yH8zXTCI4u4n5H94XuU5Ijjy8OxSWN2etguwPI93ao+pT6bL1occl1L5Je
         JMQGvk9mB0+HBDKNgyPK9yIXbqBglj5r1BnmjxSidOcT2Nc/LDiyUbY1wl2Va+KKZA
         uxl3Vyc6rRoO9dv6ZGZDzCbsz+BSQdtHA9f3/NMtqtle2V9Kj1VIAm+8Yo0wJCmUTd
         iHKOP5pnfyOOg==
Date:   Fri, 25 Feb 2022 09:59:03 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, colyli@suse.de,
        Hannes Reinecke <hare@suse.de>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv3 03/10] asm-generic: introduce be48 unaligned accessors
Message-ID: <20220225175903.GC4111669@dhcp-10-100-145-180.wdc.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-4-kbusch@kernel.org>
 <20220225160300.GC13610@lst.de>
 <cc8405c39037d1b63df3d901051118f9b12c36a9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc8405c39037d1b63df3d901051118f9b12c36a9.camel@perches.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 09:53:11AM -0800, Joe Perches wrote:
> On Fri, 2022-02-25 at 17:03 +0100, Christoph Hellwig wrote:
> > On Tue, Feb 22, 2022 at 08:31:37AM -0800, Keith Busch wrote:
> > > The NVMe protocol extended the data integrity fields with unaligned
> > > 48-bit reference tags. Provide some helper accessors in
> > > preparation for these.
> > > 
> > > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > > Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > 
> > Looks good,
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Perhaps for completeness this should also add the le48 variants
> like the 24 bit accessors above this.

I don't know of a user for le48 at this time, and kernel API's without
users often get culled. If you think it's useful, though, I can
certainly include it.
