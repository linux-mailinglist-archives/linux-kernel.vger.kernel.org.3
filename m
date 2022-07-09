Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A449756C7A3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 09:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiGIHCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 03:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIHCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 03:02:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A093774B6
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 00:02:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1E6D60C85
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 07:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD556C3411C;
        Sat,  9 Jul 2022 07:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657350171;
        bh=ywY5wSpDb5M0M/Sepmd8IRCwLxEaxwxwZ2IywAl4hRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hMyQ+dpRIlGge7oPY2dZLbR6gjlPuAcvsTZ8noFmYooPehCTP7ogL299JK6WfMlqy
         Ol3OrtdKW+51e0SdD9YjY9nfo/aaSP0F5arhuqq8c9XIEqy7vMEvnBu+240oqYJtEn
         Mn9KNGG4g0JNQggCpYDF/fhFEGuOOBVH3H7jcBOw=
Date:   Sat, 9 Jul 2022 09:02:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: vt6655: Use loop in
 vt6655_mac_write_bssid_addr
Message-ID: <YskoFoksrQyDstyc@kroah.com>
References: <cover.1657134099.git.philipp.g.hortmann@gmail.com>
 <b3b93ae7ce41562565e9007eb4580b9c47a2881f.1657134099.git.philipp.g.hortmann@gmail.com>
 <YsgjOPUDDtD48tMO@kroah.com>
 <2c1717b23896bc95a9ba9de79c9dbf112aa35460.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c1717b23896bc95a9ba9de79c9dbf112aa35460.camel@perches.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 09:07:43PM -0700, Joe Perches wrote:
> On Fri, 2022-07-08 at 14:29 +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jul 06, 2022 at 09:19:01PM +0200, Philipp Hortmann wrote:
> > > Use loop in vt6655_mac_write_bssid_addr to avoid multiple
> > > similar statements.
> []
> > > diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
> []
> > > @@ -192,12 +192,8 @@ device_set_options(struct vnt_private *priv)
> > >  static void vt6655_mac_write_bssid_addr(void __iomem *iobase, const u8 *mac_addr)
> []
> > > +	for (int i = 0; i < 6; i++)
> > 
> > Taking advantage of the new compiler level I see, nice :)
> 
> Not sure this is altogether a great idea as it may
> make backporting a bit difficult, but it's already
> in the kernel in a few places.

That's for the stable kernels to worry about, don't let that stop new
development from happening for that reason please.

thanks,

greg k-h
