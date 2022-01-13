Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBDE48D941
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 14:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiAMNod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 08:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiAMNoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 08:44:30 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2757C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 05:44:30 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id z22so14567852ybi.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 05:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t4iOUVFv53bNQSQ/gO0aroSu848/nmRUJMS9RO8UVKs=;
        b=L3t/7x5E6+oOdmCJJKKVoRGWTgQRkrBeAvTi/BR6XX6Q5XLRVBspgMP0moqqe1UGKu
         ddfQ5RrHcPahfVgeYOmn5AHJlMWc+TOAeWBWMgyMUnrivvh+PMMHgT209bAyuKNQKk3P
         k5e1boYAvB/kJ+LnMsQsDhZiHUXhb1sNYO6pAdHkXjVzD2b9imk89CO5pjBTJ1gRqmjn
         1rGkYILN48K3Xm/0nFyBivNcRKr+prkJFgLFQudXjewMCIb583bksfZpHF2EAupjIetP
         8tVVIFo+S6Vc8JE8qXdS6cSLm37UHqx/W5t6Ee+cWLutbIkIgEgGhIgQ0VWxA2nXMH26
         UgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4iOUVFv53bNQSQ/gO0aroSu848/nmRUJMS9RO8UVKs=;
        b=hFGN3SoCs8YElAuv+wvAA94X8OdjjVjgzG0gr+cLCKQGU3kloOmHWNSucfhioKEBmr
         qQLGYa/apAcJPkNwSmz9lz4vW4lVDsKPyPjGizcY2Cw8+4IIQnNAFn3Cfr1fiVGVZi60
         NCCMp07joNv9u3vnxwJ7k77EH57z2dA/Q2Jmtnnj7YCLSCltJ84kVfQgF4rcCcAfY7nv
         x3IiINUqBvGOu28r//EmododetgGi4GCMzbI0/83iACSqmKCABCDZtA/DxcjuVQNyGsk
         qwPNYDElvahUqWcWqERCD0yinN6hJ1LsiYWEf3Pb4jRlAG80PfZQ/RWWFUIq1XB1Q9MB
         O8KA==
X-Gm-Message-State: AOAM53330w0F4I4tOzP2XLUgWuwX7qC/fsHacttt0ceqX9rwOWof8kjy
        5oqk1UGpnm8G+AmTefPXZ8sivD1B9BgpUFIjA72oNQ==
X-Google-Smtp-Source: ABdhPJwo6URqBePslK+oKLzNiKNduFsi241hMu0BUXNptg5RSut3Cj4rzAH5lLArTqXi4SXz//NaTZwj4mHiagIizJ4=
X-Received: by 2002:a25:7b44:: with SMTP id w65mr5871202ybc.59.1642081469812;
 Thu, 13 Jan 2022 05:44:29 -0800 (PST)
MIME-Version: 1.0
References: <20220113094419.12433-1-etom@igel.co.jp>
In-Reply-To: <20220113094419.12433-1-etom@igel.co.jp>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Thu, 13 Jan 2022 13:44:18 +0000
Message-ID: <CAPj87rPk3_8LdnwWJ3BhtJnRuR+_WHg2hfdgK2R4SMacPGCrUQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] Add support modifiers for drivers whose planes
 only support linear layout
To:     Tomohito Esaki <etom@igel.co.jp>
Cc:     dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Simon Ser <contact@emersion.fr>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Mark Yacoub <markyacoub@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Evan Quan <evan.quan@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Esaki-san,

On Thu, 13 Jan 2022 at 09:44, Tomohito Esaki <etom@igel.co.jp> wrote:
> Some drivers whose planes only support linear layout fb do not support format
> modifiers.
> These drivers should support modifiers, however the DRM core should handle this
> rather than open-coding in every driver.
>
> In this patch series, these drivers expose format modifiers based on the
> following suggestion[1].

Thanks for the series, it looks like the right thing to do.

Can you please change the patch ordering though? At the moment there
will be a bisection break at patch #1, because the legacy drivers will
suddenly start gaining modifier support, before it is removed in patch
#2.

I think a better order would be:
  1: add fb_modifiers_not_supported flag to core and drivers
  2: add default modifiers (and set allow_fb_modifiers) if
fb_modifiers_not_supported flag is not set
  3: remove allow_fb_modifiers flag

Cheers,
Daniel
