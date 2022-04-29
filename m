Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A27514FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378652AbiD2P4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbiD2P4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:56:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D13CE10F;
        Fri, 29 Apr 2022 08:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651247601; x=1682783601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v3xHt04zUoM51m57wES9OEH4SBADCPxc9G7xtsUo2b0=;
  b=SjLJi9WGQa+2fBsBQZ+iP6CnjRh4AsWjaLMZALplkkpKvmrmplw1/O9v
   Y1FMeVs3wz2RklkEz0ddL0ALrnkQrVT34AABBeeDOMvMKzA/X1tcj4UAk
   Y5P84xf2VajX2YnbJAyxhJ5L1Vh8wxN+oUxrEaFk9MUcylnPAxafnRx+z
   4/9VlCqvyVQvdLkq8aGX9dtRY9gWCVdiqIjxjnidIImuJypIPaUdoILiO
   mQXfJU+jpv2dI/mfX0Ce66Ltd3GknkEiKzrSka+XQgXwnh8ZJYK6xq3NI
   0w3gLQChbC8A55L+N1kJW2weq6vZ40nKaQWTRwWCeM6xfjjUthNcj/2qz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="329623786"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="329623786"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 08:52:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="706606733"
Received: from vpareek-mobl1.amr.corp.intel.com (HELO ldmartin-desk2) ([10.209.103.56])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 08:52:20 -0700
Date:   Fri, 29 Apr 2022 08:52:20 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kai Vehmanen <kai.vehmanen@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Luis Chamberlain <mcgrof@kernel.org>, mauro.chehab@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        linux-modules@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
Subject: Re: [Intel-gfx] [PATCH 1/2] module: add a function to add module
 references
Message-ID: <20220429155220.6k63lt5knhertj3g@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <cover.1651212016.git.mchehab@kernel.org>
 <a078eb2e46d00ec59c8a91ea0afa5190730c9e58.1651212016.git.mchehab@kernel.org>
 <YmuZovuDaCYDDG4c@phenom.ffwll.local>
 <20220429090757.1acb943a@sal.lan>
 <YmuiKcHgl+nABvo/@kroah.com>
 <20220429101503.4048db5b@sal.lan>
 <Ymu5f8EjdC1Mawzt@kroah.com>
 <20220429112351.0e044950@sal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220429112351.0e044950@sal.lan>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 11:23:51AM +0100, Mauro Carvalho Chehab wrote:
>Em Fri, 29 Apr 2022 12:10:07 +0200
>Greg KH <gregkh@linuxfoundation.org> escreveu:
>
>> On Fri, Apr 29, 2022 at 10:15:03AM +0100, Mauro Carvalho Chehab wrote:
>> > HI Greg,
>> >
>> > Em Fri, 29 Apr 2022 10:30:33 +0200
>> > Greg KH <gregkh@linuxfoundation.org> escreveu:
>> >
>> > > On Fri, Apr 29, 2022 at 09:07:57AM +0100, Mauro Carvalho Chehab wrote:
>> > > > Hi Daniel,
>> > > >
>> > > > Em Fri, 29 Apr 2022 09:54:10 +0200
>> > > > Daniel Vetter <daniel@ffwll.ch> escreveu:
>> > > >
>> > > > > On Fri, Apr 29, 2022 at 07:31:15AM +0100, Mauro Carvalho Chehab wrote:
>> > > > > > Sometimes, device drivers are bound using indirect references,
>> > > > > > which is not visible when looking at /proc/modules or lsmod.
>> > > > > >
>> > > > > > Add a function to allow setting up module references for such
>> > > > > > cases.
>> > > > > >
>> > > > > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> > > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
>> > > > >
>> > > > > This sounds like duct tape at the wrong level. We should have a
>> > > > > device_link connecting these devices, and maybe device_link internally
>> > > > > needs to make sure the respective driver modules stay around for long
>> > > > > enough too. But open-coding this all over the place into every driver that
>> > > > > has some kind of cross-driver dependency sounds terrible.
>> > > > >
>> > > > > Or maybe the bug is that the snd driver keeps accessing the hw/component
>> > > > > side when that is just plain gone. Iirc there's still fundamental issues
>> > > > > there on the sound side of things, which have been attempted to paper over
>> > > > > by timeouts and stuff like that in the past instead of enforcing a hard
>> > > > > link between the snd and i915 side.
>> > > >
>> > > > I agree with you that the device link between snd-hda and the DRM driver
>> > > > should properly handle unbinding on both directions. This is something
>> > > > that require further discussions with ALSA and DRM people, and we should
>> > > > keep working on it.
>> > > >
>> > > > Yet, the binding between those drivers do exist, but, despite other
>> > > > similar inter-driver bindings being properly reported by lsmod, this one
>> > > > is invisible for userspace.
>> > > >
>> > > > What this series does is to make such binding visible. As simple as that.
>> > >
>> > > It also increases the reference count, and creates a user/kernel api
>> > > with the symlinks, right?  Will the reference count increase prevent the
>> > > modules from now being unloadable?
>> > >
>> > > This feels like a very "weak" link between modules that should not be
>> > > needed if reference counting is implemented properly (so that things are
>> > > cleaned up in the correct order.)
>> >
>> > The refcount increment exists even without this patch, as
>> > hda_component_master_bind() at sound/hda/hdac_component.c uses
>> > try_module_get() when it creates the device link.
>>
>> Ok, then why shouldn't try_module_get() be creating this link instead of
>> having to manually do it this way again?  You don't want to have to go
>> around and add this call to all users of that function, right?
>
>Works for me, but this is not a too trivial change, as the new
>try_module_get() function will require two parameters, instead of one:
>
>	- the module to be referenced;
>	- the module which will reference it.
>
>On trivial cases, one will be THIS_MODULE, but, in the specific case
>of snd_hda, the binding is done via an ancillary routine under
>snd_hda_core, but the actual binding happens at snd_hda_intel.
>
>Ok, we could add a __try_module_get() (or whatever other name that
>would properly express what it does) with two parameters, and then
>define try_module_get() as:
>
>	#define try_module_get(mod) __try_module_get(mod, THIS_MODULE)

agree that this should be done at this level rather than open coding it
at every driver. Main improvement being fixed here regardless of the
snd-hda-intel issue is to properly annotate what is holding a module.

Right now we have 1) symbol module dependencies; 2) kernel references;
3) userspace references. With (2) and (3) being unknown to the user from
lsmod pov. Handling this any time try_module_get() is called would make
(2) visible to lsmod.

Paired with fixes to the (unreleased) kmod 30[1], this allows `modprobe
-r --remove-holders <module>` to also try removing the holders before
removing the module itself.

thanks
Lucas De Marchi

[1] https://lore.kernel.org/linux-modules/20220329090912.geymr6xk7taq4rtq@ldmartin-desk2.jf.intel.com/T/#t


>
>Would that work for you?
>
>Regards,
>Mauro
