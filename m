Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F129149D3F4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiAZU7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiAZU7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:59:12 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FA4C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 12:59:12 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id k25so1254533ejp.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 12:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9eB3sinujdfOKjw1Rq4Yv5m0jvLygDYT+UfsakVwvFY=;
        b=hWc0SIhSU692E7TeE3QERHKR5x+Uc2JnoSd39zct3wR6ZvZdOU20Q/bEetUWnZH2qv
         k8Y87WwX4DNOZDY7hoIHLsc9RzoCzuP16c0Mu+JCrku3P3474tOJQ88YTSgwbgLVQOT+
         p17Rn52sDgl4b9IJo4cMCYZa4M7HXtY7gejYzswVMJo7wrdHQ9ep16fmYu3RxZQdUzfZ
         vbB9+epHe00IVsZhW5xqE5F+iIEAgrwaQry0tFSp3SRgrGpEemNiJ0xnUbptAQCNgexX
         lKuc1tIxApWOC8mTKsWuY1RGL78bfxNndcg3XKtb+4eUvrpLhDstJvA1Ol1ZPla5q89D
         6b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9eB3sinujdfOKjw1Rq4Yv5m0jvLygDYT+UfsakVwvFY=;
        b=HPsYgrlLMCVKn+ALru6l2C7PqAqZBw6w5xPC1Vq+AXowAksQ8skta0XaO1nSYTP7Mq
         QRB4aSQ++ZYqGNePQ4SNgNbJmxEmcspcd1a8DV/b4qnA5GqZm1Q6zG7JxqDMg4zjXIH9
         dk1R/Uw/owf6Z6bThYzl1uJGCLWwp/X4r3qap/Kxvmmx3woRsAH+i3ysZTidAmm/LK33
         FC9ftX/QGER2NOl3CwHiEWsGaHQIDLplO+gyN2sywQhsZQnXv76q2fxpeKbp/ebgbCwv
         Fpph5CfL0jpjKqbr6LrRybFMQshJNr5aC4PwqdicmpXCRgez25Sbc5y/a/4gstBR9Y8+
         4JLA==
X-Gm-Message-State: AOAM531rKsq5LLzcxw5+eqHjbB0rjPweSBSUiiqVbnxExWhjVfimhWNj
        OjEErrmCqxpYBBcinPBCgOgLUM273/J9fUYMypnH
X-Google-Smtp-Source: ABdhPJwbGFpX8vGoi0YEZndNed80nrB6pQPwjTtQxv2+KG/+YKLLOPVzvOVF4GemKeM4hVP+ZFNtczQgBVPkJvmYazE=
X-Received: by 2002:a17:906:2ed0:: with SMTP id s16mr396367eji.327.1643230750765;
 Wed, 26 Jan 2022 12:59:10 -0800 (PST)
MIME-Version: 1.0
References: <20220125141422.32655-1-cgzones@googlemail.com> <20220125141422.32655-7-cgzones@googlemail.com>
In-Reply-To: <20220125141422.32655-7-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Jan 2022 15:58:59 -0500
Message-ID: <CAHC9VhTJpeb37sOkvKHO7REUJ4K3YMGK6ZY_ptLjVVAkEKdpfA@mail.gmail.com>
Subject: Re: [PATCH 8/9] selinux: simplify cred_init_security
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
> The parameter of selinux_cred() is declared const, so an explicit cast
> dropping the const qualifier is not necessary. Without the cast the
> local variable cred serves no purpose.
>
> Reported by clang [-Wcast-qual]
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/hooks.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Merged, thanks.

--=20
paul-moore.com
