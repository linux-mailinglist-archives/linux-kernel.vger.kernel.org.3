Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C227474D54
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 22:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbhLNVmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 16:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbhLNVmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 16:42:49 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CB0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 13:42:49 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id v16so2316393pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 13:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LXswzQQIUbnsH89DKIsLGEHvU+q7ZhGpPZRWb6pLn40=;
        b=h3X3g6TGJIjhj++PPZ4wYq4hvoC88IYObA7l+ZQAeBcGmsnsvphB8Niq0ZLwviEhMo
         pV1DNGEfaujlz5Jfvz4TPBelKXdo7xcsSzeSefL1Z/3YS2LwPuTFRVTXuW/rTPwJe4ro
         1Tzpt+6xn60Uy/KCwLe34O2sQDzqMk9Lrrh8dF6hDiROrQ/XgN2yKKQQcUVn9Dx3m1/M
         iK7jhGXnoSX/xszyfhzRxLltPLtytBZzZPFJB5hi7+4oTYW9GXROXW3jMqQ4l3ei5IJC
         zcfmtmhsDfds0enGEPOPw97unnXlBpYIq4AOKKU7/0CEaABFHuNyu7t2Jyr9b/Q9G5xe
         jErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LXswzQQIUbnsH89DKIsLGEHvU+q7ZhGpPZRWb6pLn40=;
        b=ir+fg4+Zim1a7o6A1hEPqxxh3bBC9VRyIn/gZH8/2i+Pzvf6MSg/vzY6fUPkarz48x
         Ves1CHqX1mSZMMQOGtt8FxkiO9XE4AfN3d9oQB7ZdfVNr4cGwwHRjzLClcpZjLDbONsQ
         C4yfKf/TjK2Xkf1Qv+lxwStrKzHDRGgiA5GqZTTU9QQ0J2J31OAUtlIkGHxrzwpnVPpW
         0WLwSd17o8ksQNl1uiwZNvNHZFUD7bYhMwPktvoFLuzJG8tYVYh3+r6uMcGvmglwihxT
         xAcX4mwRQCVazz09rQhaH0iaboLZgbNDdd+A4QJ+llv0o+JtWkRncpHY7awztQ31fW5Q
         DVtw==
X-Gm-Message-State: AOAM533zGueZGWHdlGipI5wZiC7R7L3//UsTlNMaFE+EHcCG4gY6OgMp
        P9NIaiFPwsgyy3vyXELhuh71trdTNppYo6oog3qJ6w==
X-Google-Smtp-Source: ABdhPJxiGa9ZmzjqaVmXDV74capr+NY44f1yVhlLZw1Z4DCDaKQQ36BSQdJtpHiwE9VB3/7/bwUKVzeA3V0arZMc52k=
X-Received: by 2002:a17:902:8f88:b0:148:a2e8:2c2f with SMTP id
 z8-20020a1709028f8800b00148a2e82c2fmr1385004plo.126.1639518168819; Tue, 14
 Dec 2021 13:42:48 -0800 (PST)
MIME-Version: 1.0
References: <20211214193010.138458-1-dlatypov@google.com>
In-Reply-To: <20211214193010.138458-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 14 Dec 2021 16:42:37 -0500
Message-ID: <CAFd5g44LbKf_ZW1N7QhmpnTSKAc_yu57E++pk7BAbfT29mpBHA@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: make `build` subcommand also reconfigure
 if needed
To:     Daniel Latypov <dlatypov@google.com>, skhan@linuxfoundation.org
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 2:30 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> If I created a kunitconfig file that was incomplete, then
> $ ./tools/testing/kunit/kunit.py build --kunitconfig=my_kunitconfig
> would silently drop all the options with unmet dependencies!
>
> This is because it doesn't do the config check that `kunit.py config`
> does.
>
> So if I want to safely build a kernel for testing, I have to do
> $ ./tools/testing/kunit/kunit.py config <flags>
> $ ./tools/testing/kunit/kunit.py build <flags, again>
>
> It seems unlikely that any user of kunit.py would want the current
> `build` semantics.
> So make it effectively do `kunit.py config` + `kunit.py build`.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Looks good. Thanks for rebasing this!
