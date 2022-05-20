Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4118C52EED2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350674AbiETPMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbiETPMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:12:39 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB58681486
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DCU1eFo64vWc74LnrC4FcNTQiLPBWC9vbq0vfSXCuPs=; b=l3Y4EyrZPsqeY66LZLal2zfQDS
        D50OTCxXQ7/RoNufIy9q/N3ZGn8rWGtrlhHY1Ac8ZgyAtXj2+rwhdi7vr3fDwdJbH2REHbJ4STdd5
        iKboWjGfbVEUpMpGp2Toy5QfM+Gt5zs5gkopCTeMbKRz5xm4KAn5UEtYjWw9K9nFKuc5uOHsPLoWr
        Wba5mM8ScJh0SINEsqaVXRPEBA6ruxyVhi4pL290m7fdcMFo+kwYcXtptSH1liMNT55Bn4m8gG3fR
        3fJ+zREC3l4x0iRJdawYw/NEPX7BVs4Ra1phgsIVdq2ly8Sph4ze9do00fyTJ2eZXUdX8P7BMCcTC
        tSKqNwJQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ns4Is-00Gcy7-QH; Fri, 20 May 2022 15:12:34 +0000
Date:   Fri, 20 May 2022 15:12:34 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] random: convert to using fops->read_iter()
Message-ID: <Yoev4rwdiB9pifYT@zeniv-ca.linux.org.uk>
References: <20220520094459.116240-1-Jason@zx2c4.com>
 <20220520094459.116240-2-Jason@zx2c4.com>
 <YoeZi94CpGW9LE/y@zx2c4.com>
 <35a5ff9f-79d7-feb5-dfa7-a775b9352416@kernel.dk>
 <YoeoLWTQ29bZCOFI@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoeoLWTQ29bZCOFI@zx2c4.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 04:39:41PM +0200, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Fri, May 20, 2022 at 08:36:17AM -0600, Jens Axboe wrote:
> > On 5/20/22 7:37 AM, Jason A. Donenfeld wrote:
> > > On Fri, May 20, 2022 at 11:44:57AM +0200, Jason A. Donenfeld wrote:
> > >>  const struct file_operations urandom_fops = {
> > >> -	.read = urandom_read,
> > >> +	.read_iter = urandom_read_iter,
> > > 
> > > One thing I noticed is that drivers/char/mem.c has both the .read and
> > > the .read_iter functions for /dev/zero and /dev/null and such. I wonder
> > > if the .read ones can be removed?
> > 
> > I'm not sure if we have a clear "always use this if available" set of
> > rules for this. Ideally we'd want it to be:
> > 
> > 1) Use ->read_iter() if available
> > 2) If not, use ->read()
> > 
> > Might require a bit of auditing to ensure that's the case, and if we
> > can say that it is, then we could clean that up too.
> 
> The only case I found where it wasn't in that order was:
> https://lore.kernel.org/lkml/20220520135103.166972-1-Jason@zx2c4.com/

See reply to another mail.  Again, we might be able to retire infinibarf,
but /dev/snd/pcm* is somewhat more entrenched.
