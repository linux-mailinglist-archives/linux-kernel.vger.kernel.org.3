Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988424AE18F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385538AbiBHSzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385532AbiBHSzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:55:32 -0500
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com [91.221.196.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFD6C0612C1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:55:30 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx1.smtp.larsendata.com (Halon) with ESMTPS
        id d4e32d3c-8910-11ec-b20b-0050568c148b;
        Tue, 08 Feb 2022 18:56:32 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 26746194B43;
        Tue,  8 Feb 2022 19:55:29 +0100 (CET)
Date:   Tue, 8 Feb 2022 19:55:26 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Claudio Suarez <cssk@net-c.es>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 19/21] fbcon: Maintain a private array of fb_info
Message-ID: <YgK8nugB7HO2d6r1@ravnborg.org>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-20-daniel.vetter@ffwll.ch>
 <Yf2JbCP6dtHVZS3c@ravnborg.org>
 <YgJ4MC1IJL7AOgSK@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgJ4MC1IJL7AOgSK@phenom.ffwll.local>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, Feb 08, 2022 at 03:03:28PM +0100, Daniel Vetter wrote:
> On Fri, Feb 04, 2022 at 09:15:40PM +0100, Sam Ravnborg wrote:
> > Hi Daniel,
> > 
> > On Mon, Jan 31, 2022 at 10:05:50PM +0100, Daniel Vetter wrote:
> > > Accessing the one in fbmem.c without taking the right locks is a bad
> > > idea. Instead maintain our own private copy, which is fully protected
> > > by console_lock() (like everything else in fbcon.c). That copy is
> > > serialized through fbcon_fb_registered/unregistered() calls.
> > 
> > I fail to see why we can make a private copy of registered_fb
> > just like that - are they not somehow shared between fbcon and fbmem.
> > So when fbmem updates it, then fbcon will use the entry or such?
> > 
> > I guess I am just ignorant of how registered_fb is used - but please
> > explain.
> 
> The private copy is protected under console_lock, and hence safe to access
> from fbcon.c code.
> 
> The main registered_fb array is protected by a different mutex, so we
> could indeed end up with hilarious corruption because the value is
> inconsistent while we try to access it (e.g. we check for !NULL, but later
> on gcc decides to reload the value and now it's suddenly become NULL and
> we blow up).
> 
> The two are synchronized by fbmem.c calling fbcon_register/unregister, so
> aside from the different locks if there's no race going on, they will
> always be identical.
IT was this part that I missed, and it is already spelled out in the
commit message.

> 
> Other option would be to roll out get_fb_info() to fbcon.c, but since
> fbcon.c is fully protected by console_lock that would add complexity in
> the code flow that we don't really need. And we'd have to wire fb_info
> through all call chains, since the right way to use get_fb_info is to look
> it up once and then only drop it when your callback has finished.
> 
> Since the current code just assume it's all protected by console_lock and
> we never drop that during a callback this would mean major surgery and
> essentially refactoring all of fbcon.c to only access the fbcon stuff
> through fb_info, i.e. to get rid of _all_ the global arrays we have more
> or less. I'm not volunteering for that (despite that really this would be
> the right thing to do if we'd have infinite engineering time).
> 
> Ack with that explainer added to the commit message?

I consider the current commit message fine - it helps when you actually
read it.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
