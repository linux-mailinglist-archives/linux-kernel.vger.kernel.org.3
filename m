Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A288A50FA2E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348777AbiDZKUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348939AbiDZKTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:19:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3074A81187
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:43:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC68760C09
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605A7C385A4;
        Tue, 26 Apr 2022 09:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650966223;
        bh=hhTYoNv8/l0ISvj9DhCdthUaL/GLIjOmC4ltkJn+odE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IkyDmLw3AB8k4tfsxy3j65T+vpaZ5cMpHivxn0+mxgK+wZWyV5bX1pHL5fwPuXEvm
         stB8p1VMMcfsY5zA6eRSyvSdGYOlxP31Uk2QiUf/LSHFepEcND3CdZFcnnAAHZKmrG
         D2PEkdXNZmiTtTUIWXPPyHPjgVgJQpdRsMtdk0MU=
Date:   Tue, 26 Apr 2022 11:43:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Jirka Hladky <jhladky@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev,
        Justin Forbes <jforbes@fedoraproject.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: PANIC: "Oops: 0000 [#1] PREEMPT SMP PTI" starting from 5.17 on
 dual socket Intel Xeon Gold servers
Message-ID: <Yme+y7Vh9NB9PmrO@kroah.com>
References: <CAFxkdAq6r2WnwML-pPfdZiajaYZCEcUU3GrXW=+wsA7CxGnJdQ@mail.gmail.com>
 <CAE4VaGBchOMWeHQ8GKiGFv_aCaNGLEvSdLWXZTpE+qC=0bgM3A@mail.gmail.com>
 <YkY6W1NS+1RTw0VB@google.com>
 <CAE4VaGDAMZqjwumyvbityzEiK30=5a5vuDMjaS+UHM39R-oPRw@mail.gmail.com>
 <YkstxbC3OfzYnSRw@google.com>
 <CAE4VaGAQZcQzN8D+iwcBnP5vY=Ctmbh+oTikvONHir6JjTgpsw@mail.gmail.com>
 <YmGKrd1BR9HSEy6q@slm.duckdns.org>
 <YmLznjFdpblHzZiM@google.com>
 <56ac17fd-5f13-840c-09d8-03363af94520@leemhuis.info>
 <YmMLgHnxoTC1idCE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmMLgHnxoTC1idCE@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 01:09:36PM -0700, Minchan Kim wrote:
> On Fri, Apr 22, 2022 at 08:44:17PM +0200, Thorsten Leemhuis wrote:
> > On 22.04.22 20:27, Minchan Kim wrote:
> > > On Thu, Apr 21, 2022 at 06:47:41AM -1000, Tejun Heo wrote:
> > > [...]
> > 
> > Many thx for looking into this.
> > 
> > > Jirka, Could you test the patch? Once it's confirmed, I need to resend
> > > it with Ccing stable.
> > 
> > When you do so, could you please include a proper "Link:" tag pointing
> > to all reports of the regression, as explained in the Linux kernels
> > documentation (see 'Documentation/process/submitting-patches.rst' and
> > 'Documentation/process/5.Posting.rst'). E.g. in this case:
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=215696
> > Link:
> > https://lore.kernel.org/lkml/CAE4VaGDZr_4wzRn2___eDYRtmdPaGGJdzu_LCSkJYuY9BEO3cw@mail.gmail.com/
> 
> Sure. Will do that.

Did this ever get sent, I can't find it in my queue anywhere...

thanks,

greg k-h
