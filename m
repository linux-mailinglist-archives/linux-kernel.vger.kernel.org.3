Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD2149D3E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiAZU4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiAZU4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:56:30 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A825C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 12:56:30 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id s5so1274097ejx.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 12:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kQGUfbOiSlrXMWUB18ru2iMPwWDRo+fWaUgVereZ2qk=;
        b=wLSlYUEyQWUG6vKfQCq9KI7LXIXNt34AGU/mX3JinGyH12FdYVo8kEIoeU60EXb2mZ
         MlkSLV03PttxOVmBXcXapCY45/8sfSGnRCQjsFMu2jR/es/RTBNUvz5qCi7OVf77WU+Y
         7TYrLd/2nXd2fdynCbmwqrkopOJ//NxOX8JquCNQTFVNCdcvrovlNahGrjOeJCnWVe8T
         ClW8pOYYtQoYXf0ySW5WvNAvhg5ri22vqrNO95dE5Gs7F5hkx3tqm+WgAToLfQzKE1dJ
         ysuu8e5xSzUKHCAkUkWox443UH/2Wm/qo5oSTcrFa5gLXa+XOi5duQcq4910WWaIEkD7
         WRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kQGUfbOiSlrXMWUB18ru2iMPwWDRo+fWaUgVereZ2qk=;
        b=rOLxEjs9z8Y55c0cNTQ65xS9Yeoatk9bo5tVU8SAjBGojqWS/Am+VB0Mt65Sojlv2c
         pzd9pWscCoDIavDH3sW1+tEli0VjT9ovd0JXOGiLzLgRjMeP8vLWKyoii9+TfHAYUBi4
         3bO+/lT6O0XqY0aHiV3nPNRzQJROCmZL9oozRcrqA62cMMsL4uBVsvTDSqCoFInjc9LD
         Cb3vc+urTPOozMo1dXwJ/ZvZUmP773TpVni8P1PeBfLi6W7X/lyhbRelcYYPGBhph8XR
         QiqWwhdZxeSqMrSr88GV9sz7TSYJdAIR7xsXO8C5PwvJzP1fgJguLPWnHU2opuOpfmuF
         IiTw==
X-Gm-Message-State: AOAM530AfS4erLq4p9Hyzoy8lF/Z9Z99up73dK944ZtbTjB1Njul6Bot
        Yf1gUE3Xg2+25xFQ9FUaiPh6mgFHq2mgWlvLLr+V
X-Google-Smtp-Source: ABdhPJyPolSj1HislWpwcc7wwWj76EMmcvl2tq9+mcpygxOEbytuu7jmEd/aqFx0WAIvqedUrEaqZY4du6iFu3T5ETM=
X-Received: by 2002:a17:907:3e8a:: with SMTP id hs10mr504091ejc.112.1643230588804;
 Wed, 26 Jan 2022 12:56:28 -0800 (PST)
MIME-Version: 1.0
References: <20220125141422.32655-1-cgzones@googlemail.com> <20220125141422.32655-6-cgzones@googlemail.com>
In-Reply-To: <20220125141422.32655-6-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Jan 2022 15:56:17 -0500
Message-ID: <CAHC9VhQP+xpEQCppx-Qvyd0hW9rcANfaw9F6972zo2PwCk_ZyQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] selinux: do not discard const qualifier in cast
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

On Tue, Jan 25, 2022 at 9:14 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Do not discard the const qualifier on the cast from const void* to
> __be32*; the addressed value is not modified.
>
> Reported by clang [-Wcast-qual]
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/netnode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged, thanks.

--=20
paul-moore.com
