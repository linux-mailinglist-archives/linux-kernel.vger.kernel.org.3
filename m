Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C474C48ED47
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbiANPm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:42:58 -0500
Received: from mail-4323.proton.ch ([185.70.43.23]:59659 "EHLO
        mail-4323.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiANPm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:42:57 -0500
Date:   Fri, 14 Jan 2022 15:42:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1642174975;
        bh=EDKmMDpJ4aF8Jp9f8mriWffkkG6VIvSJs4wR/AP+ggA=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=m5aL4UXJkpjG0FRD9uFetuEs+xpH+kXIMKqxUSkXtD9HMRy8geRSGttKTRj9N6qHf
         sUfn1Sip08X5dbDnVeC3bHDbv0dIsUXfFMs70iR6N1s+DPNEQCS1S1IPJny7HNDnz0
         CbgAp5WmoKrU2W2dF20PQYvmFTHaYgx9S+o4NP/suE1AAOnoZ5la2zx3F1sjzzBIYL
         mNTPnhJK7tzj0E6324hNyzhxEnE42IUE6Y2ORoHzfZs0zze3CVghcaxDAiDfrtt38M
         K442F2rVZkm8DcV0ikY1XLCz3MMuc5av/OizhUhgJRh2Lm/6RcHyIWgMiniuxCcIz5
         ZqRULRIgThSXg==
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Tomohito Esaki <etom@igel.co.jp>, dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        =?utf-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Mark Yacoub <markyacoub@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Evan Quan <evan.quan@amd.com>, Petr Mladek <pmladek@suse.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org, Daniel Stone <daniel@fooishbar.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [RFC PATCH v3 2/3] drm: add support modifiers for drivers whose planes only support linear layout
Message-ID: <HlAWH76EJyftP63YJq3RteG0352axOjZgfftI2FwvQSapuSXn_sN1j3XhBXcql0GZbLe4YTQ5KO0R-TdtBC-SUCf8Br6j__CoU5GpT9ln8g=@emersion.fr>
In-Reply-To: <YeGUIYK3hYo7wLJt@smile.fi.intel.com>
References: <20220114101753.24996-1-etom@igel.co.jp> <20220114101753.24996-3-etom@igel.co.jp> <YeGFugZvwbF7l2I/@smile.fi.intel.com> <7eljcd3F4aWL2jjBRwr3DISmyt0XPWFIH1_kebFGqZTJXLZRx0bm_8c8yaIuEuH8rS0MaJhU6SY1y-fc6U_zCLaKgoLM124nZpr0H91nSjw=@emersion.fr> <YeGUIYK3hYo7wLJt@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, January 14th, 2022 at 16:17, Andy Shevchenko <andriy.shevchenko@=
linux.intel.com> wrote:

> On Fri, Jan 14, 2022 at 03:07:21PM +0000, Simon Ser wrote:
> > On Friday, January 14th, 2022 at 15:16, Andy Shevchenko <andriy.shevche=
nko@linux.intel.com> wrote:
> >
> > > Why not enum?
> >
> > There is no enum for DRM format modifiers.
>
> I'm not sure how this prevents to use enum in the code instead of const u=
64.
> Any specific reason for that?

I'm not sure how one would use an enum as the array item type, when there i=
s no
defined enum type.

Moreover, all the rest of DRM uses uint64 for modifiers.
