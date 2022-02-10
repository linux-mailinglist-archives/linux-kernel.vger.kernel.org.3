Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6594B06B9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 07:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiBJGzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 01:55:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiBJGzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:55:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299C5D95;
        Wed,  9 Feb 2022 22:55:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACE1161CF4;
        Thu, 10 Feb 2022 06:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAA7C340EB;
        Thu, 10 Feb 2022 06:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644476141;
        bh=9n60BmJ9fwC2I4OgXO4IafhoyEnoyZ7mPDhn1npHwU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l+kplYYZfazQmuyfN2CwTFLuQqXRT8bzrML04Zl2bqSzqQdZkH4JnwNoRQ7Vb+qqQ
         6lFLw38e/RcZh5FIAdnSphEqXyg0GNE2rYsYpWoVqG6H3puiVszqWEBOtWzH/ez3FK
         X47QbJ9psD07ed6i9GMM5kQI/DlR2JLzLIM99yqI=
Date:   Thu, 10 Feb 2022 07:55:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        John Crispin <john@phrozen.org>, linux-staging@lists.linux.dev,
        NeilBrown <neil@brown.name>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v8 0/4] clk: ralink: make system controller a reset
 provider
Message-ID: <YgS26WAtSkQbZam4@kroah.com>
References: <20220110114930.1406665-1-sergio.paracuellos@gmail.com>
 <YfE5MOkQRoHQV7Wf@kroah.com>
 <CAMhs-H8s0d=PswQDR86Tq-bQt634Z6rdFYHTE+DFepsthmKAYA@mail.gmail.com>
 <YfE7LNFuf79i3oAQ@kroah.com>
 <CAMhs-H9c8zF=v2tu5Y1OsFRP6esOi5zrUceqS_OUiJ=MSfCvRQ@mail.gmail.com>
 <20220205025548.AA1BBC004E1@smtp.kernel.org>
 <CAMhs-H82J5DC+m0V==tQKKYyqsu30kGLkdUbMRU+nsyLb8sL3Q@mail.gmail.com>
 <CAMhs-H9RSjgW1-dafqDqbfBaQ4iH6NFDLoRHqjt=f41zAEcC-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H9RSjgW1-dafqDqbfBaQ4iH6NFDLoRHqjt=f41zAEcC-g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 07:44:33AM +0100, Sergio Paracuellos wrote:
> Hi Greg,
> 
> On Sat, Feb 5, 2022 at 8:31 AM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> >
> > On Sat, Feb 5, 2022 at 3:55 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Sergio Paracuellos (2022-01-26 04:45:31)
> > > > On Wed, Jan 26, 2022 at 1:14 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Wed, Jan 26, 2022 at 01:08:52PM +0100, Sergio Paracuellos wrote:
> > > > > > On Wed, Jan 26, 2022 at 1:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > >
> > > > > > > On Mon, Jan 10, 2022 at 12:49:26PM +0100, Sergio Paracuellos wrote:
> > > > > > > > Hi all,
> > > > > > > >
> > > > > > > > This patch series add minimal change to provide mt7621 resets properly
> > > > > > > > defining them in the 'mediatek,mt7621-sysc' node which is the system
> > > > > > > > controller of the SoC and is already providing clocks to the rest of
> > > > > > > > the world.
> > > > > > > >
> > > > > > > > There is shared architecture code for all ralink platforms in 'reset.c'
> > > > > > > > file located in 'arch/mips/ralink' but the correct thing to do to align
> > > > > > > > hardware with software seems to define and add related reset code to the
> > > > > > > > already mainlined clock driver.
> > > > > > > >
> > > > > > > > After this changes, we can get rid of the useless reset controller node
> > > > > > > > in the device tree and use system controller node instead where the property
> > > > > > > > '#reset-cells' has been added. Binding documentation for this nodeq has
> > > > > > > > been updated with the new property accordly.
> > > > > > > >
> > > > > > > > This series also provide a bindings include header where all related
> > > > > > > > reset bits for the MT7621 SoC are defined.
> > > > > > > >
> > > > > > > > Also, please take a look to this review [0] to understand better motivation
> > > > > > > > for this series.
> > > > > > > >
> > > > > > > > Regarding the way of merging this:
> > > > > > > >  - I'd like patches 1 and 4 which are related going through staging tree.
> > > > > > >
> > > > > > > Patches 1 and 4 now in the staging tree, thanks.
> > > > > >
> > > > > > Stephen wanted all to go through the CLK tree since PATCH 3 and 1 were
> > > > > > also a dependency... Can we get all of them through the same tree,
> > > > > > then? I am ok with both CLK or staging trees.
> > > > >
> > > > > That's fine with me if they all go through the CLK tree, but there will
> > > > > be a merge issue that I already fixed up in my tree.  If you want me to
> > > > > drop them, just let me know.
> > > >
> > > > Stephen, what do you prefer? Is it better all going through staging-tree then?
> > > >
> > >
> > > Sure take them through staging tree.
> > >
> > > Acked-by: Stephen Boyd <sboyd@kernel.org>
> >
> > Thanks, Stephen.
> >
> > Greg, can you please take remaining patches 2 and 3 through your tree, then?
> >
> > Thanks in advance for your time.
> 
> Please, let me know if you prefer me to resend the remaining two
> patches with tags added to make this easier for you.

Please do so, as I can't seem to dig up the remaining ones...

thanks,

greg k-h
