Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB375146B7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353408AbiD2K1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245656AbiD2K1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:27:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DA0C6EFB;
        Fri, 29 Apr 2022 03:24:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7221BB8301B;
        Fri, 29 Apr 2022 10:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AFAC385A4;
        Fri, 29 Apr 2022 10:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651227840;
        bh=VrvVa5/GusZJ9VrpG6S/DfT6kLbm0YgE/cVZm1EEsfM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W01SN75HD/9NKxwPAcdRHgQ6deX+WrGupf3yk6SNkXQIEnduJtYsEYWi3sfbOgTmS
         6MwopNddRW2Mfuzwh5EyiAjvDtjIiT4ivU/0GV1msqWw/VWzI+LVT98VoZatLxCMCx
         4qIocUDIsZjHyg/rGXYmYEWUPCg4APwXrUZZ1lcofStDRRmLkQSqYeY/usr+E9V7lF
         Q/hy3vpb0xK9Dpnr04F6PtJrsvclnxSnJ6fhqjOT7sm5hhQXKRqajLKzMxafVsiOaF
         5gi8dQtcVzsgxyL9VMlyQYIDePwQpkoJC+wGD6h09G/5Dpg0mYWy9YcrW0BnaHKjqr
         PZMZv6lhsirPQ==
Date:   Fri, 29 Apr 2022 11:23:51 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <20220429112351.0e044950@sal.lan>
In-Reply-To: <Ymu5f8EjdC1Mawzt@kroah.com>
References: <cover.1651212016.git.mchehab@kernel.org>
        <a078eb2e46d00ec59c8a91ea0afa5190730c9e58.1651212016.git.mchehab@kernel.org>
        <YmuZovuDaCYDDG4c@phenom.ffwll.local>
        <20220429090757.1acb943a@sal.lan>
        <YmuiKcHgl+nABvo/@kroah.com>
        <20220429101503.4048db5b@sal.lan>
        <Ymu5f8EjdC1Mawzt@kroah.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 29 Apr 2022 12:10:07 +0200
Greg KH <gregkh@linuxfoundation.org> escreveu:

> On Fri, Apr 29, 2022 at 10:15:03AM +0100, Mauro Carvalho Chehab wrote:
> > HI Greg,
> > 
> > Em Fri, 29 Apr 2022 10:30:33 +0200
> > Greg KH <gregkh@linuxfoundation.org> escreveu:
> >   
> > > On Fri, Apr 29, 2022 at 09:07:57AM +0100, Mauro Carvalho Chehab wrote:  
> > > > Hi Daniel,
> > > > 
> > > > Em Fri, 29 Apr 2022 09:54:10 +0200
> > > > Daniel Vetter <daniel@ffwll.ch> escreveu:
> > > >     
> > > > > On Fri, Apr 29, 2022 at 07:31:15AM +0100, Mauro Carvalho Chehab wrote:    
> > > > > > Sometimes, device drivers are bound using indirect references,
> > > > > > which is not visible when looking at /proc/modules or lsmod.
> > > > > > 
> > > > > > Add a function to allow setting up module references for such
> > > > > > cases.
> > > > > > 
> > > > > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>      
> > > > > 
> > > > > This sounds like duct tape at the wrong level. We should have a
> > > > > device_link connecting these devices, and maybe device_link internally
> > > > > needs to make sure the respective driver modules stay around for long
> > > > > enough too. But open-coding this all over the place into every driver that
> > > > > has some kind of cross-driver dependency sounds terrible.
> > > > > 
> > > > > Or maybe the bug is that the snd driver keeps accessing the hw/component
> > > > > side when that is just plain gone. Iirc there's still fundamental issues
> > > > > there on the sound side of things, which have been attempted to paper over
> > > > > by timeouts and stuff like that in the past instead of enforcing a hard
> > > > > link between the snd and i915 side.    
> > > > 
> > > > I agree with you that the device link between snd-hda and the DRM driver
> > > > should properly handle unbinding on both directions. This is something
> > > > that require further discussions with ALSA and DRM people, and we should
> > > > keep working on it.
> > > > 
> > > > Yet, the binding between those drivers do exist, but, despite other
> > > > similar inter-driver bindings being properly reported by lsmod, this one
> > > > is invisible for userspace.
> > > > 
> > > > What this series does is to make such binding visible. As simple as that.    
> > > 
> > > It also increases the reference count, and creates a user/kernel api
> > > with the symlinks, right?  Will the reference count increase prevent the
> > > modules from now being unloadable?
> > >
> > > This feels like a very "weak" link between modules that should not be
> > > needed if reference counting is implemented properly (so that things are
> > > cleaned up in the correct order.)  
> > 
> > The refcount increment exists even without this patch, as
> > hda_component_master_bind() at sound/hda/hdac_component.c uses 
> > try_module_get() when it creates the device link.  
> 
> Ok, then why shouldn't try_module_get() be creating this link instead of
> having to manually do it this way again?  You don't want to have to go
> around and add this call to all users of that function, right?

Works for me, but this is not a too trivial change, as the new 
try_module_get() function will require two parameters, instead of one:

	- the module to be referenced;
	- the module which will reference it.

On trivial cases, one will be THIS_MODULE, but, in the specific case
of snd_hda, the binding is done via an ancillary routine under 
snd_hda_core, but the actual binding happens at snd_hda_intel.

Ok, we could add a __try_module_get() (or whatever other name that
would properly express what it does) with two parameters, and then
define try_module_get() as:

	#define try_module_get(mod) __try_module_get(mod, THIS_MODULE)

Would that work for you?

Regards,
Mauro
