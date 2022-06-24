Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3185598C6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 13:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiFXLo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 07:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiFXLou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 07:44:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6F17A6FC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 04:44:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB8EBB82863
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420AAC34114;
        Fri, 24 Jun 2022 11:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656071087;
        bh=qxPeo/Nw6Qd0O6UxjAzSWKbn3EkYBlOSQmLxfp1xVqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0EwM7Uv0+2NcfGDCx1hqjO6z98pnx8FCDHV3bgx5T17byHhpPBRq00eBcgVRJoQC7
         +YbA33Gp83lbi6JLVzcp5DgOzAuRzplv8KQcHMqd46ynPIjmuL3TfFUFnxGlLgqp3i
         9W6eW8TNA19GFYIdNRpuAhYfmy9ah2nD0odehepQ=
Date:   Fri, 24 Jun 2022 13:32:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Felix Schlepper <f3sch.git@outlook.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] Staging: rtl8192e: Cleaning up error handling
Message-ID: <YrWgsxH/yyEQdvEx@kroah.com>
References: <cover.1655975970.git.f3sch.git@outlook.com>
 <13b32131cd00a1f0b8793657a24ada71240a8350.1655975970.git.f3sch.git@outlook.com>
 <CAHp75VcQcKaYUP_JsmTFOY-pbOR39+TMw=5ADbb2BRGoMijCMw@mail.gmail.com>
 <20220624052118.GT16517@kadam>
 <AM9P190MB1299F18B717D3A5D3E6DE6D4A5B49@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9P190MB1299F18B717D3A5D3E6DE6D4A5B49@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 10:41:42AM +0200, Felix Schlepper wrote:
> On 24.06.2022 08:21, Dan Carpenter wrote:
> > On Thu, Jun 23, 2022 at 11:20:49PM +0200, Andy Shevchenko wrote:
> > > On Thu, Jun 23, 2022 at 10:44 PM Felix Schlepper <f3sch.git@outlook.com> wrote:
> > > >
> > > > Moved error handling to one common block.
> > > > This removes double checking if all txb->fragments[]
> > > > were initialized.
> > > > The original code worked fine, but this is cleaner.
> > >
> > > ...
> > >
> > > > +err_free:
> > > > +       while (--i >= 0)
> > >
> > >   while (i--)
> > >
> > > will suffice.
> > >
> >
> > Either one is fine.  You prefer this format.  I prefer that other
> > format.  I told Felix he could use either format without expressing any
> > bias and he chose my format.  That means he loves me more.
> >
> > regards,
> > dan carpenter
> Andy's advice is of course much appreciated but I prefer Dan's style <3.
> 
> On another note, the thread is quite messy now, since all my previous
> failed attempts to send are now threaded to this one.
> How would I go about solving this? Sending another v5 version, the v4
> with [RESEND PATCH v4...] or does this even need any action on my part?

Please resend a v5, as I now have 3 different copies of a v4 series in
my inbox, which makes no sense at all.

Remember, make it obvious as to what to do for those of us who have to
handle 1000+ emails a day...

thanks,

greg k-h
