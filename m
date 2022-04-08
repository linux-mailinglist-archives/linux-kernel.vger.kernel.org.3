Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A41E4F9471
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbiDHLu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbiDHLu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:50:27 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D9F1F127C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 04:48:22 -0700 (PDT)
Date:   Fri, 08 Apr 2022 11:48:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1649418500;
        bh=Zvbi7xqEswNRrjsp8sgXVujH0Lr0d/k1PRut6FcweZY=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=hemnCB5PgV6MjKUqiZcXyUtavYgatU3HjzR5zjUPE3u4KXYfkBfTlt8no33INNxWW
         KJRsLOwEe1yoJ+Uqp/C3IT4LCEEhVivfaLb4HC6qOw/2vfBQm8o7WPHmhQyNdMz1nq
         vEtpdnbFTrTpiC1ZW21UpBt8M1VMBr04UGxJrailoyJmbk6zVqUIl9ast2Ae+C9ftD
         xYeibHwc1dbSsi5HSPRz1lK65BJJLVmRzrUgVRqTtnqepmz+okiM+rCiwJp36Ei21/
         Gsg9VN/SP0FqSxxoM5wndaCL9/2jEBfpVRrDft+Y3VO7+56GM5yXbZwb4Esb1SC5+d
         jpDph04eTdTDA==
To:     Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
From:   Simon Ser <contact@emersion.fr>
Cc:     Grigory Vasilyev <h0tc0d3@gmail.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Evan Quan <evan.quan@amd.com>,
        Sean Paul <seanpaul@chromium.org>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amdgpu: Fix NULL pointer dereference
Message-ID: <QfKpxmkE_cy9wt5VJruw_TSdnl5KceKM8BxJGmZSBs-KiaRwIYfgc8h_-5h7Wmj6G-NtUJ3A88V5pzPvZuLlpkK-oRO5pSjeTxwHcZWlogs=@emersion.fr>
In-Reply-To: <CAP+8YyED70CSqVRaB7JgrAtK-yvBx5EsvrrdR7EpvOG2AVhskQ@mail.gmail.com>
References: <20220408092803.3188-1-h0tc0d3@gmail.com> <4o2YD5id7zhK5g__CUK3Yf-6Dj459XQ0qsydW6wKHdco3YYtl78BqGUfXvQ9UO0AZoAsMPfhFB0jw1BFldiFDcbZXmGgsobuAoTMWmoDqmE=@emersion.fr> <CAP+8YyED70CSqVRaB7JgrAtK-yvBx5EsvrrdR7EpvOG2AVhskQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, April 8th, 2022 at 13:28, Bas Nieuwenhuizen <bas@basnieuwenhuize=
n.nl> wrote:

> On Fri, Apr 8, 2022 at 12:01 PM Simon Ser contact@emersion.fr wrote:
>
> > Is amdgpu_display_get_fb_info ever called with NULL tiling_flags/tmz_su=
rface?
> > If not, there's no point in adding NULL checks.
>
> It isn't called with NULL anywhere, the NULL checks that already exist
> seem redundant.

Grigory, would be be willing to submit a v2 which removes the unnecessary
NULL checks?
