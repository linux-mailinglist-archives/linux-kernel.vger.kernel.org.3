Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0D24A7A67
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244115AbiBBV12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240232AbiBBV10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:27:26 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EFAC06173D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 13:27:25 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id i34so1764078lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 13:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vk5wYy3sT4I5WW+WUYmWyAImSgUa3X6inu5KcZCXPKY=;
        b=aENyZMxtUMXciI8o8/Vm8rLMVTMwkMTUfjJ/Gv61rnrp1fCHNR+qb4Ih6z3KIWHXhw
         s373VCw9AWxxeLrFacSEm4Gnpw0b+qTknppxCbYyULRkOKgD6E9pz34SgGO8qj+IPsdi
         YnqpBtc56ZqzQQjKXV9BQmLDHQNKnEu6G4Bg9LYVdTi7cllMQ0ThOesYqVblF5tRNKe7
         xOIQyekXcQTHn5EzdoIeKu6Iv3dQ6jyhNYlzRhFnEcI94cKlrmCoUSI1tYWV1F2FuP2K
         vmZkR7+CzSYMh0k0GdSower3/61Aazzj6k2MEh5MgsBbBZCStEbc/DRnHefWMmmTQ2Ha
         4sYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vk5wYy3sT4I5WW+WUYmWyAImSgUa3X6inu5KcZCXPKY=;
        b=2HxxiFntjpj1JaYStSk8PSXs/ooJUwvkXiJmjZeWNCTiZbKrkGayXiijr330ydMb81
         YHwmVCcbXCO9JXwJwXUHy1u7sXNB/fAv4V0aBN3HXrGj8o7m6ZvhERAjb8wBNtGTdvWS
         tC81q/FCM5xDPoszSMtGxftl7uq8ST96RB7NdOTISzcCEDbE7yqCLt879kGy5msG8/F1
         +V/i472gs9dNI7YB2TgNnA8VGIxuJ+VUVI1Zco0SgpKwyDEiOc7Zcei6P10Rx/kYpmo6
         jVZWQs7zVaDy435Gm5nj50uqruVGVERcKTCZGueCHxfb5HblE/JcKQwBMVUxeP59ovhk
         ciSA==
X-Gm-Message-State: AOAM53218wXRtCg1QpManG3ekaok1rH2dOuAZMrgp9y0D94GbE8RvqRx
        qL+PR22iG5YnG7GtYb9APpV6ujiLRBk1kk2J7tRjow==
X-Google-Smtp-Source: ABdhPJyVqcYu3VpsE+xUOxSO999oM0orrVsNe7CURCcH7MfcCvDqjXznVMXZdNpW6flzSa772wPoyzvt1jlwncMP0EQ=
X-Received: by 2002:a05:6512:3ba5:: with SMTP id g37mr24568699lfv.651.1643837243564;
 Wed, 02 Feb 2022 13:27:23 -0800 (PST)
MIME-Version: 1.0
References: <20220202003033.704951-1-keescook@chromium.org> <20220202003033.704951-5-keescook@chromium.org>
In-Reply-To: <20220202003033.704951-5-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 2 Feb 2022 13:27:11 -0800
Message-ID: <CAKwvOd=icTwyFb39U3OO5i_2YNJMiCMteeNTrVe-Q0tcmmnBJQ@mail.gmail.com>
Subject: Re: [PATCH 4/4 v5] fortify: Add Clang support
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 4:30 PM Kees Cook <keescook@chromium.org> wrote:
>
> +#define BOS    const __pass_object_size(1)
> +#define BOS0   const __pass_object_size(0)

A dumb bikeshed, but would you mind naming these BOS1 and BOS0, and
perhaps consider adding a comment or pointer or link to something that
describes why we use the two different modes?  I recognize that the
code already uses the two different modes already without comments,
but this might be a nice place to point folks like myself to so that
in a month or so when I forget what the difference is between modes
(again), we have a shorter trail of breadcrumbs.
-- 
Thanks,
~Nick Desaulniers
