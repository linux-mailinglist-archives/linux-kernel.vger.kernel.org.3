Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDDA4CD9C2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbiCDRJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiCDRJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:09:38 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7105670045;
        Fri,  4 Mar 2022 09:08:50 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id k2so8409906oia.2;
        Fri, 04 Mar 2022 09:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gi/unIqjj+EE1Nzn6J49QLVgnUqGPh615g5SFKJniNA=;
        b=nsFYJv4oWBuqxGTF0HQ7cnTNw6KmBoJ+JvjdHUMiOXYkLuKwr4OPDPojSMLxd+LHlh
         5/v7eI1MdqWL7kO974UCQeNRDSRpJKp6xUeRnEIKWDpID81sc/5e7Swpt8Q0mgEEUuXm
         avEufNonnAOcFHW17q6HQgLwiXF2kdDm68w3UOcrQWSP1VLts+QW8f9Pw1l8MBOOzD9z
         Ezz+W8xfv7RlbwFJTpdJnqHzeSQYQ7gAODdGGpuumG5DWBej3dN5RAHBE9ciIUoh/C0J
         SZE142AstxXAFv02FgCJXKSUHplHirhqMIBDxHl61J1Jp/DAXu2iLk3Uz848EPmweC9l
         y6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gi/unIqjj+EE1Nzn6J49QLVgnUqGPh615g5SFKJniNA=;
        b=kJ2IUQA2uqZ2UJ57YS+6xFTTcmu/oAkJecFwIjQnEKgcidI/vp28R3bSiLsUE8PcAc
         UZQ3XHcNaWWCZu1Z9mXoR2nsFIXkEfq0u90mrbmNUirIzPD0iNPwT5Wp1slb/evHbneu
         OSoaNxj/jtOMJOJiX7pRlzhurSXP6gH9U3Pc6b+F9bFDO+cLxOa2Puvp74BAraIXogvx
         Kji5hhV27Gglh5hJ4K9p10iowiyHdW7KuZXtqeIAKXvVnr1TaNwugOygDl+7JxvVOf38
         wAdjZOpFI0E+oNJKAnN7e/bB0Gji/ohcvtLSFQDY+Z/tpddS+gFR3LXR8GcVV1Hg8fFs
         jBCg==
X-Gm-Message-State: AOAM533TzQ57xUQgwKLY40pLTlg2LxsPdAkZxfPFsS8u0c7GZLWgXvOj
        X2erlM0DpOCohOQrUTDzE2ALQvXT1JYaKc6kX60=
X-Google-Smtp-Source: ABdhPJx/Z2+3w9vow2hddhT2Ieli5lnM7myxL9Kbn0KIBh++s/pr3Ofj6bvN+QEsl1Mjn/ULhvBd0VbnZtrk9bwq8I0=
X-Received: by 2002:a05:6808:1281:b0:2d9:a01a:4bd6 with SMTP id
 a1-20020a056808128100b002d9a01a4bd6mr42381oiw.253.1646413729711; Fri, 04 Mar
 2022 09:08:49 -0800 (PST)
MIME-Version: 1.0
References: <20220303172503.GA1731116@embeddedor> <202203030937.5BFE3EF@keescook>
 <20220303181957.GA1731711@embeddedor> <20220303204526.GA1733280@embeddedor>
In-Reply-To: <20220303204526.GA1733280@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 4 Mar 2022 12:08:38 -0500
Message-ID: <CADnq5_M6bJUOOY3Uc-8+grGKQTL=AsXC9SXaO4KYdc=z7WVGtg@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: Fix Wstringop-overflow warnings in dc_link_dp.c
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Leo Li <sunpeng.li@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 3, 2022 at 3:37 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> On Thu, Mar 03, 2022 at 12:19:57PM -0600, Gustavo A. R. Silva wrote:
> > On Thu, Mar 03, 2022 at 09:43:28AM -0800, Kees Cook wrote:
> > > On Thu, Mar 03, 2022 at 11:25:03AM -0600, Gustavo A. R. Silva wrote:
> > > > Fix the following Wstringop-overflow warnings when building with GC=
C-11:
> > > >
> > > > drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dpia.c:493:17=
: warning: =E2=80=98dp_decide_lane_settings=E2=80=99 accessing 4 bytes in a=
 region of size 1 [-Wstringop-overflow=3D]
