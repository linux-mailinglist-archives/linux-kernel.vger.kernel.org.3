Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789D949C033
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 01:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbiAZAgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 19:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbiAZAgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 19:36:12 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB442C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:36:11 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id m11so66218822edi.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oXZqBE0q9OTqMHj3VdB5E02o4A6FjZEHOwhK0PXA+iU=;
        b=Bq9cmOB9xSKfZwy7Sb1XHF82ViyWkrje71gb/xt7h6ltMt4beZ5ceHBDi96kl0nAsy
         7hwTrD2JuT4/B6Lxq9l9pEyKUoTnD45PPoNywBMh9zQ/VSEaUXGi8Cb7cboTYLHZRkFc
         2J7zO9jzPrpkNBZ3wyV7yRdQP9RjmM8yzGHmRpzdBLGpNFUhhwAK63gDPwV6Srikwyeq
         1q5oROvo9gb5pyYQ7RDMtAA+jJStxllOIiLe7rTZW7Kj/IHIQKSRN84w/6pKz/eJ6KDM
         mglRA+0XbSyg6dRCLAgGLLT6P95YsSuYQwvrk/4eImwAngVNZSkPnaA0JXhLlcM+hj1H
         S33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oXZqBE0q9OTqMHj3VdB5E02o4A6FjZEHOwhK0PXA+iU=;
        b=GyiUL2q57AWvgzFkjS/VzYBAo4eypIAe0TBB0U73loW7kxwxbKBFzzh+pcA1fdcu2L
         YO+CxyPOB+is+TCh8XeeiPFcF5+4FZ6+u/XGlJ8JsGws7LyW9+MS8cVNkvka+6w9XZuT
         r5uv3L5XHwz26mBKheNkUnWcW0p7auDkFBGb8tlhBgaUlF47KwnwMaw8brlbjE03x8uP
         Z07ftnW5yEISvrObfj18TUDZaPATv+Xjy+tXJDsJPRbEvOV7a76Y5DV5KUy+QYyk6h4k
         ZDrsAM4S76ldbv/J3mxs+JgPrDNiXpSHMs/535tZsNM7TOADWTV76S12ICFGgHZRXTLc
         olzQ==
X-Gm-Message-State: AOAM532dvI5PZEkxvDBuG2DGfQk/d2u38UQrGG5mGNIR6WqYvJagRNo6
        KD4FNpKAg9JWzpzT4XVzVonPOj+/1Nh3ZahUW2KKsp8MfN9z
X-Google-Smtp-Source: ABdhPJw+5aBMxr72MniVbnSkXxgNfff7nte9AAvKFJsRelZrQ9UuB4LYEUqXJpDD12F6xo3uaFoUBbxUcqYfEI6UJok=
X-Received: by 2002:a05:6402:3596:: with SMTP id y22mr9937844edc.232.1643157370397;
 Tue, 25 Jan 2022 16:36:10 -0800 (PST)
MIME-Version: 1.0
References: <20220125141422.32655-1-cgzones@googlemail.com> <20220125141422.32655-9-cgzones@googlemail.com>
In-Reply-To: <20220125141422.32655-9-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Jan 2022 19:35:59 -0500
Message-ID: <CAHC9VhQ-kSWQ_w0KwgMboidktdQNN+G5jRpRWsY0Ayb8-HPmMA@mail.gmail.com>
Subject: Re: [PATCH 1/9] selinux: check return value of sel_make_avc_files
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 9:15 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> sel_make_avc_files() might fail and return a negative errno value on
> memory allocation failures. Re-add the check of the return value,
> dropped in 66f8e2f03c02.
>
> Reported by clang-analyzer:
>
>     security/selinux/selinuxfs.c:2129:2: warning: Value stored to 'ret' i=
s never read [deadcode.DeadStores]
>             ret =3D sel_make_avc_files(dentry);
>             ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Fixes: 66f8e2f03c02 ("selinux: sidtab reverse lookup hash table")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/selinuxfs.c | 2 ++
>  1 file changed, 2 insertions(+)

Merged into selinux/next, thanks Christian.

--=20
paul-moore.com
