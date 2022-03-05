Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56444CE5D1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 17:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiCEQHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 11:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiCEQHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:07:10 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475E81A8C8B
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 08:06:20 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id f14so12738361ioz.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 08:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wo6nd2MeGmxMshtehc0riA0wTbVBfcjKppZ0twur98A=;
        b=M8jxO/hL/kIBZ6weK/ApLGvbKGlIVpZSV76KqNf7dvXDXwrbKEQK9NZBbxADzkxgsx
         s81o/EfbP+ZpDwuvQkWScscXIzE+CF2kf5GFwm41dvGRKruIYAN67USeMOTaSxD27Kpx
         KK4JDH/gLycJ8qtd+0fKjyWuyyUsrPJI1zKx0F35STkGXZbt8EjOyjxr4KeC/bcHYHRJ
         /IjDeNy+Ptqhmj7DO97Tv9c+1B+fCJB+gfhkECWHZozpdjJhiXNYEPGF/JyqAEW2ohIz
         fgb0iPuDzqWmnsGkuKNg3zJ3iipu9fBQfR3Y1QZqgW1+NBZYRMlxop5gXNeqaX7qn9HS
         BKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wo6nd2MeGmxMshtehc0riA0wTbVBfcjKppZ0twur98A=;
        b=xdYdme+CSyWyhDU2g4U3ryEumzZ1MvyiEz5/Qr3RROvHF4rQkHbX+HpZczEPJsX8a/
         +noeRtS3bVMCUtkkB2YZUzKGGNSF90srC301QJUNkLKntkoCLj9XqoGxN18RqOgAq9ql
         BqlwG5WYqPpDmgj/W0HwCdzIeoPM6ZeOQViLCA8qtlxyLBGx54EirOz5Hbmrhax9B3Bo
         6wJAWEq4QisAYpzJLA+aCgAFyqmYpoR8uoXhzwDGvZx0dudzgDWzKhUgAc9+T+MBpd8L
         3qIDD7Pxodm/7ecS6pef3S7oIX0BFVb/bdaBJT6LzYk8FnzdvjtuH3L0UR2ygysrnhY1
         CnYw==
X-Gm-Message-State: AOAM5333KrJpHaIGc8SSJttTi4rydTrXRAkuswjrFL9WKwWrXeKXWPht
        YO1k+vV7ODxTDWO9o0MeQ6c=
X-Google-Smtp-Source: ABdhPJwDYk64dafNSq+/Yc3f58mT4vP9ejvcvPFEE7mAQjjdPJcdtQ36Afa/BsE0DAVwLtfZmwcrLA==
X-Received: by 2002:a05:6602:1594:b0:640:7236:e6ea with SMTP id e20-20020a056602159400b006407236e6eamr3373793iow.23.1646496379438;
        Sat, 05 Mar 2022 08:06:19 -0800 (PST)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::f10e])
        by smtp.googlemail.com with ESMTPSA id v2-20020a92c802000000b002c1ed616004sm7008509iln.82.2022.03.05.08.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 08:06:19 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     daniel@ffwll.ch, Jim Cromie <jim.cromie@gmail.com>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, jani.nikula@linux.intel.com,
        jbaron@akamai.com, joonas.lahtinen@linux.intel.com,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, rodrigo.vivi@intel.com, tzimmermann@suse.de,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com
Subject: Re: [PATCH v3 3/5] drm/print: RFC add choice to use dynamic debug in drm-debug
Date:   Sat,  5 Mar 2022 09:06:05 -0700
Message-Id: <20220305160605.88922-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <YPbPvm/xcBlTK1wq@phenom.ffwll.local>
References: <YPbPvm/xcBlTK1wq@phenom.ffwll.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Vetter <daniel@ffwll.ch>


Hi Daniel, everyone,

Ive substantially updated this patchset,
and I thought it useful to reply here.

Im noting the biggest changes in context below, trimming heavily otherwize.

Also, Ive lost the msg in my gmail-cloud, so this lacks
the usual "Daniel said: " attribution, and the "> " marks.
Ive prefixed "< " to 1st line of my replies where it helps.

The current patchset is here:

https://patchwork.freedesktop.org/series/100290/
https://lore.kernel.org/lkml/20220217034829.64395-1-jim.cromie@gmail.com/

Its "failing" patchwork CI cuz of a macro warning in dyndbg, which
would be nice for CI to "pass" because its out of DRM tree, and
subject to a separate review process, and in the meantime, it would be
nice to see it under test.


