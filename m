Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE13C474D56
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 22:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbhLNVoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 16:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbhLNVoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 16:44:02 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48028C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 13:44:02 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id g19so18938265pfb.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 13:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVJAe3f0Z5eqNi3sM9iQGEnyhWGwhAY+u+A3rnH7GXU=;
        b=pSSYw2Pt8l4ROIISR28TG04nxI7zhkAD/cBk/9APNMduEGKA+8axmrbpoAxt7V5daE
         /3AMUDoA9eKDB79ikMHzoUnRwKveukZCpQLHV42mJFgdnASbWbx+GwaxFe9tsKvoun2U
         87xY7uAyqm1bHNKCKUMUajaHEIzl5Bz/ri+W5RTR22LXIeJLzSiT5uODLwObcEIcjzBV
         qvR8TbTgk12nRJFCgBcC8FaaAyLmbaMLvu5SF2rSOnpq8EplLkdXyDmfWi7RIJgFAE0s
         FMOlQfIwFdmpSohgXSgwGyKn2heFga/B5pUehQwVOLDf1JLMADgcy5T4w9vN3NPUtQL+
         G5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVJAe3f0Z5eqNi3sM9iQGEnyhWGwhAY+u+A3rnH7GXU=;
        b=eW5ricQ400VI9zeLbITiNWtOnvPY5L99XU7ha5O8pHBsxfMKTonVFLJTEhyjM/KqRr
         S4vfplUgP8pfkPSAkznn/i08zaZsKtS8PFCNCfChgS+LIPxHAJMWWqS061en5vVrBOAD
         YEXWLO46EXQmZsr4MEPOxW8Ky32sCgmitax/d4k0XKQmnJmSbtgvgg4GxB+CvVHiXZIp
         3URGyHu+6I2RG97rGnW5HhtwZJCnUE6KLIJ0c/jhyBg0Z+eOUTdtotrU7CLHLJDI7QAi
         XcIWLr3wjvvNXCvWXePQ+KtKC+C4ImtkUgG5M1DxaZmT9XJqEMoniKh/uR6U+LAItJz4
         oPDg==
X-Gm-Message-State: AOAM530XwQ+5Es8FrHGd6tEQmiYfhfjc8e3DZMH753ujgNCitWucuXmg
        UrhpxonckXuMlWFQK3rtJ5Xb5sK6m0mE8DddC3NgDg==
X-Google-Smtp-Source: ABdhPJz3ZyxeRv4cKrH8u0a9sC31mbfOEz6K+XC1VNxa2Wi3wVAQNlOXSo37bDu4pgooit0KOyrMZMPL3JeN0y59QtQ=
X-Received: by 2002:a65:590e:: with SMTP id f14mr5225001pgu.609.1639518241478;
 Tue, 14 Dec 2021 13:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20211214192612.134306-1-dlatypov@google.com>
In-Reply-To: <20211214192612.134306-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 14 Dec 2021 16:43:50 -0500
Message-ID: <CAFd5g45fP3OuRh-uWeLMYU+YBOFKGBKmzSbXKuWu9QstAD3mRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kunit: tool: use dataclass instead of collections.namedtuple
To:     Daniel Latypov <dlatypov@google.com>, skhan@linuxfoundation.org
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 2:26 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> namedtuple is a terse way of defining a collection of fields.
> However, it does not allow us to annotate the type of these fields.
> It also doesn't let us have any sort of inheritance between types.
>
> Since commit df4b0807ca1a ("kunit: tool: Assert the version
> requirement"), kunit.py has asserted that it's running on python >=3.7.
>
> So in that case use a 3.7 feature, dataclasses, to replace these.
>
> Changes in detail:
> * Make KunitExecRequest contain all the fields needed for exec_tests
> * Use inheritance to dedupe fields
>   * also allows us to e.g. pass a KUnitRequest in as a KUnitParseRequest
>   * this has changed around the order of some fields
> * Use named arguments when constructing all request objects in kunit.py
>   * This is to prevent accidentally mixing up fields, etc.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Looks good. Thanks for the rebase!
