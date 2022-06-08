Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D235543039
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239102AbiFHMXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238835AbiFHMXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:23:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413201BF166;
        Wed,  8 Jun 2022 05:23:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 679F961952;
        Wed,  8 Jun 2022 12:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0D4C3411D;
        Wed,  8 Jun 2022 12:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654691010;
        bh=hIdL6cBQ9jfGk5bMrXChPdyIkuqD0IoOIuXFKA+q0kE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h4T3JmvsnzEdWc8XoIoCfFFSJe23N9szNsUf+ahCt7NSzvYJ+JcYtcQEQA6TIO/vT
         ezR5dLzPsrKa/Wek4AYspsDsAoOJwRiwuLdoIGRXqz/iNfak3nK4hZzI2FWKHGSPty
         /h2QjzpVR4qrAdQLZ/7MOmgEwLYsXWteXAd3p3TA=
Date:   Wed, 8 Jun 2022 14:23:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] driver core: Introduce device_find_first_child()
 helper
Message-ID: <YqCUv55XKmUfe1J5@kroah.com>
References: <20220607202058.8304-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gmO-BDyurQtG4sU5KLfe2mjs7vm5kpJQoAaxYxF57t3g@mail.gmail.com>
 <YqCNuJ3RQX3jIy59@smile.fi.intel.com>
 <YqCQOAy64heA3GPM@kroah.com>
 <CAJZ5v0hxvqYaEXzEKYG++egKVgNk=KUNnMMKRT2pS2S9PN-ibw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hxvqYaEXzEKYG++egKVgNk=KUNnMMKRT2pS2S9PN-ibw@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 02:15:19PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 8, 2022 at 2:04 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jun 08, 2022 at 02:53:28PM +0300, Andy Shevchenko wrote:
> > > On Wed, Jun 08, 2022 at 01:29:08PM +0200, Rafael J. Wysocki wrote:
> > > > On Tue, Jun 7, 2022 at 10:22 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > ...
> > >
> > > > I would define it as
> > > >
> > > > static int match_first(struct device *dev, void *)
> > > > {
> > > >        return 1;
> > > > }
> > > >
> > > > struct device *device_find_first_child(struct device *parent)
> > > > {
> > > >         return device_find_first_child(parent, NULL, match_first);
> > > > }
> > > > EXPORT_SYMBOL_GPL(device_find_first_child);
> > > >
> > > > which is not that much more overhead.
> > >
> > > With this we actually may simply provide a match function and it will make the
> > > clean ups (like patch 2 in the series) almost the same without introducing a
> > > device core call.
> > >
> > > Something like
> > >
> > > int device_match_any_for_find(struct device *dev, void *unused)
> > > {
> > >       return 1;
> > > }
> > >
> > > As I replied to Greg it's pity we can't use device_match_any()...
> >
> >         int device_match_any(struct device *dev, const void *unused)
> >
> > How is that not ok to use here?
> 
> Because of the const that will be frowned upon by the compiler.
> 
> We need to define another device_match_any_relaxed() taking (void *)
> as the second argument for this.

Or we could cast it away :)
