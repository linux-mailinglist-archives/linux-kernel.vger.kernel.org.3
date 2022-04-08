Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494D64F969F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiDHN3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbiDHN3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:29:06 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056A1116B50
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:26:58 -0700 (PDT)
Date:   Fri, 08 Apr 2022 13:26:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1649424416;
        bh=xKdnbX/uu4zDxFZ8hCkBVd/wtWNCWZBH1JAcwPtLw/U=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=LIdIuHNo44bjyNxrW+WjYFfH/4NTVydxbOGEB5iHHJ3owDhI4nYaiOvipxfn+FXvy
         ISRv3yZxCJWe8nQIA+ES9ZFYs7Jhe+sXhp3X8qfjIK1tltflAvTcAUkIyz2okxJiOn
         Zx6dmDOJ6pBaKfMrw1tK0kMiaQ4KAsz3eAPmgzBLiWEWnj+5Ym6Xg+FUNd8bTi3jHZ
         VWAJdM/yRINXPQFHaVfE438ETtnh/XPI90OfXoTxM91zwnBG69RVqDCRevgTx8iRNS
         IOjnq3OqvlRm0L5NAM6LToaXr+Nq6HbePYTbRzixIBO9e1CiSKJSr5s4urJpVoLlp+
         vI7nkcslF/stQ==
To:     Grigory Vasilyev <h0tc0d3@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
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
Message-ID: <2GaGJp5T0FARGpEE4FSEdCCQQNOecHtBBdQxqneeCWad2PD7gKqhp6-2LhdZSpTvDToW2kKggbfzlcvw9vsM7L_kJXo1uMNjoiAHJ4bQAjI=@emersion.fr>
In-Reply-To: <CAD5ugGD6QzCUqk7_EVwH9Cc6PQtx_VfjVRWzzP9uKR5tkGh1RQ@mail.gmail.com>
References: <20220408092803.3188-1-h0tc0d3@gmail.com> <4o2YD5id7zhK5g__CUK3Yf-6Dj459XQ0qsydW6wKHdco3YYtl78BqGUfXvQ9UO0AZoAsMPfhFB0jw1BFldiFDcbZXmGgsobuAoTMWmoDqmE=@emersion.fr> <CAP+8YyED70CSqVRaB7JgrAtK-yvBx5EsvrrdR7EpvOG2AVhskQ@mail.gmail.com> <QfKpxmkE_cy9wt5VJruw_TSdnl5KceKM8BxJGmZSBs-KiaRwIYfgc8h_-5h7Wmj6G-NtUJ3A88V5pzPvZuLlpkK-oRO5pSjeTxwHcZWlogs=@emersion.fr> <CAD5ugGD6QzCUqk7_EVwH9Cc6PQtx_VfjVRWzzP9uKR5tkGh1RQ@mail.gmail.com>
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

On Friday, April 8th, 2022 at 15:21, Grigory Vasilyev <h0tc0d3@gmail.com> w=
rote:

> Simon Ser and Bas Nieuwenhuizen, do you understand that you are
> proposing to make the code less safe in the future? In the future,
> someone might rewrite the code and we'll get an error.

I don't think we should blindly add NULL checks for all functions which
take a pointer as argument. This makes it way more complicated to find
a bug when the function is mis-used. Crashing is better because it
indicates a programmer error. In the future, any new call with a NULL
pointer will produce a clear error.

Using pointers for output values is a common pattern in C, it allows a
function to return multiple values.