Going item by item:

On Wed, Jul 14, 2021 at 11:51:36AM -0600, Jim Cromie wrote:
> drm's debug system uses distinct categories of debug messages, encoded
> in an enum (DRM_UT_<CATEGORY>),

  enum is now renumbered to 0-15 (fits in 4 bits)
  drm_debug_enabled() does BIT(cat)
  15 is unclassed/reserved

> Dynamic debug has no concept of category, but we can map the DRM_UT_*

now it has "class" keyword, and class_id:4 field.

   #> echo module drm class 1 +p > control # 1=DRM_UT_KMS iirc

This interface is unused yet, DRM is its A-1 customer, are you shopping ?
Since its unused, it cannot break anything not using it :-)

> CONFIG_DRM_USE_DYNAMIC_DEBUG enables this, and is available if

still true.

> The indirection/switchover is layered into the macro scheme:

Heres where the biggest DRM centric changes (vs old) are:

The cDRM_UT_* => prefix-string mapping is gone; while it worked, it
made the literal format strings config dependent, and was more
complicated to explain.  Fitting category into class_id is much
cleaner.

old way replaced drm*dbg with pr_debug (at surface level)
new way adapts drm*dbg to reuse the class-Factory macro under pr_debug.

This loses pr_debug's log-decorating feature, but DRM has its own
conventions, and extra decorations are unlikely to really add anything.
OTOH, drm could re-use those flags to optionalize some of its conventions.

> 0. A new callback on drm.debug which calls dynamic_debug_exec_queries

now in dyndbg, where it belonged.  now just uses class query inside.


This is really awesome. For merging I think we need to discuss with dyn
debug folks whether they're all ok with this, but it's exported already
should should be fine.

< Your (fresh) endorsement should help :-)
Particularly, the new dyndbg features need a user.

> 
> 1. A "converted" or "classy" DRM_UT_* map
>

repeating, 2nd map is gone, DRM_UT_* is merely renumbered.

>    DRM_UT_* are unchanged, since theyre used in drm_debug_enabled()
>    and elsewhere.

I think for the production version of these we need to retire/deprecate
them, at least for drm core. Otherwise you have an annoying mismatch
between drm.debug module option and dyn debug.

< I think this isnt relevant now, since symbols are preserved.

Also, the __drm_debug var is used directly by the CLASSBITS macro,
(and therefore the callbacks), so /sys/module/drm/parameters/debug is
preserved at an ABI-ish level. (__drm_debug now ulong, to work with BIT)

> 
> 2. drm_dev_dbg & drm_debug are renamed (prefixed with '_')
> 
>    old names are now macros, calling either:
>      legacy:  -> to renamed fn
>      enabled: -> dev_dbg & pr_debug, with cDRM-prefix # format.
>

For merging, can we pull out the renames and reorgs from this patch, and
then maybe also the reorder the next patch in your series here to be
before the dyn debug stuff?

< the above adaptation is re-adapted to use dyndbg's new class-Factory
macro, other stuff is gone.


> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  drivers/gpu/drm/Kconfig     |  13 +++++
>  drivers/gpu/drm/drm_print.c |  75 ++++++++++++++++++++++++--
>  include/drm/drm_print.h     | 102 ++++++++++++++++++++++++++----------
>  3 files changed, 158 insertions(+), 32 deletions(-)

update - drm parts are slightly smaller now :-)

[jimc@frodo wk-next]$ git diff --stat master
 Documentation/admin-guide/dynamic-debug-howto.rst |   7 +++++
 drivers/gpu/drm/Kconfig                           |  12 ++++++++
 drivers/gpu/drm/Makefile                          |   2 ++
 drivers/gpu/drm/drm_print.c                       |  56 ++++++++++++++++++++++------------
 include/drm/drm_print.h                           |  80 +++++++++++++++++++++++++++++
 include/linux/dynamic_debug.h                     | 113 +++++++++++++++++++++++++++++
 lib/dynamic_debug.c                               | 140 +++++++++++++++++++++++++++++
 7 files changed, 323 insertions(+), 87 deletions(-)


I really like this, I think you can drop the RFC. A few more things that I
think we need:

- An overview kerneldoc section which explains the interfaces and how it
  all works together. Essentially your commit message with some light
  markup to make it look good.

< not sure anything worth documenting has survived.

