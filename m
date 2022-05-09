Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1025207E1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 00:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiEIWlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 18:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiEIWkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:40:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E94E1F35FD;
        Mon,  9 May 2022 15:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PZmP1cM/c+8QGucBjjYm6BgXSDyzdF3V//pAMnScE4Q=; b=jNg3toyUZcapZZcG6PXU3WHgsC
        gwvC44L7AK2D/8EVuckSRBbyxGYZYFW0p/9EXQwoMMDaqqMtPwUFpO0Qr5Uh3A+MIO3wW+ZX2v1dE
        7qkaJ3OI/FycKPh5gXDsQt23E25SYM0GXiwaDKUho3mmbHjH4f/VRnmOFzKKuGii5ZgRrb+NAwgFJ
        srRnHUaji4kdrGBL+ajqB6Rb8cpysB//JlJz6C1u20+jmba71Jn8zLGCl9e05l3UUhIaKKpxDisSF
        aoRMGe5PsbJ5xOgiqGE14hg+Ojj7JGIzd6PywlDxZqi7O0yKeStX6ME0WCP6+w6+kuaz5olkuTavc
        89iVUi+A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noBzp-00GaoX-Ql; Mon, 09 May 2022 22:36:53 +0000
Date:   Mon, 9 May 2022 15:36:53 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] test_firmware: fix end of loop test in upload_read_show()
Message-ID: <YnmXhaSMqi5k7KV7@bombadil.infradead.org>
References: <YnOm+9tEN+xerpov@kili>
 <YnPFh6ULhhPloue2@bombadil.infradead.org>
 <20220505130251.GV4031@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505130251.GV4031@kadam>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 04:02:51PM +0300, Dan Carpenter wrote:
> The patch applies to today's, May 5, linux-next just fine but I think
> I need to re-write the commit message to make the bug more clear.

Odd not for me.

> On Thu, May 05, 2022 at 05:39:35AM -0700, Luis Chamberlain wrote:
> > On Thu, May 05, 2022 at 01:29:15PM +0300, Dan Carpenter wrote:
> > > If we iterate through a loop using list_for_each_entry() without
> > > hitting a break, then the iterator points to bogus memory.  The
> > > if (tst->name != test_fw_config->upload_name) { will likely still work
> > > but technically it's an out of bounds read.
> > > 
> > > Fixes: a31ad463b72d ("test_firmware: Add test support for firmware upload")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > >  lib/test_firmware.c | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/lib/test_firmware.c b/lib/test_firmware.c
> > > index 76115c1a2629..c82b65947ce6 100644
> > > --- a/lib/test_firmware.c
> > > +++ b/lib/test_firmware.c
> > > @@ -1392,7 +1392,8 @@ static ssize_t upload_read_show(struct device *dev,
> > >  				struct device_attribute *attr,
> > >  				char *buf)
> > >  {
> > > -	struct test_firmware_upload *tst;
> > > +	struct test_firmware_upload *tst = NULL;
> > > +	struct test_firmware_upload *tst_iter;
> > >  	int ret = -EINVAL;
> > >  
> > >  	if (!test_fw_config->upload_name) {
> > > @@ -1401,11 +1402,13 @@ static ssize_t upload_read_show(struct device *dev,
> > >  	}
> > >  
> > >  	mutex_lock(&test_fw_mutex);
> > 
> > Note the mutex lock.
> > 
> 
> This lock is fine.
> 
> > > -	list_for_each_entry(tst, &test_upload_list, node)
> > > -		if (tst->name == test_fw_config->upload_name)
> > > +	list_for_each_entry(tst_iter, &test_upload_list, node)
> > 
> > If a lock is held I can't see how the premise of this patch is
> > correct and we ensure we don't remove entries while holdingg
> > the lock.
> > 
> > Generalizing this problem seems like a bigger issue, no?
> > 
> 
> It has nothing to do with the look.  The problem is using the list
> iterator outside of the loop.

Ah the new infamous list iterator violation bug..

> > Additionally this patch doesn't apply at all on linux-next.
> > 
> >   Luis
> > 
> > > +		if (tst_iter->name == test_fw_config->upload_name) {
> > > +			tst = tst_iter;
> > >  			break;
> > > +		}
> > >  
> > > -	if (tst->name != test_fw_config->upload_name) {
> > > +	if (!tst) {
> 
> This test is reading out of bounds.  Another fix would be to write it
> as:
> 
> 	if (list_entry_is_head(tst, &test_upload_list, node)) {
> 
> But there is a desire to make it impossible to access the list iterator
> outside the loop.  Linus was drafting alternative list macros but I
> don't know the status of that.

Fine to get these fixes merged, but it would seem test firmware
would be low on the list of places to fix. Either way I'm happy
for this to go in.

Greg, want to pick it up?

  Luis
