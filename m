Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD904AA3AA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356041AbiBDW4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:56:36 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47298 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241319AbiBDW4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:56:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F02B7B8395E;
        Fri,  4 Feb 2022 22:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7548AC340ED;
        Fri,  4 Feb 2022 22:56:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XFb/sIN+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644015387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d8OaeDtJfvby3H7njmqvyhzimksV2dqsHsWN5fP89Kw=;
        b=XFb/sIN+nxvgU+RlEz8E2wrJO8uELL6wMBOMEueJLH7snAzU+2wJsvI/L5uQCr5ERAObVy
        STNNaukxB3UfXTXBR5+bhYmdm0V6ZYyzJFhv043wtrDeoQKMLSKdn5PVS3yO0mnWc29MkV
        gAT4MVDVO/Pfsfc828MqqAUbSI8Bn0I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d223bf3c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 4 Feb 2022 22:56:27 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id z62so10711916ybc.11;
        Fri, 04 Feb 2022 14:56:27 -0800 (PST)
X-Gm-Message-State: AOAM530929Z4QW/Lm8wYkyZy8IVttbproavB4Xrx43GDD11GsZgF6BEK
        j7A7II3tUeSW+mBCFmMKQWOfumyUbj6oN5llEIU=
X-Google-Smtp-Source: ABdhPJwrk+I5muLt4wZm6SI6pROxCiEeZHzVxdrsk5PlFW5fOghNTWnQi51OX9ke2zswZvzAJQ5acrPZrYShKunTwhA=
X-Received: by 2002:a05:6902:14d:: with SMTP id p13mr1457700ybh.638.1644015386352;
 Fri, 04 Feb 2022 14:56:26 -0800 (PST)
MIME-Version: 1.0
References: <20220204221733.39411-1-ebiggers@kernel.org>
In-Reply-To: <20220204221733.39411-1-ebiggers@kernel.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 4 Feb 2022 23:56:15 +0100
X-Gmail-Original-Message-ID: <CAHmME9qNcggYVdEK3AmOZFfWmHyFb5WTF6Q8ubyHKE5b=8GPFA@mail.gmail.com>
Message-ID: <CAHmME9qNcggYVdEK3AmOZFfWmHyFb5WTF6Q8ubyHKE5b=8GPFA@mail.gmail.com>
Subject: Re: [PATCH] random: remove use_input_pool parameter from crng_reseed()
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Eric,

On Fri, Feb 4, 2022 at 11:18 PM Eric Biggers <ebiggers@kernel.org> wrote:
> The primary_crng is always reseeded from the input_pool, while the NUMA
> crngs are always reseeded from the primary_crng.  Remove the redundant
> 'use_input_pool' parameter from crng_reseed() and just directly check
> whether the crng is the primary_crng.

Nice simplification, thanks.

Jason
