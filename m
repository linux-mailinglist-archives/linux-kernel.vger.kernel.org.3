Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420854C34B0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 19:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiBXSZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 13:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiBXSZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 13:25:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E788D29DD2D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 10:25:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 967ACB8283E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 18:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1EDC340E9;
        Thu, 24 Feb 2022 18:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645727098;
        bh=aXCK7BIaMCE9jatONu1harMAoH2LqwbFzzZ7R98WlVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PEaAyUaMQgWVdzh6/kjFhTQGgOwvSqiQSuaJYWvSwafdwDmRaIxboaRLmbDxF9F1f
         nxZqTAY0qHWqH5bR6izd1+rPYnHLNYIiqs22oc8bzbyuG2MM2c8LX3fPDjmnGA2abh
         Jn/hkJSDxdiS4+jOdZqkbDxZdLUjG+Vrbtr5a8zM=
Date:   Thu, 24 Feb 2022 19:24:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] driver core: Refactor device unbind/probe fail
 clean-ups
Message-ID: <YhfNd51mY5S1vIkI@kroah.com>
References: <20220223225257.1681968-1-robh@kernel.org>
 <YhdLKuv3D/tQ9ia8@kroah.com>
 <CAL_JsqLQ4piDoqFstODfexNkz7cMhbjGeKD1HSb1QFgFPwCpTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLQ4piDoqFstODfexNkz7cMhbjGeKD1HSb1QFgFPwCpTg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 07:24:48AM -0600, Rob Herring wrote:
> On Thu, Feb 24, 2022 at 3:09 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Feb 23, 2022 at 04:52:55PM -0600, Rob Herring wrote:
> > > The same sequences of device clean-up code are duplicated 3 times.
> > > Changes to this code are prone to missing one of the copies. This
> > > series refactors the code into 2 common functions as there's some slight
> > > differences in the intermediate steps.
> > >
> > > Rob
> > >
> > > Rob Herring (2):
> > >   driver core: Refactor multiple copies of device cleanup
> > >   driver core: Refactor sysfs and drv/bus remove hooks
> > >
> > >  drivers/base/dd.c | 80 ++++++++++++++++++-----------------------------
> > >  1 file changed, 30 insertions(+), 50 deletions(-)
> > >
> > > --
> > > 2.32.0
> > >
> >
> > What branch/tree did you make these against?  They do not apply at all
> > to my "driver-core-next" branch of the driver-core.git tree on
> > git.kernel.org :(
> 
> linux-next. It is dependent on commit d8f7a5484f21 ("driver core: Free
> DMA range map when device is released") in your driver-core-linus
> branch.

Ah, my fault, I'll wait for the branch to be merged and then apply these
next week.

thanks,

greg k-h
