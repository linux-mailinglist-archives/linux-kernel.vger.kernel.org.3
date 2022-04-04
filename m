Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50EA4F173F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378096AbiDDOkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377994AbiDDOjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:39:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622C93F88E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C76F2B817DC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165FCC2BBE4;
        Mon,  4 Apr 2022 14:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649082984;
        bh=73qqUvZ/VQr/pWfWdhrhsVcUa7yrkg0XCAGXIPOUfDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P5KGhA/2BqUP1zD/DGNonn6yNZH5xmdobFP3PVt3Rbt9oyX3ANm7ArHHjWwsXEKY+
         EgLiBJOG2J5kxB1TBwcc1lFIFT2sTCPweTBqAMJa6IblsCJ8FyTCxqgiki4n4OYQEy
         6KVI14qtuHgedDKfR5tUiyKCWuL+js/S8LJumMxw=
Date:   Mon, 4 Apr 2022 16:36:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Charlie Sands <sandsch@northvilleschools.net>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: Re: [PATCH V2] Fix unsafe memory access by memcmp
Message-ID: <YksCZRJWNNcGSLMw@kroah.com>
References: <YkpdVyuQguGzPSNE@sckzor-linux.localdomain>
 <4729027.31r3eYUQgx@leap>
 <20220404120332.GY3293@kadam>
 <1890716.PYKUYFuaPT@leap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1890716.PYKUYFuaPT@leap>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 04:29:48PM +0200, Fabio M. De Francesco wrote:
> On luned? 4 aprile 2022 14:03:32 CEST Dan Carpenter wrote:
> > On Mon, Apr 04, 2022 at 01:25:37PM +0200, Fabio M. De Francesco wrote:
> > > On luned? 4 aprile 2022 12:50:41 CEST Dan Carpenter wrote:
> > > > On Sun, Apr 03, 2022 at 10:52:07PM -0400, Charlie Sands wrote:
> > > > > This patch fixes sparse warnings about the memcmp function unsafely
> > > > > accessing userspace memory without first copying it to kernel space.
> > > > > 
> > > > > Signed-off-by: Charlie Sands <sandsch@northvilleschools.net>
> > > > > ---
> > > > > 
> > > > > V2: Fixed checkpatch.pl warning and changed variable name as suggested
> > > > > by Greg K. H. and improved error checking on the "copy_from_user" function as
> > > > > suggested by Pavel Skripkin.
> > > > > 
> > > > >  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 21 ++++++++++++--------
> > > > >  1 file changed, 13 insertions(+), 8 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > > > > index 7df213856d66..4b4eec2bde96 100644
> > > > > --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > > > > +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > > > > @@ -3233,23 +3233,28 @@ static int rtw_p2p_get(struct net_device *dev,
> > > > >  			       struct iw_request_info *info,
> > > > >  			       union iwreq_data *wrqu, char *extra)
> > > > >  {
> > > > > -	if (!memcmp(wrqu->data.pointer, "status", 6)) {
> > > > > +	char wrqu_data[9];
> > > > > +
> > > > > +	if (copy_from_user(wrqu_data, wrqu->data.pointer, 9) != 0)
> > > > > +		return 0;
> > > > 
> > > > return -EFAULT;  We can't assume that that user wants to copy 9 bytes
> > > > especially when they're passing a 4 character + NUL string.
> > > > 
> > > > This is a custom ioctl.  Called from ioctl_private_iw_point().
> > > > 
> > > > I think if you try to dereference a user pointer like this then it will
> > > > cause a crash, right?  So that means no one has ever tested or used this
> > > > code and we hopefully we can just delete it?
> > > 
> > > After a quick look, I'm pretty confident that we can also delete 
> > > rtw_p2p_get2() and rtw_p2p_set() unless I'm overlooking something.
> > 
> > What are the problems with rtw_p2p_get2() and rtw_p2p_set()?
> > 
> > regards,
> > dan carpenter
> > 
> Is it safe to access user space pointers without using proper helpers? 

No.