- I think it would be really good to review the driver docs for all this
  and make sure it's complete. Some of the interface functions aren't
  documented yet (or maybe the ones that drivers shouldn't used need more
  __ prefixes to denote them as internal, dunno).

- I guess deprecation notice for drm_debug_enabled() and all that, so that
  we have a consistent interface. Doing the conversion will probably

< this keeps drm_debug_enabled(), and __drm_debug, so those users are fine.
__drm_debug_enabled() is optimized version for macro-wrapped sites

highlight the need for a bit more infrastructure and tooling, e.g. the
  bigger dump functions (like edid hex dump, or also the various decode
  helpers we have for dp, hdmi infoframes and all that) ideally have a
  single dyn_debug label to enable all of them instead of line-by-line.
  Tbh no idea how this should work, might need dyndbg work too.

< Factory-macros should help here, havent looked.

- For the driver side of this we probably want a
  Documentation/gpu/TODO.rst entry if it's not all easy to convert
  directly.


> +config DRM_USE_DYNAMIC_DEBUG
> +	bool "use dynamic debug to implement drm.debug"
> +	default n
> +	depends on DRM
> +	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
> +	depends on JUMP_LABEL
> +	help
> +	  The drm debug category facility does a lot of unlikely bit-field
> +	  tests at runtime; while cheap individually, the cost accumulates.
> +	  This option uses dynamic debug facility (if configured and
> +	  using jump_label) to avoid those runtime checks, patching
> +	  the kernel when those debugs are desired.

Can't we just make this an internal option that's enabled automatically
when dyndbg is around? Plus a comment somewhere that we really recommend
enabling dyndbg for drm.  Or would this mean that in certain dyndbg
configurations we'd loose all the debug lines, which would suck?

< I have 'default y' now.

WRT losing debug lines, I cant think how, but it raises a thought; cuz
drm.debug uses .class_id, the mod,func,file info isnt needed to
support queries (other than ad-hoc at >control), drm could drop them.
Its already lost pr_debug's optional mod.func.ln prefix, and cannot
use them for that.  (but Im foreshadowing, see bottom)


Anyway there's a pile of details, but the big picture I really like.
Especially that we can make dyndbg seamlessly support drm.debug is really
nice.

Cheers, Daniel


< Wait, theres more ! (here comes the tease) :-D

0. this patchset and others below are at:

ghlinux-ro	https://github.com/jimc/linux.git (fetch)

lkp-robot <lkp@intel.com> has been helping a lot.

1. dd-drm branch - this patchset

commit 46a5bd89e47d0f7e4ad63b4f574815f01d4290a0
(HEAD -> dd-drm, ghlinux/dd-drm, ghlinux-ro/dd-drm)

passing robot tests.

2. dyn-drm-trc branch - on top of 1.dd-drm

commit 0473a8ecdb15ec0e63644b77da575905c5851462
(ghlinux/dyn-drm-trc, ghlinux-ro/dyn-drm-trc, dyn-drm-trc)

It starts with Vincent Whitchurch's patch:
  https://lore.kernel.org/lkml/20211209150910.GA23668@axis.com/

which (oversimplifying) added a trace-event and called it from
pr_debug, and which met with some approval from Steve Rostedt.

It then recapitulates those changes in drm_*dbg.

3. dd-diet-next - on top of 2.dyn-drm-trc.

passes lkp-robot tests, but still problematic

This splits struct _ddebug in 2, then de-duplicates the _ddebug_site
records (containing repetitive module,filename,function).  In my
fedora-ish config kernel containing ~3100 callsites in builtin
modules, I see ~40% reduction in 24/64 of the full data footprint.
Id expect a little more in modules, due to higher prdbgs/fns ratio.

forex:  (69% compression here)
  dyndbg: 3883 debug prints in module amdgpu (in 1190 functions)

Its incomplete 2x: needs some union-fu, and more work to drop the
.site pointer.  This would drop 8/40 from struct _ddebug, recover another 8/56 of total footprint.

A noteworthy side-effect of this is that it becomes practical to drop
all _ddebug_site data for modules which don't need/want it.

DRM (in 2.dyn-drm-trc) is such a user; it gets the control it needs
using .class_id, and has no log-decoration facility which would use
the 3 fields.  It should just get lots of "_na_"s in cat control.

Dyndbg can be easily fixed to not apply query-commands which specify
those terms to callsites which do not have the data.


Clearly, getting to here is gonna be a many-step process.
DRM buy-in will certainly help :-)


Cheers, Jim