> > >
> > > Can you "show your work" a little more here? I don't actually see the
> > > what is getting fixed:
> > >
> > > enum dc_lane_count {
> > >     ...
> > >         LANE_COUNT_FOUR =3D 4,
> > >     ...
> > >         LANE_COUNT_DP_MAX =3D LANE_COUNT_FOUR
> > > };
> > >
> > > struct link_training_settings {
> > >     ...
> > >         union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX=
];
> > > };
> > >
> > > void dp_hw_to_dpcd_lane_settings(
> > >             ...
> > >             union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP=
_MAX])
> > > {
> > >     ...
> > > }
> > >
> > > static enum link_training_result dpia_training_cr_transparent(
> > >             ...
> > >                 struct link_training_settings *lt_settings)
> > > {
> > >     ...
> > >                 dp_decide_lane_settings(lt_settings, dpcd_lane_adjust=
,
> > >                                 lt_settings->hw_lane_settings, lt_set=
tings->dpcd_lane_settings);
> > >     ...
> > > }
> > >
> > > Everything looks to be the correct size?
> >
> > Yep; this fix is similar to the one for intel_pm.c in this
> >
> >       commit e7c6e405e171fb33990a12ecfd14e6500d9e5cf2
> >
> > where the array size of 8 seems to be fine for all the
> > struct members related (pri_latency, spr_latency, cur_latency
> > and skl_latency):
> >
> > drivers/gpu/drm/i915/i915_drv.h:465:struct drm_i915_private {
> > ...
> >
> > drivers/gpu/drm/i915/i915_drv.h-739-    struct {
> >
> > ...
> > drivers/gpu/drm/i915/i915_drv.h-745-            /* primary */
> > drivers/gpu/drm/i915/i915_drv.h-746-            u16 pri_latency[5];
> > drivers/gpu/drm/i915/i915_drv.h-747-            /* sprite */
> > drivers/gpu/drm/i915/i915_drv.h-748-            u16 spr_latency[5];
> > drivers/gpu/drm/i915/i915_drv.h-749-            /* cursor */
> > drivers/gpu/drm/i915/i915_drv.h-750-            u16 cur_latency[5];
> > drivers/gpu/drm/i915/i915_drv.h-751-            /*
> > drivers/gpu/drm/i915/i915_drv.h-752-             * Raw watermark memory=
 latency values
> > drivers/gpu/drm/i915/i915_drv.h-753-             * for SKL for all 8 le=
vels
> > drivers/gpu/drm/i915/i915_drv.h-754-             * in 1us units.
> > drivers/gpu/drm/i915/i915_drv.h-755-             */
> > drivers/gpu/drm/i915/i915_drv.h-756-            u16 skl_latency[8];
> >
> > ...
> > drivers/gpu/drm/i915/i915_drv.h-773-    } wm;
> > ...
> > }
>
> and in this case the ilk_wm_max_level() returns the right maximum size fo=
r the
> corresponding 'struct wm' member:
>
> drivers/gpu/drm/i915/intel_pm.c:2993:int ilk_wm_max_level(const struct dr=
m_i915_private *dev_priv)
> drivers/gpu/drm/i915/intel_pm.c-2994-{
> drivers/gpu/drm/i915/intel_pm.c-2995-   /* how many WM levels are we expe=
cting */
> drivers/gpu/drm/i915/intel_pm.c-2996-   if (HAS_HW_SAGV_WM(dev_priv))
> drivers/gpu/drm/i915/intel_pm.c-2997-           return 5;
> drivers/gpu/drm/i915/intel_pm.c-2998-   else if (DISPLAY_VER(dev_priv) >=
=3D 9)
> drivers/gpu/drm/i915/intel_pm.c-2999-           return 7;
> drivers/gpu/drm/i915/intel_pm.c-3000-   else if (IS_HASWELL(dev_priv) || =
IS_BROADWELL(dev_priv))
> drivers/gpu/drm/i915/intel_pm.c-3001-           return 4;
> drivers/gpu/drm/i915/intel_pm.c-3002-   else if (DISPLAY_VER(dev_priv) >=
=3D 6)
> drivers/gpu/drm/i915/intel_pm.c-3003-           return 3;
> drivers/gpu/drm/i915/intel_pm.c-3004-   else
> drivers/gpu/drm/i915/intel_pm.c-3005-           return 2;
> drivers/gpu/drm/i915/intel_pm.c-3006-}
>
> drivers/gpu/drm/i915/intel_pm.c:3009:static void intel_print_wm_latency(s=
truct drm_i915_private *dev_priv,
> drivers/gpu/drm/i915/intel_pm.c-3010-                              const =
char *name,
> drivers/gpu/drm/i915/intel_pm.c-3011-                              const =
u16 wm[])
> drivers/gpu/drm/i915/intel_pm.c-3012-{
> drivers/gpu/drm/i915/intel_pm.c-3013-   int level, max_level =3D ilk_wm_m=
ax_level(dev_priv);
> drivers/gpu/drm/i915/intel_pm.c-3014-
> drivers/gpu/drm/i915/intel_pm.c-3015-   for (level =3D 0; level <=3D max_=
level; level++) {
> drivers/gpu/drm/i915/intel_pm.c-3016-           unsigned int latency =3D =
wm[level];
> drivers/gpu/drm/i915/intel_pm.c-3017-
> ...
> }
>
> still GCC warns about this with Wstringop-overread, as it is explained
> in commit e7c6e405e171.

Did you want to respin with expanded explanation?

Alex

>
> --
> Gustavo
>
> >
> > however GCC warns about accessing bytes beyond the limits, and turning =
the
> > argument declarations into pointers (removing the over-specified array
> > size from the argument declaration) silence the warnings.
> >
> > --
> > Gustavo
