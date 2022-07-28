Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2335E584442
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbiG1Qfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiG1QfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:35:19 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08EC26C4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:35:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z22so2857082edd.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WuvoJ90b2lCyCsNl1uoWkwZZ34W9Zu4j6EvkcDdXVwQ=;
        b=jvQqyGbQc9RYesbut9vgjY0VzhqNEBnF3cfsQbiO2p4n6Mzc2nJb2+y8eY2mMiOcZD
         VltXGjkq3ui1UvSrfncIGFRJviK9WRplIBZ9tT/01bLoKwiNfLtrSoIEFs/XyOyS7JmS
         n+tGv2wwMpCYk7ehwo72EG/nqoP044Oca6p2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WuvoJ90b2lCyCsNl1uoWkwZZ34W9Zu4j6EvkcDdXVwQ=;
        b=Z16bTWJ3QaXIJTkCgrNGJIbUhDlydHNkrwmBZywIhtTbYGuOwqw9B3Eeve05ZC/7JY
         VrcgcD78CZm1ERJavCEnimzz+65kaz679e13JJXLdCQsP4fOgz7fLrbtXGjwyIACGB93
         /uNs/Ulv5WNnKe1tJufv2PoMqoM8X4OncqhgE/blXPDTdyc+Z2hjSvAhKpGeD8jz8/3M
         dnbBulRZvh18unNWbToCxjJqhnqALzAjREn0REJ/6DUL5yEI/ic2HWkyk9gBieQ/oihm
         LPaIKpaSO0N0XuMoY+Qb2aW5CgmdZctUd225AXe5ZB5YqTiI9E4lOfLz376tB5Bo5+iR
         mk1Q==
X-Gm-Message-State: AJIora+/Qz2mZLrq8oNFvOXK6OIaWYh0PBfpi9yZnUPkssVRBcNcJkkE
        HFUf7pZ2yubN5J07A5pG+KyCBCuaLYJXvApy
X-Google-Smtp-Source: AGRyM1svLPMUMWwYXAdsxGr0N6wfD5+OWTSwDsTmVB2IRlBcpTzrikOm8CmtdJXj2Mo9XWoR1nQTDQ==
X-Received: by 2002:a05:6402:4255:b0:43c:3af9:9653 with SMTP id g21-20020a056402425500b0043c3af99653mr15683984edb.222.1659026113033;
        Thu, 28 Jul 2022 09:35:13 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id b12-20020aa7df8c000000b0043ba0cf5dbasm974330edy.2.2022.07.28.09.35.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 09:35:10 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id v17so2898660wrr.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:35:10 -0700 (PDT)
X-Received: by 2002:adf:ead2:0:b0:21d:8b49:6138 with SMTP id
 o18-20020adfead2000000b0021d8b496138mr18613494wrn.138.1659026109819; Thu, 28
 Jul 2022 09:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220728085412.1.I242d21b378410eb6f9897a3160efb56e5608c59d@changeid>
In-Reply-To: <20220728085412.1.I242d21b378410eb6f9897a3160efb56e5608c59d@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Jul 2022 09:34:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UR+DhWuc555q8dde7MJwgkvG-s1rWYXqQ-afdo3q80pw@mail.gmail.com>
Message-ID: <CAD=FV=UR+DhWuc555q8dde7MJwgkvG-s1rWYXqQ-afdo3q80pw@mail.gmail.com>
Subject: Re: [PATCH] dm: verity-loadpin: Drop use of dm_table_get_num_targets()
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, dm-devel@redhat.com,
        Song Liu <song@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Milan Broz <gmazyland@gmail.com>, linux-raid@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 28, 2022 at 8:54 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Commit 2aec377a2925 ("dm table: remove dm_table_get_num_targets()
> wrapper") in linux-dm/for-next removed the function
> dm_table_get_num_targets() which is used by verity-loadpin. Access
> table->num_targets directly instead of using the defunct wrapper.
>
> Fixes: b6c1c5745ccc ("dm: Add verity helpers for LoadPin")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  drivers/md/dm-verity-loadpin.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

FWIW:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
