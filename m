Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A77514441
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355624AbiD2IeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355718AbiD2Idy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:33:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47D22DA92;
        Fri, 29 Apr 2022 01:30:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 519C96211E;
        Fri, 29 Apr 2022 08:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0F6C385A7;
        Fri, 29 Apr 2022 08:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651221036;
        bh=E+/mVnEPJmiEomQKTEm/f1Hrlo6iyY5JnqbAgew7j1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eVmFd9aHNPV6gH6tYsg/HMOTi1DD0dsIci9UBwtr1S6hIXqZUlEHy6YHCpXggctC2
         W94JVuNdK7kOslobvTBfb78EufmiqzqUs+mJ/3YpK7azDGHV+YTUIwuIespz0N59nA
         UaBgNZzhRne1uhN4UgPi5bAAw6YwRML4vwUaPJNA=
Date:   Fri, 29 Apr 2022 10:30:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Luis Chamberlain <mcgrof@kernel.org>, mauro.chehab@intel.com,
        Kai Vehmanen <kai.vehmanen@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] module: add a function to add module references
Message-ID: <YmuiKcHgl+nABvo/@kroah.com>
References: <cover.1651212016.git.mchehab@kernel.org>
 <a078eb2e46d00ec59c8a91ea0afa5190730c9e58.1651212016.git.mchehab@kernel.org>
 <YmuZovuDaCYDDG4c@phenom.ffwll.local>
 <20220429090757.1acb943a@sal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429090757.1acb943a@sal.lan>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 09:07:57AM +0100, Mauro Carvalho Chehab wrote:
> Hi Daniel,
> 
> Em Fri, 29 Apr 2022 09:54:10 +0200
> Daniel Vetter <daniel@ffwll.ch> escreveu:
> 
> > On Fri, Apr 29, 2022 at 07:31:15AM +0100, Mauro Carvalho Chehab wrote:
> > > Sometimes, device drivers are bound using indirect references,
> > > which is not visible when looking at /proc/modules or lsmod.
> > > 
> > > Add a function to allow setting up module references for such
> > > cases.
> > > 
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>  
> > 
> > This sounds like duct tape at the wrong level. We should have a
> > device_link connecting these devices, and maybe device_link internally
> > needs to make sure the respective driver modules stay around for long
> > enough too. But open-coding this all over the place into every driver that
> > has some kind of cross-driver dependency sounds terrible.
> > 
> > Or maybe the bug is that the snd driver keeps accessing the hw/component
> > side when that is just plain gone. Iirc there's still fundamental issues
> > there on the sound side of things, which have been attempted to paper over
> > by timeouts and stuff like that in the past instead of enforcing a hard
> > link between the snd and i915 side.
> 
> I agree with you that the device link between snd-hda and the DRM driver
> should properly handle unbinding on both directions. This is something
> that require further discussions with ALSA and DRM people, and we should
> keep working on it.
> 
> Yet, the binding between those drivers do exist, but, despite other
> similar inter-driver bindings being properly reported by lsmod, this one
> is invisible for userspace.
> 
> What this series does is to make such binding visible. As simple as that.

It also increases the reference count, and creates a user/kernel api
with the symlinks, right?  Will the reference count increase prevent the
modules from now being unloadable?

This feels like a very "weak" link between modules that should not be
needed if reference counting is implemented properly (so that things are
cleaned up in the correct order.)

Please don't paper over the real issue with this hack.

thanks,

greg k-h
