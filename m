Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4204C42D7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239855AbiBYKyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236075AbiBYKya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:54:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B02B1EC9A8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:53:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 46E31CE2422
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E42FC340E7;
        Fri, 25 Feb 2022 10:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645786433;
        bh=V9HC6maBITJsYGjeRbRYJvQwDUtea5/9NndwPNtph9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PPfMUVoQAoZ6DkUN1cwIOpxpWcyikjuQ1xMCucG64DtT5qaN/H8zNAyQGO37aQrpI
         IV2eGko0BZh8sBPPezCjnnKKtOxLs4/W7H54RqdvL4FQpQy7j+lxs5pPVcGNd13JAB
         RBZpV8ME4zpV2SHp0bwaFjwO0Z9P6G7r54w4wg3U=
Date:   Fri, 25 Feb 2022 11:53:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: Document that debugfs_create functions need not
 be error checked
Message-ID: <Yhi1PieJPFPzjIdg@kroah.com>
References: <20220222154555.1.I26d364db7a007f8995e8f0dac978673bc8e9f5e2@changeid>
 <88d84e26-9b8c-443d-ebe7-7a7c92f2b595@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88d84e26-9b8c-443d-ebe7-7a7c92f2b595@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 09:49:15AM +0100, Javier Martinez Canillas wrote:
> Hello Doug,
> 
> On 2/23/22 00:46, Douglas Anderson wrote:
> > As talked about in commit b792e64021ec ("drm: no need to check return
> > value of debugfs_create functions"), in many cases we can get away
> > with totally skipping checking the errors of debugfs functions. Let's
> > document that so people don't add new code that needlessly checks
> > these errors.
> > 
> > Probably this note could be added to a boatload of functions, but
> > that's a lot of duplication.  Let's just add it to the two most
> > frequent ones and hope people will get the idea.

There should not be many more debugfs functions that return a value,
right?  The number is getting smaller over time.

> Agreed. The first contact point for folks looking for the function's
> return values will probably be these two, I second that is enough.
> 
> > Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > 
> >  fs/debugfs/inode.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> > index 2f117c57160d..3dcf0b8b4e93 100644
> > --- a/fs/debugfs/inode.c
> > +++ b/fs/debugfs/inode.c
> > @@ -450,6 +450,11 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
> >   *
> >   * If debugfs is not enabled in the kernel, the value -%ENODEV will be
> >   * returned.
> > + *
> > + * NOTE: it's expected that most callers should _ignore_ the errors returned
> > + * by this function. Other debugfs functions handle the fact that the "dentry"
> > + * passed to them could be an error and they don't crash in that case.
> > + * Drivers should generally work fine even if debugfs fails to init anyway.
> >   */
> 
> Thanks a lot for adding this. I was confused why the kernel doc didn't mention
> anything like that, yet most drivers didn't check and just ignored the errors.

I've been working on the kernel code first, to remove the checks, and
was going to revamp all of the documentation after this was all done.

thanks,

greg k-h
